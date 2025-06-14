<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Master - Home</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: #f0f4f7;
            margin: 0;
        }

        /* Navigation Menu */
        nav {
            background-color: #333;
            padding: 15px 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        nav .logo {
            font-size: 24px;
            color: white;
            font-weight: 500;
            margin-left: 20px;
            display: inline-block;
        }

        nav .menu {
            float: right;
            margin-right: 20px;
        }

        nav .menu a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            margin: 0 10px;
            font-size: 16px;
            font-weight: 400;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        nav .menu a:hover {
            background-color: #6c5ef8;
        }

        /* Main content area */
        .hero-section {
            background: linear-gradient(135deg, #8c7ef3, #6c5ef8);
            color: white;
            padding: 100px 20px;
            text-align: center;
            margin-top: 60px;
        }

        .hero-section h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .hero-section p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .cta-btn {
            background-color: #6c5ef8;
            color: white;
            font-size: 18px;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 25px;
            transition: background-color 0.3s ease;
        }

        .cta-btn:hover {
            background-color: #8c7ef3;
        }

        /* Features Section */
        .features-section {
            display: flex;
            justify-content: space-around;
            padding: 50px 20px;
            background-color: #fff;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .feature-card {
            width: 250px;
            text-align: center;
            padding: 20px;
            border-radius: 15px;
            background-color: #f9f9f9;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .feature-card img {
            width: 100%;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
        }

        .feature-card h3 {
            font-size: 20px;
            margin-top: 15px;
        }

        .feature-card p {
            font-size: 14px;
            margin-top: 10px;
        }

        .feature-card:hover {
            transform: translateY(-10px);
        }

        /* Footer Section */
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 30px 20px;
            margin-top: 50px;
        }

        footer p {
            font-size: 14px;
        }

        footer a {
            color: #6c5ef8;
            text-decoration: none;
            font-weight: bold;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            nav .menu {
                float: none;
                margin: 0;
            }

            nav .menu a {
                padding: 10px;
                margin: 0 5px;
            }

            .hero-section h1 {
                font-size: 36px;
            }

            .features-section {
                flex-direction: column;
                padding: 20px;
            }

            .feature-card {
                width: 100%;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Navigation Menu -->
    <nav>
        <div class="logo">Quiz App</div>
        <div class="menu">
            <a href="#">Home</a>
            <a href="Login.jsp">Admin</a>
            <a href="UserLogin.jsp">User</a>
            <a href="Aboutus.jsp">About Us</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <h1>Welcome to the Quiz Master</h1>
        <p>Your personalized quiz platform for fun and learning.</p>
        <a href="Signup.jsp" class="cta-btn">Get Started</a>
    </section>


    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Quiz Master. All Rights Reserved.</p>
        <p>For more information, visit our <a href="Aboutus.jsp">About Us</a> page.</p>
    </footer>

</body>
</html>
