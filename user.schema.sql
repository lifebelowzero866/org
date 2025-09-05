CREATE DATABASE UserEducation;

--session independant
CREATE TABLE Roles(
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session independant
CREATE table Users(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    registration_no CHAR(10) NOT NULL UNIQUE,
    password VARCHAR(64),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);


--session independant
CREATE TABLE UserRole(
    user_role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


--session independant
CREATE TABLE UsersInfo(
    user_info_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_no VARCHAR(10) UNIQUE NOT NULL,
    first_name VARCHAR(150) NOT NULL,
    middle_name VARCHAR(150),
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL,
    primary_mobile_no CHAR(10) NOT NULL,
    secondary_mobile_no CHAR(10),
    dob Datetime
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


--session independant
CREATE TABLE StudentsInfo(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_no VARCHAR(10) UNIQUE NOT NULL,
    first_name VARCHAR(150) NOT NULL,
    middle_name VARCHAR(150),
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL,
    primary_mobile_no CHAR(10) NOT NULL,
    secondary_mobile_no CHAR(10),
    dob Datetime
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);




--session dependant
CREATE TABLE RelationshipSession(
    relationship_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id  INT NOT NULL,
    class_id INT NOT NULL,
    section_id INT NOT NULL,
    report_id INT,
    FOREIGN key (student_id) REFERENCES StudentsInfo(student_id),  
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


--session independant
CREATE TABLE Address(
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    pin_code CHAR(6) NOT NULL,
    area VARCHAR(100) NOT NULL,
    cluster VARCHAR(100) NOT NULL,
    district VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) DEFAULT "India",
    address_line VARCHAR(500),
    address_type ENUM("Permant","Residental","Temporary"),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


--session independant
CREATE TABLE Guardian(
    guardian_id INT PRIMARY KEY AUTO_INCREMENT,
    guardian_type ENUM("FATHER","MOTHER","LOCAL GUARDIAN"),
    guardian_first_name VARCHAR(100) NOT NULL,
    guardian_middle_name VARCHAR(100),
    guardian_last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    primary_mobile_no CHAR(10) NOT NULL,
    secondary_mobile_no CHAR(10),
    student_id INT NOT NULL,
    FOREIGN key (student_id) REFERENCES StudentsInfo(student_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);