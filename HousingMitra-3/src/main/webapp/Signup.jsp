<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign Up - Housing Management System</title>

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
        overflow-y:scroll;
    }

    body::-webkit-scrollbar { display: none; }
    html { scrollbar-width: none; }

    header{
        width:100%;
        padding:25px 50px;
        display:flex;
        justify-content:space-between;
        align-items:center;
        background:rgba(255,255,255,0.03);
        backdrop-filter: blur(6px);
    }

    header h2{ font-size:22px; }

    nav a{
        margin-left:30px;
        color:#cfe0ee;
        text-decoration:none;
        font-size:16px;
        transition:0.3s ease;
    }
    
    nav a:hover{ color:white; }

    .signup-section{
        width:100%;
        min-height:calc(100vh - 100px);
        display:flex;
        justify-content:center;
        align-items:center;
        padding:60px 20px;
    }

    .signup-box{
        background:var(--panel);
        padding:40px 30px;
        border-radius:16px;
        max-width:450px;
        width:100%;
        box-shadow:0 8px 25px rgba(0,0,0,0.4);
    }

 /* Dummy success message */
    .success-msg{
        text-align:center;
        color:var(--success);
        margin-bottom:25px; /* spacing before tabs */
        font-weight:500;
    }
    
    .signup-box h2{
        text-align:center;
        margin-bottom:20px;
        font-size:28px;
    }

    .tab-buttons{
        display:flex;
        justify-content:center;
        gap:20px;
        margin-bottom:25px;
    }

    .tab-buttons button{
        padding:10px 25px;
        border:none;
        border-radius:25px;
        background:var(--panel2);
        color:#fff;
        cursor:pointer;
        font-weight:600;
        transition:0.3s ease;
    }

    .tab-buttons button.active,
    .tab-buttons button:hover{
        background:linear-gradient(180deg,var(--accent),var(--accent2));
        box-shadow:0 6px 15px rgba(46,143,227,0.4);
    }

    form{
        display:flex;
        flex-direction:column;
        gap:18px;
    }

    input{
        padding:14px 18px;
        border-radius:10px;
        border:1px solid #1f7bd6;
        background:var(--panel2);
        color:#fff;
        font-size:16px;
    }

    input::placeholder{
        color:var(--muted);
    }

    button.submit-btn{
        background:linear-gradient(180deg,var(--accent),var(--accent2));
        padding:14px;
        border:none;
        border-radius:28px;
        color:white;
        font-weight:600;
        font-size:18px;
        cursor:pointer;
        transition:0.3s ease;
    }

    button.submit-btn:hover{
        transform:scale(1.05);
        box-shadow:0 8px 20px rgba(46,143,227,0.4);
    }

     .login-link{
        text-align:center;
        margin-top:15px;
        color:var(--muted);
        font-size:14px;
    }

    .login-link button{
        background:none;
        border:none;
        color:var(--accent);
        font-weight:600;
        cursor:pointer;
        font-size:14px;
    }

    .login-link button:hover{
        color:var(--accent2);
    }

	
	input, select
	{
    padding:14px 18px;
    border-radius:10px;
    border:1px solid #1f7bd6;
    background:var(--panel2);
    color:#fff;
    font-size:16px;
	}
	
    /* Responsive */
    @media(max-width:500px){
        .signup-box{ padding:30px 20px; }
    }
</style>
</head>
<body>

<%
String msg = (String)session.getAttribute("msg");
if(msg == null)
{
	msg="";
}
session.removeAttribute("msg");

%>

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

<!-- SIGN UP -->
<section class="signup-section">
    <div class="signup-box">
        <h2>Sign Up</h2>
        
        <!-- Dummy success message -->
        <h3 class="success-msg"> <%=msg %></h3>

        <!-- Tabs for User / Admin -->
        <div class="tab-buttons">
            <button class="active" id="userTab">User</button>
            <button id="adminTab">Admin</button>
        </div>

        <!-- User Form -->
        <form id="userForm" action="user-register" method="post">
            <input type="text" name="userName" placeholder="Full Name" required>
            <input type="email" name="userEmail" placeholder="Email Address" required>
            <input type="text" name="userFlatno" placeholder="flat no" required>
            <input type="number" name="userFamno" placeholder="family mem no" required>
            <select name="userRole" required>
			    <option value="" disabled selected>Select Role</option>
			    <option value="Owner">Owner</option>
			    <option value="Tenant">Tenant</option>
			    
			</select>
            
            <input type="text" name="userPhoneno" placeholder="phone no" required>
            <input type="password" name="userpass" placeholder="Password" required>

            <button type="submit" class="submit-btn">Sign Up as User</button>
        </form>

        <!-- Admin Form -->
        <form action="admin-register" id="adminForm" style="display:none;" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="pass" placeholder="Password" required>
            <button type="submit" class="submit-btn">Sign Up as Admin</button>
        </form>

        <div class="login-link">
            Already have an account?
            <form action="Login" method="post" style="display:inline;">
                <button type="submit">Login</button>
            </form>
        </div>
        
    </div>
</section>

<script>
    const userTab = document.getElementById('userTab');
    const adminTab = document.getElementById('adminTab');
    const userForm = document.getElementById('userForm');
    const adminForm = document.getElementById('adminForm');

    userTab.addEventListener('click', () => {
        userTab.classList.add('active');
        adminTab.classList.remove('active');
        userForm.style.display = 'flex';
        adminForm.style.display = 'none';
    });

    adminTab.addEventListener('click', () => {
        adminTab.classList.add('active');
        userTab.classList.remove('active');
        adminForm.style.display = 'flex';
        userForm.style.display = 'none';
    });
</script>

</body>
</html>
    