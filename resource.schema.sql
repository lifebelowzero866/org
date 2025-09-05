
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