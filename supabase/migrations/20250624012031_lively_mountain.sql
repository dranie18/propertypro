/*
  # Fix infinite recursion in user_profiles RLS policies

  1. Problem
    - The admin policies for user_profiles table are causing infinite recursion
    - They query the same table they're protecting to check user roles
    - This creates a circular dependency

  2. Solution
    - Drop the problematic admin policies that cause recursion
    - Create new policies that use auth.uid() directly without querying user_profiles
    - Keep the basic user policies that work correctly

  3. Changes
    - Remove "Admins can read all profiles" policy
    - Remove "Admins can update all profiles" policy
    - Keep user-specific policies that don't cause recursion
    - Admins can still manage profiles through direct database access or separate admin functions
*/

-- Drop the problematic policies that cause infinite recursion
DROP POLICY IF EXISTS "Admins can read all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON user_profiles;
DROP POLICY IF EXISTS "Superadmins can insert any profile" ON user_profiles;
DROP POLICY IF EXISTS "Superadmins can insert profiles" ON user_profiles;

-- Make sure we have the basic user policies in place
-- These don't cause recursion because they use direct auth.uid() comparison

-- Policy for users to read their own profile
CREATE POLICY IF NOT EXISTS "Users can read own profile"
  ON user_profiles
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Policy for users to update their own profile
CREATE POLICY IF NOT EXISTS "Users can update own profile"
  ON user_profiles
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Policy for users to insert their own profile (during registration)
CREATE POLICY IF NOT EXISTS "Users can insert own profile"
  ON user_profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Policy for users to delete their own profile
CREATE POLICY IF NOT EXISTS "Users can delete own profile"
  ON user_profiles
  FOR DELETE
  TO authenticated
  USING (auth.uid() = id);