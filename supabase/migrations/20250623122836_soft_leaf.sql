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

-- The remaining policies are safe and don't cause recursion:
-- - "Users can read own profile" - uses auth.uid() = id
-- - "Users can update own profile" - uses auth.uid() = id  
-- - "Users can delete own profile" - uses auth.uid() = id
-- - "Users can insert own profile" - uses auth.uid() = id
-- - "Superadmins can insert any profile" - this one also needs to be fixed

-- Also drop the superadmin insert policy as it has the same recursion issue
DROP POLICY IF EXISTS "Superadmins can insert any profile" ON user_profiles;

-- Create a simpler insert policy that allows users to create their own profile
-- This will be handled by the trigger function when a user signs up
CREATE POLICY "Allow profile creation during signup"
  ON user_profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);