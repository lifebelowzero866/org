--session independant
CREATE TABLE ExamScheme(
    academic_scheme_id INT PRIMARY KEY AUTO_INCREMENT,
    academic_scheme VARCHAR(100) NOT NULL,
    total_mark INT NOT NULL,
    min_mark INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);

-- --session independent
-- ----theory practicle audit type
-- CREATE TABLE ExamType(
--     exam_type_id INT AUTO_INCREMENT PRIMARY KEY,
--     exam_type VARCHAR(100) NOT NULL,
--     no_of_exam INT NOT NULL,
--     academic_scheme_id INT NOT NULL,
--     FOREIGN key (academic_scheme_id) REFERENCES AcademicScheme(academic_scheme_id),
-- );

--session independant
CREATE TABLE ExamSubType(
    exam_type_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_name VARCHAR(200),
    max_mark INT NOT NULL,
    exam_type_id INT,
    is_external Boolean,
    subject_type_id INT,
    -- exam_scheme_id
    FOREIGN key (exam_type_id) REFERENCES ExamType(exam_type_id),
);


CREATE TABLE Exam(
    exam_id INT,
    session_id INT,
    exam_scheme_id,
    exam_type_id,
    start_date,
    end_date
)

Exam

EnrolledExam

CREATE TABLE EnrolledExam(
    student_id
    exam_id
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
