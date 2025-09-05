

--Admission Module

CREATE TABLE Admission(
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    academic_year VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT false,
    start_date DATE,
    end_date Date
);

-- Admission Request table to store basic application information
CREATE TABLE AdmissionRequests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    reference_number INT UNIQUE NOT NULL,
    status ENUM("Approved", "Rejected", "Pending", "On Review") DEFAULT 'Pending',
    -- academic_year VARCHAR(10) NOT NULL,
    -- applied_grade VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    admission_id INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    is_token_paid BOOLEAN DEFAULT false,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY(class_id) REFERENCES Class(class_id)
    FOREIGN KEY(admission_id) REFERENCES Admission(admission_id)
);

-- Student Details table
CREATE TABLE StudentDetails (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT REFERENCES admission_requests(request_id),
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM("Male", "Female", "Other") NOT NULL,
    blood_group VARCHAR(5),
    nationality VARCHAR(50),
    religion VARCHAR(50),
    category VARCHAR(50),
    previous_school_name VARCHAR(100),
    previous_school_board VARCHAR(50),
    previous_class VARCHAR(20),
    previous_academic_year VARCHAR(10),
    FOREIGN KEY(request_id) REFERENCES admission_requests(request_id) ON DELETE CASCADE
);

-- Parent/Guardian Details table
CREATE TABLE ParentDetails (
    parent_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT REFERENCES admission_requests(request_id),
    relationship_type ENUM("Father", "Mother", "Guardian") NOT NULL, -- Father, Mother, Guardian
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    occupation VARCHAR(100),
    annual_income DECIMAL(12,2),
    education_qualification VARCHAR(100),
    primary_contact BOOLEAN DEFAULT false,
    phone_number VARCHAR(15) NOT NULL,
    alternate_phone VARCHAR(15),
    email VARCHAR(100),
    FOREIGN KEY(request_id) REFERENCES admission_requests(request_id) ON DELETE CASCADE
);

-- Address table (can be linked to both student and parents)
CREATE TABLE Addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT REFERENCES admission_requests(request_id),
    entity_type ENUM("Student", "Parent", "Guardian") NOT NULL, -- 'STUDENT' or 'PARENT'
    entity_id INT NOT NULL, -- student_id or parent_id
    address_type ENUM("Permanent", "Correspondence") NOT NULL, -- 'PERMANENT' or 'CORRESPONDENCE'
    address_line1 VARCHAR(100) NOT NULL,
    address_line2 VARCHAR(100),
    taluka VARCHAR(50) NOT NULL,
    district VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10) NOT NULL
    FOREIGN KEY(request_id) REFERENCES admission_requests(request_id) ON DELETE CASCADE
);

CREATE TABLE DocumentType(
    document_type_id INT AUTO_INCREMENT PRIMARY KEY,
    document_type_name VARCHAR(100) NOT NULL
);

-- Documents table for storing uploaded files
CREATE TABLE Documents (
    document_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT REFERENCES admission_requests(request_id),
    document_type_id VARCHAR(50), -- Birth Certificate, Previous Marksheet, etc.
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    -- file_size INT NOT NULL,
    -- mime_type VARCHAR(100) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(request_id) REFERENCES admission_requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY(document_type_id) REFERENCES DocumentType(document_type_id) ON DELETE SET NULL,
);

-- Admission Status History table for tracking application status changes
CREATE TABLE AdmissionStatusHistory (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    comments TEXT,
    changed_by INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(request_id) REFERENCES admission_requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY(changed_by) REFERENCES Users(user_id) ON DELETE SET NULL
);