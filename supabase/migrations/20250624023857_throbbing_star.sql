/*
  # Create demo users for testing

  1. New Users
    - Create demo admin and superadmin user profiles
    - These will be linked to auth.users when created through the UI

  2. Purpose
    - Provide test accounts for the login page demo credentials
    - Allow testing of admin functionality
*/

-- Insert demo user profiles (these will be linked to auth.users via triggers)
INSERT INTO user_profiles (id, full_name, role, status, created_at, updated_at)
VALUES 
  -- Admin user
  ('550e8400-e29b-41d4-a716-446655440001', 'Demo Admin', 'admin', 'active', now(), now()),
  -- Super Admin user  
  ('550e8400-e29b-41d4-a716-446655440002', 'Demo Super Admin', 'superadmin', 'active', now(), now())
ON CONFLICT (id) DO NOTHING;