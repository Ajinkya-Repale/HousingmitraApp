#🏠 Housing Management System (HMS)

-----

##**Overview**

The Housing Management System (HMS) is a web-based application designed to streamline the management of housing societies or apartment complexes. It provides separate dashboards for Admins and Residents/Users, allowing efficient management of properties, requests, complaints, payments, and notices.

The system enhances communication between residents and management while providing real-time tracking of housing activities.
<br><br>

##**Features**
<br><br>
###**Admin Features**

-Secure Admin login and dashboard overview

-**Manage Users**: tenants, owners, and their roles

-**Handle Properties**: add, edit, and view property listings

-Approve or reject Requests (maintenance, booking, permissions)

-Manage Complaints submitted by residents

-Post and manage Notices for users

-Track Expenses and monthly statistics

<br><br>




##**User Features**

-Secure User login and personalized dashboard

-View and manage booked properties

-Submit Requests and track their status (Pending/Accepted/Rejected)

-Submit and track Complaints

-View Notices posted by management

-View Payments Due and maintain payment history

-Interactive chatbot for support and queries


<br><br>


**Technology Stack**

| Layer    | Technology                            |
| -------- | ------------------------------------- |
| Backend  | **Spring Boot (Java)**                |
| Frontend | JSP, HTML, CSS, JavaScript            |
| Database | MySQL/PostgreSQL                      |
| ORM      | Spring Data JPA / Hibernate           |
| Server   | Embedded **Tomcat** (via Spring Boot) |
| Styling  | Responsive CSS (Grid & Flexbox)       |

<br><br>

****Project Structure
****

```
/src
   /com/MainApp/Entity
       Complaint.java
       Request.java
       Notice.java
   /com/MainApp/Servlets
       LoginServlet.java
       AdminServlets.java
       UserServlets.java
/webapp
   admin-home.jsp
   user-home.jsp
   user-requests.jsp
   user-complaints.jsp
   user-notice.jsp
   Login.jsp
   /css
       style.css
   /js
       scripts.js
/WEB-INF
   web.xml
```

<br><br>

**Future Enhancements******

-AI-powered chatbot for automated support

-Email/SMS notifications for requests, payments, and notices

-Payment gateway integration

-Analytics dashboard for Admin with charts and graphs

<br><br>

**Authors******

**Ajinkya Repale - https://github.com/Ajinkya-Repale** 




