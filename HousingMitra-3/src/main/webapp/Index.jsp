<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Housing Management System</title>

<style>
    :root{
        --bg:#0b1e2e;
        --panel:#11283d;
        --panel2:#0d2335;
        --muted:#bcd0df;
        --accent:#2e8fe3;
        --accent2:#1f7bd6;
    }

    *{ margin:0; padding:0; box-sizing:border-box; font-family: "Inter", sans-serif; }

    body{
        background:var(--bg);
        color:#fff;
        overflow-x:hidden;
        overflow-y:scroll;   /* keeps layout stable */
    }

    /* -------- HIDE SCROLLBAR -------- */

    /* Hide scrollbar for Chrome, Edge, Safari */
    body::-webkit-scrollbar {
        display: none;
    }

    /* Hide scrollbar for Firefox */
    html {
        scrollbar-width: none;
    }

    /* ----------- NAV ----------- */
    header{
        width:100%;
        padding:25px 50px;
        display:flex;
        justify-content:space-between;
        align-items:center;
        background:rgba(255,255,255,0.03);
        backdrop-filter: blur(6px);
    }

    header h2{
        font-size:22px;
    }

    nav a{
        margin-left:30px;
        color:#cfe0ee;
        text-decoration:none;
        font-size:16px;
        transition:0.3s ease;
    }
    
    nav a:hover{
        color:white;
    }

    /* ----------- HERO ----------- */
    .hero-section{
        width:100%;
        padding:60px 6vw;
        display:flex;
        justify-content:space-between;
        align-items:center;
        gap:50px;
        flex-wrap:wrap;
    }

    .hero-left{
        flex:1;
        min-width:330px;
    }

    .hero-left h1{
        font-size:64px;
        line-height:1.1;
        margin-bottom:18px;
        font-weight:700;
    }

    .hero-left p{
        font-size:17px;
        color:var(--muted);
        margin-bottom:25px;
        max-width:480px;
        line-height:1.6;
    }

    /* ---------- BUTTONS ---------- */
    .cta{
        background:linear-gradient(180deg,var(--accent),var(--accent2));
        padding:14px 32px;
        border-radius:28px;
        text-decoration:none;
        color:white;
        font-weight:600;
        font-size:18px;
        display:inline-block;
        transition:0.3s ease;
        margin-right:15px;
    }

    .cta:hover{
        background:linear-gradient(180deg,#3ea4ff,#1a6ac4);
        transform:scale(1.06);
        box-shadow:0 8px 20px rgba(46,143,227,0.4);
    }

    .signup-btn{
        background:transparent;
        border:2px solid var(--accent);
    }

    .signup-btn:hover{
        background:var(--accent);
        border-color:var(--accent2);
        transform:scale(1.06);
    }

    .hero-right{
        flex:1;
        display:flex;
        justify-content:center;
        align-items:center;
        min-width:330px;
    }

    .hero-right img{
        width:100%;
        max-width:440px;
        border-radius:14px;
        box-shadow:0 5px 20px rgba(0,0,0,0.3);
    }

    /* ----------- FEATURES ---------- */
    .features-container{
        width:100%;
        padding:60px 6vw;
    }

    .features-grid{
        display:grid;
        grid-template-columns:repeat(3,1fr);
        gap:30px;
    }

    .feature-box{
        background:var(--panel2);
        padding:28px;
        border-radius:16px;
        text-align:center;
        transition:0.3s ease;
    }

    .feature-box:hover{
        transform:translateY(-6px);
        background:#123049;
    }

    .feature-box h3{
        margin:10px 0;
        font-size:20px;
    }

    .feature-box p{
        color:var(--muted);
        font-size:15px;
        line-height:1.5;
    }

    /* ----------- RESPONSIVE ----------- */
    @media(max-width:1100px){
        .hero-left h1{ font-size:52px; }
    }

    @media(max-width:900px){
        .features-grid{
            grid-template-columns:repeat(2,1fr);
        }
    }

    @media(max-width:700px){
        header{
            padding:20px;
        }
        nav{ display:none; }
        .hero-section{
            text-align:center;
            flex-direction:column;
        }
        .hero-left h1{ font-size:42px; }
        .hero-left p{ font-size:15px; }
    }

    @media(max-width:550px){
        .features-grid{
            grid-template-columns:1fr;
        }
    }
</style>
</head>

<body>

<!-- NAV -->
<header>
    <h2>🏠 HOUSING</h2>
    <nav>
        <a href="#">Home</a>
        <a href="#">About</a>
        <a href="#">Features</a>
        <a href="#">Contact</a>
    </nav>
</header>

<!-- HERO -->
<section class="hero-section">

    <div class="hero-left">
        <h1>
            Housing<br>
            Management<br>
            System
        </h1>

        <p>
            Streamline society operations with digital notice boards, complaint tracking, and clubhouse booking management
        </p>

        <form action="Login" method="post" style="display:inline;">
            <button type="submit" class="cta">Get Started</button>
        </form>

        <form action="Signup" method="post" style="display:inline;">
            <button type="submit" class="cta signup-btn">Sign Up</button>
        </form>
    </div>

    <div class="hero-right">
        <img src="Image/building1.jpg" alt="House">
    </div>

</section>

<!-- FEATURES -->
<section class="features-container">

    <div class="features-grid">

        <div class="feature-box">
            <h3>🏡 Notice Management</h3>
            <p>Create and publish important society notices for residents to access instantly.</p>
        </div>

        <div class="feature-box">
            <h3>📋 Complaint Management</h3>
            <p>Submit and track maintenance complaints with a transparent, real-time resolution processubmit and track maintenance complaints with a transparent, real-time resolution process</p>
        </div>

        <div class="feature-box">
            <h3>💰 Clubhouse Booking System</h3>
            <p>Request, review, and manage clubhouse bookings with a smooth approval workflow</p>
        </div>

    </div>

</section>

</body>
</html>
    