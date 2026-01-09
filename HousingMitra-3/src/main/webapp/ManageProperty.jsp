<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Properties | Housing Management</title>

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

            /* ===== GLOBAL ===== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Inter, system-ui, sans-serif;
            }

            body {
                background: var(--bg);
                color: #fff;
                padding-top: 90px;
                overflow-x: hidden;
            }

            /* ===== HEADER ===== */
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
                background: rgba(17, 40, 61, 0.9);
                backdrop-filter: blur(10px);
                flex-wrap: wrap;
            }

            header h2 {
                font-size: 22px;
            }

            header a {
                color: #cfe0ee;
                text-decoration: none;
                font-size: 15px;
            }

            /* ===== MAIN ===== */
            main {
                padding: 40px 6vw;
            }

            /* ===== TOP BAR ===== */
            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                flex-wrap: wrap;
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

            /* ===== PROPERTY GRID ===== */
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

            /* ===== MODAL ===== */
            .overlay {
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, 0.6);
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

            /* ===== RESPONSIVE ===== */
            @media(max-width:900px) {
                header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 8px;
                    padding: 16px 20px;
                }

                .top-bar {
                    text-align: center;
                    justify-content: center;
                }

                .property-card {
                    padding: 20px;
                }
            }

            @media(max-width:600px) {
                body {
                    padding-top: 120px;
                }

                .properties {
                    grid-template-columns: 1fr;
                }
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
                <button onclick="openModal()">➕ Add Property</button>
            </div>

            <div class="properties">
                <div class="property-card">
                    <h4>Flat A-101</h4>
                    <span>Apartment</span>
                    <div class="property-details">
                        📍 Block A<br>💰 Rent: ₹12,000<br>👨‍👩‍👧 Status: Occupied
                    </div>
                    <div class="property-actions">
                        <button class="edit">Edit</button>
                        <button class="delete">Delete</button>
                    </div>
                </div>

                <div class="property-card">
                    <h4>Flat B-203</h4>
                    <span>Apartment</span>
                    <div class="property-details">
                        📍 Block B<br>💰 Rent: ₹10,000<br>👨‍👩‍👧 Status: Vacant
                    </div>
                    <div class="property-actions">
                        <button class="edit">Edit</button>
                        <button class="delete">Delete</button>
                    </div>
                </div>

                <div class="property-card">
                    <h4>Villa C-001</h4>
                    <span>Villa</span>
                    <div class="property-details">
                        📍 Block C<br>💰 Rent: ₹25,000<br>👨‍👩‍👧 Status: Vacant
                    </div>
                    <div class="property-actions">
                        <button class="edit">Edit</button>
                        <button class="delete">Delete</button>
                    </div>
                </div>
            </div>
        </main>

        <!-- MODAL -->
        <div class="overlay" id="propertyModal">
            <div class="modal">
                <button class="close-btn" onclick="closeModal()">✖</button>
                <h3>Add Property</h3>
                <form>
                    <div class="form-group">
                        <label>Property Name</label>
                        <input type="text" required>
                    </div>
                    <div class="form-group">
                        <label>Type</label>
                        <select required>
                            <option value="">Select</option>
                            <option>Apartment</option>
                            <option>Villa</option>
                            <option>Shop</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Rent</label>
                        <input type="number" required>
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select>
                            <option>Occupied</option>
                            <option>Vacant</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Block</label>
                        <input type="text" placeholder="A/B/C">
                    </div>
                    <button type="submit" class="submit-btn">Save Property</button>
                </form>
            </div>
        </div>

        <script>
            function openModal() {
                document.getElementById('propertyModal').classList.add('active');
            }
            function closeModal() {
                document.getElementById('propertyModal').classList.remove('active');
            }
        </script>

    </body>

    </html>