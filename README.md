# Hospital-Resource-Utilization-Patient-Outcomes-Dashboard
Hospital Resource Utilization Dashboard built using MySQL, Power BI, and Flask API to analyze patient flow, bed occupancy, doctor utilization, billing, and outcomes. SQL views handle core calculations, Power BI provides interactive insights, and API enables secure data access for analytics and reporting.

📌 Project Overview
This project is an interactive Hospital Analytics Dashboard designed to help hospital management teams monitor, analyze, and optimize resource utilization and patient outcomes in a mid-sized multi-specialty hospital.
The solution transforms raw hospital data into meaningful insights using MySQL, SQL analytics, Power BI, and Flask API, enabling data-driven decision-making.
________________________________________
🎯 Problem Statement
Hospitals generate large volumes of data related to patient admissions, bed occupancy, discharges, and department workloads.
Without a centralized analytics system, it becomes difficult to:
•	Track hospital performance
•	Identify resource bottlenecks
•	Optimize staffing and bed utilization
•	Improve patient outcomes
This project solves these challenges by delivering a single, interactive dashboard with key hospital metrics.
________________________________________
🛠️ Tech Stack
•	Database: MySQL
•	Backend / API: Flask (Python)
•	Data Processing: SQL (Views & Calculations)
•	Visualization: Power BI
•	Version Control: Git & GitHub
________________________________________
📊 Dashboard Features
🔹 Key Performance Indicators (KPIs)
•	Total Patient Admissions
•	Total Discharges
•	Bed Occupancy Count
•	Average Length of Stay (LOS)
•	Department-wise Patient Load

🔹 Visual Analytics
•	Bed Occupancy by Bed Type
•	Admissions vs Discharges trends
•	Department-wise comparison
•	Interactive filters (Date, Department)

🔹 Interactivity
•	Auto-refresh when database updates
•	Filter-based insights for decision-making
________________________________________
🗂️ Data Model
The minimum dataset includes:
•	Patient Demographics (Age, Gender, Insurance Type)
•	Admission & Discharge Records
•	Department & Doctor Details
•	Bed & Resource Allocation
•	Billing & Outcome Records
SQL views are used to calculate:
•	Length of Stay
•	Occupied Beds
•	Discharged Patients
•	Department-level summaries
________________________________________
🏗️ System Architecture
1.	Hospital data stored in MySQL
2.	SQL views perform all KPI calculations
3.	Power BI connects directly to MySQL
4.	Dashboard visuals update automatically
5.	Flask API exposes data endpoints for future deployment
