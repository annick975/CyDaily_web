<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.example.cydaily_new.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberGuardian - Cybersecurity Awareness Game</title>
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
            --success-color: #4caf50;
            --warning-color: #ff9800;
            --danger-color: #f44336;
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
            min-height: 100vh;
        }

        .header {
            background-color: var(--primary-color);
            color: var(--text-light);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px var(--shadow-color);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            font-size: 1.8em;
        }

        .logo-text {
            font-size: 1.5em;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-details {
            text-align: right;
        }

        .user-name {
            font-weight: 600;
            font-size: 1.1em;
        }

        .user-role {
            font-size: 0.85em;
            opacity: 0.9;
        }

        .logout-btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }

        .logout-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page-title {
            margin-bottom: 25px;
            text-align: center;
        }

        .page-title h1 {
            color: var(--primary-color);
            font-size: 2.2em;
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #666;
            font-size: 1.1em;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px var(--shadow-color);
            padding: 20px;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px var(--shadow-color);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-title {
            font-size: 1.1em;
            color: var(--primary-dark);
            font-weight: 500;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: white;
            font-size: 1.3em;
        }

        .stat-value {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .stat-description {
            font-size: 0.9em;
            color: #666;
        }

        .progress-bar {
            height: 10px;
            background-color: #e0e0e0;
            border-radius: 5px;
            margin-top: 15px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            border-radius: 5px;
            width: 0;
            animation: progressAnimation 1s ease-out forwards;
        }

        @keyframes progressAnimation {
            to { width: var(--progress-width); }
        }

        .missions-section {
            margin-top: 30px;
        }

        .section-title {
            color: var(--primary-color);
            font-size: 1.5em;
            margin-bottom: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .mission-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .mission-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 20px var(--shadow-color);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .mission-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px var(--shadow-color);
        }

        .mission-header {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 20px;
            font-weight: 600;
            font-size: 1.1em;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .mission-difficulty {
            font-size: 0.8em;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 500;
        }

        .beginner {
            background-color: var(--success-color);
        }

        .intermediate {
            background-color: var(--warning-color);
        }

        .advanced {
            background-color: var(--danger-color);
        }

        .mission-content {
            padding: 20px;
        }

        .mission-description {
            margin-bottom: 15px;
            color: #555;
            font-size: 0.95em;
            line-height: 1.5;
        }

        .mission-rewards {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .reward {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.9em;
            color: #666;
        }

        .reward-icon {
            color: var(--primary-color);
        }

        .mission-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 1em;
            cursor: pointer;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: background-color 0.3s, transform 0.2s;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .mission-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                padding: 15px;
                gap: 15px;
            }

            .user-info {
                width: 100%;
                justify-content: space-between;
            }

            .container {
                width: 95%;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">
        <div class="logo-icon">🛡️</div>
        <div class="logo-text">CyDaily</div>
    </div>
    <div class="user-info">
        <div class="user-details">
            <div class="user-name">Welcome, <%= user.getName() %>!</div>
            <div class="user-role">Role: <%= user.getRole() %></div>
        </div>
        <a href="logout" class="logout-btn">
            <span>Logout</span>
            <span>➡️</span>
        </a>
    </div>
</div>

<div class="container">
    <div class="page-title">
        <h1>Welcome to CyDaily!</h1>
        <p>Enhance your security skills through interactive missions and challenges</p>
    </div>

    <div class="dashboard">
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Security Score</div>
                <div class="stat-icon">📊</div>
            </div>
            <div class="stat-value">720</div>
            <div class="stat-description">Your current security awareness rating</div>
            <div class="progress-bar">
                <div class="progress-fill" style="--progress-width: 72%"></div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Completed Missions</div>
                <div class="stat-icon">✅</div>
            </div>
            <div class="stat-value">7</div>
            <div class="stat-description">Out of 15 total missions</div>
            <div class="progress-bar">
                <div class="progress-fill" style="--progress-width: 47%"></div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-title">Security Badges</div>
                <div class="stat-icon">🏆</div>
            </div>
            <div class="stat-value">3</div>
            <div class="stat-description">Security expertise badges earned</div>
            <div class="progress-bar">
                <div class="progress-fill" style="--progress-width: 30%"></div>
            </div>
        </div>
    </div>

    <div class="missions-section">
        <div class="section-title">
            <span>🔐</span>
            <span>Available Missions</span>
        </div>

        <div class="mission-cards">
            <div class="mission-card">
                <div class="mission-header">
                    <span>Phishing Defense</span>
                    <span class="mission-difficulty beginner">Beginner</span>
                </div>
                <div class="mission-content">
                    <div class="mission-description">
                        Learn to identify and defend against phishing attacks. Master the art of spotting suspicious emails and links.
                    </div>
                    <div class="mission-rewards">
                        <div class="reward">
                            <span class="reward-icon">⭐</span>
                            <span>100 Points</span>
                        </div>
                        <div class="reward">
                            <span class="reward-icon">🛡️</span>
                            <span>Anti-Phishing Badge</span>
                        </div>
                    </div>
                    <button class="mission-btn">
                        <span>Start Mission</span>
                        <span>▶️</span>
                    </button>
                </div>
            </div>

            <div class="mission-card">
                <div class="mission-header">
                    <span>Password Security</span>
                    <span class="mission-difficulty beginner">Beginner</span>
                </div>
                <div class="mission-content">
                    <div class="mission-description">
                        Create strong passwords and understand the importance of proper password management techniques.
                    </div>
                    <div class="mission-rewards">
                        <div class="reward">
                            <span class="reward-icon">⭐</span>
                            <span>100 Points</span>
                        </div>
                        <div class="reward">
                            <span class="reward-icon">🔑</span>
                            <span>Password Master Badge</span>
                        </div>
                    </div>
                    <button class="mission-btn">
                        <span>Start Mission</span>
                        <span>▶️</span>
                    </button>
                </div>
            </div>

            <div class="mission-card">
                <div class="mission-header">
                    <span>Social Engineering</span>
                    <span class="mission-difficulty intermediate">Intermediate</span>
                </div>
                <div class="mission-content">
                    <div class="mission-description">
                        Learn to recognize and counter various social engineering tactics used by attackers to manipulate users.
                    </div>
                    <div class="mission-rewards">
                        <div class="reward">
                            <span class="reward-icon">⭐</span>
                            <span>150 Points</span>
                        </div>
                        <div class="reward">
                            <span class="reward-icon">👥</span>
                            <span>Social Defense Badge</span>
                        </div>
                    </div>
                    <button class="mission-btn">
                        <span>Start Mission</span>
                        <span>▶️</span>
                    </button>
                </div>
            </div>

            <div class="mission-card">
                <div class="mission-header">
                    <span>Network Security</span>
                    <span class="mission-difficulty advanced">Advanced</span>
                </div>
                <div class="mission-content">
                    <div class="mission-description">
                        Master advanced network security concepts and learn to protect against sophisticated network-based attacks.
                    </div>
                    <div class="mission-rewards">
                        <div class="reward">
                            <span class="reward-icon">⭐</span>
                            <span>250 Points</span>
                        </div>
                        <div class="reward">
                            <span class="reward-icon">🌐</span>
                            <span>Network Guardian Badge</span>
                        </div>
                    </div>
                    <button class="mission-btn">
                        <span>Start Mission</span>
                        <span>▶️</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>