<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.MainApp.Entity.User"%>
<%
    List<User> users = (List<User>) request.getAttribute("users");
    String atoken = (String) session.getAttribute("atoken");
    if(atoken == null){
        response.sendRedirect("Login.jsp");
        session.setAttribute("msg","Login first to access admin panel");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Manage Members | Admin</title>

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
*{ margin:0; padding:0; box-sizing:border-box; font-family:Inter,system-ui,sans-serif; }

/* ===== BODY ===== */
body{
    background:var(--bg) fixed;
    color:#fff;
    padding-top:80px;
    overflow-y:auto;
    -ms-overflow-style: none;
    scrollbar-width: none;
}
body::-webkit-scrollbar{ display: none; }

/* ===== HEADER ===== */
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
header a{ color:#cfe0ee; text-decoration:none; font-size:15px; }

/* ===== MAIN ===== */
main{
    padding:40px 6vw;
}

/* ===== TOP ACTIONS ===== */
.top-actions{
    display:flex;
    justify-content:flex-end;
    margin-bottom:20px;
    flex-wrap:wrap;
}
.top-actions button{
    padding:10px 18px;
    border:none;
    border-radius:20px;
    font-weight:600;
    background:var(--accent);
    color:#fff;
    cursor:pointer;
}
.top-actions button:hover{ background:var(--accent2); }

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse: collapse;
    background:var(--panel2);
    border-radius:14px;
    overflow:hidden;
}
th, td{
    padding:14px;
    text-align:left;
}
th{ background:var(--panel); font-weight:600; }
tr:nth-child(even){ background:var(--panel2); }
tr:hover{ background:#13344f; }
button, .btn{
    padding:8px 14px;
    border:none;
    border-radius:14px;
    cursor:pointer;
    font-weight:600;
    text-decoration:none;
    color:#fff;
    transition:.3s;
}
button.edit, .btn.edit{ background:var(--accent); }
button.edit:hover, .btn.edit:hover{ background:var(--accent2); }
button.delete, .btn.delete{ background:var(--danger); }
button.delete:hover, .btn.delete:hover{ background:#ff3d3d; }

/* ===== MODAL ===== */
.overlay{
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.55);
    z-index:2000;
    overflow-y:auto;
    -ms-overflow-style: none;
    scrollbar-width: none;
}
.overlay::-webkit-scrollbar{ display:none; }

.form-card{
    margin:0 auto;
    background:linear-gradient(135deg,#123b5f,#0d2335);
    padding:26px;
    border-radius:24px;
    width:450px;
    max-width:90%;
    position:relative;
}
.form-card h3{ margin-bottom:18px; }
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
.form-group{ margin-bottom:14px; }
label{ font-size:13px; color:var(--muted); }
input, select{
    width:100%;
    margin-top:6px;
    padding:12px 14px;
    border-radius:14px;
    border:1px solid transparent;
    background:#071a2b;
    color:#fff;
}
.submit-btn{
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
.submit-btn:hover{ background:var(--accent2); }

/* ===== RESPONSIVE ===== */
@media(max-width:1024px){ table{ font-size:14px; } }
@media(max-width:768px){
    main{ padding:30px 3vw; }
    .top-actions{ justify-content:center; margin-bottom:25px; }
    table, thead, tbody, th, td, tr{ display:block; }
    thead{ display:none; }
    tr{ margin-bottom:15px; background:var(--panel2); border-radius:14px; padding:12px; }
    td{ text-align:right; padding:10px; position:relative; }
    td::before{ content: attr(data-label); position:absolute; left:10px; font-weight:600; color:var(--muted); text-align:left; }
    button, .btn{ width:48%; margin-top:8px; }
}
@media(max-width:480px){ button, .btn{ width:100%; } }
</style>
</head>
<body>

<header>
    <h2>👥 Manage Members</h2>
    <a href="adminhome">← Back</a>
</header>

<main>
    <div class="top-actions">
        <button onclick="openAddModal()">➕ Add Member</button>
    </div>

    <!-- MEMBER TABLE -->
    <table>
        <thead>
            <tr>
                <th>ID</th><th>Name</th><th>Email</th><th>Flat No</th><th>Phone</th>
                <th>Family Members</th><th>Role</th><th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            if(users != null && !users.isEmpty()){
                for(User u : users){
        %>
            <tr>
                <td data-label="ID"><%=u.getUserId()%></td>
                <td data-label="Name"><%=u.getUserName()%></td>
                <td data-label="Email"><%=u.getUserEmail()%></td>
                <td data-label="Flat No"><%=u.getUserFlatno()%></td>
                <td data-label="Phone"><%=u.getUserPhoneno()%></td>
                <td data-label="Family Members"><%=u.getUserFamno()%></td>
                <td data-label="Role"><%=u.getUserRole()%></td>
                <td data-label="Actions">
                    <button class="edit" onclick="openEditModal('<%=u.getUserId()%>','<%=u.getUserName().replace("'", "\\'")%>','<%=u.getUserEmail().replace("'", "\\'")%>','<%=u.getUserFlatno()%>','<%=u.getUserPhoneno()%>','<%=u.getUserFamno()%>','<%=u.getUserRole()%>')">Edit</button>
                    <form method="post" action="delete-user" style="display:inline;">
                        <input type="hidden" name="userId" value="<%=u.getUserId()%>">
                        <button type="submit" class="delete">Delete</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="8" style="text-align:center; color:#cbd5e1;">No users available</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</main>

<!-- ADD MEMBER MODAL -->
<div class="overlay" id="addModal">
    <div class="form-card">
        <button class="close-btn" onclick="closeAddModal()">✖</button>
        <h3>Add Member</h3>
        <form action="add-user" method="post">
            <div class="form-group"><label>Name</label><input type="text" name="userName" required></div>
            <div class="form-group"><label>Email</label><input type="email" name="userEmail" required></div>
            <div class="form-group"><label>Flat No</label><input type="text" name="userFlatno" required></div>
            <div class="form-group"><label>Phone</label><input type="text" name="userPhoneno" required></div>
            <div class="form-group"><label>Family Members</label><input type="number" name="userFamno" required></div>
            <div class="form-group"><label>Role</label>
                <select name="userRole" required>
                    <option value="">Select Role</option>
                    <option value="Tenant">Tenant</option>
                    <option value="Owner">Owner</option>
                    <option value="Admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="submit-btn">Save</button>
        </form>
    </div>
</div>

<!-- EDIT MEMBER MODAL -->
<div class="overlay" id="editModal">
    <div class="form-card">
        <button class="close-btn" onclick="closeEditModal()">✖</button>
        <h3>Edit Member</h3>
        <form action="edit-user" method="post">
            <input type="hidden" name="userId" id="editId">
            <div class="form-group"><label>Name</label><input type="text" name="userName" id="editName" required></div>
            <div class="form-group"><label>Email</label><input type="email" name="userEmail" id="editEmail" required></div>
            <div class="form-group"><label>Flat No</label><input type="text" name="userFlatno" id="editFlatno" required></div>
            <div class="form-group"><label>Phone</label><input type="text" name="userPhoneno" id="editPhone" required></div>
            <div class="form-group"><label>Family Members</label><input type="number" name="userFamno" id="editFamno" required></div>
            <div class="form-group"><label>Role</label>
                <select name="userRole" id="editRole" required>
                    <option value="">Select Role</option>
                    <option value="Tenant">Tenant</option>
                    <option value="Owner">Owner</option>
                    <option value="Admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="submit-btn">Update</button>
        </form>
    </div>
</div>

<script>
function openAddModal(){ document.getElementById('addModal').style.display='block'; }
function closeAddModal(){ document.getElementById('addModal').style.display='none'; }

function openEditModal(id,name,email,flat,phone,famno,role){
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editEmail').value = email;
    document.getElementById('editFlatno').value = flat;
    document.getElementById('editPhone').value = phone;
    document.getElementById('editFamno').value = famno;
    document.getElementById('editRole').value = role;
    document.getElementById('editModal').style.display='block';
}
function closeEditModal(){ document.getElementById('editModal').style.display='none'; }
</script>

</body>
</html>
