-- Create user sessions table
CREATE TABLE IF NOT EXISTS user_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES accounts(id),
    token VARCHAR(255) UNIQUE NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_user_sessions_token ON user_sessions(token);
CREATE INDEX IF NOT EXISTS idx_user_sessions_user_id ON user_sessions(user_id);

-- Insert test sessions
INSERT INTO user_sessions (user_id, token, ip_address, user_agent, expires_at)
SELECT 
    id,
    'test_token_' || username,
    '127.0.0.1',
    'Mozilla/5.0 (Test Browser)',
    CURRENT_TIMESTAMP + INTERVAL '24 hours'
FROM accounts
WHERE username IN ('test_user1', 'test_user2'); 