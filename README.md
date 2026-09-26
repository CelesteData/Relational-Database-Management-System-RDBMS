# Relational-Database-Management-System-RDBMS
A full-lifecycle PostgreSQL relational database for a hospital management system. Built as a capstone for MDS 632, this project features a 3NF normalized schema, strict data integrity constraints, dynamic DDL schema modifications, and advanced analytical reporting using multi-table joins, subqueries, and window functions to extract insights.

# Belhaven Community Hospital Database Management System
# Overview
This repository contains the complete design, implementation, and analysis of a structured PostgreSQL relational database for Belhaven Community Hospital, a 50-bed medical facility. This database transitions the hospital's operational tracking from flat spreadsheets into a robust, normalized relational architecture.

The project demonstrates the full lifecycle of backend database management, from initial schema creation (DDL) and data insertion (DML) to schema evolution and advanced analytical reporting.

## Database Schema
The database (belhaven_hospital_db) is normalized to the Third Normal Form (3NF) to eliminate redundancy and maintain data integrity. It consists of seven interconnected tables:

* **patients:** Stores demographic and contact information with unique identifiers and domain constraints (e.g., gender CHECK constraints).

* **doctors:** Tracks physician details, validated specialties, and departmental assignments.

* **departments:** Catalogs hospital departments and their physical locations.

* **appointments:** The central scheduling hub linking patients and doctors, utilizing strict referential integrity (Foreign Keys).

* **treatments:** Logs medical procedures performed during appointments, including non-null descriptions and validated cost tracking.

* **medications:** Records prescriptions tied to specific treatments, ensuring dosage constraints are met.

* **billing:** Manages financial records for appointments, enforcing positive balance constraints and boolean payment statuses.

## Key Technical Features
## 1. Robust Data Integrity
The schema heavily utilizes SQL constraints to ensure operational data quality, preventing orphaned records and insertion anomalies:

* **Entity Integrity:** Implemented via PRIMARY KEY and UNIQUE constraints across all tables.

* **Referential Integrity:** Enforced using FOREIGN KEY constraints to map relational workflows (e.g., medications must tie to a valid treatment).

* **Domain Integrity:** Applied via NOT NULL, DEFAULT, and CHECK constraints (e.g., enforcing positive billing amounts and standardizing specialty entries).

## 2. Schema Evolution & Maintenance
Demonstrates the ability to manage and adapt a live database environment using advanced DDL commands:

Dynamic column additions and data type modifications (ALTER TABLE).

Safe schema teardowns and dependency management using DROP TABLE IF EXISTS and CASCADE.

## 3. Advanced Analytical Reporting
Includes a suite of analytical queries designed to extract actionable insights for hospital administrators. Query techniques utilized include:

* **Multi-Table Joins:** INNER, LEFT, and RIGHT JOIN operations to map patient histories and doctor workloads.

* **Aggregations:** GROUP BY and HAVING clauses to identify high-volume physicians.

* **Complex Subqueries:** Single-row, multi-row, and nested subqueries utilizing the EXISTS operator to filter treatment histories and patient demographics.

* **Window Functions:** Implementation of PostgreSQL-specific RANK() functions to generate performance leaderboards.

## Tech Stack
RDBMS: PostgreSQL

Tools: pgAdmin 4

Language: SQL (DDL, DML, DQL)
