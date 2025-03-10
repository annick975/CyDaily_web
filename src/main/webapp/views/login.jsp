<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String language = request.getParameter("lang");
    if (language == null) {
        language = "en";
    }
    Locale locale = new Locale(language);
    ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
%>
<!DOCTYPE html>
<html lang="<%= language %>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=bundle.getString("login.title")%></title>
    <style>
        :root {
            --primary-color: #3f51b5;
            --primary-light: #757de8;
            --primary-dark: #002984;
            --secondary-color: #ff4081;
            --text-color: #333;
            --text-light: #ffffff;
            --background-light: #f5f7ff;
            --shadow-color: rgba(63, 81, 181, 0.2);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--background-light) 0%, #ffffff 100%);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            flex-direction: column;
        }

        .container {
            width: 90%;
            max-width: 450px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            color: var(--primary-color);
            font-size: 2.2em;
            margin-bottom: 15px;
            text-align: center;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .tagline {
            color: #666;
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.1em;
        }

        .card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px var(--shadow-color);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px var(--shadow-color);
        }

        .language-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px var(--shadow-color);
            padding: 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .language-select-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .lang-label {
            color: var(--primary-dark);
            font-weight: 500;
            font-size: 0.95em;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--primary-dark);
            font-size: 0.95em;
        }

        form {
            display: flex;
            flex-direction: column;
            padding: 30px;
        }

        .login-form {
            width: 100%;
        }

        input, select {
            width: 100%;
            padding: 12px 15px;
            font-size: 1em;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            background-color: #f9f9f9;
            transition: all 0.3s;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--primary-light);
            background-color: white;
            box-shadow: 0 0 0 3px rgba(63, 81, 181, 0.1);
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=US-ASCII,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' viewBox='0 0 24 24' fill='none' stroke='%233f51b5' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            padding-right: 40px;
        }

        button {
            background-color: var(--primary-color);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            cursor: pointer;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(63, 81, 181, 0.3);
        }

        button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(63, 81, 181, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        .error-message {
            color: #d32f2f;
            margin-top: 20px;
            font-size: 0.95em;
            background-color: #fdeaea;
            padding: 12px;
            border-radius: 8px;
            border-left: 4px solid #d32f2f;
            animation: shake 0.5s ease-in-out;
            display: <%= request.getAttribute("errorMessage") != null ? "block" : "none" %>;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .signup-link {
            margin-top: 25px;
            text-align: center;
            font-size: 1em;
        }

        .signup-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .signup-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        /* Responsive adjustments */
        @media (max-width: 500px) {
            .container {
                width: 95%;
            }

            form {
                padding: 20px;
            }

            h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1><%=bundle.getString("login.label")%></h1>
    <p class="tagline"><%=bundle.getString("login.title")%></p>

    <!-- Language Switcher -->
    <div class="language-card">
        <div class="language-select-container">
            <form method="GET" style="display: flex; align-items: center; gap: 10px;">
                <span class="lang-label"><%= bundle.getString("login.label") %>:</span>
                <select name="lang" id="lang" class="form-select" onchange="this.form.submit()">
                    <option value="en" <%= "en".equals(language) ? "selected" : "" %>>English</option>
                    <option value="kin" <%= "kin".equals(language) ? "selected" : "" %>>Kinyarwanda</option>
                </select>
            </form>
        </div>
    </div>

    <div class="card">
        <!-- Form for login -->
        <form action="login" method="post" class="login-form">
            <div class="form-group">
                <label for="name"><%=bundle.getString("login.username")%></label>
                <input type="text" id="name" name="name" placeholder="<%=bundle.getString("login.username")%>" required>
            </div>

            <div class="form-group">
                <label for="password"><%=bundle.getString("login.password")%></label>
                <input type="password" id="password" name="password" placeholder="<%=bundle.getString("login.password")%>" required>
            </div>

            <button type="submit"><%=bundle.getString("login.button")%></button>
        </form>
    </div>

    <!-- Error message display -->
    <div class="error-message">
        <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
    </div>

    <!-- Signup Link -->
    <div class="signup-link">
        <p>Don't have an account? <a href="signup">Signup here</a></p>
    </div>
</div>

</body>
</html>