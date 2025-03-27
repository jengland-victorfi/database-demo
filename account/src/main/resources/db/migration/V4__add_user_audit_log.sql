-- Create audit log table
CREATE TABLE IF NOT EXISTS user_audit_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES accounts(id),
    action VARCHAR(50) NOT NULL,
    details JSONB,
    ip_address VARCHAR(45),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_user_audit_log_user_id ON user_audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_user_audit_log_action ON user_audit_log(action);

-- Insert test audit logs
INSERT INTO user_audit_log (user_id, action, details, ip_address)
SELECT 
    id,
    'login',
    '{"success": true, "method": "password"}',
    '127.0.0.1'
FROM accounts
WHERE username IN ('test_user1', 'test_user2')
UNION ALL
SELECT 
    id,
    'profile_update',
    '{"field": "theme", "old_value": "light", "new_value": "dark"}',
    '127.0.0.1'
FROM accounts
WHERE username = 'test_user1'; 