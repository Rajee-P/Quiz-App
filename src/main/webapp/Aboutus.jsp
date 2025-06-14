<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Quiz Master</title>
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

        /* About Us Section */
        .about-section {
            padding: 80px 20px;
            text-align: center;
            background-color: #fff;
            margin-top: 60px;
        }

        .about-section h1 {
            font-size: 40px;
            color: #333;
            margin-bottom: 30px;
        }

        .about-section p {
            font-size: 18px;
            color: #555;
            margin-bottom: 20px;
            line-height: 1.6;
            text-align: left;
            width: 70%;
            margin: 0 auto;
        }

        .about-section img {
            width: 100%;
            max-width: 600px;
            border-radius: 10px;
            margin-top: 30px;
            margin-bottom: 30px;
            object-fit: cover;
        }

        /* Team Section */
        .team-section {
            background-color: #f9f9f9;
            padding: 50px 20px;
        }

        .team-section h2 {
            text-align: center;
            font-size: 32px;
            color: #333;
            margin-bottom: 40px;
        }

        .team-cards {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .team-card {
            width: 250px;
            text-align: center;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: transform 0.3s ease;
        }

        .team-card img {
            width: 100%;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
        }

        .team-card h3 {
            margin-top: 15px;
            font-size: 20px;
            color: #333;
        }

        .team-card p {
            font-size: 14px;
            color: #555;
            margin-top: 10px;
        }

        .team-card:hover {
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

            .about-section p {
                width: 90%;
            }

            .team-cards {
                flex-direction: column;
                gap: 20px;
            }

            .team-card {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>

    <!-- Navigation Menu -->
    <nav>
        <div class="logo">Quiz Master</div>
        <div class="menu">
            <a href="FrontPage.jsp">Home</a>
            <a href="Login.jsp">Admin</a>
            <a href="user.html">User</a>
            <a href="Aboutus.jsp">About Us</a>
        </div>
    </nav>

    <!-- About Us Section -->
    <section class="about-section">
        <h1>About Us</h1>
        <p>
            Quiz Master is an interactive and personalized platform designed to help students, professionals, and learners test their knowledge through a wide range of quizzes on various topics. Our mission is to make learning fun, accessible, and rewarding for everyone.
        </p>
        <p>
            Whether you are looking to enhance your skills, prepare for exams, or simply enjoy a fun challenge, Quiz Master offers a variety of quizzes tailored to your needs. Our platform is easy to use, secure, and provides instant feedback to help you improve and track your progress.
        </p>
    </section>

    <!-- Team Section -->
    <section class="team-section">
        <h2>Meet Our Team</h2>
        <div class="team-cards">
            <div class="team-card">
                <img src="https://via.placeholder.com/250x150" alt="Team Member 1">
                <h3>Rajee</h3>
                <p>Founder & CEO</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/250x150" alt="Team Member 2">
                <h3>Mahaswin</h3>
                <p>Lead Developer</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/250x150" alt="Team Member 3">
                <h3>Sachin</h3>
                <p>Product Manager</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/250x150" alt="Team Member 4">
                <h3>Logeshwaran</h3>
                <p>Marketing Lead</p>
            </div>
            <div class="team-card">
                <img src="https://via.placeholder.com/250x150" alt="Team Member 5">
                <h3>Shubakarini</h3>
                <p>UI/UX Designer</p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Quiz Master. All Rights Reserved.</p>
        <p>For more information, contact us at <a href="mailto:mahaswinakash@gmail.com">support@quizmaster.com</a></p>
    </footer>

</body>
</html>
