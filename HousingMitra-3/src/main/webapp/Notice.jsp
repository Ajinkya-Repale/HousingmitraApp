<%@page import="com.MainApp.Entity.Notice"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Notices</title>

    <style>
        :root {
            --accent: #2e8fe3;
            --danger: #dc2626;
            --success: #22c55e;
            --muted: #9fb6c9;
        }

        /* RESET */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Inter, system-ui, sans-serif;
        }

        html,
        body {
            height: 100%;
        }

        body {
            background: radial-gradient(circle at top, #0e2a44, #081726);
            color: #fff;
            padding-top: 90px;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            overflow-y: auto;
        }

        ::-webkit-scrollbar {
            width: 0;
            height: 0;
        }

        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 18px 50px;
            background: rgba(17, 40, 61, .85);
            backdrop-filter: blur(12px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
        }

        main {
            flex: 1;
            padding: 40px 6vw;
        }

        .add-btn {
            padding: 12px 22px;
            border: none;
            border-radius: 18px;
            background: linear-gradient(135deg, var(--accent), #1f6fd1);
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            margin-bottom: 25px;
        }

        .form-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .45);
            z-index: 999;
        }

        .add-form {
            position: absolute;
            top: 140px;
            left: 50%;
            transform: translateX(-50%);
            width: 420px;
            background: linear-gradient(180deg, #112b44, #0b2235);
            padding: 24px;
            border-radius: 22px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, .45);
        }

        .add-form h2 {
            margin-bottom: 14px;
        }

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

        .add-form input,
        .add-form textarea,
        .add-form select {
            width: 100%;
            padding: 11px 13px;
            margin-top: 12px;
            border: none;
            border-radius: 14px;
            background: #071a2b;
            color: #fff;
        }

        .add-form textarea {
            resize: none;
            min-height: 110px;
        }

        .add-form button[type="submit"] {
            margin-top: 18px;
            padding: 11px;
            width: 100%;
            border: none;
            border-radius: 18px;
            background: linear-gradient(135deg, var(--accent), #1f6fd1);
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }

        .notice-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .notice {
            background: linear-gradient(180deg, #0f2940, #0b2235);
            padding: 22px;
            border-radius: 20px;
            box-shadow: 0 20px 45px rgba(0, 0, 0, .45);
        }

        .notice h3 {
            margin: 10px 0;
            font-size: 16px;
        }

        .notice p {
            color: #cbd5e1;
            line-height: 1.5;
            font-size: 13px;
        }

        .actions {
            display: flex;
            gap: 10px;
            margin-top: 16px;
        }

        /* Make forms not interfere with flex layout */
        .actions form {
            display: contents;
        }

        .actions button {
            flex: 1;
            padding: 8px;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
        }

        .edit {
            background: #334155;
            color: #fff;
        }

        .delete {
            background: var(--danger);
            color: #fff;
        }

        footer {
            text-align: center;
            padding: 25px 0;
            font-size: 13px;
            color: var(--muted);
        }

        @media(max-width:1100px) {
            .notice-list {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media(max-width:700px) {
            .notice-list {
                grid-template-columns: 1fr;
            }
        }

        @media(max-width:500px) {
            header {
                padding: 14px 20px;
                flex-direction: column;
                gap: 8px;
            }

            main {
                padding: 30px 20px;
            }

            .add-form {
                width: calc(100% - 30px);
                top: 110px;
            }

            .add-btn {
                width: 100%;
            }

            .notice {
                padding: 18px;
            }

            .actions button {
                font-size: 12px;
                padding: 7px;
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
    <h2>📢 Admin Notices</h2>
    <a href="adminhome" style="color:#cfe0ee;text-decoration:none">← Back</a>
</header>

<main>

    <button class="add-btn" onclick="openForm()">➕ Add Notice</button>

    <div class="form-overlay" id="overlay">
        <div class="add-form">
            <button class="close-btn" onclick="closeForm()">✖</button>
            <h2 id="formTitle">Add Notice</h2>
            <form action="add-notice" method="post">
                <input id="titleInput" name="noticeName" placeholder="Notice title" required>
                <input id="noticeDateInput" name="noticeDate" type="date" required>
                <textarea id="descInput" name="noticeMessage" placeholder="Notice description" required></textarea>
                <button type="submit">Save Notice</button>
            </form>
        </div>
    </div>

    <div class="notice-list" id="noticeList">
        <%
            if (l != null && !l.isEmpty()) {
                for (Notice n : l) {
        %>
            <div class="notice">
                <h3><%= n.getNoticeName() %></h3>
                <h4><%= n.getNoticeDate().format(formatter) %></h4>
                <p><%= n.getNoticeMessage() %></p>
                <div class="actions">
                    <!-- Edit form -->
                    <form action="edit-notice" method="post">
                        <input type="hidden" name="nid" value="<%= n.getNid() %>">
                        <button type="submit" class="edit">Edit</button>
                    </form>
                    <!-- Delete form -->
                    <form action="delete-notice" method="post">
                        <input type="hidden" name="nid" value="<%= n.getNid() %>">
                        <button type="submit" class="delete">Delete</button>
                    </form>
                </div>
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

<script>
    let overlay = document.getElementById("overlay");
    let formTitle = document.getElementById("formTitle");

    function openForm() {
        overlay.style.display = "block";
    }

    function closeForm() {
        overlay.style.display = "none";
        formTitle.innerText = "Add Notice";
        document.querySelector("form").reset();
    }
</script>

</body>
</html>
