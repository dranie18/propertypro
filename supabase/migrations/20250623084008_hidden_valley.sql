/*
  # Fix infinite recursion in user_profiles RLS policies

  1. Problem
    - Multiple overlapping policies causing infinite recursion
    - Policies referencing user_profiles table within their own conditions
    - Duplicate policies for same operations

  2. Solution
    - Drop all existing policies
    - Create clean, non-recursive policies
    - Use direct auth.uid() comparisons without subqueries
    - Separate policies for different user roles

  3. New Policies
    - Users can manage their own profiles
    - Admins can read all profiles
    - Admins can update all profiles
    - Superadmins can insert new profiles
*/

-- Drop all existing policies to start fresh
DROP POLICY IF EXISTS "Admins can read all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Allow authenticated users to delete their own profiles" ON user_profiles;
DROP POLICY IF EXISTS "Allow authenticated users to insert their own profiles" ON user_profiles;
DROP POLICY IF EXISTS "Allow authenticated users to select their own profiles" ON user_profiles;
DROP POLICY IF EXISTS "Allow authenticated users to update their own profiles" ON user_profiles;
DROP POLICY IF EXISTS "Superadmins can insert profiles" ON user_profiles;
DROP POLICY IF EXISTS "Users can read own profile" ON user_profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON user_profiles;

-- Create clean, non-recursive policies

-- Policy for users to read their own profile
CREATE POLICY "Users can read own profile"
  ON user_profiles
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Policy for users to update their own profile
CREATE POLICY "Users can update own profile"
  ON user_profiles
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Policy for users to insert their own profile (during registration)
CREATE POLICY "Users can insert own profile"
  ON user_profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Policy for users to delete their own profile
CREATE POLICY "Users can delete own profile"
  ON user_profiles
  FOR DELETE
  TO authenticated
  USING (auth.uid() = id);

-- Policy for admins and superadmins to read all profiles
-- Using a simple approach without subqueries to avoid recursion
CREATE POLICY "Admins can read all profiles"
  ON user_profiles
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM auth.users 
      WHERE auth.users.id = auth.uid() 
      AND auth.users.raw_user_meta_data->>'role' IN ('admin', 'superadmin')
    )
  );

-- Policy for admins and superadmins to update all profiles
CREATE POLICY "Admins can update all profiles"
  ON user_profiles
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM auth.users 
      WHERE auth.users.id = auth.uid() 
      AND auth.users.raw_user_meta_data->>'role' IN ('admin', 'superadmin')
    )
  );

-- Policy for superadmins to insert profiles for other users
CREATE POLICY "Superadmins can insert profiles"
  ON user_profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM auth.users 
      WHERE auth.users.id = auth.uid() 
      AND auth.users.raw_user_meta_data->>'role' = 'superadmin'
    )
  );