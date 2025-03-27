-- Create roles table
CREATE TABLE IF NOT EXISTS roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create user_roles junction table
CREATE TABLE IF NOT EXISTS user_roles (
    user_id UUID REFERENCES accounts(id),
    role_id UUID REFERENCES roles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_id)
);

-- Insert test roles
INSERT INTO roles (name, description) VALUES
    ('admin', 'System administrator'),
    ('user', 'Regular user'),
    ('guest', 'Guest user');

-- Assign test roles to users
INSERT INTO user_roles (user_id, role_id)
SELECT a.id, r.id
FROM accounts a
CROSS JOIN roles r
WHERE a.username = 'test_user1' AND r.name = 'admin'
UNION
SELECT a.id, r.id
FROM accounts a
CROSS JOIN roles r
WHERE a.username = 'test_user2' AND r.name = 'user'; 