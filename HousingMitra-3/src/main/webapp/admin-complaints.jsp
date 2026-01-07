<%@ page import="com.MainApp.Entity.Complaint"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Complaints</title>

<style>
:root {
    --accent:#2e8fe3;
    --resolved:#22c55e;
    --rejected:#ef4444;
    --pending:#facc15;
    --muted:#9fb6c9;
}

/* RESET */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Inter,system-ui,sans-serif;
}

/* PAGE LAYOUT */
html, body{
    height:100%;
    width:100%;
    margin:0;
}

/* HIDE VERTICAL SCROLLBAR BUT KEEP SCROLLING */
html {
    overflow-y: hidden; /* hide default scrollbar */
}
body {
    overflow-y: auto; /* allow scrolling */
    scrollbar-width: none; /* Firefox */
    -ms-overflow-style: none; /* IE 10+ */
    background: radial-gradient(circle at top,#0e2a44,#081726);
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* ensures background covers full height */
    color: #fff;
    padding-top: 90px;
}

/* Hide scrollbar for Webkit */
body::-webkit-scrollbar {
    width: 0;
    height: 0;
}

/* HEADER */
header{
    position: fixed;
    top:0;
    left:0;
    width:100%;
    padding:18px 50px;
    background:rgba(17,40,61,.85);
    backdrop-filter:blur(12px);
    display:flex;
    justify-content:space-between;
    align-items:center;
    z-index:1000;
}
header h2{font-size:22px;}
header a{color:#cfe0ee; text-decoration:none;}

/* MAIN */
main{
    flex:1 0 auto;
    padding:40px 6vw;
}

/* FILTER DROPDOWN */
.filter-btns{
    display:flex;
    justify-content:flex-end;
    gap:12px;
    margin-bottom:20px;
}
.filter-btns select{
    padding:8px 16px;
    border:none;
    border-radius:18px;
    background:var(--accent);
    color:#fff;
    font-weight:600;
    cursor:pointer;
}

/* COMPLAINT GRID */
.complaint-list{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:22px;
}

/* COMPLAINT CARD */
.complaint{
    background:linear-gradient(180deg,#0f2940,#0b2235);
    padding:22px;
    border-radius:20px;
    box-shadow:0 20px 45px rgba(0,0,0,.45);
    transition:.3s;
}
.complaint:hover{
    transform:translateY(-6px);
    background:#13344f;
}
.complaint h3{margin-bottom:6px; font-size:16px;}
.complaint small{font-size:12px; color:var(--muted);}
.complaint p{font-size:13px; color:#cbd5e1; line-height:1.5;}

/* STATUS LABEL */
.status{
    font-weight:600;
    padding:3px 8px;
    border-radius:12px;
    font-size:12px;
}
.resolved{ background:var(--resolved); }
.rejected{ background:var(--rejected); }
.pending{ background:var(--pending); }

/* ACTION BUTTONS */
.actions{
    display:flex;
    gap:10px;
    margin-top:16px;
}
.actions form{display:contents;}
.actions button{
    flex:1;
    padding:8px;
    border:none;
    border-radius:14px;
    cursor:pointer;
    font-size:13px;
    font-weight:600;
}
.resolve{ background:var(--resolved); color:#fff; }
.reject{ background:var(--rejected); color:#fff; }

/* PAGINATION */
.pagination{
    display:flex;
    justify-content:center;
    gap:8px;
    margin:30px 0 10px 0;
}
.pagination a{
    padding:8px 12px;
    border-radius:6px;
    background:#112b44;
    color:#fff;
    text-decoration:none;
    font-weight:600;
}
.pagination a.active{
    background:var(--accent);
}

/* FOOTER */
footer{
    text-align:center;
    padding:25px 10px;
    font-size:13px;
    color:var(--muted);
    flex-shrink:0;
}

/* RESPONSIVE */
@media(max-width:1100px)
{
.complaint-list
{
	grid-template-columns:repeat(2,1fr);
}

main
{
	padding:40px 4vw;
}

}

@media(max-width:768px)
{
.complaint-list
{
	grid-template-columns:1fr;
} 
.filter-btns
{
	justify-content:center; 
	margin-bottom:25px;
}

main
{
	padding:30px 3vw;
}

header
{	
	padding:16px 30px; 
	flex-direction:column; 
	gap:6px;
}
}

@media(max-width:500px)
{
header
{
	padding:14px 20px; 
	flex-direction:column; 
	gap:6px;
}

main
{
	padding:20px 2vw;
}

.complaint
{
	padding:16px; 
	border-radius:16px;
}

.actions button
{
	font-size:12px; 
	padding:6px;
}

.filter-btns select
{
	padding:6px 12px;
	font-size:13px;
}
}

@media(max-width:360px)
{
header h2
{
	font-size:18px;
}

.complaint h3
{
	font-size:15px;
} 

.complaint p
{
	font-size:12px;
}
}
</style>
</head>

<body>

<%
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String filter = (String) request.getAttribute("filter");
    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 0;
    int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
%>

<header>
    <h2>🛠 Admin Complaints</h2>
    <a href="adminhome">← Back</a>
</header>

<main>

    <!-- FILTER DROPDOWN -->
    <div class="filter-btns">
        <form method="post" action="complaints">
            <select name="status" onchange="this.form.submit()">
                <option value="" <%= (filter == null || filter.isEmpty()) ? "selected" : "" %>>All</option>
                <option value="Pending" <%= "Pending".equals(filter) ? "selected" : "" %>>Pending</option>
                <option value="Resolved" <%= "Resolved".equals(filter) ? "selected" : "" %>>Resolved</option>
                <option value="Rejected" <%= "Rejected".equals(filter) ? "selected" : "" %>>Rejected</option>
            </select>
        </form>
    </div>

    <!-- COMPLAINT CARDS -->
    <div class="complaint-list">
        <%
            if(complaints != null && !complaints.isEmpty()){
                for(Complaint c : complaints){
                    String statusClass = "pending";
                    if("Resolved".equalsIgnoreCase(c.getStatus())) statusClass="resolved";
                    else if("Rejected".equalsIgnoreCase(c.getStatus())) statusClass="rejected";
        %>
        <div class="complaint">
            <h3><%= c.getComplaintTitle() %></h3>
            <small>Type: <%= c.getComplaintType() %></small>
            <p><%= c.getComplaintDescription() %></p>
            <span class="status <%= statusClass %>"><%= c.getStatus() %></span>

            <div class="actions">
                <form action="resolve-complaint" method="post">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <button type="submit" class="resolve">Resolve</button>
                </form>
                <form action="reject-complaint" method="post">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <button type="submit" class="reject">Reject</button>
                </form>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p style="color:#cbd5e1;">No complaints available</p>
        <%
            }
        %>
    </div>

    <!-- PAGINATION -->
    <div class="pagination">
        <%
            for(int i = 0; i < totalPages; i++){
                String activeClass = i == currentPage ? "active" : "";
                String url = "complaints?page=" + i;
                if(filter != null && !filter.isEmpty()) url += "&status=" + filter;
        %>
            <a href="<%= url %>" class="<%= activeClass %>"><%= (i+1) %></a>
        <%
            }
        %>
    </div>

</main>

<footer>© 2025 Housing Management System</footer>

</body>
</html>
