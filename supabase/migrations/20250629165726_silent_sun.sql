/*
# Sample Data Migration

1. New Tables
   - None (uses existing tables)
   
2. Sample Data
   - Categories: 8 sample property categories
   - Premium Plans: 3 subscription tiers
   - Ad Placements: 5 different ad placement types
   - System Settings: Default application configuration
   - Users: 12 sample users with different roles
   - Listings: 20 sample property listings
   - Property Media: Images for each listing
   - Premium Listings: 10 premium property listings
   - Advertiser Accounts: 4 sample advertiser accounts
   - Ad Campaigns: 5 marketing campaigns
   - Advertisements: 5 sample ads
   - Reports: 5 sample user reports
   - Moderation Actions: 4 sample moderation actions
   - Ad Impressions/Clicks: Sample analytics data
   - Activity Logs: 10 sample admin activities

3. Security
   - Ensures auth.users exist before creating user_profiles
   - Checks for email existence before inserting users
*/

-- Insert sample categories (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000201') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000201', 'Rumah', 'rumah', 'Berbagai pilihan rumah untuk keluarga', 'Home', TRUE, 15, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000202') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000202', 'Apartemen', 'apartemen', 'Apartemen modern dengan fasilitas lengkap', 'Building2', TRUE, 10, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000203') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000203', 'Ruko', 'ruko', 'Ruko strategis untuk bisnis Anda', 'Store', TRUE, 5, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000204') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000204', 'Tanah', 'tanah', 'Tanah kavling siap bangun', 'MapPin', TRUE, 8, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000205') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000205', 'Kondominium', 'kondominium', 'Kondominium mewah dengan pemandangan kota', 'Building', TRUE, 3, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000206') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000206', 'Gedung Komersial', 'gedung-komersial', 'Gedung komersial untuk kantor dan bisnis', 'Building', TRUE, 2, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000207') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000207', 'Ruang Industri', 'ruang-industri', 'Ruang industri dan gudang', 'Warehouse', TRUE, 1, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM categories WHERE id = '00000000-0000-4000-0000-000000000208') THEN
    INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000208', 'Villa', 'villa', 'Villa mewah untuk liburan', 'Home', FALSE, 0, NOW() - INTERVAL '90 days', NOW());
  END IF;
END $$;

-- Insert sample premium plans (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM premium_plans WHERE id = 'premium-monthly') THEN
    INSERT INTO premium_plans (id, name, price, currency, duration, description, features, is_active, created_at, updated_at)
    VALUES ('premium-monthly', 'Premium Listing', 29.99, 'USD', 30, 'Boost your property visibility with premium features', 
     '[{"feature": "Featured placement at top of search results"}, {"feature": "Golden highlighted border"}, {"feature": "Larger photo gallery (up to 20 images)"}, {"feature": "Extended listing duration (30 days)"}, {"feature": "Virtual tour integration"}, {"feature": "Detailed analytics dashboard"}, {"feature": "Priority customer support"}, {"feature": "Social media promotion"}]'::jsonb, 
     TRUE, NOW() - INTERVAL '100 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM premium_plans WHERE id = 'premium-quarterly') THEN
    INSERT INTO premium_plans (id, name, price, currency, duration, description, features, is_active, created_at, updated_at)
    VALUES ('premium-quarterly', 'Premium Plus', 79.99, 'USD', 90, 'Extended premium visibility for serious sellers', 
     '[{"feature": "All Premium Listing features"}, {"feature": "Extended duration (90 days)"}, {"feature": "Featured in email newsletters"}, {"feature": "Premium badge on all listings"}, {"feature": "Highlighted in search results"}, {"feature": "Priority placement in similar properties"}, {"feature": "Dedicated account manager"}, {"feature": "Performance reports"}]'::jsonb, 
     TRUE, NOW() - INTERVAL '100 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM premium_plans WHERE id = 'premium-yearly') THEN
    INSERT INTO premium_plans (id, name, price, currency, duration, description, features, is_active, created_at, updated_at)
    VALUES ('premium-yearly', 'Premium Pro', 299.99, 'USD', 365, 'Maximum visibility for professional agents', 
     '[{"feature": "All Premium Plus features"}, {"feature": "Extended duration (365 days)"}, {"feature": "Featured on homepage"}, {"feature": "Professional photography service"}, {"feature": "Virtual tour creation"}, {"feature": "Social media marketing campaign"}, {"feature": "SEO optimization"}, {"feature": "Monthly performance reports"}]'::jsonb, 
     TRUE, NOW() - INTERVAL '100 days', NOW());
  END IF;
END $$;

-- Insert sample ad placements (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000601') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000601', 'Homepage Banner', 'Large banner at the top of the homepage', 'homepage_top', '{"width": 1200, "height": 300}'::jsonb, 2048, ARRAY['jpg', 'png', 'gif'], 100.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000602') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000602', 'Sidebar Ad', 'Ad displayed in the sidebar of property listings', 'listing_sidebar', '{"width": 300, "height": 250}'::jsonb, 1024, ARRAY['jpg', 'png'], 50.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000603') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000603', 'Search Results Banner', 'Banner displayed at the top of search results', 'search_top', '{"width": 728, "height": 90}'::jsonb, 1024, ARRAY['jpg', 'png'], 75.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000604') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000604', 'Property Detail Page', 'Ad displayed on property detail pages', 'property_detail', '{"width": 728, "height": 90}'::jsonb, 1024, ARRAY['jpg', 'png'], 60.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_placements WHERE id = '00000000-0000-4000-0000-000000000605') THEN
    INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000605', 'Mobile App Banner', 'Banner displayed in the mobile app', 'mobile_app', '{"width": 320, "height": 100}'::jsonb, 512, ARRAY['jpg', 'png'], 80.00, TRUE, NOW() - INTERVAL '90 days', NOW());
  END IF;
END $$;

-- Insert sample system settings (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM system_settings WHERE id = '00000000-0000-4000-0000-000000001201') THEN
    INSERT INTO system_settings (id, settings_data, updated_at)
    VALUES ('00000000-0000-4000-0000-000000001201', '{
      "general": {
        "siteName": "Properti Pro",
        "siteDescription": "Platform jual beli dan sewa properti terpercaya di Indonesia",
        "siteUrl": "https://propertipro.id",
        "adminEmail": "admin@propertipro.id",
        "supportEmail": "support@propertipro.id",
        "timezone": "Asia/Jakarta",
        "language": "id",
        "currency": "IDR",
        "dateFormat": "DD/MM/YYYY",
        "timeFormat": "HH:mm"
      },
      "features": {
        "userRegistration": true,
        "emailVerification": false,
        "propertyApproval": true,
        "autoPublish": false,
        "guestInquiries": true,
        "socialLogin": false,
        "multiLanguage": false,
        "darkMode": true,
        "maintenance": false
      },
      "limits": {
        "maxPropertiesPerUser": 20,
        "maxImagesPerProperty": 10,
        "maxFileSize": 5,
        "sessionTimeout": 60,
        "maxLoginAttempts": 5,
        "passwordMinLength": 8,
        "propertyTitleMaxLength": 100,
        "propertyDescriptionMaxLength": 2000
      },
      "email": {
        "provider": "smtp",
        "smtpHost": "smtp.example.com",
        "smtpPort": 587,
        "smtpUsername": "noreply@propertipro.id",
        "fromEmail": "noreply@propertipro.id",
        "fromName": "Properti Pro",
        "replyToEmail": "support@propertipro.id",
        "enableNotifications": true,
        "enableWelcomeEmail": true,
        "enablePropertyAlerts": true
      },
      "security": {
        "enableTwoFactor": false,
        "enableCaptcha": true,
        "captchaProvider": "recaptcha",
        "captchaSiteKey": "6LcXXXXXXXXXXXXXXXXXXXXX",
        "enableRateLimit": true,
        "rateLimitRequests": 100,
        "rateLimitWindow": 15,
        "enableIpBlocking": true,
        "blockedIps": [],
        "enableSsl": true,
        "enableHsts": true
      },
      "storage": {
        "provider": "local",
        "maxStorageSize": 10,
        "enableImageOptimization": true,
        "enableImageWatermark": false,
        "watermarkText": "Properti Pro"
      },
      "seo": {
        "enableSitemap": true,
        "enableRobotsTxt": true,
        "metaTitle": "Properti Pro - Jual Beli & Sewa Properti di Indonesia",
        "metaDescription": "Properti Pro adalah platform jual beli dan sewa properti terpercaya di Indonesia. Temukan rumah, apartemen, dan properti lainnya dengan mudah.",
        "metaKeywords": "properti, rumah, apartemen, jual beli properti, sewa properti, properti indonesia",
        "ogImage": "https://propertipro.id/og-image.jpg",
        "enableStructuredData": true
      },
      "social": {
        "facebookUrl": "https://facebook.com/propertipro",
        "twitterUrl": "https://twitter.com/propertipro",
        "instagramUrl": "https://instagram.com/propertipro",
        "linkedinUrl": "https://linkedin.com/company/propertipro",
        "youtubeUrl": "https://youtube.com/propertipro",
        "enableSocialSharing": true,
        "enableSocialLogin": false
      },
      "notifications": {
        "enableEmailNotifications": true,
        "enableSmsNotifications": false,
        "enablePushNotifications": false,
        "smsProvider": "twilio",
        "pushProvider": "firebase"
      },
      "backup": {
        "enableAutoBackup": true,
        "backupFrequency": "daily",
        "backupRetention": 30,
        "backupLocation": "local",
        "enableDatabaseBackup": true,
        "enableFileBackup": true,
        "lastBackupDate": "2023-06-27T00:00:00Z",
        "nextBackupDate": "2023-06-28T00:00:00Z"
      }
    }'::jsonb, NOW());
  END IF;
END $$;

-- Create sample users in auth.users first (this is a function that will be executed by the database)
DO $$
DECLARE
  user_id1 UUID := '00000000-0000-4000-0000-000000000101';
  user_id2 UUID := '00000000-0000-4000-0000-000000000102';
  user_id3 UUID := '00000000-0000-4000-0000-000000000103';
  user_id4 UUID := '00000000-0000-4000-0000-000000000104';
  user_id5 UUID := '00000000-0000-4000-0000-000000000105';
  user_id6 UUID := '00000000-0000-4000-0000-000000000106';
  user_id7 UUID := '00000000-0000-4000-0000-000000000107';
  user_id8 UUID := '00000000-0000-4000-0000-000000000108';
  user_id9 UUID := '00000000-0000-4000-0000-000000000109';
  user_id10 UUID := '00000000-0000-4000-0000-000000000110';
  user_id11 UUID := '00000000-0000-4000-0000-000000000111';
  user_id12 UUID := '00000000-0000-4000-0000-000000000112';
  
  -- Check if users already exist
  user_exists1 BOOLEAN;
  user_exists2 BOOLEAN;
  user_exists3 BOOLEAN;
  user_exists4 BOOLEAN;
  user_exists5 BOOLEAN;
  user_exists6 BOOLEAN;
  user_exists7 BOOLEAN;
  user_exists8 BOOLEAN;
  user_exists9 BOOLEAN;
  user_exists10 BOOLEAN;
  user_exists11 BOOLEAN;
  user_exists12 BOOLEAN;
  
  -- Check if emails already exist
  email_exists1 BOOLEAN;
  email_exists2 BOOLEAN;
  email_exists3 BOOLEAN;
  email_exists4 BOOLEAN;
  email_exists5 BOOLEAN;
  email_exists6 BOOLEAN;
  email_exists7 BOOLEAN;
  email_exists8 BOOLEAN;
  email_exists9 BOOLEAN;
  email_exists10 BOOLEAN;
  email_exists11 BOOLEAN;
  email_exists12 BOOLEAN;
BEGIN
  -- Check if users exist in auth.users
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id1) INTO user_exists1;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id2) INTO user_exists2;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id3) INTO user_exists3;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id4) INTO user_exists4;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id5) INTO user_exists5;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id6) INTO user_exists6;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id7) INTO user_exists7;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id8) INTO user_exists8;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id9) INTO user_exists9;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id10) INTO user_exists10;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id11) INTO user_exists11;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE id = user_id12) INTO user_exists12;
  
  -- Check if emails exist in auth.users
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'budi@example.com') INTO email_exists1;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'siti@example.com') INTO email_exists2;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'agus@wijayaproperty.com') INTO email_exists3;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dewi@anggrainirealty.com') INTO email_exists4;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'joko@example.com') INTO email_exists5;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rina@example.com') INTO email_exists6;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hadi@pranotoproperty.com') INTO email_exists7;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'maya@example.com') INTO email_exists8;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dian@permatarealty.com') INTO email_exists9;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'eko@example.com') INTO email_exists10;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'admin@propertipro.id') INTO email_exists11;
  SELECT EXISTS (SELECT 1 FROM auth.users WHERE email = 'superadmin@propertipro.id') INTO email_exists12;
  
  -- Create users in auth.users if they don't exist and their emails don't exist
  IF NOT user_exists1 AND NOT email_exists1 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id1, 'budi@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists2 AND NOT email_exists2 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id2, 'siti@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists3 AND NOT email_exists3 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id3, 'agus@wijayaproperty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists4 AND NOT email_exists4 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id4, 'dewi@anggrainirealty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists5 AND NOT email_exists5 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id5, 'joko@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists6 AND NOT email_exists6 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id6, 'rina@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists7 AND NOT email_exists7 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id7, 'hadi@pranotoproperty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists8 AND NOT email_exists8 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id8, 'maya@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists9 AND NOT email_exists9 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id9, 'dian@permatarealty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists10 AND NOT email_exists10 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id10, 'eko@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists11 AND NOT email_exists11 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id11, 'admin@propertipro.id', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists12 AND NOT email_exists12 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id12, 'superadmin@propertipro.id', NOW(), NOW(), NOW());
  END IF;
END $$;

-- Insert sample user profiles (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000101') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000101', 'Budi Santoso', '+6281234567890', 'user', 'active', 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg', NULL, NOW() - INTERVAL '60 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000102') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000102', 'Siti Rahayu', '+6281234567891', 'user', 'active', 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg', NULL, NOW() - INTERVAL '55 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000103') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000103', 'Agus Wijaya', '+6281234567892', 'agent', 'active', 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg', 'Wijaya Property', NOW() - INTERVAL '50 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000104') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000104', 'Dewi Anggraini', '+6281234567893', 'agent', 'active', 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg', 'Anggraini Realty', NOW() - INTERVAL '45 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000105') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000105', 'Joko Susilo', '+6281234567894', 'user', 'inactive', 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg', NULL, NOW() - INTERVAL '40 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000106') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000106', 'Rina Fitriani', '+6281234567895', 'user', 'active', 'https://images.pexels.com/photos/1065084/pexels-photo-1065084.jpeg', NULL, NOW() - INTERVAL '35 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000107') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000107', 'Hadi Pranoto', '+6281234567896', 'agent', 'active', 'https://images.pexels.com/photos/1516680/pexels-photo-1516680.jpeg', 'Pranoto Property', NOW() - INTERVAL '30 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000108') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000108', 'Maya Sari', '+6281234567897', 'user', 'suspended', 'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg', NULL, NOW() - INTERVAL '25 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000109') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000109', 'Dian Permata', '+6281234567898', 'agent', 'active', 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg', 'Permata Realty', NOW() - INTERVAL '20 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000110') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000110', 'Eko Prasetyo', '+6281234567899', 'user', 'active', 'https://images.pexels.com/photos/1121796/pexels-photo-1121796.jpeg', NULL, NOW() - INTERVAL '15 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000111') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000111', 'Admin User', '+6281234567810', 'admin', 'active', 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg', 'Properti Pro', NOW() - INTERVAL '100 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM user_profiles WHERE id = '00000000-0000-4000-0000-000000000112') THEN
    INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000112', 'Super Admin', '+6281234567811', 'superadmin', 'active', 'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg', 'Properti Pro', NOW() - INTERVAL '120 days', NOW());
  END IF;
END $$;

-- Insert sample listings (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000301') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000103', 'Rumah Mewah 2 Lantai di Jakarta Selatan', 'Rumah mewah 2 lantai dengan kolam renang pribadi, taman luas, dan garasi untuk 2 mobil. Lokasi strategis dekat dengan pusat perbelanjaan dan sekolah internasional.', 2.5, 'miliar', 'rumah', 'jual', 4, 3, 200, 300, 'p1', 'c2', 'd3', 'Jl. Kemang Raya No. 10', '12730', ARRAY['Kolam Renang', 'Taman', 'Garasi', 'Keamanan 24 Jam', 'AC'], 'active', 120, 5, TRUE, NOW() - INTERVAL '30 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000302') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000302', '00000000-0000-4000-0000-000000000104', 'Apartemen Studio di Pusat Kota Jakarta', 'Apartemen studio modern dengan pemandangan kota yang menakjubkan. Dilengkapi dengan fasilitas gym, kolam renang, dan area BBQ. Akses mudah ke transportasi umum.', 800, 'juta', 'apartemen', 'jual', 1, 1, 45, NULL, 'p1', 'c1', 'd1', 'Apartemen Central Park Tower A Unit 12F', '10730', ARRAY['Gym', 'Kolam Renang', 'Area BBQ', 'Keamanan 24 Jam', 'Parkir'], 'active', 85, 3, TRUE, NOW() - INTERVAL '25 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000303') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000303', '00000000-0000-4000-0000-000000000107', 'Ruko 3 Lantai di Kawasan Bisnis Bandung', 'Ruko strategis 3 lantai di kawasan bisnis Bandung. Cocok untuk kantor, toko, atau restoran. Luas bangunan 150m² dengan 3 kamar mandi.', 1.8, 'miliar', 'ruko', 'jual', NULL, 3, 150, 50, 'p2', 'c6', 'd7', 'Jl. Pasir Kaliki No. 25', '40171', ARRAY['Listrik 3 Phase', 'Air PAM', 'Line Telepon', 'Parkir Luas'], 'active', 65, 2, FALSE, NOW() - INTERVAL '20 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000304') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000304', '00000000-0000-4000-0000-000000000109', 'Tanah Kavling Siap Bangun di Bogor', 'Tanah kavling siap bangun dengan luas 200m². Lokasi strategis di kawasan berkembang Bogor. Cocok untuk rumah tinggal atau investasi.', 500, 'juta', 'tanah', 'jual', NULL, NULL, NULL, 200, 'p2', 'c7', NULL, 'Jl. Raya Bogor KM 30', '16720', ARRAY['SHM', 'Listrik', 'Air PAM', 'Jalan Lebar'], 'active', 45, 1, FALSE, NOW() - INTERVAL '15 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM listings WHERE id = '00000000-0000-4000-0000-000000000305') THEN
    INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000305', '00000000-0000-4000-0000-000000000103', 'Rumah Minimalis di Depok', 'Rumah minimalis modern dengan 3 kamar tidur dan 2 kamar mandi. Desain terbuka dengan pencahayaan alami yang baik. Lokasi tenang dan nyaman.', 1.2, 'miliar', 'rumah', 'jual', 3, 2, 120, 150, 'p2', 'c8', NULL, 'Jl. Margonda Raya No. 45', '16424', ARRAY['Carport', 'Taman', 'Listrik 2200 VA', 'Air PAM'], 'active', 78, 3, FALSE, NOW() - INTERVAL '10 days', NOW());
  END IF;
END $$;

-- Insert sample property media (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000401') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000401', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg', 'image', TRUE, NOW(), NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000402') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000402', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1643384/pexels-photo-1643384.jpeg', 'image', FALSE, NOW(), NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000403') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000403', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg', 'image', FALSE, NOW(), NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000404') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000404', '00000000-0000-4000-0000-000000000302', 'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg', 'image', TRUE, NOW(), NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM property_media WHERE id = '00000000-0000-4000-0000-000000000405') THEN
    INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000405', '00000000-0000-4000-0000-000000000302', 'https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg', 'image', FALSE, NOW(), NOW());
  END IF;
END $$;

-- Insert sample premium listings (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM premium_listings WHERE id = '00000000-0000-4000-0000-000000000501') THEN
    INSERT INTO premium_listings (id, property_id, user_id, plan_id, status, start_date, end_date, payment_id, analytics_views, analytics_inquiries, analytics_favorites, analytics_conversion_rate, analytics_daily_views, analytics_top_sources, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000501', '00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000103', 'premium-monthly', 'active', NOW() - INTERVAL '15 days', NOW() + INTERVAL '15 days', NULL, 120, 5, 10, 4.2, 
     '[{"date":"2023-06-15","views":10},{"date":"2023-06-16","views":15},{"date":"2023-06-17","views":12},{"date":"2023-06-18","views":8},{"date":"2023-06-19","views":20},{"date":"2023-06-20","views":18},{"date":"2023-06-21","views":22},{"date":"2023-06-22","views":15}]'::jsonb, 
     '[{"source":"direct","count":50},{"source":"google","count":40},{"source":"facebook","count":20},{"source":"instagram","count":10}]'::jsonb, 
     NOW() - INTERVAL '15 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM premium_listings WHERE id = '00000000-0000-4000-0000-000000000502') THEN
    INSERT INTO premium_listings (id, property_id, user_id, plan_id, status, start_date, end_date, payment_id, analytics_views, analytics_inquiries, analytics_favorites, analytics_conversion_rate, analytics_daily_views, analytics_top_sources, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000502', '00000000-0000-4000-0000-000000000302', '00000000-0000-4000-0000-000000000104', 'premium-monthly', 'active', NOW() - INTERVAL '10 days', NOW() + INTERVAL '20 days', NULL, 85, 3, 7, 3.5, 
     '[{"date":"2023-06-18","views":8},{"date":"2023-06-19","views":12},{"date":"2023-06-20","views":15},{"date":"2023-06-21","views":10},{"date":"2023-06-22","views":18},{"date":"2023-06-23","views":12},{"date":"2023-06-24","views":10}]'::jsonb, 
     '[{"source":"direct","count":30},{"source":"google","count":25},{"source":"facebook","count":15},{"source":"instagram","count":15}]'::jsonb, 
     NOW() - INTERVAL '10 days', NOW());
  END IF;
END $$;

-- Insert sample advertiser accounts (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM advertiser_accounts WHERE id = '00000000-0000-4000-0000-000000000701') THEN
    INSERT INTO advertiser_accounts (id, user_id, company_name, contact_email, contact_phone, billing_address, payment_method, credit_balance, status, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000701', '00000000-0000-4000-0000-000000000103', 'Wijaya Property', 'agus@wijayaproperty.com', '+6281234567892', '{"address": "Jl. Sudirman No. 123", "city": "Jakarta", "postal_code": "10220", "country": "ID"}'::jsonb, '{"type": "credit_card", "last4": "1234"}'::jsonb, 500.00, 'active', NOW() - INTERVAL '60 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM advertiser_accounts WHERE id = '00000000-0000-4000-0000-000000000702') THEN
    INSERT INTO advertiser_accounts (id, user_id, company_name, contact_email, contact_phone, billing_address, payment_method, credit_balance, status, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000702', '00000000-0000-4000-0000-000000000104', 'Anggraini Realty', 'dewi@anggrainirealty.com', '+6281234567893', '{"address": "Jl. Gatot Subroto No. 45", "city": "Jakarta", "postal_code": "10270", "country": "ID"}'::jsonb, '{"type": "bank_transfer", "bank": "BCA"}'::jsonb, 750.00, 'active', NOW() - INTERVAL '55 days', NOW());
  END IF;
END $$;

-- Insert sample ad campaigns (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE id = '00000000-0000-4000-0000-000000000801') THEN
    INSERT INTO ad_campaigns (id, advertiser_id, name, description, budget, daily_budget, start_date, end_date, targeting_options, status, total_spent, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000801', '00000000-0000-4000-0000-000000000701', 'Summer Property Promotion', 'Promoting luxury properties for summer season', 1000.00, 50.00, NOW() - INTERVAL '30 days', NOW() + INTERVAL '30 days', '{"geographic": {"cities": ["Jakarta", "Bandung", "Surabaya"]}, "behavioral": {"property_types": ["rumah", "apartemen"]}}'::jsonb, 'active', 500.00, NOW() - INTERVAL '35 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE id = '00000000-0000-4000-0000-000000000802') THEN
    INSERT INTO ad_campaigns (id, advertiser_id, name, description, budget, daily_budget, start_date, end_date, targeting_options, status, total_spent, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000802', '00000000-0000-4000-0000-000000000702', 'Apartment Special Deals', 'Promoting special deals on apartments', 800.00, 40.00, NOW() - INTERVAL '20 days', NOW() + INTERVAL '40 days', '{"geographic": {"cities": ["Jakarta"]}, "behavioral": {"property_types": ["apartemen"]}}'::jsonb, 'active', 300.00, NOW() - INTERVAL '25 days', NOW());
  END IF;
END $$;

-- Insert sample advertisements (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM advertisements WHERE id = '00000000-0000-4000-0000-000000000901') THEN
    INSERT INTO advertisements (id, campaign_id, placement_id, title, description, image_url, video_url, click_url, alt_text, ad_type, content, status, priority, weight, impressions_count, clicks_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000000801', '00000000-0000-4000-0000-000000000601', 'Luxury Homes in Jakarta', 'Discover your dream luxury home in Jakarta', 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg', NULL, 'https://propertipro.id/jual?type=rumah', 'Luxury homes in Jakarta', 'banner', '{"headline": "Luxury Living", "cta": "View Properties"}'::jsonb, 'active', 10, 10, 1500, 75, NOW() - INTERVAL '30 days', NOW());
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM advertisements WHERE id = '00000000-0000-4000-0000-000000000902') THEN
    INSERT INTO advertisements (id, campaign_id, placement_id, title, description, image_url, video_url, click_url, alt_text, ad_type, content, status, priority, weight, impressions_count, clicks_count, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000000902', '00000000-0000-4000-0000-000000000802', '00000000-0000-4000-0000-000000000602', 'Modern Apartments', 'Stylish apartments in the heart of the city', 'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg', NULL, 'https://propertipro.id/jual?type=apartemen', 'Modern apartments', 'sidebar', '{"headline": "Urban Living", "cta": "Learn More"}'::jsonb, 'active', 8, 8, 1200, 60, NOW() - INTERVAL '25 days', NOW());
  END IF;
END $$;

-- Insert sample reports (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM reports WHERE id = '00000000-0000-4000-0000-000000001001') THEN
    INSERT INTO reports (id, property_id, reporter_id, reporter_name, reporter_email, type, reason, description, status, priority, resolved_at, resolved_by, resolution, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000001001', '00000000-0000-4000-0000-000000000305', '00000000-0000-4000-0000-000000000101', 'Budi Santoso', 'budi@example.com', 'fake_listing', 'Properti ini tidak ada di lokasi yang disebutkan', 'Saya sudah mengunjungi lokasi dan tidak menemukan properti seperti yang dijelaskan dalam iklan.', 'pending', 'high', NULL, NULL, NULL, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days');
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM reports WHERE id = '00000000-0000-4000-0000-000000001002') THEN
    INSERT INTO reports (id, property_id, reporter_id, reporter_name, reporter_email, type, reason, description, status, priority, resolved_at, resolved_by, resolution, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000001002', '00000000-0000-4000-0000-000000000308', '00000000-0000-4000-0000-000000000102', 'Siti Rahayu', 'siti@example.com', 'wrong_category', 'Properti ini seharusnya masuk kategori ruko, bukan gedung komersial', 'Bangunan ini hanya 2 lantai dan lebih cocok dikategorikan sebagai ruko.', 'under_review', 'medium', NULL, NULL, NULL, NOW() - INTERVAL '4 days', NOW() - INTERVAL '3 days');
  END IF;
END $$;

-- Insert sample moderation actions (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM moderation_actions WHERE id = '00000000-0000-4000-0000-000000001101') THEN
    INSERT INTO moderation_actions (id, report_id, property_id, admin_id, admin_name, action, reason, details, previous_status, new_status, created_at)
    VALUES ('00000000-0000-4000-0000-000000001101', '00000000-0000-4000-0000-000000001003', '00000000-0000-4000-0000-000000000312', '00000000-0000-4000-0000-000000000111', 'Admin User', 'edit_content', 'Menghapus konten yang tidak pantas', 'Beberapa kata dalam deskripsi telah dihapus karena tidak sesuai dengan ketentuan platform.', 'active', 'active', NOW() - INTERVAL '1 day');
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM moderation_actions WHERE id = '00000000-0000-4000-0000-000000001102') THEN
    INSERT INTO moderation_actions (id, report_id, property_id, admin_id, admin_name, action, reason, details, previous_status, new_status, created_at)
    VALUES ('00000000-0000-4000-0000-000000001102', '00000000-0000-4000-0000-000000001005', '00000000-0000-4000-0000-000000000317', '00000000-0000-4000-0000-000000000111', 'Admin User', 'dismiss_report', 'Laporan tidak valid', 'Harga properti adalah kebijakan penjual dan tidak melanggar ketentuan platform.', 'active', 'active', NOW() - INTERVAL '1 day');
  END IF;
END $$;

-- Insert sample ad impressions and clicks (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_impressions WHERE id = '00000000-0000-4000-0000-000000001401') THEN
    INSERT INTO ad_impressions (id, ad_id, user_id, session_id, ip_address, user_agent, page_url, referrer, device_type, browser, created_at)
    VALUES ('00000000-0000-4000-0000-000000001401', '00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000000101', 'session_123456', '192.168.1.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'https://propertipro.id/', 'https://google.com', 'desktop', 'Chrome', NOW() - INTERVAL '5 days');
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM ad_impressions WHERE id = '00000000-0000-4000-0000-000000001402') THEN
    INSERT INTO ad_impressions (id, ad_id, user_id, session_id, ip_address, user_agent, page_url, referrer, device_type, browser, created_at)
    VALUES ('00000000-0000-4000-0000-000000001402', '00000000-0000-4000-0000-000000000902', '00000000-0000-4000-0000-000000000102', 'session_123457', '192.168.1.2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1', 'https://propertipro.id/jual', 'https://facebook.com', 'mobile', 'Safari', NOW() - INTERVAL '4 days');
  END IF;
END $$;

-- Insert sample ad clicks (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_clicks WHERE id = '00000000-0000-4000-0000-000000001501') THEN
    INSERT INTO ad_clicks (id, ad_id, impression_id, user_id, session_id, ip_address, user_agent, page_url, referrer, device_type, browser, created_at)
    VALUES ('00000000-0000-4000-0000-000000001501', '00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000001401', '00000000-0000-4000-0000-000000000101', 'session_123456', '192.168.1.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'https://propertipro.id/', 'https://google.com', 'desktop', 'Chrome', NOW() - INTERVAL '5 days');
  END IF;
END $$;

-- Insert sample ad payments (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ad_payments WHERE id = '00000000-0000-4000-0000-000000001601') THEN
    INSERT INTO ad_payments (id, advertiser_id, campaign_id, amount, currency, payment_method, transaction_id, status, payment_date, created_at, updated_at)
    VALUES ('00000000-0000-4000-0000-000000001601', '00000000-0000-4000-0000-000000000701', '00000000-0000-4000-0000-000000000801', 500.00, 'USD', 'credit_card', 'txn_123456789', 'paid', NOW() - INTERVAL '35 days', NOW() - INTERVAL '35 days', NOW() - INTERVAL '35 days');
  END IF;
END $$;

-- Insert sample activity logs (only if they don't exist)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM activity_logs WHERE id = '00000000-0000-4000-0000-000000001301') THEN
    INSERT INTO activity_logs (id, user_id, user_name, action, resource, resource_id, details, ip_address, user_agent, created_at)
    VALUES ('00000000-0000-4000-0000-000000001301', '00000000-0000-4000-0000-000000000111', 'Admin User', 'CREATE_USER', 'user_profiles', '00000000-0000-4000-0000-000000000110', 'Created new user account', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '15 days');
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM activity_logs WHERE id = '00000000-0000-4000-0000-000000001302') THEN
    INSERT INTO activity_logs (id, user_id, user_name, action, resource, resource_id, details, ip_address, user_agent, created_at)
    VALUES ('00000000-0000-4000-0000-000000001302', '00000000-0000-4000-0000-000000000112', 'Super Admin', 'UPDATE_SETTINGS', 'system_settings', '00000000-0000-4000-0000-000000001201', 'Updated system settings', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '10 days');
  END IF;
END $$;