
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
