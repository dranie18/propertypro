/*
  # Create demo user accounts

  1. Demo Users
    - Creates demo admin and superadmin accounts for testing
    - Inserts corresponding user profiles with proper roles
    - Uses the credentials shown on the login page

  2. Security
    - Uses Supabase's built-in authentication system
    - Profiles are created with proper role assignments
    - Accounts are set to active status

  Note: These are demo accounts for development/testing purposes only
*/

-- Insert demo user profiles (these will be linked to auth.users via triggers)
INSERT INTO user_profiles (id, full_name, role, status, created_at, updated_at)
VALUES 
  -- Admin user
  ('550e8400-e29b-41d4-a716-446655440001', 'Demo Admin', 'admin', 'active', now(), now()),
  -- Super Admin user  
  ('550e8400-e29b-41d4-a716-446655440002', 'Demo Super Admin', 'superadmin', 'active', now(), now())
ON CONFLICT (id) DO NOTHING;