/*
  # Real Estate Listing Management Schema

  1. New Tables
    - `listings`
      - `id` (uuid, primary key)
      - `title` (text, required)
      - `description` (text, required)
      - `price` (numeric, required)
      - `location` (text, required)
      - `property_type` (enum: 'rumah', 'apartemen', 'ruko', 'tanah')
      - `status` (enum: 'tersedia', 'terjual', 'disewa')
      - `square_meters` (numeric, required)
      - `bedrooms` (integer)
      - `bathrooms` (integer)
      - `created_at` (timestamp with time zone)
      - `updated_at` (timestamp with time zone)
      - `user_id` (uuid, foreign key)
    - `property_media`
      - `id` (uuid, primary key)
      - `listing_id` (uuid, foreign key)
      - `media_url` (text, required)
      - `media_type` (enum: 'photo', 'video')
      - `is_primary` (boolean)
      - `created_at` (timestamp with time zone)
  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Create custom types
CREATE TYPE property_type AS ENUM ('rumah', 'apartemen', 'ruko', 'tanah');
CREATE TYPE property_status AS ENUM ('tersedia', 'terjual', 'disewa');
CREATE TYPE media_type AS ENUM ('photo', 'video');

-- Create listings table
CREATE TABLE IF NOT EXISTS listings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL CHECK (char_length(title) >= 10 AND char_length(title) <= 100),
  description text NOT NULL CHECK (char_length(description) >= 50),
  price numeric NOT NULL CHECK (price > 0),
  location text NOT NULL CHECK (char_length(location) >= 5),
  property_type property_type NOT NULL,
  status property_status NOT NULL DEFAULT 'tersedia',
  square_meters numeric NOT NULL CHECK (square_meters > 0),
  bedrooms integer,
  bathrooms integer,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE
);

-- Create property_media table
CREATE TABLE IF NOT EXISTS property_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  listing_id uuid NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  media_url text NOT NULL,
  media_type media_type NOT NULL,
  is_primary boolean DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for listings table
CREATE TRIGGER update_listings_updated_at
BEFORE UPDATE ON listings
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE property_media ENABLE ROW LEVEL SECURITY;

-- Create policies for listings
CREATE POLICY "Users can view all available listings"
  ON listings
  FOR SELECT
  USING (status = 'tersedia');

CREATE POLICY "Users can create their own listings"
  ON listings
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own listings"
  ON listings
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own listings"
  ON listings
  FOR DELETE
  USING (auth.uid() = user_id);

-- Create policies for property_media
CREATE POLICY "Users can view all property media"
  ON property_media
  FOR SELECT
  USING (true);

CREATE POLICY "Users can insert media for their own listings"
  ON property_media
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = listing_id
      AND listings.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can update media for their own listings"
  ON property_media
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = listing_id
      AND listings.user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = listing_id
      AND listings.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete media for their own listings"
  ON property_media
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM listings
      WHERE listings.id = listing_id
      AND listings.user_id = auth.uid()
    )
  );

-- Create index for faster queries
CREATE INDEX idx_listings_user_id ON listings(user_id);
CREATE INDEX idx_listings_property_type ON listings(property_type);
CREATE INDEX idx_listings_status ON listings(status);
CREATE INDEX idx_property_media_listing_id ON property_media(listing_id);