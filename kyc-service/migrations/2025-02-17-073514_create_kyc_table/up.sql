-- Your SQL goes here
CREATE TABLE kyc_entries (
    id SERIAL PRIMARY KEY,
    user_email TEXT NOT NULL UNIQUE,
    identity_hash TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
