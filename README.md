# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

<br><br>
# 📚 Salesforce Attendance Management System

A custom-built Attendance Management System developed using Salesforce Platform (Apex, Triggers, Lightning Web Components).

---

## 🚀 Project Overview

This system allows teachers to:

- Create Attendance Sessions
- Automatically generate attendance records for students
- Mark students as Present / Absent using Lightning Web Component
- Save attendance records
- Automatically calculate and update attendance percentage for each student

---

## 🏗️ Architecture

### 🔹 Custom Objects
- Student__c
- Attendance__c
- Attendance_Session__c

### 🔹 Relationships
- Attendance__c → Student__c (Lookup)
- Attendance__c → Attendance_Session__c (Lookup)

---

## ⚙️ Automation

### ✅ Apex Trigger
When an Attendance Session is created:
- Automatically creates attendance records for all students in that class.

### ✅ Apex Controller
- Fetches attendance records
- Updates attendance status
- Calculates attendance percentage
- Updates Student.Attendance_Percentage__c

### ✅ Lightning Web Component (LWC)
- Displays student list
- Toggle Present / Absent buttons
- Save attendance
- Real-time UI feedback

---

## 📊 Attendance Percentage Logic

Attendance % is calculated using:
(Present Count / Total Classes) * 100

Automatically recalculated whenever attendance is updated.

---

## 🛠️ Technologies Used

- Salesforce Apex
- Apex Triggers
- SOQL
- Lightning Web Components (LWC)
- Salesforce CLI (sf)
- VS Code
- Git & GitHub

---

## 📌 Features

- Real-time attendance marking
- Dynamic percentage calculation
- Bulk-safe Apex logic
- Clean Lightning UI
- GitHub version control

---

## 🎯 Future Enhancements

- Attendance dashboard analytics
- Teacher-based access restriction
- Attendance locking after submission
- Export to CSV
- Low attendance alert system

---

## 👩‍💻 Author

Developed by: [Sapna]
