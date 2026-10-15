CREATE DATABASE IF NOT EXISTS bank;
use bank;
CREATE TABLE branch (
    branch_name VARCHAR(100) NOT NULL,
    branch_city VARCHAR(100) NOT NULL,
    assets DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (branch_name),
    CONSTRAINT chk_branch_assets CHECK (assets >= 0.00)
);
CREATE TABLE customer (
    customer_name VARCHAR(100) NOT NULL,
    customer_street VARCHAR(255) NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    PRIMARY KEY (customer_name)
);
CREATE TABLE account (
    account_number VARCHAR(50) NOT NULL,
    branch_name VARCHAR(100) NOT NULL,
    balance DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (account_number),
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_account_balance CHECK (balance >= 0.00)
);
CREATE TABLE loan (
    loan_number VARCHAR(50) NOT NULL,
    branch_name VARCHAR(100) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_loan_amount CHECK (amount >= 0.00)
);
CREATE TABLE depositor (
    customer_name VARCHAR(100) NOT NULL,
    account_number VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_name, account_number), -- Composite Key prevents duplicate customer-to-account rows
    FOREIGN KEY (customer_name) REFERENCES customer(customer_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (account_number) REFERENCES account(account_number) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE financial_audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type ENUM('ACCOUNT', 'LOAN') NOT NULL,
    identifier VARCHAR(50) NOT NULL,
    old_amount DECIMAL(15, 2),
    new_amount DECIMAL(15, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO branch (branch_name, branch_city, assets) VALUES
('Downtown', 'Bengaluru', 9000000.00),
('Malli_Square', 'Bengaluru', 4500000.00),
('West_End', 'Mumbai', 7100000.00),
('Central_Hub', 'Delhi', 12000000.00);

INSERT INTO customer (customer_name, customer_street, customer_city) VALUES
('Amit Sharma', '12 Ring Road', 'Bengaluru'),
('Priya Rao', '45 MG Road', 'Bengaluru'),
('Rahul Kapoor', '88 Marine Drive', 'Mumbai'),
('Sneha Patel', '23 Connaught Place', 'Delhi'),
('Vikram Singh', '77 Jayanagar', 'Bengaluru');
INSERT INTO account (account_number, branch_name, balance) VALUES
('ACC-1001', 'Downtown', 5000.50),
('ACC-1002', 'Downtown', 12500.00),
('ACC-1003', 'Malli_Square', 350.00),
('ACC-1004', 'West_End', 8900.75),
('ACC-1005', 'Central_Hub', 75000.00);

INSERT INTO loan (loan_number, branch_name, amount) VALUES
('LN-5001', 'Downtown', 250000.00),
('LN-5002', 'West_End', 45000.00),
('LN-5003', 'Central_Hub', 120000.00);

INSERT INTO depositor (customer_name, account_number) VALUES
('Amit Sharma', 'ACC-1001'),
('Priya Rao', 'ACC-1002'),
('Rahul Kapoor', 'ACC-1004'),
('Sneha Patel', 'ACC-1005'),
('Amit Sharma', 'ACC-1003'),
('Priya Rao', 'ACC-1003');

SELECT * FROM account;
SELECT * FROM customer;
SELECT * FROM depositor;
SHOW TABLES FROM bank;