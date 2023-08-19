Drop database Centra;
Create database if not exists Centra;

use Centra;

/*Creates Address relation which has Eircode, Street, Town, County */
CREATE TABLE Address (
	Eircode VARCHAR(7) PRIMARY KEY, -- Eircode's are unique ids assigned to addresses, VARCHAR(7) is used as eircodes are seven characters long eg "D09FW22", it is the Primary key of Address relation
    Street VARCHAR(50) NOT NULL, -- -- The Street that address is located in,  VARCHAR(50) is uesd to store Street, Street can't be null
    Town VARCHAR(20) NOT NULL,  -- The Town that address is located in, VARCHAR(20) is uesd to store TOwn, Town can't be null
	County VARCHAR(12) NOT NULL -- The County that address is located in, VARCHAR(12) is used as longest county name is "London Derry", County can't be null
	);

/*Creates Promotion relation which has Promotion_id, Name, Start_date, End_date */
CREATE TABLE Promotion ( 
    Promotion_id INT AUTO_INCREMENT PRIMARY KEY, -- Promotion_id is the primary key of Promotion, Type INT, Which is auto generated
    Name TEXT NOT NULL, -- The name of the promotion, A promtion name can be long so TEXT is used, Name can't be null
    Start_date DATE NOT  NULL, -- The stating date of the promotion, DATE type is used to store the starting date, Start_date can't be null
    End_date DATE NOT NULL -- The ending date of the promotion, DATE type is used to store the starting date, End_date can't be null
    ); 
    
/*Creates Employee relation which has Employee_id, fName, lName, Email, Phone_number, Employee_status, Wage */
CREATE TABLE Employee ( 
    Employee_id INT AUTO_INCREMENT PRIMARY KEY,  -- Employee_id is the primary key of Employee, Type INT, Which is auto generated
    fName TINYTEXT NOT NULL, -- The first name of the employee, First names fit inside 255 charachters so TINYTEXT is used, fName can't be null
    lName TINYTEXT NOT NULL, -- The last name of the employee, Second names will fit inside 255 charachters so TINYTEXT is used, lName can't be null
    Email VARCHAR(64) UNIQUE NOT NULL, -- The email of the employee,VARCHAR(64) is used as email has type Unique ,Emails are Unique to each employee, Email can't be null
    Phone_number CHAR(9) UNIQUE NOT NULL, -- The phone number of the employee, Phone numbers are 9 digits long so CHAR(9) is used, Unique to each Employee, Phone_number can't be null
    Employee_status ENUM('part-time', 'full-time')  NOT NULL, -- The employee's status, Options are 'part-time' or 'full-time', Employee_status can't be null
    Wage float(4,2) NOT NULL -- The employees wage, Has type float to represent hourly pay to the cent, Wage can't be null
    );    

/*Creates Franchise relation which has Franchise_id, Name, Phone_number, Email, Eircode, fName, lName */
Create Table Franchise(
    Franchise_id INT AUTO_INCREMENT PRIMARY KEY,  -- Franchise_id is the primary key of Franchise, Type INT, Which is auto generated
    Name VARCHAR(200) UNIQUE NOT NULL, -- The name of the franchise E.g "Cross's Centra", VARCHAR(200) is used as Name has type Unique ,Names are Unique to each Franchise, Name can't be null
    Phone_number CHAR(9) UNIQUE NOT NULL, -- The phone number of the franchise, Phone numbers are 9 digits long so CHAR(9) is used, Unique to each franchise, Phone_number can't be null
    Email VARCHAR(64) UNIQUE NOT NULL, -- The email of the franchise,VARCHAR(64) is used as email has type Unique ,Emails are Unique to each Franchise, Email can't be null
    Eircode VARCHAR(7) UNIQUE NOT NULL, -- Foregin key of Address relation, VARCHAR(7) is used as eircodes are 7 charachters long, Eircode can't be null
    fName TINYTEXT NOT NULL, -- The first name of the franchisee, First names fit inside 255 charachters so TINYTEXT is used, fName can't be null
    lName TINYTEXT NOT NULL, -- The last name of the franchisee, Second names will fit inside 255 charachters so TINYTEXT is used, lName can't be null
    Foreign key (Eircode) References Address (Eircode) -- Connecting Eircode in Franchise to Eircode in Address
    );


/*Creates Department relation which has Department_id, Name, Manager_id, Franchise_id */
CREATE TABLE Department ( 
    Department_id INT AUTO_INCREMENT PRIMARY KEY,  -- Department_id is the primary key of Department, Type INT, Which is auto generated
    Name  TINYTEXT NOT NULL, -- The name of the department, department names fit inside 255 charachters so TINYTEXT is used, Name can't be null
    Manager_id INT NOT NULL, -- The manager of the Department, Renamed Employee_id from Employee, Manager_id is a foreign key to Empolyee relation, Manager_id can't be null
    Franchise_id INT NOT NULL, -- The Franchise_id of the Franchise the department is inside, Franchise_id is the foregin key to Franchise relation, Franchise_id can't be null
    Foreign key (Manager_id) References Employee (Employee_id), -- Connecting Manager_id in Departemnt to Employee_id in Employee
    Foreign key (Franchise_id) References Franchise (Franchise_id)  -- Connecting Franchise_id in Department to Franchise_id in Franchise
    );



/*Creates Supplier relation which has Supplier_id, Name, Phone_number, Email */
Create Table Supplier(
    Supplier_id INT AUTO_INCREMENT PRIMARY KEY, -- Suppier_id is the primary key of Supplier, Type INT, Which is auto generated
    Name VARCHAR(64) UNIQUE NOT NULL, -- Name of supplier, VARCHAR(64) is used as Name has type Unique ,Names are Unique to each Product, Name can't be null
    Phone_number CHAR(9) UNIQUE NOT NULL, -- The phone number of the franchise, Phone numbers are 9 digits long so CHAR(9) is used, Unique to each franchise, Phone_number can't be null
    Email VARCHAR(64) UNIQUE NOT NULL -- The email of the franchise, VARCHAR(64) is used as Email has type Unique ,Emails are Unique to each Supplier, Email can't be null
    );

/*Creates Employee_course relation which has Course_id, Course_name */
Create Table Employee_course(
    Course_id INT PRIMARY KEY, -- Course_id is the primary key of Employee_course, Type INT, Which is auto generated
    Course_name VARCHAR(64) UNIQUE NOT NULL -- VARCHAR(64) is used  Name as it has type Unique ,Names are Unique to each Employee_course, Name can't be null
    );

/*Creates Product relation which has Product_id, Weigtht, Name, Shelf_life, Price */
CREATE TABLE Product (
    Product_id INT AUTO_INCREMENT PRIMARY KEY, -- Product_id is the primary key of Product, Type INT, Which is auto generated
    Weight FLOAT(5,2) NOT NULL, -- Weight of product in kg, Stored as a float with two decimal places, Weight can't be null
    Name VARCHAR(64) UNIQUE NOT NULL, -- Name of product, VARCHAR(64) is used as Name has type Unique ,Names are Unique to each Product, Name can't be null
    Shelf_life SMALLINT UNSIGNED NOT NULL, -- shelf life in days of the product, SMALLINT UNSIGHED as its shelf life can't be a negative number, Shelf_life can't be null
    Price FLOAT(5,2) NOT NULL, -- Price of Product, store price in euro with two decimals up to €999.99, Price can't be null
    Supplier_id INT, -- Foreign Key for Franchise relation, Type INT 
    Foreign key (Supplier_id) References Supplier (Supplier_id)
);

/*Creates WorksFor relation which has Franchise_id, Employee_id*/
Create Table WorksFor(
    Franchise_id INT, -- Foreign Key for Franchise relation, Type INT 
    Employee_id INT, -- Foreign key of Employee relation, Type INT
    PRIMARY KEY (Franchise_id, Employee_id), -- Composite primary Key, The combination of Franchise_id and Employee_id must be unique for each row
    Foreign key (Franchise_id) References Franchise (Franchise_id), -- Connecting Franchise_id in WorksFor to Franchise_id in Franchise
    Foreign key (Employee_id) References Employee (Employee_id) -- Connecting Employee_id in WorksFor to Employee_id in Employee
    );

/*Creates AssignedTO relation which has Department_id, Employee_id*/
Create Table AssignedTo(
    Department_id INT ,-- Foreign Key for Department relation, Type INT
    Employee_id INT, -- Foreign key of Employee relation, Type INT
    PRIMARY KEY (Department_id ,Employee_id), -- Composite primary Key, The combination of Department_id and Employee_id must be unique for each row
    Foreign key (Department_id) References Department (Department_id), -- Connecting Department_id in AssignedTo to Department_id in Department
    Foreign key (Employee_id) References Employee (Employee_id) --  Connecting Employee_id in AssignedTo to Employee_id in Employee
    );

/*Creates TeachesSkillsTo relation which has Course_id, Employee_id, Start_date, Finished_date*/
Create Table TeachesSkillsTo(
    Course_id INT, -- Foreign key of Employee_course relation, Type INT
    Employee_id INT, -- Foreign key of Employee relation, Type INT
    PRIMARY KEY (Course_id ,Employee_id), -- Composite primary Key, The combination of Course_id and Employee_id must be unique for each row
    Start_date DATE NOT NULL, -- The date the employee starts the course, Uses type DATE, Start_date can't be null
    Finished_date DATE NOT NULL, -- The date the employee finishes the course, Uses type DATE, FInish_date can't be null
    Foreign key (Course_id) References Employee_course (Course_id), --  Connecting Course_id in TeachesSkillsTo to Course_id in Employee_course
    Foreign key (Employee_id) References Employee (Employee_id) --  Connecting Employee_id in TeachesSkillsTo to Employee_id in Employee
    );

/*Creates ProductsDisplayedIn relation which has Department_id, Product_id */
Create Table ProductDisplayedIn(
    Department_id INT, -- Foreign key of Department relation, Type INT
    Product_id INT, -- Foreign key of Product relation, Type INT
    PRIMARY KEY (Department_id ,Product_id), -- Composite primary Key, The combination of Department_id and Product_id must be unique for each row
    Foreign key (Department_id) References Department (Department_id), -- Connecting Department_id in ProductsDisplayedIn to Department_id in Department
    Foreign key (Product_id) References Product (Product_id) -- Connecting Product_id in TeachesSkillsTo to Product_id in Product
    );

/*Creates ProductPromotion relation which has Promotion_id, Product_id, New_price */
Create Table ProductPromotion(
    Promotion_id INT, -- Foreign key of Promotion relation, Type INT
    Product_id INT, -- Foreign key of Product relation, Type INT
    New_price FLOAT(5,2) NOT NULL, -- New price of Product, store price in euro with two decimals up to €999.99, Not null
    PRIMARY KEY (Promotion_id ,Product_id), -- Composite primary Key, The combination of Promotion_id and Product_id must be unique for each row
    Foreign key (Promotion_id) References Promotion (Promotion_id), -- Connecting Promtotion_id in ProductPromotion to Promotion_id in Promotion
    Foreign key (Product_id) References Product (Product_id) -- Connecting Product_id in ProductPromotion to Product_id in Product
    );

/*Creates ManufacturerCountry relation which has ManufactuerCountry, Product_id */
Create Table ManufacturerCountry(
    ManufacturerCountry VARCHAR(56), -- The counrty the product was manufactured in, Uses Type VARCHAR(56) as it is a primary Key and the country with the longest name has 54 charachters.
    Product_id INT, -- Foreign key of Product relation, Type INT
    PRIMARY KEY (ManufacturerCountry , Product_id), -- Composite primary Key, The combination of ManufacturerCountry and Product_id must be unique for each row
    Foreign key (Product_id) References Product (Product_id) -- Connecting Product_id in ManufacturerCountry to Product_id in Product
    );

/*Creates ProductCategory relation which has Category, Product_id */
Create Table ProductCategory(
    Category VARCHAR(50), -- The category of the product, Uses type VARCHAR(50) as it is a primary key
    Product_id INT, -- Foreign key of Product relation, Type INT
    PRIMARY KEY (Category, Product_id), -- Composite primary Key, The combination of Category and Product_id must be unique for each row
    Foreign key (Product_id) References Product (Product_id) -- Connecting Product_id in ProductCategory to Product_id in Product
    );

/*Creates SupplierAddress relation which has Supplier_id, Eircode */
Create Table SupplierAddress(
    Supplier_id INT,  -- Foreign key of Suppiler relation, Type INT
    Eircode VARCHAR(7), -- Eircode of the Supplier, Foreign key of Address relation, Type VARCHAR(7)
    PRIMARY KEY(Eircode, Supplier_id), -- Composite primary Key, The combination of Eircode and Supplier_id must be unique for each row
    Foreign key (Supplier_id) References Supplier (Supplier_id), -- Connecting Supplier_id in SupplierAddress to Supplier_id in Supplier
    Foreign key (Eircode) References Address (Eircode) -- Connecting Eircode in Franchise to Eircode in Address
    );

/*Creates WorkHistory relation which has Company_name, Employee_id */
Create Table WorkHistory(
    Company_name VARCHAR(100), -- The name of the company the employee has previously worked for, Uses VARCHAR(100) as it is a primary key
    Employee_id INT, -- Foreign key of Employee relation,Type INT
    PRIMARY KEY(Company_name, Employee_id), -- Composite primary Key, The combination of Company_name and Employee_id must be unique for each row
    Foreign key (Employee_id) References Employee (Employee_id) --  Connecting Employee_id in WorkHistory to Employee_id in Employee
    );
    
/*Creates Transaction relation which has Transaction_id, Employee_id, Franchise_id*/
Create Table Transaction(
	Transaction_id INT, -- Transaction_id is the primary key of Transaction, Type INT
    Employee_id INT, -- Foreign key of Employee relation, Type INT
    Franchise_id INT, -- Foreign Key for Franchise relation, Type INT
    Foreign key (Employee_id) References Employee (Employee_id), --  Connecting Employee_id in Transaction to Employee_id in Employee
    Foreign key (Franchise_id) References Franchise (Franchise_id) -- Connecting Franchise_id in Transaction to Franchise_id in Franchise
	);
    
/*Creates ShoppingCart realtion which has Transaction_id, Product_id, Quantity */
Create Table ShoppingCart(
	Transaction_id INT, -- Foreign key of Transaction relation, Type INT
    Product_id INT, -- Foreign key of Product relation, Type INT
    Quantity INT UNSIGNED NOT NULL, -- The quantity od the smae product that is being purchased, UNSIGNED INT as it must be a positive number, Quantity can't be null
    Foreign key (Product_id) References Product (Product_id), -- Connecting Product_id in ShoppingCart to Product_id in Product
    Foreign key (Product_id) References Product (Product_id) -- Connecting Transaction_id in ShoppingCart to Transaction_id in Transaction
    );


/* Inseting to the Address relation a new tuble with Eircode: W91H85D, Street: Main street, Town: Naas, County: Kildare */
INSERT INTO Address (Eircode, Street, Town, County) VALUES ('W91H85D', 'Main street', 'Naas', 'Kildare');

/* Inseting to the Address relation a new tuble with Eircode: D09KB10, Street: Home Farm Road, Town: Drumcondra, County: Dublin */
INSERT INTO Address (Eircode, Street, Town, County) VALUES ('D09KB10', 'Home Farm Road', 'Drumcondra', 'Dublin');

/* Inseting to the Address relation a new tuble with Eircode: D12AF4E, Street: Harbour street, Town: Black Rock, County: Dublin */
INSERT INTO Address (Eircode, Street, Town, County) VALUES ('D12AF4E', 'Harbour street', 'Black Rock', 'Dublin');

INSERT INTO Address (Eircode, Street, Town, County) VALUES ('D05GQEB', 'Fake street', 'Glassnevin', 'Dublin');
INSERT INTO Address (Eircode, Street, Town, County) VALUES ('D11OWE5', '123 street', 'Ballymun', 'Dublin');
INSERT INTO Address (Eircode, Street, Town, County) VALUES ('D05KA5e', 'ABC road', 'Lucan', 'Dublin');





/* Inseting to the Promotion relation a new tuble with Name: Black Friday 2019, Start_date: 2019-11-22, End_date: 2019-11-29 */
INSERT INTO Promotion (Name, Start_date, End_date) VALUES ('Black Friday 2019', '2019-11-22', '2019-11-29');

/* Inseting to the Promotion relation a new tuble with Name: Christmas 2020, Start_date: 2020-12-01, End_date: 2020-12-26 */
INSERT INTO Promotion (Name, Start_date, End_date) VALUES ('Christmas 2020', '2020-12-01', '2020-12-26');

/* Inseting to the Promotion relation a new tuble with Name: Summer Savings 2021, Start_date: 2021-07-01, End_date: 2022-07-08 */
INSERT INTO Promotion (Name, Start_date, End_date) VALUES ('Summer Savings 2021', '2021-07-01', '2022-07-08');


/* Inseting to the Employee relation a new tuble with fName: Michael, lName: Regan, Email: 123@gmail.com, Phone_number: 876734924, Employee_status: full-time, Wage: 14.50 */
INSERT INTO Employee (fName, lName, Email, Phone_number, Employee_status, Wage) VALUES ('Michael', 'Regan', '123@gmail.com', '876734924', 'full-time', '14.50');

/* Inseting to the Employee relation a new tuble with fName: Ayoub, lName: Al-Kendi, Email: Ayoub2@gmail.com, Phone_number: 875738765, Employee_status: part-time, Wage: 14.50 */
INSERT INTO Employee (fName, lName, Email, Phone_number, Employee_status, Wage) VALUES ('Ayoub', 'Al-Kendi', 'Ayoub2@gmail.com', '875738765', 'part-time', '14.50');

/* Inseting to the Employee relation a new tuble with fName: Jane, lName: Doe, Email: Dane45@gmail.com, Phone_number: 851234567, Employee_status: full-time, Wage: 18.71 */
INSERT INTO Employee (fName, lName, Email, Phone_number, Employee_status, Wage) VALUES ('Jane', 'Doe', 'Dane45@gmail.com', '851234567', 'full-time', '18.71');


/* Inseting to the Franchise relation a new tuble with Name: Cross Centra, Phone_number: 924527198, Email: Crosses@centra.ie, Eircode: W91H85D, fName: Stephan, lName: Cross */
INSERT INTO Franchise (Name, Phone_number, Email, Eircode, fName, lName) VALUES ('Cross Centra', '924527198', 'Crosses@centra.ie', 'W91H85D', 'Stephan', 'Cross');

/* Inseting to the Franchise relation a new tuble with Name: Borans Centra, Phone_number: 823467246, Email: Borans@centra.ie, Eircode: D09KB10, fName: Cian, lName: Boran */
INSERT INTO Franchise (Name, Phone_number, Email, Eircode, fName, lName) VALUES ('Borans Centra', '823467246', 'Borans@centra.ie', 'D09KB10', 'Cian', 'Boran');

/* Inseting to the Franchise relation a new tuble with Name: Reids Centra, Phone_number: 876749080, Email: Reids@centra.ie, Eircode: D12AF4E, fName: Robert, lName:  Reid */
INSERT INTO Franchise (Name, Phone_number, Email, Eircode, fName, lName) VALUES ('Reids Centra', '876749080', 'Reids@centra.ie', 'D12AF4E', 'Robert', 'Reid');


/* Inseting to the Franchise relation a new tuble with Name: Bakery, Manager_id: 3, Franchise_id: 2 */
INSERT INTO Department (Name, Manager_id, Franchise_id) VALUES ('Bakery', '3', '1');

/* Inseting to the Franchise relation a new tuble with Name: Bakery, Manager_id: 1, Franchise_id: 3 */
INSERT INTO Department (Name, Manager_id, Franchise_id) VALUES ('Bakery', '1', '2');

/* Inseting to the Franchise relation a new tuble with Name: Deli, Manager_id: 2, Franchise_id: 1 */
INSERT INTO Department (Name, Manager_id, Franchise_id) VALUES ('Deli', '2', '3');


/* Inseting to the Supplier relation new tubles with Name: Musgrave Distrabution, Phone_number: 865427653, Email: distribution@musgrave.ie */
INSERT INTO Supplier (Name, Phone_number, Email) VALUES ('Musgrave Distrabution', '865427653', 'distribution@musgrave.ie');

/* Inseting to the Supplier relation new tubles with Name: Whole Foods International, Phone_number: 892462367, Email: contact@wfi.com */
INSERT INTO Supplier (Name, Phone_number, Email) VALUES ('Whole Foods International', '892462367', 'contact@wfi.com');

/* Inseting to the Supplier relation new tubles with Name: Coca Cola, Phone_number: 876543267, Email: contact@cocacola.com */
INSERT INTO Supplier (Name, Phone_number, Email) VALUES ('Coca Cola', '876543267', 'contact@cocacola.com');

/* Inseting to the Product relation new tubles with Weight: 0.01, Name: Kit-Kat, Shelf_life: 250, Price: 1.50, Supplier_id:  1*/
INSERT INTO Product (Weight, Name, Shelf_life, Price, Supplier_id) VALUES ('0.01', 'Kit-Kat', '250','1.50', '1');
INSERT INTO Product (Weight, Name, Shelf_life, Price, Supplier_id) VALUES ('2', 'Coca-Cola 2L', '365','2.45', '3');
INSERT INTO Product (Weight, Name, Shelf_life, Price, Supplier_id) VALUES ('6', 'Sour dough bread', '5','3.60', '2');
INSERT INTO Product (Weight, Name, Shelf_life, Price, Supplier_id) VALUES ('0.4', 'Poppcorn chicken', '1','4.50', '1');


INSERT INTO Employee_course (Course_id, Course_name) VALUES ('1', 'Food Safty');
INSERT INTO Employee_course (Course_id, Course_name) VALUES ('2', 'Maual Handling');
INSERT INTO Employee_course (Course_id, Course_name) VALUES ('3', 'Customer Service');

INSERT INTO WorksFor (Franchise_id, Employee_id) VALUES ('1', '3');
INSERT INTO WorksFor (Franchise_id, Employee_id) VALUES ('2', '1');
INSERT INTO WorksFor (Franchise_id, Employee_id) VALUES ('3', '2');

INSERT INTO AssignedTo (Department_id, Employee_id) VALUES ('1', '3');
INSERT INTO AssignedTo (Department_id, Employee_id) VALUES ('2', '1');
INSERT INTO AssignedTo (Department_id, Employee_id) VALUES ('3', '2');

INSERT INTO TeachesSkillsTo (Course_id, Employee_id, Start_date, Finished_date) VALUES ('1', '2' , '2019-11-01', '2019-11-08');
INSERT INTO TeachesSkillsTo (Course_id, Employee_id, Start_date, Finished_date) VALUES ('2', '2' , '2020-05-12', '20202-06-01');
INSERT INTO TeachesSkillsTo (Course_id, Employee_id, Start_date, Finished_date) VALUES ('3', '3' , '2021-03-26', '2021-03-26');

INSERT INTO ProductDisplayedIn (Department_id, Product_id) VALUES ('1', '3');
INSERT INTO ProductDisplayedIn (Department_id, Product_id) VALUES ('2', '3');
INSERT INTO ProductDisplayedIn (Department_id, Product_id) VALUES ('3', '4');

INSERT INTO ProductDisplayedIn (Promotion_id, Product_id, New_price) VALUES ('1', '2', '2.10');
INSERT INTO ProductDisplayedIn (Promotion_id, Product_id, New_price) VALUES ('2', '1', '0.61');
INSERT INTO ProductDisplayedIn (Promotion_id, Product_id, New_price) VALUES ('3', '4', '3');

INSERT INTO ManufactuerCountry (Promotion_id, Product_id, New_price) VALUES ('2', 'United States of America');
INSERT INTO ManufactuerCountry (Promotion_id, Product_id, New_price) VALUES ('2', 'Great Britain');
INSERT INTO ManufactuerCountry (Promotion_id, Product_id, New_price) VALUES ('3', 'Republic of Ireland');
