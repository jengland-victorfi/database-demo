-- Initialize account database
CREATE DATABASE IF NOT EXISTS account_db;

\c account_db;

-- Create account table
CREATE TABLE IF NOT EXISTS accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert test data
INSERT INTO accounts (username, email, password_hash, status) VALUES
    ('test_user1', 'test1@example.com', 'hash1', 'active'),
    ('test_user2', 'test2@example.com', 'hash2', 'active'),
    ('test_user3', 'test3@example.com', 'hash3', 'inactive');

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_accounts_username ON accounts(username);
CREATE INDEX IF NOT EXISTS idx_accounts_email ON accounts(email); 