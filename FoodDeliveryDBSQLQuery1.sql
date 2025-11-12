CREATE DATABASE FoodDeliveryDB;

use FoodDeliveryDB ;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    City VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    CuisineType VARCHAR(50),
    Rating DECIMAL(2,1)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2),
    DeliveryTime INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

INSERT INTO Customers (Name, City, JoinDate) VALUES
('Vikram Reddy', 'Chennai', '2024-01-22'),
('Megha Singh', 'Pune', '2024-04-11'),
('Rahul Verma', 'Delhi', '2024-02-25'),
('Sneha Patil', 'Mumbai', '2024-03-30'),
('Arjun Das', 'Kolkata', '2024-05-18'),
('Priya Nair', 'Kochi', '2024-06-02'),
('Karan Gupta', 'Hyderabad', '2024-01-05'),
('Divya Sharma', 'Bangalore', '2024-04-15');

INSERT INTO Restaurants (Name, CuisineType, Rating) VALUES
('WokWay', 'Chinese', 4.1),
('BurgerMania', 'American', 4.3),
('Tandoori Treat', 'North Indian', 4.4),
('SushiZone', 'Japanese', 4.6),
('Cafe Delight', 'Continental', 4.0),
('WrapHub', 'Fast Food', 3.9),
('BiryaniBazaar', 'Hyderabadi', 4.7),
('VeggieVilla', 'Vegan', 4.2);

INSERT INTO Orders (CustomerID, RestaurantID, OrderDate, TotalAmount, DeliveryTime) VALUES
(3, 3, '2024-06-12 14:10', 400.00, 25),
(4, 4, '2024-06-13 19:50', 750.00, 35),
(5, 1, '2024-06-14 21:00', 1100.00, 45),
(6, 2, '2024-06-15 12:20', 500.00, 30),
(7, 5, '2024-06-16 18:00', 950.00, 40),
(8, 6, '2024-06-17 13:45', 650.00, 28),
(1, 7, '2024-06-18 20:10', 1200.00, 50),
(2, 8, '2024-06-19 15:30', 580.00, 32),
(3, 4, '2024-06-20 19:10', 720.00, 35),
(4, 2, '2024-06-21 21:25', 870.00, 38),
(5, 5, '2024-06-22 17:40', 600.00, 29),
(6, 1, '2024-06-23 13:10', 1000.00, 33),
(7, 3, '2024-06-24 18:20', 950.00, 27),
(8, 6, '2024-06-25 20:45', 780.00, 36);

INSERT INTO OrderItems (OrderID, ItemName, Quantity, Price) VALUES
(6, 'Chicken Biryani', 1, 250.00),
(6, 'Raita', 1, 50.00),
(7, 'Veg Burger', 2, 300.00),
(7, 'French Fries', 2, 150.00),
(8, 'Tandoori Chicken', 2, 500.00),
(8, 'Butter Naan', 2, 200.00),
(9, 'Veg Sushi', 2, 600.00),
(9, 'Miso Soup', 5, 600.00),
(10, 'Pasta Alfredo', 1, 400.00),
(10, 'Cold Coffee', 3, 180.00),
(11, 'Wrap Combo', 3, 960.00),
(11, 'Choco Shake', 3, 180.00),
(12, 'Hyderabadi Biryani', 3, 450.00),
(12, 'Double Ka Meetha', 5, 150.00),
(13, 'Veg Noodles', 5, 300.00),
(13, 'Spring Rolls', 3, 150.00),
(14, 'Veg Sandwich', 3, 750.00),
(14, 'Lemon Juice', 2, 100.00);


SELECT * FROM Customers;

SELECT c.Name AS Customer, r.Name AS Restaurant, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID;

SELECT r.Name AS Restaurant, SUM(o.TotalAmount) AS TotalSales
FROM Orders o
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
GROUP BY r.Name;

SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent,
    RANK() OVER (ORDER BY SUM(TotalAmount) DESC) AS SpendingRank
FROM Orders
GROUP BY CustomerID;

SELECT TOP 5 
    c.Name,
    SUM(o.TotalAmount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Name
ORDER BY TotalSpent DESC;


SELECT r.Name, COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
GROUP BY r.Name
ORDER BY TotalOrders DESC;

SELECT c.City, AVG(o.DeliveryTime) AS AvgDeliveryTime
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.City;

SELECT 
    c.Name,
    SUM(o.TotalAmount) AS TotalSpent,
    RANK() OVER (ORDER BY SUM(o.TotalAmount) DESC) AS RankBySpending
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Name;

