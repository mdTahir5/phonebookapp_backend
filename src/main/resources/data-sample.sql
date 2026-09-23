-- Phonebook Sample Seed Data
-- Optional verification data for local or staging testing
-- Password hash below corresponds to BCrypt hash for "Password123!"

INSERT IGNORE INTO users (id, name, email, password, created_at, updated_at)
VALUES (
    1,
    'Demo User',
    'demo@phonebook.com',
    '$2a$10$w09Z56z7Mhy4y82rFp3CqOHsE3F1zQ28qI6eN7cQ3k9sT7Xk4g0rG',
    NOW(),
    NOW()
);

INSERT IGNORE INTO contacts (id, name, email, phone, address, user_id, created_at, updated_at)
VALUES 
(
    1,
    'Jane Doe',
    'jane.doe@example.com',
    '+1 555-0199',
    '123 Maple Street, Springfield',
    1,
    NOW(),
    NOW()
),
(
    2,
    'John Smith',
    'john.smith@example.com',
    '+1 555-0144',
    '456 Oak Avenue, Metropolis',
    1,
    NOW(),
    NOW()
);
