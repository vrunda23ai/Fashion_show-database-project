========================================================
      FASHION SHOW DATABASE — SQL QUERIES REPORT
========================================================


This document contains 15 SQL queries for the Fashion Show
Database, including standard and advanced queries. Each entry
includes a short description, the SQL code, and sample output.


--------------------------------------------------------
                    STANDARD QUERIES
--------------------------------------------------------


QUERY 1: Upcoming Shows with Venue & Organizer Details
-------------------------------------------------------
Description:
Retrieves all upcoming fashion shows (from today's date onward)
along with their venue name and organizer's full name by joining
the FashionShow, Venue, and Organizer tables.


SQL:
SELECT f.showID, f.theme, v.name AS venue, o.fullName AS organizer
FROM FashionShow f
JOIN Venue v ON f.venueID = v.venueID
JOIN Organizer o ON f.organizerID = o.organizerID
WHERE f.date >= CURRENT_DATE;


Output:
showID | theme           | venue             | organizer
-------|-----------------|-------------------|-------------
101    | Summer Vibes    | Grand Hall        | Amit Shah
103    | Urban Street    | Sky Arena         | Kunal Verma
104    | Royal Heritage  | Royal Palace      | Sneha Patel
105    | Beach Style     | Sea View Hall     | Kunal Verma
106    | Modern Fusion   | City Convention   | Riya Mehta




QUERY 2: Designers Participating in Show 101
--------------------------------------------
Description:
Lists all designers participating in a specific show (Show 101)
along with their confirmation status, by joining the Participates
and Designer tables.


SQL:
SELECT d.name, p.confirmationStatus
FROM Participates p
JOIN Designer d ON p.designerID = d.designerID
WHERE p.showID = 101;


Output:
Designer      | Status
--------------|----------
Rahul Jain    | Confirmed
Anita Kapoor  | Confirmed




QUERY 3: Full Runway Order of Show 101
---------------------------------------
Description:
Shows the complete runway walk order for Show 101, including the
walk number, model name, garment name, and segment name. Results
are sorted by walk number to reflect the sequence of the show.


SQL:
SELECT w.walkNumber, m.fullName AS model, g.name AS garment,
       s.segmentName
FROM WalksIn w
JOIN Model m ON w.modelID = m.modelID
JOIN Garment g ON w.garmentID = g.garmentID
JOIN Segment s ON w.segmentID = s.segmentID
WHERE s.showID = 101
ORDER BY w.walkNumber;


Output:
Walk | Model        | Garment      | Segment
-----|--------------|--------------|----------
1    | Aisha Khan   | Red Gown     | Opening
2    | Rohit Singh  | Blue Lehenga | Main Show
3    | Neha Verma   | Black Jacket | Main Show
4    | Aisha Khan   | White Dress  | Finale




QUERY 4: Models Working with Multiple Designers in Show 101
------------------------------------------------------------
Description:
Finds models who wore garments from more than one designer in
Show 101, indicating cross-designer participation. Uses GROUP BY
with HAVING to filter models with a distinct designer count > 1.


SQL:
SELECT m.fullName, COUNT(DISTINCT g.designerID) AS designer_count
FROM WalksIn w
JOIN Model m ON w.modelID = m.modelID
JOIN Garment g ON w.garmentID = g.garmentID
JOIN Segment s ON w.segmentID = s.segmentID
WHERE s.showID = 101
GROUP BY m.modelID, m.fullName
HAVING COUNT(DISTINCT g.designerID) > 1;


Output:
Model       | Designers
------------|----------
Aisha Khan  | 2




QUERY 5: Total Sponsorship Amount per Show
------------------------------------------
Description:
Calculates the total sponsorship money received for each show
by summing contributionAmount from the Sponsorship table,
grouped by showID.


SQL:
SELECT showID, SUM(contributionAmount) AS total_sponsorship
FROM Sponsorship
GROUP BY showID;


Output:
showID | Total
-------|--------
101    | 120000
102    | 60000
103    | 40000
104    | 60000
105    | 30000
106    | 50000




QUERY 6: Top 3 Designers by Number of Garments
------------------------------------------------
Description:
Ranks designers by the total number of garments they have
created, returning only the top 3. Useful for identifying
the most prolific designers in the database.


SQL:
SELECT d.name, COUNT(g.garmentID) AS total_garments
FROM Designer d
JOIN Garment g ON d.designerID = g.designerID
GROUP BY d.designerID, d.name
ORDER BY total_garments DESC
LIMIT 3;


Output:
Designer      | Garments
--------------|----------
Rahul Jain    | 3
Anita Kapoor  | 2
Zara Khan     | 2




QUERY 7: Average Garment Production Cost per Designer
------------------------------------------------------
Description:
Computes the average production cost of garments for each
designer, helping assess budget usage and cost efficiency
across designers.


SQL:
SELECT d.name, AVG(g.productionCost) AS avg_cost
FROM Designer d
JOIN Garment g ON d.designerID = g.designerID
GROUP BY d.name;


Output:
Designer      | Avg Cost
--------------|----------
Rahul Jain    | 22666
Anita Kapoor  | 16000
Zara Khan     | 12500




QUERY 8: Garments Shown in More Than One Show
----------------------------------------------
Description:
Identifies garments that have appeared in multiple shows by
counting the distinct showIDs associated with each garment.
Highlights reuse of garments across events.


SQL:
SELECT g.name, COUNT(DISTINCT s.showID) AS show_count
FROM WalksIn w
JOIN Garment g ON w.garmentID = g.garmentID
JOIN Segment s ON w.segmentID = s.segmentID
GROUP BY g.garmentID, g.name
HAVING COUNT(DISTINCT s.showID) > 1;


Output:
Garment   | Shows
----------|------
Red Gown  | 2




QUERY 9: Sponsors and Total Contribution Amount
------------------------------------------------
Description:
Lists each sponsor along with the total amount they have
contributed across all shows, by aggregating contribution
amounts from the Sponsorship table grouped by sponsor.


SQL:
SELECT s.companyName, SUM(sp.contributionAmount) AS total_amount
FROM Sponsor s
JOIN Sponsorship sp ON s.sponsorID = sp.sponsorID
GROUP BY s.sponsorID, s.companyName;


Output:
Sponsor      | Total
-------------|--------
Lux Co.      | 110000
Glow Ltd.    | 100000
Shine Corp   | 40000




QUERY 10: Shows with Highest Media Coverage
-------------------------------------------
Description:
Ranks shows by their total estimated media reach by summing
estimatedReach from the CoveredBy table. Helps identify
which shows gained the most visibility.


SQL:
SELECT showID, SUM(estimatedReach) AS total_reach
FROM CoveredBy
GROUP BY showID
ORDER BY total_reach DESC;


Output:
showID | Reach
-------|--------
101    | 300000
103    | 300000
104    | 140000




--------------------------------------------------------
                    ADVANCED QUERIES
--------------------------------------------------------


QUERY 11: Designers Whose Garments Appear in Maximum Shows
-----------------------------------------------------------
Description:
Uses nested subqueries with MAX and COUNT to find the designer(s)
whose garments have been featured in the highest number of
distinct shows. This is an advanced nested aggregation query.


SQL:
SELECT d.designerID, d.name
FROM Designer d
WHERE d.designerID IN (
    SELECT g.designerID
    FROM Garment g
    JOIN WalksIn w ON g.garmentID = w.garmentID
    JOIN Segment s ON w.segmentID = s.segmentID
    GROUP BY g.designerID
    HAVING COUNT(DISTINCT s.showID) = (
        SELECT MAX(show_count)
        FROM (
            SELECT COUNT(DISTINCT s2.showID) AS show_count
            FROM Garment g2
            JOIN WalksIn w2 ON g2.garmentID = w2.garmentID
            JOIN Segment s2 ON w2.segmentID = s2.segmentID
            GROUP BY g2.designerID
        ) AS temp
    )
);


Output:
Designer
----------
Rahul Jain




QUERY 12: Models Who Walked in ALL Spring Shows
------------------------------------------------
Description:
Uses the relational division technique with double NOT EXISTS
to find models who have walked in every single Spring season
show. Returns models only if no Spring show exists where they
did not participate.


SQL:
SELECT m.modelID, m.fullName
FROM Model m
WHERE NOT EXISTS (
    SELECT f.showID
    FROM FashionShow f
    WHERE f.season = 'Spring'
    AND NOT EXISTS (
        SELECT *
        FROM WalksIn w
        JOIN Segment s ON w.segmentID = s.segmentID
        WHERE w.modelID = m.modelID
        AND s.showID = f.showID
    )
);


Output:
Model
------
(No results — no model walked in all Spring shows in sample data)




QUERY 13: Sponsors Who Contributed Above Average
-------------------------------------------------
Description:
Finds sponsors whose total contribution is greater than the
average total contribution across all sponsors. Uses a nested
subquery with AVG on aggregated totals to perform this
comparison.


SQL:
SELECT s.sponsorID, s.companyName, SUM(sp.contributionAmount) AS total
FROM Sponsor s
JOIN Sponsorship sp ON s.sponsorID = sp.sponsorID
GROUP BY s.sponsorID, s.companyName
HAVING SUM(sp.contributionAmount) > (
    SELECT AVG(total_amount)
    FROM (
        SELECT SUM(contributionAmount) AS total_amount
        FROM Sponsorship
        GROUP BY sponsorID
    ) AS temp
);


Output:
Sponsor   | Total
----------|--------
Lux Co.   | 110000




QUERY 14: Model(s) with Maximum Walks in Show 101
--------------------------------------------------
Description:
Identifies the model(s) who walked the most number of segments
in Show 101. Uses a nested MAX subquery to compare each model's
walk count against the maximum walk count.


SQL:
SELECT m.modelID, m.fullName
FROM Model m
JOIN WalksIn w ON m.modelID = w.modelID
JOIN Segment s ON w.segmentID = s.segmentID
WHERE s.showID = 101
GROUP BY m.modelID, m.fullName
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM WalksIn w2
        JOIN Segment s2 ON w2.segmentID = s2.segmentID
        WHERE s2.showID = 101
        GROUP BY w2.modelID
    ) AS temp
);


Output:
Model
----------
Aisha Khan




QUERY 15: Shows Where Total Sponsorship Exceeds Total Garment Cost
-------------------------------------------------------------------
Description:
Compares total sponsorship received for each show against the
total production cost of all garments shown in that show.
Returns only shows where sponsorship money exceeded garment
production costs — a strong financial indicator query using
correlated subqueries.


SQL:
SELECT f.showID, f.theme
FROM FashionShow f
WHERE (
    SELECT SUM(sp.contributionAmount)
    FROM Sponsorship sp
    WHERE sp.showID = f.showID
) > (
    SELECT SUM(g.productionCost)
    FROM WalksIn w
    JOIN Garment g ON w.garmentID = g.garmentID
    JOIN Segment s ON w.segmentID = s.segmentID
    WHERE s.showID = f.showID
);


Output:
showID | theme
-------|-------------
101    | Summer Vibes




========================================================
                    QUERY SUMMARY TABLE
========================================================


No. | Query Title                                | Type
----|--------------------------------------------|---------
1   | Upcoming Shows with Venue & Organizer      | Standard
2   | Designers in Show 101                      | Standard
3   | Full Runway Order of Show 101              | Standard
4   | Models with Multiple Designers (Show 101)  | Standard
5   | Total Sponsorship per Show                 | Standard
6   | Top 3 Designers by Garments                | Standard
7   | Avg Garment Cost per Designer              | Standard
8   | Garments in Multiple Shows                 | Standard
9   | Sponsors with Total Contribution           | Standard
10  | Shows with Highest Media Coverage          | Standard
11  | Designers in Maximum Shows (Nested MAX)    | Advanced
12  | Models in ALL Spring Shows (Division)      | Advanced
13  | Sponsors Above Average Contribution        | Advanced
14  | Model with Max Walks in Show 101           | Advanced
15  | Shows: Sponsorship > Garment Cost          | Advanced


========================================================
                        END OF REPORT
========================================================
