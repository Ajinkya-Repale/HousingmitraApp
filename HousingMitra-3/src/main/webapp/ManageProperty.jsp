<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.MainApp.Entity.Property"%>
<%@ page import="java.util.List"%>

<%
    List<Property> properties = (List<Property>) request.getAttribute("properties");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Properties</title>

<style>
/* ================= ROOT ================= */
:root {
    --bg: #0b1e2e;
    --panel: #0d2335;
    --muted: #bcd0df;
    --accent: #2e8fe3;
    --accent2: #1f7bd6;
    --danger: #b91c1c;
}

/* ================= RESET ================= */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Inter, system-ui, sans-serif;
}

/* ================= SCROLL (HIDDEN BUT WORKING) ================= */
html, body {
    height: 100%;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: none;
    -ms-overflow-style: none;
}

html::-webkit-scrollbar,
body::-webkit-scrollbar {
    width: 0;
    height: 0;
    display: none;
}

/* ================= BODY ================= */
body {
    background: var(--bg);
    color: #fff;
    padding-top: 90px;
}

/* ================= HEADER ================= */
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    padding: 18px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: rgba(17, 40, 61, 0.9);
    backdrop-filter: blur(10px);
    z-index: 1000;
}

header h2 { font-size: 22px; }
header a { color: #cfe0ee; text-decoration: none; }

/* ================= MAIN ================= */
main {
    padding: 40px 6vw;
    min-height: calc(100vh - 160px);
}

/* ================= TOP BAR ================= */
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
}

.top-bar h3 { font-size: 22px; }

.top-bar button {
    padding: 10px 18px;
    border: none;
    border-radius: 20px;
    background: var(--accent);
    color: #fff;
    font-weight: 600;
    cursor: pointer;
}

/* ================= GRID ================= */
.properties {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 22px;
}

/* ================= CARD ================= */
.property-card {
    background: linear-gradient(180deg, #0f2940, #0b2235);
    padding: 22px;
    border-radius: 20px;
    min-height: 230px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: .3s;
}

.property-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 18px 40px rgba(0,0,0,.45);
}

.property-card h4 {
    font-size: 16px;
    margin-bottom: 6px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.property-card span {
    font-size: 12px;
    color: var(--muted);
}

.property-details {
    margin-top: 10px;
    font-size: 13px;
    color: #cbd5e1;
    line-height: 1.6;
}

/* ================= ACTIONS ================= */
.property-actions {
    display: flex;
    gap: 10px;
    margin-top: 16px;
}

.property-actions form { display: contents; }

.property-actions button {
    flex: 1;
    height: 38px;
    border: none;
    border-radius: 14px;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
}

.edit { background: var(--accent); }
.delete { background: var(--danger); }

/* ================= FOOTER ================= */
footer {
    text-align: center;
    padding: 25px 10px;
    font-size: 13px;
    color: var(--muted);
}

/* ================= MODAL ================= */
.overlay {
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,.6);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 2000;
}

.overlay.active { display: flex; }

.modal {
    background: linear-gradient(180deg,#123b5f,#0d2335);
    padding: 26px;
    border-radius: 24px;
    width: 420px;
    max-width: 100%;
    position: relative;
}

.modal h3 { margin-bottom: 16px; }

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

label {
    font-size: 13px;
    color: var(--muted);
}

input, select {
    width: 100%;
    margin-top: 6px;
    padding: 12px 14px;
    border-radius: 14px;
    border: none;
    background: #071a2b;
    color: #fff;
}

.submit-btn {
    width: 100%;
    padding: 12px;
    border-radius: 18px;
    background: var(--accent);
    font-weight: 700;
    cursor: pointer;
    border: none;
}

/* ================= RESPONSIVE ================= */
@media (max-width: 1100px) {
    .properties { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 768px) {
    .properties { grid-template-columns: 1fr; }
    header { flex-direction: column; gap: 6px; }
}
</style>
</head>

<body>

<header>
    <h2>🏡 Manage Properties</h2>
    <a href="userhome">← Back</a>
</header>

<main>
    <div class="top-bar">
        <h3>Your Properties</h3>
        <button onclick="openAddModal()">➕ Add Property</button>
    </div>

    <div class="properties">
        <% if (properties != null && !properties.isEmpty()) {
            for (Property p : properties) { %>

        <div class="property-card">
            <div>
                <h4><%= p.getPropertyName() %></h4>
                <span><%= p.getPropertyType() %></span>
                <div class="property-details">
                    📍 Block: <%= p.getBlock() %><br>
                    💰 Rent: ₹<%= p.getRent() %><br>
                    👨‍👩‍👧 Status: <%= p.getStatus() %>
                </div>
            </div>

            <div class="property-actions">
                <button class="edit"
                        data-id="<%= p.getId() %>"
                        data-name="<%= p.getPropertyName() %>"
                        data-type="<%= p.getPropertyType() %>"
                        data-rent="<%= p.getRent() %>"
                        data-status="<%= p.getStatus() %>"
                        data-block="<%= p.getBlock() %>"
                        onclick="openEditModal(this)">Edit</button>

                <form action="delete-property" method="post">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button class="delete">Delete</button>
                </form>
            </div>
        </div>

        <% } } %>
    </div>
</main>

<footer>© 2025 Housing Management System</footer>

<!-- ADD MODAL -->
<div class="overlay" id="addModal">
    <div class="modal">
        <button class="close-btn" onclick="closeAddModal()">✖</button>
        <h3>Add Property</h3>
        <form action="add-property" method="post">
            <div class="form-group">
                <label>Property Name</label>
                <input type="text" name="propertyName" required>
            </div>
            <div class="form-group">
                <label>Type</label>
                <select name="propertyType" required>
                    <option>Apartment</option>
                    <option>Villa</option>
                    <option>Shop</option>
                </select>
            </div>
            <div class="form-group">
                <label>Rent</label>
                <input type="number" name="rent" required>
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="status">
                    <option>Occupied</option>
                    <option>Vacant</option>
                </select>
            </div>
            <div class="form-group">
                <label>Block</label>
                <input type="text" name="block" required>
            </div>
            <button class="submit-btn">Save Property</button>
        </form>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="overlay" id="editModal">
    <div class="modal">
        <button class="close-btn" onclick="closeEditModal()">✖</button>
        <h3>Edit Property</h3>
        <form action="edit-property" method="post">
            <input type="hidden" name="id" id="editId">
            <div class="form-group">
                <label>Property Name</label>
                <input type="text" name="propertyName" id="editName" required>
            </div>
            <div class="form-group">
                <label>Type</label>
                <select name="propertyType" id="editType" required>
                    <option>Apartment</option>
                    <option>Villa</option>
                    <option>Shop</option>
                </select>
            </div>
            <div class="form-group">
                <label>Rent</label>
                <input type="number" name="rent" id="editRent" required>
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="status" id="editStatus">
                    <option>Occupied</option>
                    <option>Vacant</option>
                </select>
            </div>
            <div class="form-group">
                <label>Block</label>
                <input type="text" name="block" id="editBlock" required>
            </div>
            <button class="submit-btn">Update Property</button>
        </form>
    </div>
</div>

<script>
function openAddModal() {
    document.getElementById("addModal").classList.add("active");
}
function closeAddModal() {
    document.getElementById("addModal").classList.remove("active");
}
function openEditModal(btn) {
    document.getElementById("editId").value = btn.dataset.id;
    document.getElementById("editName").value = btn.dataset.name;
    document.getElementById("editType").value = btn.dataset.type;
    document.getElementById("editRent").value = btn.dataset.rent;
    document.getElementById("editStatus").value = btn.dataset.status;
    document.getElementById("editBlock").value = btn.dataset.block;
    document.getElementById("editModal").classList.add("active");
}
function closeEditModal() {
    document.getElementById("editModal").classList.remove("active");
}
</script>

</body>
</html>
