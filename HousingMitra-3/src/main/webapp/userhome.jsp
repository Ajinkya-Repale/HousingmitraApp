<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>User Dashboard | Housing Management</title>

<style>
:root {
    --bg: #0b1e2e;
    --panel: #11283d;
    --panel2: #0d2335;
    --muted: #bcd0df;
    --accent: #2e8fe3;
    --accent2: #1f7bd6;
    --danger: #b91c1c;
}

/* ===== GLOBAL RESET ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Inter, system-ui, sans-serif;
}

/* ===== BODY ===== */
body {
    background: var(--bg);
    color: #fff;
    padding-top: 80px;
    overflow-x: hidden;
}

body::-webkit-scrollbar { display: none; }
html { scrollbar-width: none; }

/* ===== NAVBAR ===== */
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 18px 50px;
    background: rgba(17, 40, 61, 0.85);
    backdrop-filter: blur(10px);
    flex-wrap: wrap;
}

header h2 { font-size: 22px; }

nav {
    display: flex;
    gap: 28px;
    align-items: center;
    flex-wrap: wrap;
}

nav a {
    color: #cfe0ee;
    text-decoration: none;
    font-size: 15px;
    position: relative;
    padding: 6px 0;
}

nav a.active,
nav a:hover { color: #fff; }

nav a.active::after,
nav a:hover::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -6px;
    width: 100%;
    height: 2px;
    background: var(--accent);
}

nav a.logout {
    color: #ffb3b3;
    font-weight: 600;
    padding: 8px 16px;
    border-radius: 16px;
}

nav a.logout:hover {
    background: var(--danger);
    color: #fff;
}

nav a.logout::after { display: none; }

/* ===== LAYOUT ===== */
.section { padding: 40px 6vw; }

.hero {
    background: linear-gradient(135deg, #123b5f, #0d2335);
    padding: 40px;
    border-radius: 20px;
    margin-bottom: 40px;
}

.hero h1 {
    font-size: 34px;
    margin-bottom: 8px;
}

.hero p {
    color: var(--muted);
    font-size: 16px;
}

/* ===== STATS ===== */
.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
}

.stat {
    background: var(--panel2);
    padding: 20px;
    border-radius: 18px;
    text-align: center;
}

.stat span {
    font-size: 13px;
    color: var(--muted);
}

.stat h3 {
    font-size: 22px;
    margin-top: 6px;
}

/* ===== ACTION CARDS ===== */
.cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
}

.card {
    background: var(--panel2);
    padding: 24px;
    border-radius: 20px;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-6px);
    background: #13344f;
}

.card h4 {
    font-size: 18px;
    margin-bottom: 10px;
}

.card p {
    font-size: 14px;
    color: var(--muted);
}

.card .btn {
    display: inline-block;
    margin-top: 16px;
    padding: 10px 18px;
    border-radius: 20px;
    background: var(--accent);
    color: #fff;
    font-weight: 600;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: 0.3s;
}

.card .btn:hover { background: var(--accent2); }

/* ===== CHATBOT ===== */
.chatbot-icon {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background: var(--accent);
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    font-size: 28px;
    z-index: 1000;
}

.chatbot-popup {
    position: fixed;
    bottom: 90px;
    right: 20px;
    width: 320px;
    background: var(--panel2);
    border-radius: 15px;
    padding: 10px;
    display: none;
    flex-direction: column;
}

.chatbot-title {
    font-weight: 600;
    margin-bottom: 10px;
    font-size: 16px;
}

#chatLog {
    height: 200px;
    overflow-y: auto;
    background: #0b1e2e;
    border-radius: 10px;
    padding: 6px;
    margin-bottom: 10px;
}

.chat-user,
.chat-bot {
    color: #ffffff;
    font-size: 14px;
    margin-bottom: 6px;
    line-height: 1.4;
}

.chatbot-popup textarea {
    width: 100%;
    padding: 8px;
    border-radius: 10px;
    border: none;
    margin-bottom: 10px;
    resize: none;
    background: #11283d;
    color: #fff;
}

.chatbot-popup button {
    padding: 8px 12px;
    border-radius: 12px;
    border: none;
    background: var(--accent);
    color: #fff;
    font-weight: 600;
    cursor: pointer;
}

.chatbot-popup .clear-btn {
    background: #ef4444;
    margin-top: 5px;
}

/* ===== FOOTER ===== */
footer {
    text-align: center;
    padding: 30px 10px;
    color: var(--muted);
    font-size: 13px;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 1200px) {
    header { padding: 18px 30px; }
    .hero { padding: 30px; }
    .cards { grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); }
}

@media (max-width: 900px) {
    header { flex-direction: column; align-items: flex-start; gap: 10px; padding: 18px 20px; }
    nav { gap: 15px; }
    .hero h1 { font-size: 28px; }
    .hero p { font-size: 15px; }
    .stat h3 { font-size: 20px; }
    .card { padding: 20px; }
}

@media (max-width: 600px) {
    body { padding-top: 100px; }
    header h2 { font-size: 20px; }
    nav a { font-size: 14px; padding: 5px 0; }
    .hero { padding: 20px; border-radius: 15px; }
    .hero h1 { font-size: 24px; }
    .hero p { font-size: 14px; }
    .stats { grid-template-columns: repeat(auto-fit, minmax(120px, 1fr)); gap: 15px; }
    .cards { grid-template-columns: 1fr; gap: 15px; }
    .card h4 { font-size: 16px; }
    .card p { font-size: 13px; }
    .card .btn { padding: 8px 16px; font-size: 14px; }
    .chatbot-popup { width: 90%; right: 5%; bottom: 90px; }
}

@media (max-width: 400px) {
    header h2 { font-size: 18px; }
    nav a { font-size: 13px; }
    .hero h1 { font-size: 22px; }
    .hero p { font-size: 13px; }
    .stat h3 { font-size: 18px; }
}
</style>
</head>

<body>

<%
String utoken = (String) session.getAttribute("utoken");
if (utoken != null) {
%>

<header>
    <h2>🏠 Housing User</h2>
    <nav>
        <a class="active">Home</a>
        <a>My Properties</a>
        <a>Requests</a>
        <a>Payments</a>
        <a href="user-logout" class="logout">Logout</a>
    </nav>
</header>

<section class="section">

<div class="hero">
    <h1>Welcome back, <%= utoken %> 👋</h1>
    <p>Here’s a quick overview of your housing account.</p>
</div>

<div class="stats">
    <div class="stat"><span>Properties Booked</span><h3>3</h3></div>
    <div class="stat"><span>Pending Requests</span><h3>2</h3></div>
    <div class="stat"><span>Payments Due</span><h3>₹12,000</h3></div>
    <div class="stat"><span>Maintenance Tickets</span><h3>1</h3></div>
</div>

<div class="cards">
    <div class="card">
        <h4>🏡 My Properties</h4>
        <p>View or manage your properties and bookings.</p>
        <a class="btn">Open</a>
    </div>
    <div class="card">
        <h4>📢 Requests</h4>
        <p>Submit or track maintenance and service requests.</p>
         <a href="user-requests" class="btn">Open</a>
    </div>
    <div class="card">
        <h4>💳 Payments</h4>
        <p>Check and pay your bills securely.</p>
        <a class="btn">Open</a>
    </div>
    <div class="card">
        <h4>📄 Notices</h4>
        <p>View notices and updates from management.</p>
         <a href="user-notice" class="btn">Open</a>
    </div>
    <div class="card">
        <h4>📄 Complaints</h4>
        <p>Add, edit, track and delete complaints.</p>
         <a href="user-complaints" class="btn">Open</a>
    </div>
</div>

</section>

<footer>© 2025 Housing Management System</footer>

<!-- CHATBOT -->
<div class="chatbot-icon" onclick="toggleChat()">💬</div>

<div class="chatbot-popup" id="chatbot">
    <div class="chatbot-title">Chat with Support</div>
    <div id="chatLog"></div>
    <textarea id="chatInput" rows="3" placeholder="Type your message..."></textarea>
    <button onclick="sendMessage()">Send</button>
    <button class="clear-btn" onclick="clearChat()">Clear Chat</button>
</div>

<script>
function toggleChat() {
    const chat = document.getElementById("chatbot");
    chat.style.display = chat.style.display === "flex" ? "none" : "flex";
}

function sendMessage() {
    const input = document.getElementById("chatInput");
    const log = document.getElementById("chatLog");
    const msg = input.value.trim();
    if (!msg) return;

    const user = document.createElement("div");
    user.className = "chat-user";
    user.textContent = "You: " + msg;
    log.appendChild(user);

    const bot = document.createElement("div");
    bot.className = "chat-bot";
    bot.textContent = "Bot: " + getBotReply(msg.toLowerCase());
    log.appendChild(bot);

    log.scrollTop = log.scrollHeight;
    input.value = "";
}

function getBotReply(m) {
    if (m.includes("complaint")) return "You can raise complaints from the Complaints section.";
    if (m.includes("payment")) return "Payments can be handled from the Payments section.";
    if (m.includes("request")) return "Maintenance requests are under Requests.";
    if (m.includes("notice")) return "All notices are available in Notices.";
    if (m.includes("property")) return "Your properties are listed in My Properties.";
    return "I can help with complaints, payments, requests, notices, and properties.";
}

function clearChat() {
    document.getElementById("chatLog").innerHTML = "";
}
</script>

<%
} else {
    response.sendRedirect("Login.jsp");
}
%>

</body>
</html>
