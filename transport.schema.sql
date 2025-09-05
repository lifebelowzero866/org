
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