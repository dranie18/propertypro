/*
  # Add Xendit payment fields to ad_payments table

  1. Changes
    - Add xendit_invoice_id column to ad_payments table
    - Add xendit_payment_method column to ad_payments table
    - Add xendit_payment_channel column to ad_payments table
    - Add xendit_callback_data column to ad_payments table
*/

-- Add Xendit specific columns to ad_payments table
ALTER TABLE ad_payments ADD COLUMN IF NOT EXISTS xendit_invoice_id TEXT;
ALTER TABLE ad_payments ADD COLUMN IF NOT EXISTS xendit_payment_method TEXT;
ALTER TABLE ad_payments ADD COLUMN IF NOT EXISTS xendit_payment_channel TEXT;
ALTER TABLE ad_payments ADD COLUMN IF NOT EXISTS xendit_callback_data JSONB;

-- Create index on xendit_invoice_id for faster lookups
CREATE INDEX IF NOT EXISTS idx_ad_payments_xendit_invoice_id ON ad_payments(xendit_invoice_id);

-- Add webhook_logs table to store incoming webhooks
CREATE TABLE IF NOT EXISTS webhook_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider TEXT NOT NULL,
  event_type TEXT,
  payload JSONB NOT NULL,
  headers JSONB,
  processed BOOLEAN DEFAULT false,
  error TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Create index on webhook_logs created_at for faster queries
CREATE INDEX IF NOT EXISTS idx_webhook_logs_created_at ON webhook_logs(created_at);