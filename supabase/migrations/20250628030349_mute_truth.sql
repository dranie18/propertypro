/*
  # Premium Listings Integration

  1. New Tables
    - `premium_plans` - Stores premium plan configurations
    - Updates to `premium_listings` table to ensure proper structure

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to manage their own premium listings
    - Add policies for admins to manage all premium listings
*/

-- Create premium_plans table if it doesn't exist
CREATE TABLE IF NOT EXISTS premium_plans (
  id text PRIMARY KEY,
  name text NOT NULL,
  price numeric(10,2) NOT NULL,
  currency text NOT NULL DEFAULT 'USD',
  duration integer NOT NULL,
  description text,
  features jsonb,
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Insert default premium plan
INSERT INTO premium_plans (id, name, price, currency, duration, description, features)
VALUES (
  'premium-monthly',
  'Premium Listing',
  29.99,
  'USD',
  30,
  'Boost your property visibility with premium features',
  '["Featured placement at top of search results", "Golden highlighted border", "Larger photo gallery (up to 20 images)", "Extended listing duration (30 days)", "Virtual tour integration", "Detailed analytics dashboard", "Priority customer support", "Social media promotion"]'::jsonb
) ON CONFLICT (id) DO NOTHING;

-- Ensure premium_listings table has all required fields
DO $$ 
BEGIN
  -- Add analytics fields if they don't exist
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'premium_listings' AND column_name = 'analytics_daily_views') THEN
    ALTER TABLE premium_listings ADD COLUMN analytics_daily_views jsonb DEFAULT '[]'::jsonb;
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'premium_listings' AND column_name = 'analytics_top_sources') THEN
    ALTER TABLE premium_listings ADD COLUMN analytics_top_sources jsonb DEFAULT '[]'::jsonb;
  END IF;
END $$;

-- Enable RLS on premium_plans
ALTER TABLE premium_plans ENABLE ROW LEVEL SECURITY;

-- Create policies for premium_plans
CREATE POLICY "Anyone can read active premium plans"
  ON premium_plans
  FOR SELECT
  TO public
  USING (is_active = true);

CREATE POLICY "Admins can manage premium plans"
  ON premium_plans
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role IN ('admin', 'superadmin')
    )
  );

-- Create policies for premium_listings if not already created
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'premium_listings' AND policyname = 'Users can manage own premium listings') THEN
    CREATE POLICY "Users can manage own premium listings"
      ON premium_listings
      FOR ALL
      TO authenticated
      USING (user_id = auth.uid());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'premium_listings' AND policyname = 'Admins can manage all premium listings') THEN
    CREATE POLICY "Admins can manage all premium listings"
      ON premium_listings
      FOR ALL
      TO authenticated
      USING (
        EXISTS (
          SELECT 1 FROM user_profiles
          WHERE user_profiles.id = auth.uid()
          AND user_profiles.role IN ('admin', 'superadmin')
        )
      );
  END IF;
END $$;

-- Create function to update premium_listings analytics
CREATE OR REPLACE FUNCTION update_premium_listing_analytics(
  p_listing_id uuid,
  p_type text
)
RETURNS void AS $$
DECLARE
  v_listing premium_listings;
  v_today date := current_date;
  v_daily_views jsonb;
  v_today_entry jsonb;
  v_today_index integer := -1;
  v_views integer;
  v_inquiries integer;
  v_conversion_rate numeric(5,2);
BEGIN
  -- Get the premium listing
  SELECT * INTO v_listing
  FROM premium_listings
  WHERE id = p_listing_id;
  
  IF NOT FOUND THEN
    RETURN;
  END IF;
  
  -- Update based on type
  IF p_type = 'view' THEN
    -- Update views
    UPDATE premium_listings
    SET analytics_views = analytics_views + 1
    WHERE id = p_listing_id;
    
    -- Update daily views
    v_daily_views := v_listing.analytics_daily_views;
    
    -- Find today's entry
    FOR i IN 0..jsonb_array_length(v_daily_views) - 1 LOOP
      IF (v_daily_views->i->>'date')::date = v_today THEN
        v_today_index := i;
        EXIT;
      END IF;
    END LOOP;
    
    IF v_today_index >= 0 THEN
      -- Update existing entry
      v_today_entry := v_daily_views->v_today_index;
      v_views := (v_today_entry->>'views')::integer + 1;
      v_daily_views := jsonb_set(
        v_daily_views,
        ARRAY[v_today_index::text],
        jsonb_build_object('date', v_today, 'views', v_views)
      );
    ELSE
      -- Add new entry
      v_daily_views := v_daily_views || jsonb_build_array(
        jsonb_build_object('date', v_today, 'views', 1)
      );
    END IF;
    
    UPDATE premium_listings
    SET analytics_daily_views = v_daily_views
    WHERE id = p_listing_id;
    
  ELSIF p_type = 'inquiry' THEN
    -- Update inquiries
    UPDATE premium_listings
    SET analytics_inquiries = analytics_inquiries + 1
    WHERE id = p_listing_id;
    
  ELSIF p_type = 'favorite' THEN
    -- Update favorites
    UPDATE premium_listings
    SET analytics_favorites = analytics_favorites + 1
    WHERE id = p_listing_id;
  END IF;
  
  -- Update conversion rate
  SELECT analytics_views, analytics_inquiries INTO v_views, v_inquiries
  FROM premium_listings
  WHERE id = p_listing_id;
  
  IF v_views > 0 THEN
    v_conversion_rate := (v_inquiries::numeric / v_views::numeric) * 100;
    
    UPDATE premium_listings
    SET analytics_conversion_rate = v_conversion_rate
    WHERE id = p_listing_id;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Create trigger function to update updated_at column
CREATE OR REPLACE FUNCTION update_premium_listings_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for premium_listings
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_premium_listings_updated_at') THEN
    CREATE TRIGGER update_premium_listings_updated_at
    BEFORE UPDATE ON premium_listings
    FOR EACH ROW
    EXECUTE FUNCTION update_premium_listings_updated_at();
  END IF;
END $$;

-- Create trigger function to update updated_at column for premium_plans
CREATE OR REPLACE FUNCTION update_premium_plans_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for premium_plans
CREATE TRIGGER update_premium_plans_updated_at
BEFORE UPDATE ON premium_plans
FOR EACH ROW
EXECUTE FUNCTION update_premium_plans_updated_at();