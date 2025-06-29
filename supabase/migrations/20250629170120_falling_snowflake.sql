/*
# Sample Data Migration

This migration adds sample data to the database for development and testing purposes.

1. Categories
   - Adds property categories like Rumah, Apartemen, etc.
2. Premium Plans
   - Adds premium subscription plans
3. Ad Placements
   - Adds advertisement placement configurations
4. System Settings
   - Adds default system settings
5. Users and Profiles
   - Creates sample users with proper foreign key relationships
6. Sample Content
   - Adds listings, property media, premium listings, etc.

Note: This migration uses conditional inserts to avoid duplicate key errors
*/

-- Insert sample categories (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000201') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000201', 'Rumah', 'rumah', 'Berbagai pilihan rumah untuk keluarga', 'Home', TRUE, 15, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000202') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000202', 'Apartemen', 'apartemen', 'Apartemen modern dengan fasilitas lengkap', 'Building2', TRUE, 10, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000203') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000203', 'Ruko', 'ruko', 'Ruko strategis untuk bisnis Anda', 'Store', TRUE, 5, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000204') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000204', 'Tanah', 'tanah', 'Tanah kavling siap bangun', 'MapPin', TRUE, 8, NOW() - INTERVAL '90 days', NOW());
  END IF;
END $$;

-- Insert sample premium plans (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM premium_plans WHERE id = 'premium-monthly') THEN
    INSERT INTO premium_plans (id, name, price, currency, duration, description, features, is_active, created_at, updated_at)
    VALUES ('premium-monthly', 'Premium Listing', 29.99, 'USD', 30, 'Boost your property visibility with premium features', 
     '[{"feature": "Featured placement at top of search results"}, {"feature": "Golden highlighted border"}, {"feature": "Larger photo gallery (up to 20 images)"}, {"feature": "Extended listing duration (30 days)"}, {"feature": "Virtual tour integration"}, {"feature": "Detailed analytics dashboard"}, {"feature": "Priority customer support"}, {"feature": "Social media promotion"}]'::jsonb, 
     TRUE, NOW() - INTERVAL '100 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM premium_plans WHERE id = 'premium-quarterly') THEN
    INSERT INTO premium_plans (id, name, price, currency, duration, description, features, is_active, created_at, updated_at)
    VALUES ('premium-quarterly', 'Premium Plus', 79.99, 'USD', 90, 'Extended premium visibility for serious sellers', 
     '[{"feature": "All Premium Listing features"}, {"feature": "Extended duration (90 days)"}, {"feature": "Featured in email newsletters"}, {"feature": "Premium badge on all listings"}, {"feature": "Highlighted in search results"}, {"feature": "Priority placement in similar properties"}, {"feature": "Dedicated account manager"}, {"feature": "Performance reports"}]'::jsonb, 
     TRUE, NOW() - INTERVAL '100 days', NOW());
  END IF;
END $$;

-- Insert sample ad placements (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000601') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000601', 'Homepage Banner', 'Large banner at the top of the homepage', 'homepage_top', '{"width": 1200, "height": 300}'::jsonb, 2048, ARRAY['jpg', 'png', 'gif'], 100.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000602') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000602', 'Sidebar Ad', 'Ad displayed in the sidebar of property listings', 'listing_sidebar', '{"width": 300, "height": 250}'::jsonb, 1024, ARRAY['jpg', 'png'], 50.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
END $$;

-- Insert sample system settings (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM system_settings WHERE id = '00000000-0000-4000-0000-000000001201') THEN
    INSERT INTO system_settings (id, settings_data, updated_at)
    VALUES ('00000000-0000-4000-0000-000000001201', '{
      "general": {
        "siteName": "Properti Pro",
        "siteDescription": "Platform jual beli dan sewa properti terpercaya di Indonesia",
        "siteUrl": "https://propertipro.id",
        "adminEmail": "admin@propertipro.id",
        "supportEmail": "support@propertipro.id",
        "timezone": "Asia/Jakarta",
        "language": "id",
        "currency": "IDR",
        "dateFormat": "DD/MM/YYYY",
        "timeFormat": "HH:mm"
      },
      "features": {
        "userRegistration": true,
        "emailVerification": false,
        "propertyApproval": true,
        "autoPublish": false,
        "guestInquiries": true,
        "socialLogin": false,
        "multiLanguage": false,
        "darkMode": true,
        "maintenance": false
      },
      "limits": {
        "maxPropertiesPerUser": 20,
        "maxImagesPerProperty": 10,
        "maxFileSize": 5,
        "sessionTimeout": 60,
        "maxLoginAttempts": 5,
        "passwordMinLength": 8,
        "propertyTitleMaxLength": 100,
        "propertyDescriptionMaxLength": 2000
      }
    }'::jsonb, NOW());
  END IF;
END $$;

-- Create sample users in auth.users first, then insert user_profiles
-- This ensures the foreign key constraint is satisfied
DO $$
DECLARE
  user_id1 UUID := '00000000-0000-4000-0000-000000000101';
  user_id2 UUID := '00000000-0000-4000-0000-000000000102';
  user_id3 UUID := '00000000-0000-4000-0000-000000000103';
  
  -- Check if users already exist
  user_exists1 BOOLEAN;
  user_exists2 BOOLEAN;
  user_exists3 BOOLEAN;
  
  -- Check if emails already exist
  email_exists1 BOOLEAN;
  email_exists2 BOOLEAN;
  email_exists3 BOOLEAN;
BEGIN
  -- Check if users exist in auth.users
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id1) INTO user_exists1;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id2) INTO user_exists2;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id3) INTO user_exists3;
  
  -- Check if emails exist in auth.users
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'budi@example.com') INTO email_exists1;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'siti@example.com') INTO email_exists2;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'agus@wijayaproperty.com') INTO email_exists3;
  
  -- Create users in auth.users if they don't exist and their emails don't exist
  IF NOT user_exists1 AND NOT email_exists1 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id1, 'budi@example.com', NOW(), NOW(), NOW());
    
    -- Only insert user_profile after auth.users entry exists
    IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id1) THEN
      INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
      VALUES (user_id1, 'Budi Santoso', '+6281234567890', 'user', 'active', 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg', NULL, NOW() - INTERVAL '60 days', NOW());
    END IF;
  END IF;
  
  IF NOT user_exists2 AND NOT email_exists2 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id2, 'siti@example.com', NOW(), NOW(), NOW());
    
    -- Only insert user_profile after auth.users entry exists
    IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id2) THEN
      INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
      VALUES (user_id2, 'Siti Rahayu', '+6281234567891', 'user', 'active', 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg', NULL, NOW() - INTERVAL '55 days', NOW());
    END IF;
  END IF;
  
  IF NOT user_exists3 AND NOT email_exists3 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id3, 'agus@wijayaproperty.com', NOW(), NOW(), NOW());
    
    -- Only insert user_profile after auth.users entry exists
    IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id3) THEN
      INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
      VALUES (user_id3, 'Agus Wijaya', '+6281234567892', 'agent', 'active', 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg', 'Wijaya Property', NOW() - INTERVAL '50 days', NOW());
    END IF;
  END IF;
  
  -- For existing users, ensure user_profiles exist
  IF user_exists1 AND NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id1) THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES (user_id1, 'Budi Santoso', '+6281234567890', 'user', 'active', 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg', NULL, NOW() - INTERVAL '60 days', NOW());
  END IF;
  
  IF user_exists2 AND NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id2) THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES (user_id2, 'Siti Rahayu', '+6281234567891', 'user', 'active', 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg', NULL, NOW() - INTERVAL '55 days', NOW());
  END IF;
  
  IF user_exists3 AND NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = user_id3) THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES (user_id3, 'Agus Wijaya', '+6281234567892', 'agent', 'active', 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg', 'Wijaya Property', NOW() - INTERVAL '50 days', NOW());
  END IF;
END $$;

-- Insert sample listings (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000301') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000103', 'Rumah Mewah 2 Lantai di Jakarta Selatan', 'Rumah mewah 2 lantai dengan kolam renang pribadi, taman luas, dan garasi untuk 2 mobil. Lokasi strategis dekat dengan pusat perbelanjaan dan sekolah internasional.', 2.5, 'miliar', 'rumah', 'jual', 4, 3, 200, 300, 'p1', 'c2', 'd3', 'Jl. Kemang Raya No. 10', '12730', ARRAY['Kolam Renang', 'Taman', 'Garasi', 'Keamanan 24 Jam', 'AC'], 'active', 120, 5, TRUE, NOW() - INTERVAL '30 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000302') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000302', '00000000-0000-4000-0000-000000000103', 'Apartemen Studio di Pusat Kota Jakarta', 'Apartemen studio modern dengan pemandangan kota yang menakjubkan. Dilengkapi dengan fasilitas gym, kolam renang, dan area BBQ. Akses mudah ke transportasi umum.', 800, 'juta', 'apartemen', 'jual', 1, 1, 45, NULL, 'p1', 'c1', 'd1', 'Apartemen Central Park Tower A Unit 12F', '10730', ARRAY['Gym', 'Kolam Renang', 'Area BBQ', 'Keamanan 24 Jam', 'Parkir'], 'active', 85, 3, TRUE, NOW() - INTERVAL '25 days', NOW());
  END IF;
END $$;

-- Insert sample property media (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000401') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000401', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg', 'image', TRUE, NOW(), NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000402') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000402', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1643384/pexels-photo-1643384.jpeg', 'image', FALSE, NOW(), NOW());
  END IF;
END $$;

-- Insert sample premium listings (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM premium_listings WHERE id = '00000000-0000-4000-0000-000000000501') THEN
    INSERT INTO premium_listings (id, property_id, user_id, plan_id, status, start_date, end_date, payment_id, analytics_views, analytics_inquiries, analytics_favorites, analytics_conversion_rate, analytics_daily_views, analytics_top_sources, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000501', '00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000103', 'premium-monthly', 'active', NOW() - INTERVAL '15 days', NOW() + INTERVAL '15 days', NULL, 120, 5, 10, 4.2, 
     '[{"date":"2023-06-15","views":10},{"date":"2023-06-16","views":15},{"date":"2023-06-17","views":12},{"date":"2023-06-18","views":8},{"date":"2023-06-19","views":20},{"date":"2023-06-20","views":18},{"date":"2023-06-21","views":22},{"date":"2023-06-22","views":15}]'::jsonb, 
     '[{"source":"direct","count":50},{"source":"google","count":40},{"source":"facebook","count":20},{"source":"instagram","count":10}]'::jsonb, 
     NOW() - INTERVAL '15 days', NOW());
  END IF;
END $$;

-- Insert sample advertiser accounts (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM advertiser_accounts WHERE id = '00000000-0000-4000-0000-000000000701') THEN
    INSERT INTO advertiser_accounts (id, user_id, company_name, contact_email, contact_phone, billing_address, payment_method, credit_balance, status, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000701', '00000000-0000-4000-0000-000000000103', 'Wijaya Property', 'agus@wijayaproperty.com', '+6281234567892', '{"address": "Jl. Sudirman No. 123", "city": "Jakarta", "postal_code": "10220", "country": "ID"}'::jsonb, '{"type": "credit_card", "last4": "1234"}'::jsonb, 500.00, 'active', NOW() - INTERVAL '60 days', NOW());
  END IF;
END $$;

-- Insert sample ad campaigns (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE id = '00000000-0000-4000-0000-000000000801') THEN
    INSERT INTO ad_campaigns (id, advertiser_id, name, description, budget, daily_budget, start_date, end_date, targeting_options, status, total_spent, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000801', '00000000-0000-4000-0000-000000000701', 'Summer Property Promotion', 'Promoting luxury properties for summer season', 1000.00, 50.00, NOW() - INTERVAL '30 days', NOW() + INTERVAL '30 days', '{"geographic": {"cities": ["Jakarta", "Bandung", "Surabaya"]}, "behavioral": {"property_types": ["rumah", "apartemen"]}}'::jsonb, 'active', 500.00, NOW() - INTERVAL '35 days', NOW());
  END IF;
END $$;

-- Insert sample advertisements (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM advertisements WHERE id = '00000000-0000-4000-0000-000000000901') THEN
    INSERT INTO advertisements (id, campaign_id, placement_id, title, description, image_url, video_url, click_url, alt_text, ad_type, content, status, priority, weight, impressions_count, clicks_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000000801', '00000000-0000-4000-0000-000000000601', 'Luxury Homes in Jakarta', 'Discover your dream luxury home in Jakarta', 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg', NULL, 'https://propertipro.id/jual?type=rumah', 'Luxury homes in Jakarta', 'banner', '{"headline": "Luxury Living", "cta": "View Properties"}'::jsonb, 'active', 10, 10, 1500, 75, NOW() - INTERVAL '30 days', NOW());
  END IF;
END $$;

-- Insert sample reports (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM reports WHERE id = '00000000-0000-4000-0000-000000001001') THEN
    INSERT INTO reports (id, property_id, reporter_id, reporter_name, reporter_email, type, reason, description, status, priority, resolved_at, resolved_by, resolution, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000001001', '00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000101', 'Budi Santoso', 'budi@example.com', 'fake_listing', 'Properti ini tidak ada di lokasi yang disebutkan', 'Saya sudah mengunjungi lokasi dan tidak menemukan properti seperti yang dijelaskan dalam iklan.', 'pending', 'high', NULL, NULL, NULL, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days');
  END IF;
END $$;

-- Insert sample activity logs (only if they don't exist)
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM auth.users WHERE id = '00000000-0000-4000-0000-000000000103') THEN
    IF NOT EXISTS (SELECT 1 FROM activity_logs WHERE id = '00000000-0000-4000-0000-000000001301') THEN
      INSERT INTO activity_logs (id, user_id, user_name, action, resource, resource_id, details, ip_address, user_agent, created_at)
      VALUES ('00000000-0000-4000-0000-000000001301', '00000000-0000-4000-0000-000000000103', 'Agus Wijaya', 'CREATE_LISTING', 'listings', '00000000-0000-4000-0000-000000000301', 'Created new property listing', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '30 days');
    END IF;
  END IF;
END $$;