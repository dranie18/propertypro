/*
  # System Settings Table

  1. New Tables
    - `system_settings`
      - `id` (uuid, primary key)
      - `settings_data` (jsonb)
      - `updated_at` (timestamptz)
  2. Security
    - Enable RLS on `system_settings` table
    - Add policy for authenticated admin users to read/write
*/

-- Create system_settings table
CREATE TABLE IF NOT EXISTS system_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  settings_data jsonb NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE system_settings ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Admins can read system settings"
  ON system_settings
  FOR SELECT
  TO authenticated
  USING (auth.jwt() ->> 'role' IN ('admin', 'superadmin'));

CREATE POLICY "Admins can update system settings"
  ON system_settings
  FOR UPDATE
  TO authenticated
  USING (auth.jwt() ->> 'role' IN ('admin', 'superadmin'));

CREATE POLICY "Admins can insert system settings"
  ON system_settings
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.jwt() ->> 'role' IN ('admin', 'superadmin'));