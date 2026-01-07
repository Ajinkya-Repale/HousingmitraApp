<%@ page import="com.MainApp.Entity.Request"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Requests</title>

<style>
:root {
    --accent:#2e8fe3;
    --success:#22c55e;
    --danger:#ef4444;
    --pending:#facc15;
    --muted:#9fb6c9;
    --bg-dark:#081726;
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

body{
    display:flex;
    flex-direction:column;
    background: radial-gradient(circle at top,#0e2a44,#081726);
    color:#fff;
    min-height:100vh;
    padding-top:90px;
    overflow-y:auto;
    scrollbar-width:none;
    -ms-overflow-style:none;
}

body::-webkit-scrollbar
{ 
	width:0; 
	height:0; 
}

/* HEADER */
header
{
    position:fixed;
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

header h2
{
	 font-size:22px; 
}

header a
{
	 color:#cfe0ee; 
	 text-decoration:none; 
}


/* MAIN */
main{
    flex:1 0 auto;
    padding:40px 6vw;
}

/* TOP ACTIONS + FILTER */
.top-actions
{
    display:flex;
    justify-content:space-between;
    margin-bottom:20px;
    flex-wrap:wrap;
}

.top-actions button
{
    padding:10px 18px;
    border:none;
    border-radius:20px;
    font-weight:600;
    background:var(--accent);
    color:#fff;
    cursor:pointer;
}

.filter-btns select
{
    padding:8px 16px;
    border:none;
    border-radius:18px;
    background:var(--accent);
    color:#fff;
    font-weight:600;
    cursor:pointer;
}

/* REQUEST GRID */
.request-list
{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:22px;
}

/* REQUEST CARD */
.request-card
{
    background:linear-gradient(180deg,#0f2940,#0b2235);
    padding:22px;
    border-radius:20px;
    box-shadow:0 20px 45px rgba(0,0,0,.45);
    transition:.3s;
}

.request-card:hover
{
    transform:translateY(-6px);
    background:#13344f;
}

.request-card h3
{ 
	margin-bottom:6px; 
	font-size:16px; 
}

.request-card small
{ 
	font-size:12px;
	color:var(--muted); 
	display:block; 
	margin-bottom:4px; 
}

.request-card p
{
	 font-size:13px; 
	 color:#cbd5e1; 
	 line-height:1.5; 
	 margin-bottom:6px; 
}

.request-date
{ 
	font-size:11px; 
	color:var(--muted); 
	margin-bottom:6px; 
}

/* STATUS LABEL */
.status
{
    font-weight:600;
    padding:3px 8px;
    border-radius:12px;
    font-size:12px;
}

.status.PENDING
{ 
	background:var(--pending); 
	color:#000; 
}

.status.ACCEPTED
{ 
	background:var(--success); 
	color:#fff; 
}

.status.REJECTED
{
 	background:var(--danger); 
 	color:#fff; 
}


/* ACTION BUTTONS */
.actions
{
    display:flex;
    gap:10px;
    margin-top:16px;
}

.actions form
{ 
	display:contents; 
}

.actions button{
    flex:1;
    padding:8px;
    border:none;
    border-radius:14px;
    cursor:pointer;
    font-size:13px;
    font-weight:600;
}

.delete
{ 
	background:var(--danger); 
	color:#fff; 
}

.edit
{
	 background:var(--accent); 
	 color:#fff; 
}


/* FOOTER */
footer{
    text-align:center;
    padding:25px 10px;
    font-size:13px;
    color:var(--muted);
    background:var(--bg-dark);
    flex-shrink:0;
}

/* MODAL */
.overlay{
    display:none;
    position:fixed;
    inset:0;
    background: rgba(0,0,0,.55);
    z-index:2000;
}
.form-card{
    position:absolute;
    top:120px;
    left:50%;
    transform:translateX(-50%);
    width:420px;
    background: linear-gradient(180deg, #112b44, #0b2235);
    padding:26px;
    border-radius:24px;
}

.form-card h3
{ 
	margin-bottom:18px; 
}

.close-btn{
    position:absolute;
    top:14px;
    right:16px;
    background:none;
    border:none;
    color:#cbd5e1;
    font-size:20px;
    cursor:pointer;
}

.form-group
{ 
	margin-bottom:14px; 
}

label
{
 	font-size:12px; 
 	color:var(--muted); 
}


input, textarea, select{
    width:100%;
    margin-top:6px;
    padding:12px 14px;
    border-radius:14px;
    border:1px solid transparent;
    background:#071a2b;
    color:#fff;
}

textarea
{ 
	resize:none; 
	min-height:120px; 
}

.submit-btn
{
    margin-top:18px;
    width:100%;
    padding:12px;
    border:none;
    border-radius:18px;
    background:var(--accent);
    color:#fff;
    font-weight:700;
    cursor:pointer;
}

/* RESPONSIVE */
@media(max-width:1100px)
{ 

.request-list
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
.request-list
{
	grid-template-columns:1fr;
}
 
.top-actions
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

.actions button
{
	font-size:12px;
	padding:6px;
}

.top-actions button,.filter-btns select
{
	width:100%; 
	padding:8px 12px; 
	margin-bottom:8px;
}
}

@media(max-width:360px)
{
header h2
{
	font-size:18px;
} 

.request-card h3
{
	font-size:15px;
} 

.request-card p
{
	font-size:12px;
} 

.form-card
{
	width:calc(100% - 30px);
	top:100px;
}
}

</style>
</head>
<body>

<%
    List<Request> lr = (List<Request>) request.getAttribute("request");
    String status = (String) request.getAttribute("status");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
%>

<header>
    <h2>📝 User Requests</h2>
    <a href="userhome">← Back</a>
</header>

<main>

    <!-- TOP ACTIONS -->
    <div class="top-actions">
        <button onclick="openForm()">➕ New Request</button>
        <div class="filter-btns">
            <form method="post" action="user-requests">
                <select name="status" onchange="this.form.submit()">
                    <option value="ALL" <%= "ALL".equals(status) ? "selected" : "" %>>All</option>
                    <option value="PENDING" <%= "PENDING".equals(status) ? "selected" : "" %>>Pending</option>
                    <option value="ACCEPTED" <%= "ACCEPTED".equals(status) ? "selected" : "" %>>Accepted</option>
                    <option value="REJECTED" <%= "REJECTED".equals(status) ? "selected" : "" %>>Rejected</option>
                </select>
            </form>
        </div>
    </div>

    <!-- REQUEST CARDS -->
    <div class="request-list">
        <%
            if(lr != null && !lr.isEmpty()){
                for(Request r : lr){
        %>
        <div class="request-card">
            <h3><%= r.getRequestTitle() %></h3>
            <small>Type: <%= r.getRequestType() %></small>
            <div class="request-date">Date: <%= r.getRequestDate() != null ? r.getRequestDate().format(formatter) : "-" %></div>
            <p><%= r.getRequestMessage() %></p>
            <span class="status <%= r.getStatus() %>"><%= r.getStatus() %></span>

            <div class="actions">
                <form action="edit-request" method="get">
                    <input type="hidden" name="id" value="<%= r.getId() %>">
                    <button type="submit" class="edit">Edit</button>
                </form>
                <form action="delete-request" method="post">
                    <input type="hidden" name="id" value="<%= r.getId() %>">
                    <button type="submit" class="delete">Delete</button>
                </form>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p style="color:#cbd5e1;">No request available</p>
        <%
            }
        %>
    </div>

</main>

<footer>© 2025 Housing Management System</footer>

<!-- MODAL FOR NEW REQUEST -->
<div class="overlay" id="overlay">
    <div class="form-card">
        <button class="close-btn" onclick="closeForm()">✖</button>
        <h3>Submit Request</h3>
        <form action="submitRequest" method="post">
            <input type="hidden" name="status" value="PENDING">
            <div class="form-group">
                <label>Title</label>
                <input type="text" name="requestTitle" required>
            </div>
            <div class="form-group">
                <label>Type</label>
                <select name="requestType" required>
                    <option value="">Select type</option>
                    <option value="Maintenance">Maintenance</option>
                    <option value="Permission">Permission</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="requestMessage" required></textarea>
            </div>
            <button class="submit-btn" type="submit">Submit Request</button>
        </form>
    </div>
</div>

<script>
function openForm(){ document.getElementById("overlay").style.display="block"; }
function closeForm(){ document.getElementById("overlay").style.display="none"; }
</script>

</body>
</html>
