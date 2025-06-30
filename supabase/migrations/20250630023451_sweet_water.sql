/*
  # Add floors column to listings table

  1. Changes
    - Add `floors` column to the `listings` table to store the number of floors/levels
*/

-- Add floors column to listings table
ALTER TABLE listings ADD COLUMN IF NOT EXISTS floors INTEGER;