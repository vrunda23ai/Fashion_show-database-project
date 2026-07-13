# 👗 Fashion Show Database

A relational database project modeling the end-to-end operations of a
fashion show — venues, organizers, designers, models, garments, runway
segments, sponsors, media coverage, guests, and crew. Built as a SQL/DBMS
project covering schema design (ER modeling → relational schema → normal
forms), sample data, and a set of standard + advanced queries.

---

## 📖 Overview

This project simulates a database that could back a real fashion-show
management platform. It models:

- **Event structure** — shows, venues, organizers, and the segments
  (Opening, Main Show, Finale, etc.) each show is broken into
- **People & creative work** — designers, the garments they create,
  models, and which garments each model wears on which runway walk
- **Business side** — sponsors and their contributions, media outlets
  and their coverage/reach
- **Attendance** — VIP guests invited to shows, and crew assigned to
  each show

It was built for `[course name / assignment name]` at `[institution]`,
`[semester/year]`.

---

## 📂 Repository Structure

```
FashionShowDB/
├── README.md
├── LICENSE
├── .gitignore
├── sql/
│   ├── 01_schema.sql        # CREATE TABLE statements (DDL)
│   ├── 02_insert_data.sql   # Sample data (INSERT statements)
│   └── 03_queries.sql       # All queries, ready to run
└── docs/
    ├── ER_diagram_and_schema_notes.md   # Entities, relationships, normalization
    ├── er_diagram.png                   # (add your exported ER diagram image here)
    └── queries_report.txt               # Query descriptions + sample output
```

---

## 🗄️ Database Schema

**Core entities:** `FashionShow`, `Venue`, `Organizer`, `Segment`,
`Designer`, `Garment`, `Model`, `Sponsor`, `MediaRep`, `Guests`, `Crew`

**Relationship / junction tables (many-to-many):** `Participates`,
`WalksIn`, `Sponsorship`, `CoveredBy`, `InvitedTo`, `ConsistsOf`, `Wears`,
`Languages`

| Table | Purpose | Key Relationships |
|---|---|---|
| `FashionShow` | Central event record | → `Venue`, → `Organizer` |
| `Venue` | Location hosting shows | 1:N with `FashionShow` |
| `Organizer` | Person/team running a show | 1:N with `FashionShow` |
| `Segment` | A portion of the runway show (e.g. Finale) | N:1 with `FashionShow` |
| `Designer` | Creates garments, participates in shows | 1:N `Garment`, N:M `FashionShow` via `Participates` |
| `Garment` | Individual outfit | N:1 `Designer`, N:M `Model` via `Wears`/`WalksIn` |
| `Model` | Walks the runway | N:M `Segment`/`Garment` via `WalksIn` |
| `Sponsor` | Funds a show | N:M `FashionShow` via `Sponsorship` |
| `MediaRep` | Covers a show | N:M `FashionShow` via `CoveredBy` |
| `Guests` | Attendees | N:M `FashionShow` via `InvitedTo` |
| `Crew` | Behind-the-scenes staff | N:M `FashionShow` via `ConsistsOf` |

Full ER breakdown (attributes, cardinalities, normalization reasoning) is
in [`docs/ER_diagram_and_schema_notes.md`](docs/ER_diagram_and_schema_notes.md).

**Normalization:** All junction tables use composite primary keys so that
relationship attributes (`ContributionAmount`, `EstimatedReach`,
`WalkNumber`, `ConfirmationStatus`) depend on the *whole* key, not a
subset — consistent with 3NF/BCNF. See the docs file for the full
argument.

---

## ▶️ Getting Started

### Prerequisites
- MySQL / PostgreSQL / SQLite (any relational DB — adjust types like
  `DECIMAL` vs `NUMERIC` as needed for your engine)

### Setup

```bash
git clone https://github.com/<your-username>/FashionShowDB.git
cd FashionShowDB
```

**MySQL:**
```bash
mysql -u root -p -e "CREATE DATABASE fashion_show;"
mysql -u root -p fashion_show < sql/01_schema.sql
mysql -u root -p fashion_show < sql/02_insert_data.sql
mysql -u root -p fashion_show < sql/03_queries.sql
```

**PostgreSQL:**
```bash
createdb fashion_show
psql -d fashion_show -f sql/01_schema.sql
psql -d fashion_show -f sql/02_insert_data.sql
psql -d fashion_show -f sql/03_queries.sql
```

**SQLite:**
```bash
sqlite3 fashion_show.db < sql/01_schema.sql
sqlite3 fashion_show.db < sql/02_insert_data.sql
sqlite3 fashion_show.db < sql/03_queries.sql
```

---

## 📊 Queries

`sql/03_queries.sql` contains all queries in runnable form.
`docs/queries_report.txt` explains what each one does and shows sample
output against the seed data.

| # | Query | Type | Concepts Used |
|---|---|---|---|
| 1 | Upcoming shows with venue & organizer | Standard | JOIN, WHERE |
| 2 | Designers participating in Show 101 | Standard | JOIN |
| 3 | Full runway order of Show 101 | Standard | JOIN, ORDER BY |
| 4 | Models with multiple designers (Show 101) | Standard | GROUP BY, HAVING, COUNT DISTINCT |
| 5 | Total sponsorship per show | Standard | GROUP BY, SUM |
| 6 | Top 3 designers by garment count | Standard | GROUP BY, ORDER BY, LIMIT |
| 7 | Avg garment cost per designer | Standard | GROUP BY, AVG |
| 8 | Garments shown in more than one show | Standard | GROUP BY, HAVING |
| 9 | Sponsors' total contribution | Standard | JOIN, GROUP BY, SUM |
| 10 | Shows with highest media coverage | Standard | GROUP BY, SUM, ORDER BY |
| 11 | Designers whose garments appear in the most shows | Advanced | Nested subquery, MAX |
| 12 | Models who walked in ALL Spring shows | Advanced | Relational division (double NOT EXISTS) |
| 13 | Sponsors who contributed above average | Advanced | Nested subquery, AVG |
| 14 | Model(s) with max walks in Show 101 | Advanced | Nested subquery, MAX |
| 15 | Shows where sponsorship exceeds garment cost | Advanced | Correlated subqueries |

---

## 🧠 Design Decisions

- `[Explain a choice you made, e.g. "WalksIn uses a composite key of
  (segmentID, modelID, garmentID) rather than a surrogate key because..."]`
- `[Note any assumptions, e.g. "A model can wear the same garment in
  multiple segments, so Wears and WalksIn are kept as separate tables."]`

---

## 🛠️ Tech Stack

- Pure SQL — portable across MySQL / PostgreSQL / SQLite with minor
  type adjustments
- No application layer; this is a database design and querying exercise

---

## 🚧 Possible Extensions

- Add a `Ticket`/`Booking` table for public (non-VIP) attendees
- Track garment inventory across seasons
- Add views for commonly-run reports (e.g. `vw_show_financials`)
- Build a thin API/front-end on top of this schema

---

## 👤 Author

It was a group university project

## 📄 License

MIT — see [LICENSE](LICENSE).
