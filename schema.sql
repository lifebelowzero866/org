-- Table for Users (Students, Teachers, Admin, etc.)

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


--session independant
CREATE TABLE AcademicYear(
    academic_year_id INT PRIMARY KEY AUTO_INCREMENT,
    academic_year VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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

--session independant
CREATE TABLE Class(
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(100) NOT NULL,
    class_intake INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session independant
CREATE TABLE Section(
    section_id INT PRIMARY KEY AUTO_INCREMENT,
    section_name VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Class(class_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session independant
CREATE TABLE SubjectType(
    subject_type_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_type VARCHAR(100) NOT NULL UNIQUE;
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session independant
CREATE TABLE Subject(
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subjet_name VARCHAR(100),
    subject_code VARCHAR(100) UNIQUE,
    subject_type_id INT NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Class(class_id),
    FOREIGN KEY (subject_type_id) REFERENCES SubjectType(subject_type_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session dependant
CREATE TABLE TimetableSession (
    timetable_id INT AUTO_INCREMENT PRIMARY KEY,
    -- class_id INT NOT NULL,
    section_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    DayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    room_no VARCHAR(10) NOT NULL
    -- FOREIGN KEY (class_id) REFERENCES Class(class_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session dependant
CREATE TABLE RelationshipTeacherSession(
    rts_id INT PRIMARY KEY AUTO_INCREMENT,
    -- class_id INT NOT NULL,
    section_id INT NOT NULl,
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Users(user_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


--session dependant
CREATE TABLE TeacherSubject(
    teacher_subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT NOT NULL,
    rts_id INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    FOREIGN KEY (rts_id) REFERENCES RelationshipTeacherSession(rts_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--Session Independent
CREATE TABLE Houses(
    house_id INT PRIMARY KEY AUTO_INCREMENT,
    house_name VARCHAR(50) NOT NULL UNIQUE,
    house_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--Session Dependent
CREATE TABLE HouseEvent(
    hourse_event_id INT PRIMARY KEY AUTO_INCREMENT,
    house_event VARCHAR(100),
    house_event_description TEXT,
    house_id INT NOT NULL,
    FOREIGN KEY (house_id) REFERENCES Houses(house_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--Session Independent
CREATE TABLE HouseRoles(
    house_role_id INT PRIMARY KEY AUTO_INCREMENT,
    house_role_name VARCHAR(100) NOT NULL,
);

--session dependent
CREATE TABLE HouseSession(
    house_session_id INT PRIMARY KEY AUTO_INCREMENT,
    house_id INT NOT NULL,
    user_id INT NOT NULL,
    house_role_id INT NOT NULL, 
    FOREIGN KEY (house_role_id) REFERENCES HouseRoles(house_role_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (house_id) REFERENCES Houses(house_id)
);

--session dependent
CREATE TABLE HouseStudents(
    house_student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    role ENUM("Member", "Leader") DEFAULT "Member",
    FOREIGN KEY (student_id) REFERENCES StudentsInfo(student_id),
);


--session dependant
CREATE TABLE Leave(
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason TEXT,
    leave_type ENUM("Sick Leave","Family Leave","Other") NOT NULL,
    approved_date DATE,
    status ENUM("PENDING","APPROVED","REJECTED") DEFAULT "PENDING",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    check (start_date<=end_date),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
);

--session dependant
CREATE TABLE AcademicCalender(
    academic_calender INT PRIMARY KEY AUTO_INCREMENT,
    event VARCHAR(100) NOT NULL,
    event_description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    check (start_date<=end_date),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

--session dependant
CREATE TABLE Feedback(
    feedbak_id INT PRIMARY KEY AUTO_INCREMENT,
    feedback_name VARCHAR(500) NOT NULL,
    feedback_description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    check (start_date<=end_date),
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Role(role_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session dependant
CREATE TABLE FeedbackQuestion(
    feedback_question_id INT PRIMARY KEY AUTO_INCREMENT,
    question TEXT,
    feedbak_id INT
    FOREIGN KEY (feedbak_id) REFERENCES Feedback(feedbak_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session dependant
CREATE TABLE FeedbackQuestionOption(
    fq_id INT PRIMARY KEY AUTO_INCREMENT,
    option VARCHAR(100) NOT NULL,
    feedback_question_id INT NOT NULL,
    FOREIGN key (feedback_question_id) REFERENCES FeedbackQuestion(feedback_question_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session dependant
CREATE TABLE FeedbackResponse(
    feedback_response_id INT PRIMARY KEY AUTO_INCREMENT,
    fq_id INT NOT NULL,
    user_id NOT NULL,
    FOREIGN KEY (fq_id) REFERENCES FeedbackQuestionOption(fq_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--session independant
CREATE TABLE Job(
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    job_title VARCHAR(200),
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Role(role_id),
    job description TEXT,
    status ENUM("Active","Inactive","Hired"),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE 
);


--session independant
CREATE TABLE JobApply(
    job_apply_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(500) NOT NULL,
    mobile VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    resume_path VARCHAR(100) NOT NULL,
    job_id INT NOT NULL,
    status ENUM("Hired","Rejected","Pending") DEFAULT "Pending",
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);


--session independant
CREATE TABLE Complaint(
    complaint_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    complaint TEXT,
    status ENUM("Solved","Unsolved","Pending") DEFAULT "Pending",
    remark TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

--session dependant
CREATE TABLE Notification(
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT Null,
    description TEXT NOT NULL,
    status ENUM("Draft","Sent"),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);


--session independant
CREATE TABLE Groups(
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(100) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Groups(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

--session independant
CREATE TABLE GroupMember(
    group_member_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

--session dependant
CREATE TABLE StaffAttendance(
    staff_attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    attendance ENUM("Present", "Absent", "Late") NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);


--session dependant
CREATE TABLE Attendance(
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    status ENUM("Present","Absent") DEFAULT "Present",
    FOREIGN KEY (student_id) REFERENCES StudentsInfo(student_id),
    FOREIGN key (subject_id) REFERENCES Subject(subject_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

--session independant
CREATE TABLE AcademicScheme(
    academic_scheme_id INT PRIMARY KEY AUTO_INCREMENT,
    academic_scheme VARCHAR(100) NOT NULL,
    total_mark INT NOT NULL,
    min_mark INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

CREATE TABLE ExamType(
    exam_type_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_type VARCHAR(100) NOT NULL,
    no_of_exam INT NOT NULL,
    academic_scheme_id INT NOT NULL,
    FOREIGN key (academic_scheme_id) REFERENCES AcademicScheme(academic_scheme_id),
)

--session independant
CREATE TABLE Exam(
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_name VARCHAR(200),
    max_mark INT NOT NULL,
    exam_type_id INT
    FOREIGN key (exam_type_id) REFERENCES ExamType(exam_type_id),
);

-- --session dependant
-- CREATE TABLE ExamDate(
--     exam_date_id INT PRIMARY KEY AUTO_INCREMENT,
--     class_id INT NOT NULL,
--     exam_id INT NOT NULL,
--     start_date DATE,
--     end_date DATE,
--     FOREIGN key (exam_id) REFERENCES Exam(exam_id),
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
-- );

--session dependant
CREATE TABLE ExamTimetable (
    exam_timetable_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_date DATE,
    subject_id INT,
    invigilator_id INT,
    start_time TIME,
    end_time TIME,
    exam_id INT
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id),
    FOREIGN KEY (invigilator_id) REFERENCES Users(user_id),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
)

--session dependant
CREATE TABLE Mark(
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    exam_id INT NOT NULL,
    mark_obtain INT NOT NULL,
    status ENUM("Pass","Fail","Absent","Detain")
    FOREIGN KEY (student_id) REFERENCES StudentsInfo(student_id),
    FOREIGN key (subject_id) REFERENCES Subject(subject_id),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

--session dependant
CREATE TABLE Result(
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    result_name VARCHAR(100),
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    exam_id INT NOT NULL,
    total_obtain_marks INT NOT NULL,
    status ENUM("Pass","Fail")
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id),
    FOREIGN KEY (student_id) REFERENCES StudentsInfo(student_id),
    FOREIGN key (subject_id) REFERENCES Subject(subject_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);



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

-- exam

finance
    payment type
    payments
    transaction
resource
lma


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


CREATE TABLE BuildingType(
    building_type_id INT PRIMARY KEY AUTO_INCREMENT,
    building_type VARCHAR(100),
);

CREATE TABLE Building(
    building_id INT PRIMARY KEY AUTO_INCREMENT,
    building_name VARCHAR(100).
    floor INT,
    building_type_id INT,
    description TEXT,
    location VARCHAR(100),
    FOREIGN KEY (building_type_id) REFERENCES BuildingType(building_type_id)
);

CREATE TABLE RoomType(
    root_type_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type  VARCHAR(200),
)

CREATE TABLE Rooms(
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room VARCHAR(100),
    building_id INT,
    floor_no INT
    room_type_id INT,
    status ENUM("Maintenance","Construction","Inuse","Free"),
    FOREIGN KEY (building_id) REFERENCES Building(building_id),
    FOREIGN KEY (room_type_id) REFERENCES RoomType(room_type_id)
)

CREATE TABLE EquipmentType(
    equipment_type_id INT PRIMARY KEY AUTO_INCREMENT,
    equipment_type VARCHAR(100)
)

CREATE TABLE Equipment(
    equipment_id INT PRIMARY KEY AUTO_INCREMENT,
    equipment VARCHAR(100),
    room_id INT,
    equipment_type_id INT,
    FOREIGN KEY (room_type_id) REFERENCES RoomType(room_type_id),
    FOREIGN KEY (equipment_type_id) REFERENCES EquipmentType(equipment_type_id)
)

CREATE TABLE GroundType (
    ground_type_id INT PRIMARY KEY AUTO_INCREMENT,
    ground_type VARCHAR(100)
);


CREATE TABLE Grounds (
    ground_id INT PRIMARY KEY AUTO_INCREMENT,
    ground_name VARCHAR(100),
    ground_type_id INT,
    location VARCHAR(100),
    status ENUM('Available', 'Booked', 'Under Maintenance') DEFAULT 'Available',
    FOREIGN KEY (ground_type_id) REFERENCES GroundType(ground_type_id)
);


CREATE TABLE ResourceBookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    equipment_id INT,    
    room_id INT,    
    ground_id INT,             
    user_id INT NOT NULL,             
    start_time DATETIME NOT NULL,    
    end_time DATETIME NOT NULL,    
    purpose VARCHAR(255), 
    resource_type ENUM('Equipment', 'Room', 'Ground') NOT NULL,   
    status ENUM('Booked', 'Completed', 'Cancelled') DEFAULT 'Booked', 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
    FOREIGN KEY (ground_id) REFERENCES Grounds(ground_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT chk_resource CHECK (
        (resource_type = 'Equipment' AND equipment_id IS NOT NULL AND room_id IS NULL AND ground_id IS NULL) OR
        (resource_type = 'Room' AND room_id IS NOT NULL AND equipment_id IS NULL AND ground_id IS NULL) OR
        (resource_type = 'Ground' AND ground_id IS NOT NULL AND equipment_id IS NULL AND room_id IS NULL)
    )
);

booktypes
books
issuedBooks


CREATE TABLE QuestionPapersType(
    question_papers_type_id INT PRIMARY KEY AUTO_INCREMENT,
    question_papers_type VARCHAR(100) NOT NULL,
);

CREATE TABLE QuestionPapers (
    question_paper_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT,
    exam_id INT,
    academic_year_id INT   ,
    question_papers_type_id INT NOT NULL,



);




-- Library Management Database Schema

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



-- Vehicles Table
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_number VARCHAR(50) UNIQUE NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL, 
    capacity INT NOT NULL,
    manufacturing_year INT,
    model VARCHAR(100),
    registration_number VARCHAR(50) UNIQUE,
    insurance_expiry DATE,
    current_status ENUM('Active', 'Inactive', 'Under Maintenance', 'Reserved'),
    route_id VARCHAR(20),
    last_maintenance_date DATE
);

-- Routes Table
CREATE TABLE Routes (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    route_name VARCHAR(100) NOT NULL,
    start_location INT NOT NULL,
    end_location INT NOT NULL,
    total_distance DECIMAL(10,2) NOT NULL,
    estimated_travel_time TIME,
    description TEXT
);

-- Route Stops Table
CREATE TABLE RouteStops (
    stop_id INT PRIMARY KEY AUTO_INCREMENT,
    next_stop_id INT NOT NULL,
    previous_stop_id INT NOT NULL,
    next_stop_distance VARCHAR(100),
    route_id VARCHAR(20) NOT NULL,
    stop_name VARCHAR(100) NOT NULL,
    stop_order INT NOT NULL,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    FOREIGN KEY (route_id) REFERENCES Routes(route_id)
);

ALTER TABLE Routes 
ADD CONSTRAINT fk_start_location 
FOREIGN KEY (start_location) 
REFERENCES Route_Stops(stop_id);

ALTER TABLE Routes 
ADD CONSTRAINT fk_end_location 
FOREIGN KEY (end_location) 
REFERENCES Route_Stops(stop_id);

-- Drivers Table
CREATE TABLE Drivers (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    license_expiry_date DATE NOT NULL,
    user_id INT NOT NULL,
    current_status ENUM('Active', 'On Leave', 'Terminated'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Vehicle Assignments Table
CREATE TABLE VehicleAssignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    driver_id INT NOT NULL,
    route_id INT NOT NULL,
    assignment_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
    FOREIGN KEY (route_id) REFERENCES Routes(route_id)
);

-- Maintenance Logs Table
CREATE TABLE MaintenanceLogs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id VARCHAR(20) NOT NULL,
    maintenance_date DATE NOT NULL,
    maintenance_type VARCHAR(50) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2),
    performed_by VARCHAR(100),
    next_maintenance_due_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- Transportation Users Table (Students/Staff)
CREATE TABLE TransportationUsers (
    transportation_user_id INT PRIMARY KEY AUTO_INCREMENT,
    route_id INT NOT NULL,
    user_id INT NOT NULL,
    stop_id INT NOT NULL,
    FOREIGN KEY (stop_id) REFERENCES RouteStops(stop_id),
    FOREIGN KEY (route_id) REFERENCES Route(route_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Trip Logs Table
CREATE TABLE TripLogs (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    driver_id INT NOT NULL,
    route_id INT NOT NULL,
    trip_date DATE NOT NULL,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    actual_start_location VARCHAR(255),
    actual_end_location VARCHAR(255),
    status VARCHAR(50) CHECK (status IN ('Completed', 'Delayed', 'Cancelled')),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
    FOREIGN KEY (route_id) REFERENCES Routes(route_id)
);

-- Fuel Consumption Logs
CREATE TABLE FuelConsumptionLogs (
    fuel_consumption_log_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id VARCHAR(20) NOT NULL,
    fuel_date DATE NOT NULL,
    fuel_type VARCHAR(50),
    quantity DECIMAL(10,2) NOT NULL,
    cost_per_unit DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    odometer_reading INT,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);


--lms
--homework
