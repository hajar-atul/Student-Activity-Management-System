-- Database schema for Student Activity Management System
-- Make sure you're connected to the 'student' database

USE student;

-- Drop existing activity table if it exists
DROP TABLE IF EXISTS activity;

-- Create the activity table with BLOB support
CREATE TABLE IF NOT EXISTS activity (
    activityID VARCHAR(10) PRIMARY KEY,
    activityName VARCHAR(500) NOT NULL,
    activityType VARCHAR(50) DEFAULT 'General',
    activityDesc TEXT,
    activityDate VARCHAR(50),
    activityVenue VARCHAR(500),
    activityStatus VARCHAR(50) DEFAULT 'Pending',
    activityBudget DOUBLE DEFAULT 0.0,
    adabPoint INT DEFAULT 0,
    proposalFile LONGBLOB,
    qrImage LONGBLOB,
    posterImage LONGBLOB,
    clubID INT,
    FOREIGN KEY (clubID) REFERENCES club(clubID)
);

-- Create registration table for student activity registration
CREATE TABLE IF NOT EXISTS registeration (
    regID INT AUTO_INCREMENT PRIMARY KEY,
    studID INT,
    activityID VARCHAR(10),
    regDate VARCHAR(50),
    receiptFile LONGBLOB,
    FOREIGN KEY (studID) REFERENCES student(studID),
    FOREIGN KEY (activityID) REFERENCES activity(activityID)
);

-- Optional: Insert some sample data for testing
INSERT INTO activity (activityID, activityName, activityDesc, activityDate, activityVenue, activityStatus, activityBudget, activityType, adabPoint) VALUES
('A001', 'Basketball Tournament', 'Annual inter-department basketball competition', '2024-03-15', 'Sports Complex', 'Approved', 500.00, 'Free', 50),
('A002', 'Coding Workshop', 'Learn Java programming basics', '2024-03-20', 'Computer Lab 1', 'Approved', 200.00, 'Paid', 30),
('A003', 'Cultural Night', 'Multicultural celebration event', '2024-04-01', 'Auditorium', 'Approved', 1000.00, 'Paid', 75); 