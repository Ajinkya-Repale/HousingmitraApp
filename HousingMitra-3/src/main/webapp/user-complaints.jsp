<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.MainApp.Entity.Complaint"%>
<%@ page import="java.util.List"%>

<%
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String filter = (String) request.getAttribute("filter");
    int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 0;
    int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Complaints</title>

<style>
/* ===== COLORS ===== */
:root {
    --accent: #2e8fe3;
    --success: #22c55e;
    --danger: #ef4444;
    --pending: #facc15;
    --muted: #9fb6c9;
    --bg-dark: #081726;
}

/* ===== RESET ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Inter, system-ui, sans-serif;
}

/* ===== PAGE LAYOUT ===== */
html, body {
    height: 100%;
    width: 100%;
}

body {
    display: flex;
    flex-direction: column;
    background: radial-gradient(circle at top,#0e2a44,#081726);
    color: #fff;
    min-height: 100vh;
    padding-top: 90px;
    overflow-y: auto;
    scrollbar-width: none;
    -ms-overflow-style: none;
}

body::-webkit-scrollbar {
    width: 0;
    height: 0;
}

/* ===== HEADER ===== */
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    padding: 18px 50px;
    background: rgba(17,40,61,.85);
    backdrop-filter: blur(12px);
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 1000;
}

header h2 { font-size: 22px; }
header a { color: #cfe0ee; text-decoration: none; }

/* ===== MAIN ===== */
main { flex: 1 0 auto; padding: 40px 6vw; }

/* ===== TOP ACTIONS + FILTER ===== */
.top-actions {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    flex-wrap: wrap;
}

.top-actions button {
    padding: 10px 18px;
    border: none;
    border-radius: 20px;
    font-weight: 600;
    background: var(--accent);
    color: #fff;
    cursor: pointer;
}

.filter-btns select {
    padding: 8px 16px;
    border: none;
    border-radius: 18px;
    background: var(--accent);
    color: #fff;
    font-weight: 600;
    cursor: pointer;
}

/* ===== COMPLAINT GRID ===== */
.complaint-list {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 22px;
}

/* ===== COMPLAINT CARD ===== */
.complaint {
    background: linear-gradient(180deg,#0f2940,#0b2235);
    padding: 22px;
    border-radius: 20px;
    box-shadow: 0 20px 45px rgba(0,0,0,.45);
    transition: .3s;
}

.complaint:hover {
    transform: translateY(-6px);
    background: #13344f;
}

.complaint h3 { margin-bottom: 6px; font-size: 16px; }
.complaint h4 { font-size: 13px; color: var(--muted); margin-bottom: 10px; }
.complaint p { font-size: 13px; color: #cbd5e1; line-height: 1.5; }

/* ===== STATUS LABEL ===== */
.status {
    font-weight: 600;
}

.status.Pending { color: var(--pending); }
.status.Resolved { color: var(--success); }
.status.Rejected { color: var(--danger); }

/* ===== ACTION BUTTONS ===== */
.actions {
    display: flex;
    gap: 10px;
    margin-top: 16px;
}

.actions form { display: contents; }

.actions button {
    flex: 1;
    padding: 8px;
    border: none;
    border-radius: 14px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
}

.edit { background: var(--accent); color: #fff; }
.delete { background: var(--danger); color: #fff; }

/* ===== PAGINATION ===== */
.pagination {
    display: flex;
    justify-content: center;
    gap: 8px;
    margin: 30px 0 10px;
}

.pagination a {
    padding: 8px 12px;
    border-radius: 6px;
    background: #112b44;
    color: #fff;
    text-decoration: none;
    font-weight: 600;
}

.pagination a.active { background: var(--accent); }

/* ===== FOOTER ===== */
footer {
    text-align: center;
    padding: 25px 10px;
    font-size: 13px;
    color: var(--muted);
    background: var(--bg-dark);
    flex-shrink: 0;
}

/* ===== MODAL ===== */
.overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,.55);
    z-index: 2000;
}

.form-card {
    position: absolute;
    top: 120px;
    left: 50%;
    transform: translateX(-50%);
    width: 420px;
    background: linear-gradient(180deg, #112b44, #0b2235);
    padding: 26px;
    border-radius: 24px;
}

.form-card h3 { margin-bottom: 18px; }

.close-btn {
    position: absolute;
    top: 14px;
    right: 16px;
    background: none;
    border: none;
    color: #cbd5e1;
    font-size: 20px;
    cursor: pointer;
}

.form-group { margin-bottom: 14px; }
label { font-size: 12px; color: var(--muted); }

input, textarea, select {
    width: 100%;
    margin-top: 6px;
    padding: 12px 14px;
    border-radius: 14px;
    border: 1px solid transparent;
    background: #071a2b;
    color: #fff;
}

textarea { resize: none; min-height: 120px; }

.submit-btn {
    margin-top: 18px;
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 18px;
    background: var(--accent);
    color: #fff;
    font-weight: 700;
    cursor: pointer;
}

/* ===== RESPONSIVE ===== */
@media(max-width:1100px) {
    .complaint-list { grid-template-columns: repeat(2,1fr); }
    main { padding: 40px 4vw; }
}

@media(max-width:768px) {
    .complaint-list { grid-template-columns: 1fr; }
    .top-actions { justify-content: center; margin-bottom: 25px; }
    main { padding: 30px 3vw; }
    header { padding: 16px 30px; flex-direction: column; gap: 6px; }
}

@media(max-width:500px) {
    header { padding: 14px 20px; flex-direction: column; gap: 6px; }
    .actions button { font-size: 12px; padding: 6px; }
    .top-actions button, .filter-btns select { width: 100%; padding: 8px 12px; margin-bottom: 8px; }
}

@media(max-width:360px) {
    header h2 { font-size: 18px; }
    .complaint h3 { font-size: 15px; }
    .complaint p { font-size: 12px; }
    .form-card { width: calc(100% - 30px); top: 100px; }
}
</style>

</head>
<body>

<header>
    <h2>📝 User Complaints</h2>
    <a href="userhome">← Back</a>
</header>

<main>
    <!-- TOP ACTIONS -->
    <div class="top-actions">
        <button onclick="openAddModal()">➕ Add Complaint</button>
        <div class="filter-btns">
            <form method="post" action="user-complaints">
                <select name="status" onchange="this.form.submit()">
                    <option value="">All</option>
                    <option value="Pending" <%= "Pending".equals(filter) ? "selected" : "" %>>Pending</option>
                    <option value="Resolved" <%= "Resolved".equals(filter) ? "selected" : "" %>>Resolved</option>
                    <option value="Rejected" <%= "Rejected".equals(filter) ? "selected" : "" %>>Rejected</option>
                </select>
            </form>
        </div>
    </div>

    <!-- COMPLAINT LIST -->
    <div class="complaint-list">
        <%
        if(complaints != null && !complaints.isEmpty()) {
            for(Complaint c : complaints) {
        %>
        <div class="complaint">
            <h3><%= c.getComplaintTitle() %> <span class="status <%= c.getStatus() %>">(<%= c.getStatus() %>)</span></h3>
            <h4>Type: <%= c.getComplaintType() %></h4>
            <p><%= c.getComplaintDescription() %></p>

            <div class="actions">
                <button class="edit" type="button" 
                    onclick="openEditModal('<%= c.getId() %>', '<%= c.getComplaintTitle().replace("'", "\\'") %>', '<%= c.getComplaintType().replace("'", "\\'") %>', '<%= c.getComplaintDescription().replace("'", "\\'") %>')">Edit</button>

                <form method="post" action="delete-complaint">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <button type="submit" class="delete">Delete</button>
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
        for(int i = 0; i < totalPages; i++) {
        %>
            <a href="user-complaints?page=<%= i %><%= (filter!=null && !filter.isEmpty())?"&status="+filter:"" %>" class="<%= (i==currentPage)?"active":"" %>"><%= i+1 %></a>
        <%
        }
        %>
    </div>
</main>

<footer>© 2025 Housing Management System</footer>

<!-- ===== ADD COMPLAINT MODAL ===== -->
<div class="overlay" id="addModal">
    <div class="form-card">
        <button class="close-btn" onclick="closeAddModal()">✖</button>
        <h3>Add Complaint</h3>
        <form action="submitComplaint" method="post">
            <div class="form-group">
                <label>Title</label>
                <input type="text" name="complaintTitle" required>
            </div>
            <div class="form-group">
                <label>Type</label>
                <select name="complaintType" required>
                    <option value="">Select Type</option>
                    <option value="Maintenance">Maintenance</option>
                    <option value="Permission">Permission</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="complaintDescription" required></textarea>
            </div>
            <button type="submit" class="submit-btn">Save</button>
        </form>
    </div>
</div>

<!-- ===== EDIT COMPLAINT MODAL ===== -->
<div class="overlay" id="editModal">
    <div class="form-card">
        <button class="close-btn" onclick="closeEditModal()">✖</button>
        <h3>Edit Complaint</h3>
        <form action="edit-complaint" method="post">
            <input type="hidden" name="id" id="editId">
            <div class="form-group">
                <label>Title</label>
                <input type="text" name="complaintTitle" id="editTitle" required>
            </div>
            <div class="form-group">
                <label>Type</label>
                <select name="complaintType" id="editType" required>
                    <option value="">Select Type</option>
                    <option value="Maintenance">Maintenance</option>
                    <option value="Permission">Permission</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="complaintDescription" id="editDescription" required></textarea>
            </div>
            <button type="submit" class="submit-btn">Update</button>
        </form>
    </div>
</div>

<script>
function openAddModal(){ document.getElementById('addModal').style.display='block'; }
function closeAddModal(){ document.getElementById('addModal').style.display='none'; }

function openEditModal(id, title, type, desc){
    document.getElementById('editId').value = id;
    document.getElementById('editTitle').value = title;
    document.getElementById('editType').value = type;
    document.getElementById('editDescription').value = desc;
    document.getElementById('editModal').style.display='block';
}
function closeEditModal(){ document.getElementById('editModal').style.display='none'; }
</script>

</body>
</html>
