/*
  # Reports Management Schema

  1. New Tables
    - `reports` - Stores property reports from users
    - `moderation_actions` - Stores admin actions taken on reports

  2. Security
    - Enable RLS on both tables
    - Add policies for admin access
*/

-- Create reports table
CREATE TABLE IF NOT EXISTS reports (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id uuid REFERENCES listings(id) ON DELETE CASCADE,
  reporter_id uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  reporter_name text NOT NULL,
  reporter_email text NOT NULL,
  type text NOT NULL, -- 'spam', 'inappropriate_content', 'fake_listing', 'wrong_category', 'duplicate', 'other'
  reason text NOT NULL,
  description text,
  status text NOT NULL DEFAULT 'pending', -- 'pending', 'under_review', 'resolved', 'dismissed'
  priority text NOT NULL DEFAULT 'medium', -- 'low', 'medium', 'high', 'urgent'
  resolved_at timestamptz,
  resolved_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  resolution text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Create moderation_actions table
CREATE TABLE IF NOT EXISTS moderation_actions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  report_id uuid REFERENCES reports(id) ON DELETE SET NULL,
  property_id uuid REFERENCES listings(id) ON DELETE CASCADE,
  admin_id uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  admin_name text NOT NULL,
  action text NOT NULL, -- 'approve', 'remove', 'suspend', 'warn_user', 'edit_content', 'change_category', 'dismiss_report'
  reason text NOT NULL,
  details text,
  previous_status text,
  new_status text,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS reports_property_id_idx ON reports(property_id);
CREATE INDEX IF NOT EXISTS reports_status_idx ON reports(status);
CREATE INDEX IF NOT EXISTS reports_priority_idx ON reports(priority);
CREATE INDEX IF NOT EXISTS reports_created_at_idx ON reports(created_at);

CREATE INDEX IF NOT EXISTS moderation_actions_property_id_idx ON moderation_actions(property_id);
CREATE INDEX IF NOT EXISTS moderation_actions_admin_id_idx ON moderation_actions(admin_id);
CREATE INDEX IF NOT EXISTS moderation_actions_created_at_idx ON moderation_actions(created_at);

-- Enable Row Level Security
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE moderation_actions ENABLE ROW LEVEL SECURITY;

-- Create policies for reports table
CREATE POLICY "Admins can read all reports"
  ON reports
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role IN ('admin', 'superadmin')
    )
  );

CREATE POLICY "Admins can update reports"
  ON reports
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role IN ('admin', 'superadmin')
    )
  );

CREATE POLICY "Users can create reports"
  ON reports
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Anonymous users can create reports"
  ON reports
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Create policies for moderation_actions table
CREATE POLICY "Admins can read all moderation actions"
  ON moderation_actions
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role IN ('admin', 'superadmin')
    )
  );

CREATE POLICY "Admins can create moderation actions"
  ON moderation_actions
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM user_profiles
      WHERE user_profiles.id = auth.uid()
      AND user_profiles.role IN ('admin', 'superadmin')
    )
  );

-- Create trigger to update updated_at column
CREATE OR REPLACE FUNCTION update_reports_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_reports_updated_at
BEFORE UPDATE ON reports
FOR EACH ROW
EXECUTE FUNCTION update_reports_updated_at();