-- Create user preferences table
CREATE TABLE IF NOT EXISTS user_preferences (
    user_id UUID PRIMARY KEY REFERENCES accounts(id),
    theme VARCHAR(20) DEFAULT 'light',
    language VARCHAR(10) DEFAULT 'en',
    notifications_enabled BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert test preferences
INSERT INTO user_preferences (user_id, theme, language) VALUES
    ((SELECT id FROM accounts WHERE username = 'test_user1'), 'dark', 'en'),
    ((SELECT id FROM accounts WHERE username = 'test_user2'), 'light', 'es'); 