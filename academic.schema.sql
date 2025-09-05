--session independant
CREATE TABLE AcademicYear(
    academic_year_id INT PRIMARY KEY AUTO_INCREMENT,
    academic_year VARCHAR(10) NOT NULL,
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