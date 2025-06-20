-- Database schema for Student Activity Management System
-- Make sure you're connected to the 'student' database

USE student;

-- Create the activity table
CREATE TABLE IF NOT EXISTS activity (
    activityID INT AUTO_INCREMENT PRIMARY KEY,
    activityName VARCHAR(255) NOT NULL,
    activityDesc TEXT,
    activityDate VARCHAR(50),
    activityVenue VARCHAR(255),
    activityStatus VARCHAR(50) DEFAULT 'pending',
    activityBudget DOUBLE DEFAULT 0.0
);

-- Optional: Insert some sample data for testing
INSERT INTO activity (activityName, activityDesc, activityDate, activityVenue, activityStatus, activityBudget) VALUES
('Basketball Tournament', 'Annual inter-department basketball competition', '2024-03-15', 'Sports Complex', 'upcoming', 500.00),
('Coding Workshop', 'Learn Java programming basics', '2024-03-20', 'Computer Lab 1', 'upcoming', 200.00),
('Cultural Night', 'Multicultural celebration event', '2024-04-01', 'Auditorium', 'upcoming', 1000.00); 