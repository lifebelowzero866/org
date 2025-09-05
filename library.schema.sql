
CREATE TABLE Shelf (
    shelf_id INT PRIMARY KEY AUTO_INCREMENT,
    shelf_name VARCHAR(100) NOT NULL,
    shelf_location VARCHAR(500)
)

-- Book Categories Table
CREATE TABLE BookCategories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES BookCategories(category_id)
);

-- Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    publisher VARCHAR(255),
    publication_year INT,
    total_copies INT DEFAULT 1,
    available_copies INT NOT NULL,
    shelf_id INT,
    language VARCHAR(50),
    description TEXT,
    book_condition VARCHAR(50) CHECK (book_condition IN ('New', 'Good', 'Damaged', 'Worn')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY (category_id) REFERENCES BookCategories(category_id)
    FOREIGN KEY (shelf_id) REFERENCES Shelf(shelf_id)
);

-- Book Loans Table
CREATE TABLE BookLoans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id VARCHAR(20) NOT NULL,
    user_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) CHECK (status IN ('Borrowed', 'Returned', 'Overdue')),
    fine_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Fine Payment History
CREATE TABLE FinePayments (
    fine_payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_id INT NOT NULL,
    loan_id VARCHAR(20) NOT NULL,
    user_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (loan_id) REFERENCES Book_Loans(loan_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);

-- Book Request Table
CREATE TABLE BookRequest (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(20) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    user_id VARCHAR(20),
    request_date DATE NOT NULL,
    status ENUM('Active', 'Fulfilled', 'Cancelled') DEFAULT "Active",
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);