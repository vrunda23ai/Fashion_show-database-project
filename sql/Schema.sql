/*DDL Script (BCNF Compliant)
The following SQL DDL script creates all tables in the Fashion Show Management Database. The script is fully BCNF-compliant and includes all necessary constraints, foreign keys, and integrity checks. */
 
 
 
-- 1. VENUE 
CREATE TABLE VENUE ( 
    VenueID     INT             PRIMARY KEY, 
    Name        VARCHAR(150)    NOT NULL, 
    City        VARCHAR(100)    NOT NULL, 
    Country     VARCHAR(100)    NOT NULL, 
    Capacity    INT             NOT NULL CHECK (Capacity > 0), 
    RentalCost  DECIMAL(12, 2)  NOT NULL CHECK (RentalCost >= 0) ); 
 
-- 2. ORGANIZER 
-- Username is a candidate key -> enforced with UNIQUE (BCNF fix) 
CREATE TABLE ORGANIZER ( 
    OrganizerID INT             PRIMARY KEY, 
    FullName    VARCHAR(150)    NOT NULL, 
    Email       VARCHAR(150)    NOT NULL UNIQUE, 
    Phone       VARCHAR(20), 
    Username    VARCHAR(80)     NOT NULL UNIQUE,   -- candidate key 
    Password    VARCHAR(255)    NOT NULL ); 
 
-- 3. FASHION_SHOW 
CREATE TABLE FASHION_SHOW ( 
    ShowID              INT             PRIMARY KEY, 
    Theme               VARCHAR(200)    NOT NULL, 
    Date                DATE            NOT NULL, 
    Season              VARCHAR(50), 
    Expected_Audience   INT             CHECK (Expected_Audience >= 0), 
    Initial_Budget      DECIMAL(15, 2)  CHECK (Initial_Budget >= 0), 
    VenueID             INT             NOT NULL, 
    OrganizerID         INT             NOT NULL, 
    FOREIGN KEY (VenueID)     REFERENCES VENUE(VenueID), 
    FOREIGN KEY (OrganizerID) REFERENCES ORGANIZER(OrganizerID) ); 
 
-- 4. SEGMENT 
CREATE TABLE SEGMENT ( 
    SegmentID   INT             PRIMARY KEY, 
    SegmentName VARCHAR(150)    NOT NULL, 
    StartTime   TIME            NOT NULL, 
    EndTime     TIME            NOT NULL, 
    ShowID      INT             NOT NULL, 
    FOREIGN KEY (ShowID) REFERENCES FASHION_SHOW(ShowID) ); 
 
 
-- 5. DESIGNER 
CREATE TABLE DESIGNER ( 
    DesignerID          INT             PRIMARY KEY, 
    Name                VARCHAR(150)    NOT NULL, 
    BrandName           VARCHAR(150), 
    YearsOfExperience   INT             CHECK (YearsOfExperience >= 0), 
    Specialization      VARCHAR(150), 
    Country             VARCHAR(100), 
    Contact             VARCHAR(150), 
    Website             VARCHAR(255) 
); 
 
-- 6. GARMENT 
CREATE TABLE GARMENT ( 
    GarmentID       INT             PRIMARY KEY, 
    Name            VARCHAR(150)    NOT NULL, 
    Type            VARCHAR(100), 
    Fabric          VARCHAR(100), 
    Color           VARCHAR(80), 
    ProductionCost  DECIMAL(10, 2)  CHECK (ProductionCost >= 0), 
    DesignerID      INT             NOT NULL, 
    FOREIGN KEY (DesignerID) REFERENCES DESIGNER(DesignerID) ); 
 
-- 7. MODEL 
CREATE TABLE MODEL ( 
    ModelID         INT             PRIMARY KEY, 
    FullName        VARCHAR(150)    NOT NULL, 
    Contact         VARCHAR(150), 
    AgencyName      VARCHAR(150), 
    Height          DECIMAL(5, 2), 
    Measurements    VARCHAR(100), 
    PortfolioLink   VARCHAR(255) 
); 
 
-- 8. LANGUAGES (multivalued attribute of MODEL   separate table, BCNF compliant) 
CREATE TABLE LANGUAGES ( 
    ModelID     INT             NOT NULL, 
    Language    VARCHAR(80)     NOT NULL, 
    PRIMARY KEY (ModelID, Language), 
    FOREIGN KEY (ModelID) REFERENCES MODEL(ModelID) ); 
 
-- 9. SPONSOR 
CREATE TABLE SPONSOR ( 
    SponsorID       INT             PRIMARY KEY, 
    CompanyName     VARCHAR(150)    NOT NULL, 
    Industry        VARCHAR(100), 
    ContactName     VARCHAR(150), 
    ContactEmail    VARCHAR(150) 
); 
 
-- 10. MEDIA_REP 
CREATE TABLE MEDIA_REP ( 
    MediaID             INT             PRIMARY KEY, 
    OrganizationName    VARCHAR(150)    NOT NULL, 
    MediaType           VARCHAR(80), 
    ContactPerson       VARCHAR(150) 
); 
 
-- 11. GUESTS 
CREATE TABLE GUESTS ( 
    GuestID     INT             PRIMARY KEY, 
    Name        VARCHAR(150)    NOT NULL, 
    Email       VARCHAR(150), 
    Phone       VARCHAR(20), 
    VIP_Status  BOOLEAN         DEFAULT FALSE, 
    Profession  VARCHAR(150), 
    Gender      VARCHAR(20) 
); 
 
-- 12. CREW 
CREATE TABLE CREW ( 
    CrewID              INT             PRIMARY KEY, 
    Name                VARCHAR(150)    NOT NULL, 
    Experience_Years    INT             CHECK (Experience_Years >= 0), 
    Email               VARCHAR(150), 
    Role                VARCHAR(100) 
); 
 
-- ============================================================= 
-- RELATIONSHIP / JUNCTION TABLES 
-- ============================================================= 
 
-- 13. PARTICIPATES (Designer -> Show) 
CREATE TABLE PARTICIPATES ( 
    DesignerID          INT             NOT NULL, 
    ShowID              INT             NOT NULL, 
    Confirmation_Status VARCHAR(50), 
    PRIMARY KEY (DesignerID, ShowID), 
    FOREIGN KEY (DesignerID) REFERENCES DESIGNER(DesignerID), 
    FOREIGN KEY (ShowID)     REFERENCES FASHION_SHOW(ShowID) ); 
 
-- 14. WALKS_IN (Model walks in Segment wearing a Garment) 
CREATE TABLE WALKS_IN ( 
    ModelID     INT     NOT NULL, 
    GarmentID   INT     NOT NULL, 
    SegmentID   INT     NOT NULL, 
    WalkNumber  INT, 
    PRIMARY KEY (ModelID, GarmentID, SegmentID), 
    FOREIGN KEY (ModelID)   REFERENCES MODEL(ModelID), 
    FOREIGN KEY (GarmentID) REFERENCES GARMENT(GarmentID), 
    FOREIGN KEY (SegmentID) REFERENCES SEGMENT(SegmentID) ); 
 
-- 15. SPONSORSHIP (Sponsor -> Show) 
CREATE TABLE SPONSORSHIP ( 
    SponsorID           INT             NOT NULL, 
    ShowID              INT             NOT NULL, 
    ContributionAmount  DECIMAL(15, 2)  CHECK (ContributionAmount >= 0), 
    BenefitType         VARCHAR(150), 
    PRIMARY KEY (SponsorID, ShowID), 
    FOREIGN KEY (SponsorID) REFERENCES SPONSOR(SponsorID), 
    FOREIGN KEY (ShowID)    REFERENCES FASHION_SHOW(ShowID) ); 
 
-- 16. COVERED_BY (Media -> Show) 
CREATE TABLE COVERED_BY ( 
    MediaID         INT             NOT NULL, 
    ShowID          INT             NOT NULL, 
    EstimatedReach  BIGINT          CHECK (EstimatedReach >= 0), 
    Coverage_Type   VARCHAR(100), 
    PRIMARY KEY (MediaID, ShowID), 
    FOREIGN KEY (MediaID) REFERENCES MEDIA_REP(MediaID), 
    FOREIGN KEY (ShowID)  REFERENCES FASHION_SHOW(ShowID) ); 
 
-- 17. INVITED_TO (Guest -> Show) 
CREATE TABLE INVITED_TO ( 
    GuestID INT     NOT NULL, 
    ShowID  INT     NOT NULL, 
    PRIMARY KEY (GuestID, ShowID), 
    FOREIGN KEY (GuestID) REFERENCES GUESTS(GuestID), 
    FOREIGN KEY (ShowID)  REFERENCES FASHION_SHOW(ShowID) ); 
 
-- 18. WEARS (Model -> Garment   general association outside segments) CREATE TABLE WEARS ( 
    ModelID     INT     NOT NULL, 
    GarmentID   INT     NOT NULL, 
    PRIMARY KEY (ModelID, GarmentID), 
    FOREIGN KEY (ModelID)   REFERENCES MODEL(ModelID), 
    FOREIGN KEY (GarmentID) REFERENCES GARMENT(GarmentID) ); 


-- 19. CONSISTS_OF (Crew -> Show) 
CREATE TABLE CONSISTS_OF ( 
    CrewID  INT     NOT NULL, 
    ShowID  INT     NOT NULL, 
    PRIMARY KEY (CrewID, ShowID), 
    FOREIGN KEY (CrewID)  REFERENCES CREW(CrewID), 
    FOREIGN KEY (ShowID)  REFERENCES FASHION_SHOW(ShowID) ); 
 
