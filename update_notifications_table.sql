-- Run this against your medisev_db
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS target_role VARCHAR(20) DEFAULT 'admin';
ALTER TABLE notifications ADD COLUMN IF NOT EXISTS doctor_id INT NULL;
ALTER TABLE notifications ADD INDEX (target_role);
ALTER TABLE notifications ADD INDEX (doctor_id);
