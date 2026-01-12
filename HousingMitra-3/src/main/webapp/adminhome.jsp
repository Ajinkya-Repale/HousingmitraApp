<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Admin Dashboard | Housing Management</title>

<style>
:root {
    --bg:#0b1e2e;
    --panel:#11283d;
    --panel2:#0d2335;
    --muted:#bcd0df;
    --accent:#2e8fe3;
    --accent2:#1f7bd6;
    --danger:#b91c1c;
}

/* ===== GLOBAL RESET ===== */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Inter,system-ui,sans-serif;
}

/* ===== BODY ===== */
body{
    background:var(--bg);
    color:#fff;
    padding-top:80px;
    overflow-x:hidden;
}

/* HIDE SCROLLBAR */
body::-webkit-scrollbar{ display:none; }
html{ scrollbar-width:none; }

/* ===== NAVBAR ===== */
header{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    z-index:1000;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 50px;
    background:rgba(17,40,61,.85);
    backdrop-filter:blur(10px);
}

header h2{ font-size:22px; }

nav{
    display:flex;
    gap:28px;
    align-items:center;
}

nav a{
    color:#cfe0ee;
    text-decoration:none;
    font-size:15px;
    position:relative;
    padding:6px 0;
}

/* normal nav hover */
nav a.active,
nav a:not(.logout):hover{
    color:#fff;
}

nav a.active::after,
nav a:not(.logout):hover::after{
    content:"";
    position:absolute;
    left:0;
    bottom:-6px;
    width:100%;
    height:2px;
    background:var(--accent);
}

/* ===== LOGOUT ===== */
nav a.logout{
    color:#ffb3b3;
    font-weight:600;
    padding:8px 16px;
    border-radius:16px;
    transition:.3s;
}

nav a.logout:hover{
    background:var(--danger);
    color:#fff;
}

/* remove underline from logout */
nav a.logout::after{
    display:none;
}

/* ===== HAMBURGER ===== */
.hamburger{
    display:none;
    font-size:28px;
    cursor:pointer;
}

/* MOBILE NAV */
@media(max-width:768px){
    .hamburger{ display:block; }

    nav{
        position:absolute;
        top:70px;
        right:20px;
        flex-direction:column;
        background:var(--panel);
        padding:18px;
        border-radius:14px;
        display:none;
    }

    nav.show{ display:flex; }

    nav a{
        padding:10px 0;
    }

    nav a.logout{
        width:100%;
        text-align:center;
    }
}

/* ===== LAYOUT ===== */
.section{ padding:40px 6vw; }

.hero{
    background:linear-gradient(135deg,#123b5f,#0d2335);
    padding:40px;
    border-radius:20px;
    margin-bottom:40px;
}

.hero h1{ font-size:34px; margin-bottom:8px; }
.hero p{ color:var(--muted); }

/* ===== STATS ===== */
.stats{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:24px;
    margin-bottom:40px;
}

.stat{
    background:var(--panel2);
    padding:24px;
    border-radius:18px;
    text-align:center;
}

.stat span{
    font-size:13px;
    color:var(--muted);
}

.stat h3{
    font-size:26px;
    margin-top:6px;
}

/* ===== ACTION CARDS ===== */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:26px;
}

.card{
    background:var(--panel2);
    padding:28px;
    border-radius:20px;
    transition:.3s;
}

.card:hover{
    transform:translateY(-6px);
    background:#13344f;
}

.card h4{
    font-size:20px;
    margin-bottom:10px;
}

.card p{
    font-size:14px;
    color:var(--muted);
}

.card button{
    margin-top:16px;
    padding:10px 18px;
    border:none;
    border-radius:20px;
    background:var(--accent);
    color:#fff;
    font-weight:600;
    cursor:pointer;
}

.card button:hover{
    background:var(--accent2);
}

.card .btn{
    display:inline-block;
    margin-top:16px;
    padding:10px 18px;
    border-radius:20px;
    background:var(--accent);
    color:#fff;
    font-weight:600;
    text-decoration:none;
    transition:.3s;
}

.card .btn:hover{
    background:var(--accent2);
}


/* ===== FOOTER ===== */
footer{
    text-align:center;
    padding:30px;
    color:var(--muted);
    font-size:13px;
}
</style>
</head>

<body>

<%
String atoken =(String)session.getAttribute("atoken");
if(atoken != null)
{
%>

<header>
    <h2>🏠 Housing Admin</h2>

    <nav id="nav">
        <a class="active" href="#">Dashboard</a>
        <a href="#">Users</a>
        <a href="#">Properties</a>
        <a href="#">Requests</a>
        <a href="#">Expenses</a>
        <a href="admin-logout" class="logout">Logout</a>
    </nav>

    <div class="hamburger" onclick="toggleNav()">☰</div>
</header>

<section class="section">
    <div class="hero">
        <h1>Welcome back, <%=atoken%> 👋</h1>
        <p>Here’s a quick overview of your housing management system.</p>
    </div>

    <div class="stats">
        <div class="stat">
        	<span>Total Users</span>
        	<h3><%=request.getAttribute("totalUsers") %></h3>
        </div>
        
        <div class="stat">
        	<span>Pending Request</span>
        	<h3><%=request.getAttribute("pendingRequests") %></h3>
        </div>
        
        <div class="stat">
        	<span>Pending Complaints</span>
        	<h3><%=request.getAttribute("pendingComplaints") %></h3>
        </div>
        
        <div class="stat">
        	<span>Monthly Expense</span>
        	<h3><%=request.getAttribute("noticeCount") %></h3>
        </div>
    </div>

    <div class="cards">
        
        
        <div class="card">
            <h4>📢 Manage Notice</h4>
            <p>Add, edit or remove notices</p>
            <a href="notice" class="btn">Open</a>
        </div>

        <div class="card">
            <h4>👥 Manage Users</h4>
            <p>View tenants, owners and role permissions.</p>
            <a href="manage-members" class="btn">Open</a>

        </div>

        <div class="card">
            <h4>🛠 Requests</h4>
            <p>Approve or reject maintenance and booking requests.</p>
            <a href="request" class="btn">Open</a>
        </div>
        
        <div class="card">
            <h4>🛠 Complaints</h4>
            <p>Approve or reject maintenance and booking requests.</p>
            <a href="complaints" class="btn">Open</a>
        </div>

        
    </div>
</section>

<footer>© 2025 Housing Management System</footer>

<script>
function toggleNav(){
    document.getElementById('nav').classList.toggle('show');
}


</script>

<% 
}
else
{
	response.sendRedirect("Login.jsp");
	session.setAttribute("msg", "login and access home");
}
%>

</body>
</html>
