<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.MainApp.Entity.Property" %>
<%@ page import="java.util.List" %>

<% List<Property> properties = (List<Property>) request.getAttribute("properties");%>

  <!DOCTYPE html>
  <html lang="en">

  <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Manage Properties</title>

                        <style>
                            :root {
                                --bg: #0b1e2e;
                                --panel2: #0d2335;
                                --muted: #bcd0df;
                                --accent: #2e8fe3;
                                --accent2: #1f7bd6;
                                --danger: #b91c1c;
                            }

                            * {
                                margin: 0;
                                padding: 0;
                                box-sizing: border-box;
                                font-family: Inter, sans-serif;
                            }

                            body {
                                background: var(--bg);
                                color: #fff;
                                padding-top: 90px;
                                overflow-x: hidden;
                            }

                            header {
                                position: fixed;
                                top: 0;
                                left: 0;
                                width: 100%;
                                display: flex;
                                justify-content: space-between;
                                padding: 18px 50px;
                                background: rgba(17, 40, 61, .9);
                                backdrop-filter: blur(10px);
                            }

                            header h2 {
                                font-size: 22px;
                            }

                            header a {
                                color: #cfe0ee;
                                text-decoration: none;
                                font-size: 15px;
                            }

                            main {
                                padding: 40px 6vw;
                            }

                            .top-bar {
                                display: flex;
                                justify-content: space-between;
                                margin-bottom: 25px;
                                gap: 15px;
                            }

                            .top-bar h3 {
                                font-size: 22px;
                            }

                            .top-bar button {
                                padding: 10px 18px;
                                border: none;
                                border-radius: 20px;
                                background: var(--accent);
                                color: #fff;
                                font-weight: 600;
                                cursor: pointer;
                            }

                            .top-bar button:hover {
                                background: var(--accent2);
                            }

                            .properties {
                                display: grid;
                                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
                                gap: 20px;
                            }

                            .property-card {
                                background: var(--panel2);
                                padding: 22px;
                                border-radius: 20px;
                            }

                            .property-card h4 {
                                font-size: 18px;
                                margin-bottom: 6px;
                            }

                            .property-card span {
                                font-size: 13px;
                                color: var(--muted);
                            }

                            .property-details {
                                margin: 12px 0;
                                font-size: 14px;
                                color: #dbe7f2;
                            }

                            .property-actions {
                                display: flex;
                                gap: 10px;
                                flex-wrap: wrap;
                            }

                            .property-actions button {
                                flex: 1;
                                padding: 8px 14px;
                                border: none;
                                border-radius: 14px;
                                font-weight: 600;
                                cursor: pointer;
                                color: #fff;
                            }

                            .property-actions .edit {
                                background: var(--accent);
                            }

                            .property-actions .edit:hover {
                                background: var(--accent2);
                            }

                            .property-actions .delete {
                                background: var(--danger);
                            }

                            .property-actions .delete:hover {
                                background: #ff3d3d;
                            }

                            .overlay {
                                position: fixed;
                                inset: 0;
                                background: rgba(0, 0, 0, .6);
                                display: none;
                                justify-content: center;
                                align-items: center;
                                padding: 20px;
                                z-index: 2000;
                            }

                            .overlay.active {
                                display: flex;
                            }

                            .modal {
                                background: linear-gradient(135deg, #123b5f, #0d2335);
                                padding: 26px;
                                border-radius: 24px;
                                width: 420px;
                                max-width: 100%;
                                position: relative;
                            }

                            .modal h3 {
                                margin-bottom: 16px;
                            }

                            .close-btn {
                                position: absolute;
                                top: 14px;
                                right: 16px;
                                background: none;
                                border: none;
                                font-size: 20px;
                                color: #cbd5e1;
                                cursor: pointer;
                            }

                            .form-group {
                                margin-bottom: 14px;
                            }

                            label {
                                font-size: 13px;
                                color: var(--muted);
                            }

                            input,
                            select {
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

                            .submit-btn:hover {
                                background: var(--accent2);
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
                                <% if(properties !=null && !properties.isEmpty()){ for(Property p : properties){ %>
                                    <div class="property-card">
                                        <h4>
                                            <%=p.getPropertyName()%>
                                        </h4>
                                        <span>
                                            <%=p.getPropertyType()%>
                                        </span>
                                        <div class="property-details">
                                            📍 Block: <%=p.getBlock()%><br>
                                                💰 Rent: ₹<%=p.getRent()%><br>
                                                    👨‍👩‍👧 Status: <%=p.getStatus()%>
                                        </div>
                                        <div class="property-actions">
                                            <button class="edit" data-id="<%=p.getId()%>"
                                                data-name="<%=p.getPropertyName()%>"
                                                data-type="<%=p.getPropertyType()%>" data-rent="<%=p.getRent()%>"
                                                data-status="<%=p.getStatus()%>" data-block="<%=p.getBlock()%>"
                                                onclick="openEditModal(this)">Edit</button>

                                            <form method="post" action="delete-property">
                                                <input type="hidden" name="id" value="<%=p.getId()%>">
                                                <button type="submit" class="delete">Delete</button>
                                            </form>
                                        </div>
                                    </div>
                                    <% } } else { %>
                                        <p style="color:#cbd5e1;">No properties added yet.</p>
                                        <% } %>
                            </div>
                        </main>

                        <!-- ADD PROPERTY MODAL -->
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
                                            <option value="">Select Type</option>
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
                                        <input type="text" name="block" placeholder="A/B/C" required>
                                    </div>
                                    <button type="submit" class="submit-btn">Save Property</button>
                                </form>
                            </div>
                        </div>

                        <!-- EDIT PROPERTY MODAL -->
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
                                    <button type="submit" class="submit-btn">Update Property</button>
                                </form>
                            </div>
                        </div>

                        <script>
                            function openAddModal() { document.getElementById('addModal').classList.add('active'); }
                            function closeAddModal() { document.getElementById('addModal').classList.remove('active'); }

                            function openEditModal(btn) {
                                document.getElementById('editId').value = btn.getAttribute('data-id');
                                document.getElementById('editName').value = btn.getAttribute('data-name');
                                document.getElementById('editType').value = btn.getAttribute('data-type');
                                document.getElementById('editRent').value = btn.getAttribute('data-rent');
                                document.getElementById('editStatus').value = btn.getAttribute('data-status');
                                document.getElementById('editBlock').value = btn.getAttribute('data-block');
                                document.getElementById('editModal').classList.add('active');
                            }
                            function closeEditModal() { document.getElementById('editModal').classList.remove('active'); }
                        </script>

                    </body>

                    </html>