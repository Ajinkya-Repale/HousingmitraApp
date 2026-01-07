<%@ page import="com.MainApp.Entity.Notice"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Notices</title>

<style>
:root {
    --accent:#2e8fe3;
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
}

body{
    background:radial-gradient(circle at top,#0e2a44,#081726);
    color:#fff;
    padding-top:90px;
    display:flex;
    flex-direction:column;
}

/* HIDE SCROLLBAR */
::-webkit-scrollbar{ width:0; }

/* HEADER */
header{
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

header h2{
    font-size:22px;
}

header a{
    color:#cfe0ee;
    text-decoration:none;
}

/* MAIN */
main{
    flex:1; /* pushes footer to bottom */
    padding:40px 6vw;
}

/* NOTICE GRID */
.notice-list{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:22px;
}

/* NOTICE CARD */
.notice{
    background:linear-gradient(180deg,#0f2940,#0b2235);
    padding:22px;
    border-radius:20px;
    box-shadow:0 20px 45px rgba(0,0,0,.45);
    transition:.3s; /* hover animation */
}

/* HOVER EFFECT (LIKE ADMIN HOME) */
.notice:hover{
    transform:translateY(-6px);
    background:#13344f;
}

.notice h3{
    margin-bottom:6px;
    font-size:16px;
}

.notice h4{
    font-size:13px;
    color:var(--muted);
    margin-bottom:10px;
}

.notice p{
    font-size:13px;
    color:#cbd5e1;
    line-height:1.5;
}

/* FOOTER */
footer{
    text-align:center;
    padding:25px 10px;
    font-size:13px;
    color:var(--muted);
}

/* RESPONSIVE */
@media(max-width:1100px){
    .notice-list{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:700px){
    .notice-list{
        grid-template-columns:1fr;
    }
}

@media(max-width:500px){
    header{
        padding:14px 20px;
        flex-direction:column;
        gap:6px;
    }

    main{
        padding:30px 20px;
    }

    .notice{
        padding:18px;
    }
}
</style>
</head>

<body>

<%
    List<Notice> l = (List<Notice>) request.getAttribute("ln");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
%>

<header>
    <h2>📢 Notices</h2>
    <a href="userhome">← Back</a>
</header>

<main>

    <div class="notice-list">
    <%
        if(l != null && !l.isEmpty()){
            for(Notice n : l){
    %>
        <div class="notice">
            <h3><%= n.getNoticeName() %></h3>
            <h4><%= n.getNoticeDate().format(formatter) %></h4>
            <p><%= n.getNoticeMessage() %></p>
        </div>
    <%
            }
        } else {
    %>
        <p style="color:#cbd5e1;">No notices available</p>
    <%
        }
    %>
    </div>

</main>

<footer>© 2025 Housing Management System</footer>

</body>
</html>
