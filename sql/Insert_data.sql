========================================================
       FASHION SHOW DATABASE — INSERT STATEMENTS
========================================================




-- 1. VENUE
--------------------------------------------------------


INSERT INTO Venue VALUES
(1, 'Grand Hall',       'Mumbai',    'India', 500, 100000),
(2, 'Expo Center',      'Delhi',     'India', 800, 150000),
(3, 'Sky Arena',        'Bangalore', 'India', 700, 120000),
(4, 'Royal Palace',     'Jaipur',    'India', 400,  90000),
(5, 'Sea View Hall',    'Goa',       'India', 350,  80000),
(6, 'City Convention',  'Ahmedabad', 'India', 600, 110000);




-- 2. ORGANIZER
--------------------------------------------------------


INSERT INTO Organizer VALUES
(1, 'Amit Shah',   'amit@mail.com',  '9999999991', 'amit01',  'pass'),
(2, 'Riya Mehta',  'riya@mail.com',  '9999999992', 'riya01',  'pass'),
(3, 'Kunal Verma', 'kunal@mail.com', '9999999993', 'kunal01', 'pass'),
(4, 'Sneha Patel', 'sneha@mail.com', '9999999994', 'sneha01', 'pass');




-- 3. FASHIONSHOW
--------------------------------------------------------


INSERT INTO FashionShow VALUES
(101, 'Summer Vibes',   '2026-05-10', 'Spring', 300, 200000, 1, 1),
(102, 'Winter Luxe',    '2026-12-15', 'Winter', 600, 400000, 2, 2),
(103, 'Urban Street',   '2026-06-20', 'Spring', 400, 250000, 3, 3),
(104, 'Royal Heritage', '2026-11-10', 'Winter', 500, 300000, 4, 4),
(105, 'Beach Style',    '2026-07-05', 'Spring', 350, 180000, 5, 3),
(106, 'Modern Fusion',  '2026-09-15', 'Fall',   450, 220000, 6, 2);




-- 4. SEGMENT
--------------------------------------------------------


INSERT INTO Segment VALUES
(1,  'Opening',   '10:00', '10:30', 101),
(2,  'Main Show', '10:30', '11:30', 101),
(3,  'Finale',    '11:30', '12:00', 101),
(4,  'Opening',   '18:00', '18:30', 102),
(5,  'Main Show', '18:30', '19:30', 102),
(6,  'Finale',    '19:30', '20:00', 102),
(7,  'Opening',   '14:00', '14:30', 103),
(8,  'Main Show', '14:30', '15:30', 103),
(9,  'Opening',   '16:00', '16:30', 104),
(10, 'Main Show', '16:30', '17:30', 104);




-- 5. DESIGNER
--------------------------------------------------------


INSERT INTO Designer VALUES
(1, 'Rahul Jain',     'RJ Couture', 10, 'Couture',    'India', '9991', 'rj.com'),
(2, 'Anita Kapoor',   'AK Designs',  8, 'Bridal',     'India', '9992', 'ak.com'),
(3, 'Zara Khan',      'ZK Street',   5, 'Streetwear', 'India', '9993', 'zk.com'),
(4, 'Vikas Sharma',   'VS Studio',  12, 'Luxury',     'India', '9994', 'vs.com'),
(5, 'Meera Joshi',    'MJ Fashion',  6, 'Casual',     'India', '9995', 'mj.com'),
(6, 'Arjun Malhotra', 'AM Label',    9, 'Formal',     'India', '9996', 'am.com');




-- 6. GARMENT
--------------------------------------------------------


INSERT INTO Garment VALUES
(1,  'Red Gown',     'Gown',   'Silk',    'Red',    20000, 1),
(2,  'Blue Lehenga', 'Lehenga','Cotton',  'Blue',   15000, 2),
(3,  'Black Jacket', 'Jacket', 'Leather', 'Black',  12000, 3),
(4,  'White Dress',  'Dress',  'Silk',    'White',  18000, 1),
(5,  'Golden Saree', 'Saree',  'Silk',    'Gold',   22000, 4),
(6,  'Denim Set',    'Casual', 'Denim',   'Blue',   10000, 5),
(7,  'Black Suit',   'Formal', 'Wool',    'Black',  25000, 6),
(8,  'Pink Dress',   'Dress',  'Silk',    'Pink',   17000, 2),
(9,  'Green Jacket', 'Jacket', 'Cotton',  'Green',  13000, 3),
(10, 'Silver Gown',  'Gown',   'Silk',    'Silver', 30000, 1);




-- 7. MODEL
--------------------------------------------------------


INSERT INTO Model VALUES
(1, 'Aisha Khan',  '8881', 'Elite Models', 170, '34-26-36', 'link1'),
(2, 'Rohit Singh', '8882', 'Top Models',   180, '38-30-40', 'link2'),
(3, 'Neha Verma',  '8883', 'Elite Models', 168, '33-25-35', 'link3'),
(4, 'Simran Kaur', '8884', 'Top Models',   172, '34-27-36', 'link4'),
(5, 'Aman Verma',  '8885', 'Elite Models', 182, '40-32-42', 'link5'),
(6, 'Priya Shah',  '8886', 'Star Models',  168, '33-26-35', 'link6');




-- 8. WALKSIN
--------------------------------------------------------


INSERT INTO WalksIn VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 2, 3),
(1, 4, 3, 4),
(2, 1, 4, 1),
(4, 5, 5, 2),
(5, 6, 5, 3),
(6, 7, 6, 4),
(4, 8, 7, 1),
(5, 9, 8, 2),
(6, 10, 8, 3);




-- 9. PARTICIPATES
--------------------------------------------------------


INSERT INTO Participates VALUES
(1, 101, 'Confirmed'),
(2, 101, 'Confirmed'),
(3, 102, 'Pending'),
(4, 103, 'Confirmed'),
(5, 103, 'Confirmed'),
(6, 104, 'Confirmed'),
(1, 105, 'Pending'),
(2, 106, 'Confirmed');




-- 10. SPONSOR
--------------------------------------------------------


INSERT INTO Sponsor VALUES
(1, 'Lux Co.',    'Luxury',   'Ramesh', 'lux@mail.com'),
(2, 'Glow Ltd.',  'Cosmetics','Sita',   'glow@mail.com'),
(3, 'Shine Corp', 'Jewelry',  'Rita',   'shine@mail.com'),
(4, 'Style Hub',  'Fashion',  'Vikram', 'style@mail.com');




-- 11. SPONSORSHIP
--------------------------------------------------------


INSERT INTO Sponsorship VALUES
(1, 101, 50000, 'Logo'),
(2, 101, 70000, 'Ads'),
(1, 102, 60000, 'Banner'),
(3, 103, 40000, 'Ads'),
(4, 104, 60000, 'Logo'),
(2, 105, 30000, 'Banner'),
(1, 106, 50000, 'Promotion');




-- 12. MEDIAREP
--------------------------------------------------------


INSERT INTO MediaRep VALUES
(1, 'Vogue',        'Magazine',     'John'),
(2, 'FashionTV',    'TV',           'Alice'),
(3, 'StyleMag',     'Magazine',     'Rohan'),
(4, 'InstaFashion', 'Social Media', 'Pooja');




-- 13. COVEREDBY
--------------------------------------------------------


INSERT INTO CoveredBy VALUES
(1, 101, 100000, 'Photos'),
(2, 101, 200000, 'Live'),
(1, 102, 150000, 'Article'),
(3, 103, 120000, 'Photos'),
(4, 103, 180000, 'Social'),
(3, 104, 140000, 'Article'),
(4, 105, 160000, 'Reel');




-- 14. GUESTS
--------------------------------------------------------


INSERT INTO Guests VALUES
(1, 'Karan Johar',        'karan@mail.com',   '7771', 'VIP', 'Director', 'M'),
(2, 'Alia Bhatt',         'alia@mail.com',    '7772', 'VIP', 'Actor',    'F'),
(3, 'Ranveer Singh',      'ranveer@mail.com', '7773', 'VIP', 'Actor',    'M'),
(4, 'Deepika Padukone',   'deepika@mail.com', '7774', 'VIP', 'Actor',    'F');




-- 15. INVITEDTO
--------------------------------------------------------


INSERT INTO InvitedTo VALUES
(1, 101),
(2, 101),
(3, 102),
(4, 103);




-- 16. CREW
--------------------------------------------------------


INSERT INTO Crew VALUES
(1, 'Manoj',  5, 'manoj@mail.com', 'Lighting'),
(2, 'Suresh', 7, 'suresh@mail.com','Sound'),
(3, 'Ravi',   4, 'ravi@mail.com',  'Camera'),
(4, 'Ajay',   6, 'ajay@mail.com',  'Stage');




-- 17. CONSISTSOF
--------------------------------------------------------


INSERT INTO ConsistsOf VALUES
(1, 101),
(2, 101),
(3, 102),
(4, 103);




-- 18. LANGUAGES
--------------------------------------------------------


INSERT INTO Languages VALUES
(1, 'English'),
(1, 'Hindi'),
(2, 'English'),
(3, 'Hindi'),
(4, 'Punjabi'),
(5, 'English'),
(6, 'Gujarati');




-- 19. WEARS
--------------------------------------------------------


INSERT INTO Wears VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 4),
(4, 5),
(5, 6),
(6, 7),
(4, 8),
(5, 9);




========================================================
                      END OF FILE
========================================================
