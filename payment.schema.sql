
CREATE TABLE PaymentTypes (
    payment_type_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_type VARCHAR(255) NOT NULL, --salary admission resource buy other
    description TEXT,   
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL, 
    base_salary DECIMAL(10, 2) NOT NULL, 
    allowances DECIMAL(10, 2) DEFAULT 0, 
    deductions DECIMAL(10, 2) DEFAULT 0, 
    net_salary DECIMAL(10, 2) AS (base_salary + allowances - deductions),
    pay_frequency ENUM('Monthly', 'Bi-weekly', 'Weekly') NOT NULL, 
    effective_date DATE NOT NULL,    
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE FeeStructures (
    fee_structure_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL, 
    academic_year VARCHAR(50) NOT NULL, 
    tuition_fee DECIMAL(10, 2) NOT NULL,
    exam_fee DECIMAL(10, 2) DEFAULT 0,
    library_fee DECIMAL(10, 2) DEFAULT 0,
    other_charges DECIMAL(10, 2) DEFAULT 0,
    total_fee DECIMAL(10, 2) AS (tuition_fee + exam_fee + library_fee + other_charges), 
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


CREATE TABLE Installments (
    installment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,    
    payment_type_id INT NOT NULL,    
    fee_structure_id INT NOT NULL
    total_amount DECIMAL(10, 2) NOT NULL, 
    installment_no INT NOT NULL,        
    installment_amount DECIMAL(10, 2) NOT NULL,
    due_date DATE NOT NULL,     
    paid_status ENUM('Pending', 'Paid') DEFAULT 'Pending',  
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (payment_type_id) REFERENCES PaymentTypes(payment_type_id)-- Linking with Payments table
);

CREATE TABLE LateFeeCriteria((
    late_fee_criteria_id INT PRIMARY KEY  AUTO_INCREMENT
    day INT 
    late_fee DECIMAL(10,2),
))


CREATE TABLE LateFees (
    late_fee_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,   
    late_fee_criteria_id INT,
    late_fee_amount DECIMAL(10,2)
    installment_id INT,       
    reason VARCHAR(255),     
    charged_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    FOREIGN KEY (installment_id) REFERENCES Installments(installment_id)
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,    
    payment_type_id INT NOT NULL,
    installment_id INT,
    late_fee_id INT
    amount DECIMAL(10, 2) NOT NULL,  
    status ENUM('Pending', 'Completed', 'Failed') NOT NULL,
    transaction_id VARCHAR(255),  
    payment_mode VARCHAR(100),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    remarks TEXT,    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_type_id) REFERENCES PaymentTypes(payment_type_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (installment_id) REFERENCES Installments(installment_id),
    FOREIGN KEY (late_fee_id) REFERENCES LateFees(late_fee_id)
);


CREATE TABLE Scholarships (
    scholarship_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,    
    scholarship_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,  
    effective_date DATE NOT NULL,    
    expiry_date DATE,  
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
