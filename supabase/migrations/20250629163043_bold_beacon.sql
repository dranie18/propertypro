/*
# Sample Data Migration

This migration adds sample data to the database for development and testing purposes.

1. Categories - Property types like houses, apartments, etc.
2. Premium plans - Subscription plans for premium listings
3. Ad placements - Locations for advertisements on the platform
4. System settings - Global application settings
5. Users - Sample user accounts with different roles
6. Listings - Property listings with various types and statuses
7. Property media - Images for property listings
8. Premium listings - Enhanced property listings with analytics
9. Advertiser accounts - Accounts for ad campaigns
10. Ad campaigns - Marketing campaigns for properties
11. Advertisements - Actual ads displayed on the platform
12. Reports - User reports about properties
13. Moderation actions - Admin actions on reports
14. Ad impressions and clicks - Analytics data for ads
15. Activity logs - System activity records
*/

-- Insert sample categories
INSERT INTO categories (id, name, slug, description, icon, is_active, property_count, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000201', 'Rumah', 'rumah', 'Berbagai pilihan rumah untuk keluarga', 'Home', TRUE, 15, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000202', 'Apartemen', 'apartemen', 'Apartemen modern dengan fasilitas lengkap', 'Building2', TRUE, 10, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000203', 'Ruko', 'ruko', 'Ruko strategis untuk bisnis Anda', 'Store', TRUE, 5, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000204', 'Tanah', 'tanah', 'Tanah kavling siap bangun', 'MapPin', TRUE, 8, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000205', 'Kondominium', 'kondominium', 'Kondominium mewah dengan pemandangan kota', 'Building', TRUE, 3, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000206', 'Gedung Komersial', 'gedung-komersial', 'Gedung komersial untuk kantor dan bisnis', 'Building', TRUE, 2, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000207', 'Ruang Industri', 'ruang-industri', 'Ruang industri dan gudang', 'Warehouse', TRUE, 1, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000208', 'Villa', 'villa', 'Villa mewah untuk liburan', 'Home', FALSE, 0, NOW() - INTERVAL '90 days', NOW());

-- Insert sample premium plans
INSERT INTO premium_plans (id, name, price, currency, duration, description, features, is_active, created_at, updated_at)
VALUES
  ('premium-monthly', 'Premium Listing', 29.99, 'USD', 30, 'Boost your property visibility with premium features', 
   '[{"feature": "Featured placement at top of search results"}, {"feature": "Golden highlighted border"}, {"feature": "Larger photo gallery (up to 20 images)"}, {"feature": "Extended listing duration (30 days)"}, {"feature": "Virtual tour integration"}, {"feature": "Detailed analytics dashboard"}, {"feature": "Priority customer support"}, {"feature": "Social media promotion"}]'::jsonb, 
   TRUE, NOW() - INTERVAL '100 days', NOW()),
  ('premium-quarterly', 'Premium Plus', 79.99, 'USD', 90, 'Extended premium visibility for serious sellers', 
   '[{"feature": "All Premium Listing features"}, {"feature": "Extended duration (90 days)"}, {"feature": "Featured in email newsletters"}, {"feature": "Premium badge on all listings"}, {"feature": "Highlighted in search results"}, {"feature": "Priority placement in similar properties"}, {"feature": "Dedicated account manager"}, {"feature": "Performance reports"}]'::jsonb, 
   TRUE, NOW() - INTERVAL '100 days', NOW()),
  ('premium-yearly', 'Premium Pro', 299.99, 'USD', 365, 'Maximum visibility for professional agents', 
   '[{"feature": "All Premium Plus features"}, {"feature": "Extended duration (365 days)"}, {"feature": "Featured on homepage"}, {"feature": "Professional photography service"}, {"feature": "Virtual tour creation"}, {"feature": "Social media marketing campaign"}, {"feature": "SEO optimization"}, {"feature": "Monthly performance reports"}]'::jsonb, 
   TRUE, NOW() - INTERVAL '100 days', NOW());

-- Insert sample ad placements
INSERT INTO ad_placements (id, name, description, location, dimensions, max_file_size, allowed_formats, base_price, is_active, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000601', 'Homepage Banner', 'Large banner at the top of the homepage', 'homepage_top', '{"width": 1200, "height": 300}'::jsonb, 2048, ARRAY['jpg', 'png', 'gif'], 100.00, TRUE, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000602', 'Sidebar Ad', 'Ad displayed in the sidebar of property listings', 'listing_sidebar', '{"width": 300, "height": 250}'::jsonb, 1024, ARRAY['jpg', 'png'], 50.00, TRUE, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000603', 'Search Results Banner', 'Banner displayed at the top of search results', 'search_top', '{"width": 728, "height": 90}'::jsonb, 1024, ARRAY['jpg', 'png'], 75.00, TRUE, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000604', 'Property Detail Page', 'Ad displayed on property detail pages', 'property_detail', '{"width": 728, "height": 90}'::jsonb, 1024, ARRAY['jpg', 'png'], 60.00, TRUE, NOW() - INTERVAL '90 days', NOW()),
  ('00000000-0000-4000-0000-000000000605', 'Mobile App Banner', 'Banner displayed in the mobile app', 'mobile_app', '{"width": 320, "height": 100}'::jsonb, 512, ARRAY['jpg', 'png'], 80.00, TRUE, NOW() - INTERVAL '90 days', NOW());

-- Insert sample system settings
INSERT INTO system_settings (id, settings_data, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000001201', '{
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
  
  -- Create users in auth.users if they don't exist
  IF NOT user_exists1 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id1, 'budi@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists2 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id2, 'siti@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists3 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id3, 'agus@wijayaproperty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists4 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id4, 'dewi@anggrainirealty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists5 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id5, 'joko@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists6 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id6, 'rina@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists7 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id7, 'hadi@pranotoproperty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists8 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id8, 'maya@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists9 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id9, 'dian@permatarealty.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists10 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id10, 'eko@example.com', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists11 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id11, 'admin@propertipro.id', NOW(), NOW(), NOW());
  END IF;
  
  IF NOT user_exists12 THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at, updated_at)
    VALUES (user_id12, 'superadmin@propertipro.id', NOW(), NOW(), NOW());
  END IF;
END $$;

-- Insert sample user profiles (now that we've ensured the auth.users exist)
INSERT INTO user_profiles (id, full_name, phone, role, status, avatar_url, company, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000101', 'Budi Santoso', '+6281234567890', 'user', 'active', 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg', NULL, NOW() - INTERVAL '60 days', NOW()),
  ('00000000-0000-4000-0000-000000000102', 'Siti Rahayu', '+6281234567891', 'user', 'active', 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg', NULL, NOW() - INTERVAL '55 days', NOW()),
  ('00000000-0000-4000-0000-000000000103', 'Agus Wijaya', '+6281234567892', 'agent', 'active', 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg', 'Wijaya Property', NOW() - INTERVAL '50 days', NOW()),
  ('00000000-0000-4000-0000-000000000104', 'Dewi Anggraini', '+6281234567893', 'agent', 'active', 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg', 'Anggraini Realty', NOW() - INTERVAL '45 days', NOW()),
  ('00000000-0000-4000-0000-000000000105', 'Joko Susilo', '+6281234567894', 'user', 'inactive', 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg', NULL, NOW() - INTERVAL '40 days', NOW()),
  ('00000000-0000-4000-0000-000000000106', 'Rina Fitriani', '+6281234567895', 'user', 'active', 'https://images.pexels.com/photos/1065084/pexels-photo-1065084.jpeg', NULL, NOW() - INTERVAL '35 days', NOW()),
  ('00000000-0000-4000-0000-000000000107', 'Hadi Pranoto', '+6281234567896', 'agent', 'active', 'https://images.pexels.com/photos/1516680/pexels-photo-1516680.jpeg', 'Pranoto Property', NOW() - INTERVAL '30 days', NOW()),
  ('00000000-0000-4000-0000-000000000108', 'Maya Sari', '+6281234567897', 'user', 'suspended', 'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg', NULL, NOW() - INTERVAL '25 days', NOW()),
  ('00000000-0000-4000-0000-000000000109', 'Dian Permata', '+6281234567898', 'agent', 'active', 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg', 'Permata Realty', NOW() - INTERVAL '20 days', NOW()),
  ('00000000-0000-4000-0000-000000000110', 'Eko Prasetyo', '+6281234567899', 'user', 'active', 'https://images.pexels.com/photos/1121796/pexels-photo-1121796.jpeg', NULL, NOW() - INTERVAL '15 days', NOW()),
  ('00000000-0000-4000-0000-000000000111', 'Admin User', '+6281234567810', 'admin', 'active', 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg', 'Properti Pro', NOW() - INTERVAL '100 days', NOW()),
  ('00000000-0000-4000-0000-000000000112', 'Super Admin', '+6281234567811', 'superadmin', 'active', 'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg', 'Properti Pro', NOW() - INTERVAL '120 days', NOW());

-- Insert sample listings
INSERT INTO listings (id, user_id, title, description, price, price_unit, property_type, purpose, bedrooms, bathrooms, building_size, land_size, province_id, city_id, district_id, address, postal_code, features, status, views, inquiries, is_promoted, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000103', 'Rumah Mewah 2 Lantai di Jakarta Selatan', 'Rumah mewah 2 lantai dengan kolam renang pribadi, taman luas, dan garasi untuk 2 mobil. Lokasi strategis dekat dengan pusat perbelanjaan dan sekolah internasional.', 2.5, 'miliar', 'rumah', 'jual', 4, 3, 200, 300, 'p1', 'c2', 'd3', 'Jl. Kemang Raya No. 10', '12730', ARRAY['Kolam Renang', 'Taman', 'Garasi', 'Keamanan 24 Jam', 'AC'], 'active', 120, 5, TRUE, NOW() - INTERVAL '30 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000302', '00000000-0000-4000-0000-000000000104', 'Apartemen Studio di Pusat Kota Jakarta', 'Apartemen studio modern dengan pemandangan kota yang menakjubkan. Dilengkapi dengan fasilitas gym, kolam renang, dan area BBQ. Akses mudah ke transportasi umum.', 800, 'juta', 'apartemen', 'jual', 1, 1, 45, NULL, 'p1', 'c1', 'd1', 'Apartemen Central Park Tower A Unit 12F', '10730', ARRAY['Gym', 'Kolam Renang', 'Area BBQ', 'Keamanan 24 Jam', 'Parkir'], 'active', 85, 3, TRUE, NOW() - INTERVAL '25 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000303', '00000000-0000-4000-0000-000000000107', 'Ruko 3 Lantai di Kawasan Bisnis Bandung', 'Ruko strategis 3 lantai di kawasan bisnis Bandung. Cocok untuk kantor, toko, atau restoran. Luas bangunan 150m² dengan 3 kamar mandi.', 1.8, 'miliar', 'ruko', 'jual', NULL, 3, 150, 50, 'p2', 'c6', 'd7', 'Jl. Pasir Kaliki No. 25', '40171', ARRAY['Listrik 3 Phase', 'Air PAM', 'Line Telepon', 'Parkir Luas'], 'active', 65, 2, FALSE, NOW() - INTERVAL '20 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000304', '00000000-0000-4000-0000-000000000109', 'Tanah Kavling Siap Bangun di Bogor', 'Tanah kavling siap bangun dengan luas 200m². Lokasi strategis di kawasan berkembang Bogor. Cocok untuk rumah tinggal atau investasi.', 500, 'juta', 'tanah', 'jual', NULL, NULL, NULL, 200, 'p2', 'c7', NULL, 'Jl. Raya Bogor KM 30', '16720', ARRAY['SHM', 'Listrik', 'Air PAM', 'Jalan Lebar'], 'active', 45, 1, FALSE, NOW() - INTERVAL '15 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000305', '00000000-0000-4000-0000-000000000103', 'Rumah Minimalis di Depok', 'Rumah minimalis modern dengan 3 kamar tidur dan 2 kamar mandi. Desain terbuka dengan pencahayaan alami yang baik. Lokasi tenang dan nyaman.', 1.2, 'miliar', 'rumah', 'jual', 3, 2, 120, 150, 'p2', 'c8', NULL, 'Jl. Margonda Raya No. 45', '16424', ARRAY['Carport', 'Taman', 'Listrik 2200 VA', 'Air PAM'], 'active', 78, 3, FALSE, NOW() - INTERVAL '10 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000306', '00000000-0000-4000-0000-000000000104', 'Apartemen 2BR di Bekasi', 'Apartemen 2 kamar tidur dengan pemandangan kota. Lokasi strategis dekat dengan mall dan stasiun. Fasilitas lengkap dan keamanan 24 jam.', 650, 'juta', 'apartemen', 'jual', 2, 1, 65, NULL, 'p2', 'c9', NULL, 'Apartemen Grand Bekasi Tower B Unit 15A', '17214', ARRAY['Kolam Renang', 'Gym', 'Taman Bermain', 'Jogging Track'], 'pending', 0, 0, FALSE, NOW() - INTERVAL '5 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000307', '00000000-0000-4000-0000-000000000107', 'Kondominium Mewah di Surabaya', 'Kondominium mewah dengan pemandangan laut. Dilengkapi dengan fasilitas premium seperti jacuzzi, sauna, dan private lift. Keamanan 24 jam.', 3.5, 'miliar', 'kondominium', 'jual', 3, 3, 180, NULL, 'p4', 'c11', NULL, 'The Peak Residence Tower A Unit PH-01', '60226', ARRAY['Private Lift', 'Jacuzzi', 'Sauna', 'Smart Home System', 'Balkon Luas'], 'active', 95, 4, TRUE, NOW() - INTERVAL '40 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000308', '00000000-0000-4000-0000-000000000109', 'Gedung Komersial 4 Lantai di Semarang', 'Gedung komersial 4 lantai dengan luas bangunan 800m². Cocok untuk kantor, hotel, atau pusat bisnis. Lokasi strategis di pusat kota.', 15, 'miliar', 'gedung_komersial', 'jual', NULL, 8, 800, 400, 'p3', 'c10', NULL, 'Jl. Pandanaran No. 15', '50241', ARRAY['Lift', 'Genset', 'Parkir Luas', 'CCTV', 'Fire Alarm System'], 'active', 60, 2, FALSE, NOW() - INTERVAL '35 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000309', '00000000-0000-4000-0000-000000000103', 'Rumah Kost 15 Kamar di Yogyakarta', 'Rumah kost dengan 15 kamar yang sudah beroperasi. Lokasi strategis dekat kampus. Penghasilan pasif Rp 15 juta per bulan.', 2.2, 'miliar', 'rumah', 'jual', 15, 5, 250, 300, 'p3', 'c10', NULL, 'Jl. Kaliurang KM 5 No. 10', '55281', ARRAY['Wifi', 'Dapur Bersama', 'Ruang Tamu', 'Parkir Motor', 'CCTV'], 'active', 88, 4, FALSE, NOW() - INTERVAL '28 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000310', '00000000-0000-4000-0000-000000000104', 'Rumah Mewah di Bali', 'Villa mewah dengan pemandangan sawah dan laut. Desain modern dengan sentuhan Bali. Kolam renang infinity dan taman tropis.', 5, 'miliar', 'rumah', 'jual', 4, 5, 300, 500, 'p6', 'c14', NULL, 'Jl. Sunset Road No. 88', '80361', ARRAY['Kolam Renang Infinity', 'Taman Tropis', 'Outdoor Jacuzzi', 'Gazebo', 'Smart Home'], 'active', 150, 8, TRUE, NOW() - INTERVAL '45 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000311', '00000000-0000-4000-0000-000000000107', 'Apartemen Disewakan di Jakarta Pusat', 'Apartemen 2 kamar tidur fully furnished. Lokasi strategis di pusat kota. Tersedia untuk kontrak tahunan.', 15, 'juta', 'apartemen', 'sewa', 2, 1, 70, NULL, 'p1', 'c1', NULL, 'Thamrin Residence Tower A Unit 12B', '10230', ARRAY['Fully Furnished', 'AC', 'Water Heater', 'TV', 'Kulkas'], 'active', 110, 6, TRUE, NOW() - INTERVAL '15 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000312', '00000000-0000-4000-0000-000000000109', 'Ruko Disewakan di Bandung', 'Ruko 2 lantai di kawasan bisnis Bandung. Cocok untuk berbagai jenis usaha. Tersedia untuk kontrak minimal 2 tahun.', 25, 'juta', 'ruko', 'sewa', NULL, 2, 100, 50, 'p2', 'c6', NULL, 'Jl. Braga No. 45', '40111', ARRAY['Listrik 3 Phase', 'Air PAM', 'Line Telepon', 'Parkir Depan'], 'active', 75, 3, FALSE, NOW() - INTERVAL '20 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000313', '00000000-0000-4000-0000-000000000103', 'Rumah Kontrakan di Malang', 'Rumah nyaman dengan 3 kamar tidur. Lokasi tenang dan asri. Tersedia untuk kontrak tahunan.', 35, 'juta', 'rumah', 'sewa', 3, 2, 120, 150, 'p4', 'c11', NULL, 'Jl. Soekarno Hatta No. 55', '65141', ARRAY['Carport', 'Taman', 'Pagar', 'Listrik 2200 VA'], 'active', 65, 2, FALSE, NOW() - INTERVAL '25 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000314', '00000000-0000-4000-0000-000000000104', 'Gedung Kantor di Makassar', 'Gedung kantor 3 lantai dengan luas bangunan 500m². Lokasi strategis di pusat bisnis Makassar. Tersedia untuk kontrak minimal 3 tahun.', 150, 'juta', 'gedung_komersial', 'sewa', NULL, 6, 500, 300, 'p8', 'c16', NULL, 'Jl. Pengayoman No. 12', '90231', ARRAY['Lift', 'Genset', 'Parkir Luas', 'CCTV', 'Ruang Meeting'], 'active', 55, 1, FALSE, NOW() - INTERVAL '30 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000315', '00000000-0000-4000-0000-000000000107', 'Rumah Mewah di Jakarta Selatan', 'Rumah mewah dengan desain modern minimalis. Lokasi premium di kawasan elit Jakarta Selatan. Lingkungan aman dan nyaman.', 4.5, 'miliar', 'rumah', 'jual', 5, 5, 350, 450, 'p1', 'c2', NULL, 'Jl. Senopati No. 15', '12110', ARRAY['Kolam Renang', 'Taman', 'Smart Home', 'Gym', 'Home Theater'], 'active', 130, 7, TRUE, NOW() - INTERVAL '18 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000316', '00000000-0000-4000-0000-000000000109', 'Apartemen 3BR di Surabaya', 'Apartemen mewah 3 kamar tidur dengan pemandangan laut. Fasilitas premium dan lokasi strategis di pusat kota Surabaya.', 1.8, 'miliar', 'apartemen', 'jual', 3, 2, 120, NULL, 'p4', 'c11', NULL, 'Ciputra World Residence Tower A Unit 25F', '60293', ARRAY['Kolam Renang', 'Gym', 'Sauna', 'Taman Bermain', 'Sky Lounge'], 'active', 95, 4, TRUE, NOW() - INTERVAL '22 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000317', '00000000-0000-4000-0000-000000000103', 'Tanah Komersial di Denpasar', 'Tanah komersial strategis di jalan utama Denpasar. Cocok untuk hotel, mall, atau pusat bisnis. Luas 1000m² dengan akses mudah.', 10, 'miliar', 'tanah', 'jual', NULL, NULL, NULL, 1000, 'p6', 'c14', NULL, 'Jl. Bypass Ngurah Rai No. 100', '80361', ARRAY['SHM', 'Jalan Lebar', 'Listrik', 'Air PAM'], 'active', 70, 2, FALSE, NOW() - INTERVAL '27 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000318', '00000000-0000-4000-0000-000000000104', 'Rumah Kos Eksklusif di Yogyakarta', 'Rumah kos eksklusif dengan 20 kamar. Setiap kamar dilengkapi dengan kamar mandi dalam, AC, dan WiFi. Lokasi strategis dekat kampus.', 3.5, 'miliar', 'rumah', 'jual', 20, 20, 400, 500, 'p3', 'c10', NULL, 'Jl. Affandi No. 25', '55281', ARRAY['Kamar Mandi Dalam', 'AC', 'WiFi', 'Dapur Bersama', 'Ruang Santai'], 'active', 85, 3, FALSE, NOW() - INTERVAL '32 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000319', '00000000-0000-4000-0000-000000000107', 'Kondominium Mewah di Jakarta Utara', 'Kondominium mewah dengan pemandangan laut. Dilengkapi dengan fasilitas premium dan keamanan 24 jam. Akses mudah ke pusat kota.', 5.5, 'miliar', 'kondominium', 'jual', 4, 4, 250, NULL, 'p1', 'c5', NULL, 'Regatta Tower Miami Unit PH-02', '14460', ARRAY['Private Lift', 'Jacuzzi', 'Smart Home', 'Wine Cellar', 'Balkon Luas'], 'active', 110, 5, TRUE, NOW() - INTERVAL '38 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000320', '00000000-0000-4000-0000-000000000109', 'Ruang Kantor di Jakarta Pusat', 'Ruang kantor modern dengan luas 200m². Lokasi premium di gedung perkantoran kelas A. Tersedia untuk sewa jangka panjang.', 100, 'juta', 'gedung_komersial', 'sewa', NULL, 2, 200, NULL, 'p1', 'c1', NULL, 'Menara Sudirman Lantai 15 Unit A', '10220', ARRAY['Furnished', 'Receptionist', 'Meeting Room', 'Pantry', 'Parking'], 'active', 75, 3, TRUE, NOW() - INTERVAL '12 days', NOW());

-- Insert sample property media
INSERT INTO property_media (id, listing_id, media_url, media_type, is_primary, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000401', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000402', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1643384/pexels-photo-1643384.jpeg', 'image', FALSE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000403', '00000000-0000-4000-0000-000000000301', 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000404', '00000000-0000-4000-0000-000000000302', 'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000405', '00000000-0000-4000-0000-000000000302', 'https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000406', '00000000-0000-4000-0000-000000000303', 'https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000407', '00000000-0000-4000-0000-000000000303', 'https://images.pexels.com/photos/1115804/pexels-photo-1115804.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000408', '00000000-0000-4000-0000-000000000304', 'https://images.pexels.com/photos/280229/pexels-photo-280229.jpeg', 'image', TRUE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000409', '00000000-0000-4000-0000-000000000305', 'https://images.pexels.com/photos/2102587/pexels-photo-2102587.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000410', '00000000-0000-4000-0000-000000000305', 'https://images.pexels.com/photos/2724749/pexels-photo-2724749.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000411', '00000000-0000-4000-0000-000000000306', 'https://images.pexels.com/photos/1571468/pexels-photo-1571468.jpeg', 'image', TRUE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000412', '00000000-0000-4000-0000-000000000307', 'https://images.pexels.com/photos/1732414/pexels-photo-1732414.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000413', '00000000-0000-4000-0000-000000000307', 'https://images.pexels.com/photos/2089698/pexels-photo-2089698.jpeg', 'image', FALSE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000414', '00000000-0000-4000-0000-000000000307', 'https://images.pexels.com/photos/2121121/pexels-photo-2121121.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000415', '00000000-0000-4000-0000-000000000308', 'https://images.pexels.com/photos/534228/pexels-photo-534228.jpeg', 'image', TRUE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000416', '00000000-0000-4000-0000-000000000309', 'https://images.pexels.com/photos/2079234/pexels-photo-2079234.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000417', '00000000-0000-4000-0000-000000000309', 'https://images.pexels.com/photos/2029731/pexels-photo-2029731.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000418', '00000000-0000-4000-0000-000000000310', 'https://images.pexels.com/photos/2360673/pexels-photo-2360673.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000419', '00000000-0000-4000-0000-000000000310', 'https://images.pexels.com/photos/2476632/pexels-photo-2476632.jpeg', 'image', FALSE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000420', '00000000-0000-4000-0000-000000000310', 'https://images.pexels.com/photos/2462015/pexels-photo-2462015.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000421', '00000000-0000-4000-0000-000000000311', 'https://images.pexels.com/photos/1571459/pexels-photo-1571459.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000422', '00000000-0000-4000-0000-000000000311', 'https://images.pexels.com/photos/1571463/pexels-photo-1571463.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000423', '00000000-0000-4000-0000-000000000312', 'https://images.pexels.com/photos/2079246/pexels-photo-2079246.jpeg', 'image', TRUE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000424', '00000000-0000-4000-0000-000000000313', 'https://images.pexels.com/photos/2635038/pexels-photo-2635038.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000425', '00000000-0000-4000-0000-000000000313', 'https://images.pexels.com/photos/2724748/pexels-photo-2724748.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000426', '00000000-0000-4000-0000-000000000314', 'https://images.pexels.com/photos/2581922/pexels-photo-2581922.jpeg', 'image', TRUE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000427', '00000000-0000-4000-0000-000000000315', 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000428', '00000000-0000-4000-0000-000000000315', 'https://images.pexels.com/photos/2089698/pexels-photo-2089698.jpeg', 'image', FALSE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000429', '00000000-0000-4000-0000-000000000315', 'https://images.pexels.com/photos/2089696/pexels-photo-2089696.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000430', '00000000-0000-4000-0000-000000000316', 'https://images.pexels.com/photos/2462015/pexels-photo-2462015.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000431', '00000000-0000-4000-0000-000000000316', 'https://images.pexels.com/photos/2119713/pexels-photo-2119713.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000432', '00000000-0000-4000-0000-000000000317', 'https://images.pexels.com/photos/280221/pexels-photo-280221.jpeg', 'image', TRUE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000433', '00000000-0000-4000-0000-000000000318', 'https://images.pexels.com/photos/2079249/pexels-photo-2079249.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000434', '00000000-0000-4000-0000-000000000318', 'https://images.pexels.com/photos/2079293/pexels-photo-2079293.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000435', '00000000-0000-4000-0000-000000000319', 'https://images.pexels.com/photos/2506990/pexels-photo-2506990.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000436', '00000000-0000-4000-0000-000000000319', 'https://images.pexels.com/photos/2251247/pexels-photo-2251247.jpeg', 'image', FALSE, NOW(), NOW()),
  
  ('00000000-0000-4000-0000-000000000437', '00000000-0000-4000-0000-000000000320', 'https://images.pexels.com/photos/1170412/pexels-photo-1170412.jpeg', 'image', TRUE, NOW(), NOW()),
  ('00000000-0000-4000-0000-000000000438', '00000000-0000-4000-0000-000000000320', 'https://images.pexels.com/photos/260689/pexels-photo-260689.jpeg', 'image', FALSE, NOW(), NOW());

-- Insert sample premium listings
INSERT INTO premium_listings (id, property_id, user_id, plan_id, status, start_date, end_date, payment_id, analytics_views, analytics_inquiries, analytics_favorites, analytics_conversion_rate, analytics_daily_views, analytics_top_sources, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000501', '00000000-0000-4000-0000-000000000301', '00000000-0000-4000-0000-000000000103', 'premium-monthly', 'active', NOW() - INTERVAL '15 days', NOW() + INTERVAL '15 days', NULL, 120, 5, 10, 4.2, 
   '[{"date":"2023-06-15","views":10},{"date":"2023-06-16","views":15},{"date":"2023-06-17","views":12},{"date":"2023-06-18","views":8},{"date":"2023-06-19","views":20},{"date":"2023-06-20","views":18},{"date":"2023-06-21","views":22},{"date":"2023-06-22","views":15}]'::jsonb, 
   '[{"source":"direct","count":50},{"source":"google","count":40},{"source":"facebook","count":20},{"source":"instagram","count":10}]'::jsonb, 
   NOW() - INTERVAL '15 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000502', '00000000-0000-4000-0000-000000000302', '00000000-0000-4000-0000-000000000104', 'premium-monthly', 'active', NOW() - INTERVAL '10 days', NOW() + INTERVAL '20 days', NULL, 85, 3, 7, 3.5, 
   '[{"date":"2023-06-18","views":8},{"date":"2023-06-19","views":12},{"date":"2023-06-20","views":15},{"date":"2023-06-21","views":10},{"date":"2023-06-22","views":18},{"date":"2023-06-23","views":12},{"date":"2023-06-24","views":10}]'::jsonb, 
   '[{"source":"direct","count":30},{"source":"google","count":25},{"source":"facebook","count":15},{"source":"instagram","count":15}]'::jsonb, 
   NOW() - INTERVAL '10 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000503', '00000000-0000-4000-0000-000000000307', '00000000-0000-4000-0000-000000000107', 'premium-quarterly', 'active', NOW() - INTERVAL '30 days', NOW() + INTERVAL '60 days', NULL, 95, 4, 8, 4.2, 
   '[{"date":"2023-05-29","views":5},{"date":"2023-05-30","views":8},{"date":"2023-05-31","views":10},{"date":"2023-06-01","views":12},{"date":"2023-06-02","views":15},{"date":"2023-06-03","views":18},{"date":"2023-06-04","views":12},{"date":"2023-06-05","views":15}]'::jsonb, 
   '[{"source":"direct","count":35},{"source":"google","count":30},{"source":"facebook","count":20},{"source":"instagram","count":10}]'::jsonb, 
   NOW() - INTERVAL '30 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000504', '00000000-0000-4000-0000-000000000310', '00000000-0000-4000-0000-000000000104', 'premium-monthly', 'active', NOW() - INTERVAL '20 days', NOW() + INTERVAL '10 days', NULL, 150, 8, 15, 5.3, 
   '[{"date":"2023-06-08","views":15},{"date":"2023-06-09","views":18},{"date":"2023-06-10","views":22},{"date":"2023-06-11","views":25},{"date":"2023-06-12","views":20},{"date":"2023-06-13","views":18},{"date":"2023-06-14","views":17},{"date":"2023-06-15","views":15}]'::jsonb, 
   '[{"source":"direct","count":60},{"source":"google","count":45},{"source":"facebook","count":25},{"source":"instagram","count":20}]'::jsonb, 
   NOW() - INTERVAL '20 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000505', '00000000-0000-4000-0000-000000000311', '00000000-0000-4000-0000-000000000107', 'premium-monthly', 'active', NOW() - INTERVAL '5 days', NOW() + INTERVAL '25 days', NULL, 110, 6, 12, 5.5, 
   '[{"date":"2023-06-23","views":20},{"date":"2023-06-24","views":25},{"date":"2023-06-25","views":18},{"date":"2023-06-26","views":22},{"date":"2023-06-27","views":25}]'::jsonb, 
   '[{"source":"direct","count":45},{"source":"google","count":35},{"source":"facebook","count":20},{"source":"instagram","count":10}]'::jsonb, 
   NOW() - INTERVAL '5 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000506', '00000000-0000-4000-0000-000000000315', '00000000-0000-4000-0000-000000000107', 'premium-monthly', 'active', NOW() - INTERVAL '8 days', NOW() + INTERVAL '22 days', NULL, 130, 7, 14, 5.4, 
   '[{"date":"2023-06-20","views":15},{"date":"2023-06-21","views":18},{"date":"2023-06-22","views":22},{"date":"2023-06-23","views":25},{"date":"2023-06-24","views":20},{"date":"2023-06-25","views":18},{"date":"2023-06-26","views":12}]'::jsonb, 
   '[{"source":"direct","count":50},{"source":"google","count":40},{"source":"facebook","count":25},{"source":"instagram","count":15}]'::jsonb, 
   NOW() - INTERVAL '8 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000507', '00000000-0000-4000-0000-000000000316', '00000000-0000-4000-0000-000000000109', 'premium-monthly', 'active', NOW() - INTERVAL '12 days', NOW() + INTERVAL '18 days', NULL, 95, 4, 9, 4.2, 
   '[{"date":"2023-06-16","views":10},{"date":"2023-06-17","views":12},{"date":"2023-06-18","views":15},{"date":"2023-06-19","views":18},{"date":"2023-06-20","views":15},{"date":"2023-06-21","views":12},{"date":"2023-06-22","views":13}]'::jsonb, 
   '[{"source":"direct","count":40},{"source":"google","count":30},{"source":"facebook","count":15},{"source":"instagram","count":10}]'::jsonb, 
   NOW() - INTERVAL '12 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000508', '00000000-0000-4000-0000-000000000319', '00000000-0000-4000-0000-000000000107', 'premium-quarterly', 'active', NOW() - INTERVAL '25 days', NOW() + INTERVAL '65 days', NULL, 110, 5, 11, 4.5, 
   '[{"date":"2023-06-03","views":8},{"date":"2023-06-04","views":10},{"date":"2023-06-05","views":12},{"date":"2023-06-06","views":15},{"date":"2023-06-07","views":18},{"date":"2023-06-08","views":22},{"date":"2023-06-09","views":25}]'::jsonb, 
   '[{"source":"direct","count":45},{"source":"google","count":35},{"source":"facebook","count":20},{"source":"instagram","count":10}]'::jsonb, 
   NOW() - INTERVAL '25 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000509', '00000000-0000-4000-0000-000000000320', '00000000-0000-4000-0000-000000000109', 'premium-monthly', 'active', NOW() - INTERVAL '3 days', NOW() + INTERVAL '27 days', NULL, 75, 3, 6, 4.0, 
   '[{"date":"2023-06-25","views":20},{"date":"2023-06-26","views":25},{"date":"2023-06-27","views":30}]'::jsonb, 
   '[{"source":"direct","count":30},{"source":"google","count":25},{"source":"facebook","count":10},{"source":"instagram","count":10}]'::jsonb, 
   NOW() - INTERVAL '3 days', NOW()),
   
  ('00000000-0000-4000-0000-000000000510', '00000000-0000-4000-0000-000000000305', '00000000-0000-4000-0000-000000000103', 'premium-monthly', 'expired', NOW() - INTERVAL '45 days', NOW() - INTERVAL '15 days', NULL, 78, 3, 7, 3.8, 
   '[{"date":"2023-05-15","views":8},{"date":"2023-05-16","views":10},{"date":"2023-05-17","views":12},{"date":"2023-05-18","views":15},{"date":"2023-05-19","views":18},{"date":"2023-05-20","views":15}]'::jsonb, 
   '[{"source":"direct","count":35},{"source":"google","count":25},{"source":"facebook","count":10},{"source":"instagram","count":8}]'::jsonb, 
   NOW() - INTERVAL '45 days', NOW() - INTERVAL '15 days');

-- Insert sample advertiser accounts
INSERT INTO advertiser_accounts (id, user_id, company_name, contact_email, contact_phone, billing_address, payment_method, credit_balance, status, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000701', '00000000-0000-4000-0000-000000000103', 'Wijaya Property', 'agus@wijayaproperty.com', '+6281234567892', '{"address": "Jl. Sudirman No. 123", "city": "Jakarta", "postal_code": "10220", "country": "ID"}'::jsonb, '{"type": "credit_card", "last4": "1234"}'::jsonb, 500.00, 'active', NOW() - INTERVAL '60 days', NOW()),
  ('00000000-0000-4000-0000-000000000702', '00000000-0000-4000-0000-000000000104', 'Anggraini Realty', 'dewi@anggrainirealty.com', '+6281234567893', '{"address": "Jl. Gatot Subroto No. 45", "city": "Jakarta", "postal_code": "10270", "country": "ID"}'::jsonb, '{"type": "bank_transfer", "bank": "BCA"}'::jsonb, 750.00, 'active', NOW() - INTERVAL '55 days', NOW()),
  ('00000000-0000-4000-0000-000000000703', '00000000-0000-4000-0000-000000000107', 'Pranoto Property', 'hadi@pranotoproperty.com', '+6281234567896', '{"address": "Jl. Diponegoro No. 78", "city": "Surabaya", "postal_code": "60241", "country": "ID"}'::jsonb, '{"type": "credit_card", "last4": "5678"}'::jsonb, 1000.00, 'active', NOW() - INTERVAL '50 days', NOW()),
  ('00000000-0000-4000-0000-000000000704', '00000000-0000-4000-0000-000000000109', 'Permata Realty', 'dian@permatarealty.com', '+6281234567898', '{"address": "Jl. Ahmad Yani No. 56", "city": "Bandung", "postal_code": "40112", "country": "ID"}'::jsonb, '{"type": "bank_transfer", "bank": "Mandiri"}'::jsonb, 1200.00, 'active', NOW() - INTERVAL '45 days', NOW());

-- Insert sample ad campaigns
INSERT INTO ad_campaigns (id, advertiser_id, name, description, budget, daily_budget, start_date, end_date, targeting_options, status, total_spent, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000801', '00000000-0000-4000-0000-000000000701', 'Summer Property Promotion', 'Promoting luxury properties for summer season', 1000.00, 50.00, NOW() - INTERVAL '30 days', NOW() + INTERVAL '30 days', '{"geographic": {"cities": ["Jakarta", "Bandung", "Surabaya"]}, "behavioral": {"property_types": ["rumah", "apartemen"]}}'::jsonb, 'active', 500.00, NOW() - INTERVAL '35 days', NOW()),
  ('00000000-0000-4000-0000-000000000802', '00000000-0000-4000-0000-000000000702', 'Apartment Special Deals', 'Promoting special deals on apartments', 800.00, 40.00, NOW() - INTERVAL '20 days', NOW() + INTERVAL '40 days', '{"geographic": {"cities": ["Jakarta"]}, "behavioral": {"property_types": ["apartemen"]}}'::jsonb, 'active', 300.00, NOW() - INTERVAL '25 days', NOW()),
  ('00000000-0000-4000-0000-000000000803', '00000000-0000-4000-0000-000000000703', 'Commercial Property Campaign', 'Promoting commercial properties', 1200.00, 60.00, NOW() - INTERVAL '15 days', NOW() + INTERVAL '45 days', '{"geographic": {"cities": ["Jakarta", "Surabaya"]}, "behavioral": {"property_types": ["ruko", "gedung_komersial"]}}'::jsonb, 'active', 250.00, NOW() - INTERVAL '20 days', NOW()),
  ('00000000-0000-4000-0000-000000000804', '00000000-0000-4000-0000-000000000704', 'Premium Property Showcase', 'Showcasing premium properties', 1500.00, 75.00, NOW() - INTERVAL '10 days', NOW() + INTERVAL '50 days', '{"geographic": {"cities": ["Jakarta", "Bandung", "Bali"]}, "behavioral": {"property_types": ["rumah", "kondominium"]}}'::jsonb, 'active', 200.00, NOW() - INTERVAL '15 days', NOW()),
  ('00000000-0000-4000-0000-000000000805', '00000000-0000-4000-0000-000000000701', 'Land Investment Opportunities', 'Promoting land for investment', 600.00, 30.00, NOW() - INTERVAL '5 days', NOW() + INTERVAL '55 days', '{"geographic": {"cities": ["Jakarta", "Bogor", "Tangerang"]}, "behavioral": {"property_types": ["tanah"]}}'::jsonb, 'active', 50.00, NOW() - INTERVAL '10 days', NOW());

-- Insert sample advertisements
INSERT INTO advertisements (id, campaign_id, placement_id, title, description, image_url, video_url, click_url, alt_text, ad_type, content, status, priority, weight, impressions_count, clicks_count, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000000801', '00000000-0000-4000-0000-000000000601', 'Luxury Homes in Jakarta', 'Discover your dream luxury home in Jakarta', 'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg', NULL, 'https://propertipro.id/jual?type=rumah', 'Luxury homes in Jakarta', 'banner', '{"headline": "Luxury Living", "cta": "View Properties"}'::jsonb, 'active', 10, 10, 1500, 75, NOW() - INTERVAL '30 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000902', '00000000-0000-4000-0000-000000000802', '00000000-0000-4000-0000-000000000602', 'Modern Apartments', 'Stylish apartments in the heart of the city', 'https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg', NULL, 'https://propertipro.id/jual?type=apartemen', 'Modern apartments', 'sidebar', '{"headline": "Urban Living", "cta": "Learn More"}'::jsonb, 'active', 8, 8, 1200, 60, NOW() - INTERVAL '25 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000903', '00000000-0000-4000-0000-000000000803', '00000000-0000-4000-0000-000000000603', 'Commercial Properties', 'Prime commercial properties for your business', 'https://images.pexels.com/photos/534228/pexels-photo-534228.jpeg', NULL, 'https://propertipro.id/jual?type=gedung_komersial', 'Commercial properties', 'banner', '{"headline": "Business Opportunities", "cta": "Explore Now"}'::jsonb, 'active', 9, 9, 1000, 50, NOW() - INTERVAL '20 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000904', '00000000-0000-4000-0000-000000000804', '00000000-0000-4000-0000-000000000604', 'Exclusive Villas in Bali', 'Experience luxury living in Bali', 'https://images.pexels.com/photos/2360673/pexels-photo-2360673.jpeg', NULL, 'https://propertipro.id/jual?type=rumah&province=p6', 'Villas in Bali', 'in_content', '{"headline": "Paradise Living", "cta": "View Villas"}'::jsonb, 'active', 10, 10, 800, 40, NOW() - INTERVAL '15 days', NOW()),
  
  ('00000000-0000-4000-0000-000000000905', '00000000-0000-4000-0000-000000000805', '00000000-0000-4000-0000-000000000605', 'Land Investment', 'Secure your future with strategic land investment', 'https://images.pexels.com/photos/280229/pexels-photo-280229.jpeg', NULL, 'https://propertipro.id/jual?type=tanah', 'Land investment', 'banner', '{"headline": "Invest in Land", "cta": "Learn More"}'::jsonb, 'active', 7, 7, 600, 30, NOW() - INTERVAL '10 days', NOW());

-- Insert sample reports
INSERT INTO reports (id, property_id, reporter_id, reporter_name, reporter_email, type, reason, description, status, priority, resolved_at, resolved_by, resolution, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000001001', '00000000-0000-4000-0000-000000000305', '00000000-0000-4000-0000-000000000101', 'Budi Santoso', 'budi@example.com', 'fake_listing', 'Properti ini tidak ada di lokasi yang disebutkan', 'Saya sudah mengunjungi lokasi dan tidak menemukan properti seperti yang dijelaskan dalam iklan.', 'pending', 'high', NULL, NULL, NULL, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days'),
  
  ('00000000-0000-4000-0000-000000001002', '00000000-0000-4000-0000-000000000308', '00000000-0000-4000-0000-000000000102', 'Siti Rahayu', 'siti@example.com', 'wrong_category', 'Properti ini seharusnya masuk kategori ruko, bukan gedung komersial', 'Bangunan ini hanya 2 lantai dan lebih cocok dikategorikan sebagai ruko.', 'under_review', 'medium', NULL, NULL, NULL, NOW() - INTERVAL '4 days', NOW() - INTERVAL '3 days'),
  
  ('00000000-0000-4000-0000-000000001003', '00000000-0000-4000-0000-000000000312', '00000000-0000-4000-0000-000000000106', 'Rina Fitriani', 'rina@example.com', 'inappropriate_content', 'Deskripsi properti mengandung konten yang tidak pantas', 'Ada beberapa kata-kata yang tidak pantas dalam deskripsi properti.', 'resolved', 'medium', NOW() - INTERVAL '1 day', '00000000-0000-4000-0000-000000000111', 'Konten yang tidak pantas telah dihapus dari deskripsi.', NOW() - INTERVAL '3 days', NOW() - INTERVAL '1 day'),
  
  ('00000000-0000-4000-0000-000000001004', '00000000-0000-4000-0000-000000000315', '00000000-0000-4000-0000-000000000110', 'Eko Prasetyo', 'eko@example.com', 'spam', 'Iklan ini duplikat dan muncul berkali-kali', 'Saya melihat iklan yang sama diposting berkali-kali oleh pengguna yang sama.', 'pending', 'low', NULL, NULL, NULL, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),
  
  ('00000000-0000-4000-0000-000000001005', '00000000-0000-4000-0000-000000000317', NULL, 'Anonymous User', 'anonymous@example.com', 'fake_listing', 'Harga tidak sesuai dengan kondisi properti', 'Harga yang dipasang terlalu tinggi untuk kondisi dan lokasi properti ini.', 'dismissed', 'low', NOW() - INTERVAL '1 day', '00000000-0000-4000-0000-000000000111', 'Harga properti adalah kebijakan penjual dan tidak melanggar ketentuan platform.', NOW() - INTERVAL '3 days', NOW() - INTERVAL '1 day');

-- Insert sample moderation actions
INSERT INTO moderation_actions (id, report_id, property_id, admin_id, admin_name, action, reason, details, previous_status, new_status, created_at)
VALUES
  ('00000000-0000-4000-0000-000000001101', '00000000-0000-4000-0000-000000001003', '00000000-0000-4000-0000-000000000312', '00000000-0000-4000-0000-000000000111', 'Admin User', 'edit_content', 'Menghapus konten yang tidak pantas', 'Beberapa kata dalam deskripsi telah dihapus karena tidak sesuai dengan ketentuan platform.', 'active', 'active', NOW() - INTERVAL '1 day'),
  
  ('00000000-0000-4000-0000-000000001102', '00000000-0000-4000-0000-000000001005', '00000000-0000-4000-0000-000000000317', '00000000-0000-4000-0000-000000000111', 'Admin User', 'dismiss_report', 'Laporan tidak valid', 'Harga properti adalah kebijakan penjual dan tidak melanggar ketentuan platform.', 'active', 'active', NOW() - INTERVAL '1 day'),
  
  ('00000000-0000-4000-0000-000000001103', NULL, '00000000-0000-4000-0000-000000000306', '00000000-0000-4000-0000-000000000112', 'Super Admin', 'approve', 'Properti memenuhi syarat', 'Properti telah diverifikasi dan memenuhi semua persyaratan.', 'pending', 'active', NOW() - INTERVAL '4 days'),
  
  ('00000000-0000-4000-0000-000000001104', NULL, '00000000-0000-4000-0000-000000000313', '00000000-0000-4000-0000-000000000111', 'Admin User', 'warn_user', 'Peringatan untuk memperbaiki deskripsi', 'Deskripsi properti perlu diperbaiki agar lebih akurat.', 'active', 'active', NOW() - INTERVAL '5 days');

-- Insert sample ad impressions and clicks
INSERT INTO ad_impressions (id, ad_id, user_id, session_id, ip_address, user_agent, page_url, referrer, device_type, browser, created_at)
VALUES
  ('00000000-0000-4000-0000-000000001401', '00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000000101', 'session_123456', '192.168.1.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'https://propertipro.id/', 'https://google.com', 'desktop', 'Chrome', NOW() - INTERVAL '5 days'),
  ('00000000-0000-4000-0000-000000001402', '00000000-0000-4000-0000-000000000902', '00000000-0000-4000-0000-000000000102', 'session_123457', '192.168.1.2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1', 'https://propertipro.id/jual', 'https://facebook.com', 'mobile', 'Safari', NOW() - INTERVAL '4 days'),
  ('00000000-0000-4000-0000-000000001403', '00000000-0000-4000-0000-000000000903', '00000000-0000-4000-0000-000000000106', 'session_123458', '192.168.1.3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36', 'https://propertipro.id/sewa', 'https://instagram.com', 'desktop', 'Chrome', NOW() - INTERVAL '3 days'),
  ('00000000-0000-4000-0000-000000001404', '00000000-0000-4000-0000-000000000904', '00000000-0000-4000-0000-000000000110', 'session_123459', '192.168.1.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'https://propertipro.id/properti/00000000-0000-4000-0000-000000000310', 'https://propertipro.id/jual', 'desktop', 'Chrome', NOW() - INTERVAL '2 days'),
  ('00000000-0000-4000-0000-000000001405', '00000000-0000-4000-0000-000000000905', NULL, 'session_123460', '192.168.1.5', 'Mozilla/5.0 (Linux; Android 11; SM-G998B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36', 'https://propertipro.id/jual?type=tanah', 'https://google.com', 'mobile', 'Chrome', NOW() - INTERVAL '1 day');

INSERT INTO ad_clicks (id, ad_id, impression_id, user_id, session_id, ip_address, user_agent, page_url, referrer, device_type, browser, created_at)
VALUES
  ('00000000-0000-4000-0000-000000001501', '00000000-0000-4000-0000-000000000901', '00000000-0000-4000-0000-000000001401', '00000000-0000-4000-0000-000000000101', 'session_123456', '192.168.1.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'https://propertipro.id/', 'https://google.com', 'desktop', 'Chrome', NOW() - INTERVAL '5 days'),
  ('00000000-0000-4000-0000-000000001502', '00000000-0000-4000-0000-000000000903', '00000000-0000-4000-0000-000000001403', '00000000-0000-4000-0000-000000000106', 'session_123458', '192.168.1.3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36', 'https://propertipro.id/sewa', 'https://instagram.com', 'desktop', 'Chrome', NOW() - INTERVAL '3 days');

-- Insert sample ad payments
INSERT INTO ad_payments (id, advertiser_id, campaign_id, amount, currency, payment_method, transaction_id, status, payment_date, created_at, updated_at)
VALUES
  ('00000000-0000-4000-0000-000000001601', '00000000-0000-4000-0000-000000000701', '00000000-0000-4000-0000-000000000801', 500.00, 'USD', 'credit_card', 'txn_123456789', 'paid', NOW() - INTERVAL '35 days', NOW() - INTERVAL '35 days', NOW() - INTERVAL '35 days'),
  ('00000000-0000-4000-0000-000000001602', '00000000-0000-4000-0000-000000000702', '00000000-0000-4000-0000-000000000802', 300.00, 'USD', 'bank_transfer', 'txn_123456790', 'paid', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days'),
  ('00000000-0000-4000-0000-000000001603', '00000000-0000-4000-0000-000000000703', '00000000-0000-4000-0000-000000000803', 250.00, 'USD', 'credit_card', 'txn_123456791', 'paid', NOW() - INTERVAL '20 days', NOW() - INTERVAL '20 days', NOW() - INTERVAL '20 days'),
  ('00000000-0000-4000-0000-000000001604', '00000000-0000-4000-0000-000000000704', '00000000-0000-4000-0000-000000000804', 200.00, 'USD', 'bank_transfer', 'txn_123456792', 'paid', NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days', NOW() - INTERVAL '15 days'),
  ('00000000-0000-4000-0000-000000001605', '00000000-0000-4000-0000-000000000701', '00000000-0000-4000-0000-000000000805', 50.00, 'USD', 'credit_card', 'txn_123456793', 'paid', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days');

-- Insert sample activity logs
INSERT INTO activity_logs (id, user_id, user_name, action, resource, resource_id, details, ip_address, user_agent, created_at)
VALUES
  ('00000000-0000-4000-0000-000000001301', '00000000-0000-4000-0000-000000000111', 'Admin User', 'CREATE_USER', 'user_profiles', '00000000-0000-4000-0000-000000000110', 'Created new user account', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '15 days'),
  
  ('00000000-0000-4000-0000-000000001302', '00000000-0000-4000-0000-000000000112', 'Super Admin', 'UPDATE_SETTINGS', 'system_settings', '00000000-0000-4000-0000-000000001201', 'Updated system settings', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '10 days'),
  
  ('00000000-0000-4000-0000-000000001303', '00000000-0000-4000-0000-000000000111', 'Admin User', 'APPROVE_LISTING', 'listings', '00000000-0000-4000-0000-000000000306', 'Approved property listing', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '4 days'),
  
  ('00000000-0000-4000-0000-000000001304', '00000000-0000-4000-0000-000000000111', 'Admin User', 'RESOLVE_REPORT', 'reports', '00000000-0000-4000-0000-000000001003', 'Resolved report about inappropriate content', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '1 day'),
  
  ('00000000-0000-4000-0000-000000001305', '00000000-0000-4000-0000-000000000112', 'Super Admin', 'DISMISS_REPORT', 'reports', '00000000-0000-4000-0000-000000001005', 'Dismissed invalid report', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '1 day'),
  
  ('00000000-0000-4000-0000-000000001306', '00000000-0000-4000-0000-000000000111', 'Admin User', 'CREATE_CATEGORY', 'categories', '00000000-0000-4000-0000-000000000208', 'Created new property category', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '8 days'),
  
  ('00000000-0000-4000-0000-000000001307', '00000000-0000-4000-0000-000000000112', 'Super Admin', 'UPDATE_USER', 'user_profiles', '00000000-0000-4000-0000-000000000108', 'Suspended user account', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '7 days'),
  
  ('00000000-0000-4000-0000-000000001308', '00000000-0000-4000-0000-000000000111', 'Admin User', 'CREATE_AD_CAMPAIGN', 'ad_campaigns', '00000000-0000-4000-0000-000000000805', 'Created new ad campaign', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '10 days'),
  
  ('00000000-0000-4000-0000-000000001309', '00000000-0000-4000-0000-000000000112', 'Super Admin', 'CREATE_PREMIUM_PLAN', 'premium_plans', 'premium-yearly', 'Created new premium plan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '100 days', NOW()),
  
  ('00000000-0000-4000-0000-000000001310', '00000000-0000-4000-0000-000000000111', 'Admin User', 'UPDATE_LOCATION', 'locations', 'p1', 'Updated location information', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', NOW() - INTERVAL '12 days', NOW());