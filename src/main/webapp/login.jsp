<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Log in — SwadExpress</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<style>
:root {
	--color-red: #ff7a1a;
	--color-red-dark: #e35f00;
	--color-maroon: #1a0f05;
	--color-maroon-deep: #0f0803;
	--color-blush: #24160a;
	--color-ink: #f3efe9;
	--color-gray: #b3aca3;
	--color-border: rgba(255, 255, 255, 0.14);
	--color-white: #fff6ee;
	--color-bg: #0d0d0d;
	--color-dark-text: #1a1409;
	--color-dark-muted: #6f6a62;
	--font-display: 'Poppins', Arial, sans-serif;
	--font-body: 'Inter', Arial, sans-serif;
}

* {
	box-sizing: border-box;
}

html, body {
	margin: 0;
	padding: 0;
	background: var(--color-bg);
	color: var(--color-ink);
	font-family: var(--font-body);
	min-height: 100vh;
}

a {
	color: inherit;
	text-decoration: none;
}

.wrap {
	max-width: 1240px;
	margin: 0 auto;
	padding: 0 40px;
}

header.site-nav {
	padding: 18px 0;
	border-bottom: 1px solid var(--color-border);
}

.site-nav .wrap {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.brand {
	font-family: var(--font-display);
	font-weight: 700;
	font-size: 20px;
	color: var(--color-red);
}

.back-link {
	font-size: 14px;
	font-weight: 600;
	color: var(--color-gray);
}

.back-link:hover {
	color: var(--color-red);
}

.login-shell {
	min-height: calc(100vh - 65px);
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 60px 24px;
	position: relative;
	overflow: hidden;
}

.login-bg {
	position: absolute;
	inset: -20px;
	background-image:
		url('<%= request.getContextPath() %>/images/login.jpg');
	background-size: cover;
	background-position: center;
	filter: blur(1px) brightness(0.95);
	transform: scale(1.05);
	z-index: 0;
}

.login-overlay {
	position: absolute;
	inset: 0;
	background: linear-gradient(180deg, rgba(13, 8, 3, 0.68),
		rgba(13, 8, 3, 0.87));
	z-index: 1;
}

.login-card {
	position: relative;
	z-index: 2;
	width: 100%;
	max-width: 400px;
	background: var(--color-white);
	color: var(--color-dark-text);
	border-radius: 20px;
	padding: 40px 36px;
	box-shadow: 0 30px 60px rgba(0, 0, 0, 0.5);
}

.login-card h1 {
	font-family: var(--font-display);
	font-size: 26px;
	font-weight: 800;
	color: var(--color-red);
	text-transform: uppercase;
	margin: 0 0 8px;
}

.login-card>p {
	font-size: 14px;
	color: var(--color-gray);
	margin: 0 0 28px;
}

.field {
	margin-bottom: 18px;
}

.field label {
	display: block;
	font-size: 13px;
	font-weight: 600;
	margin-bottom: 6px;
}

.field input {
	width: 100%;
	padding: 12px 14px;
	border-radius: 10px;
	border: 1px solid rgba(26, 20, 9, 0.18);
	background: #ffffff;
	color: var(--color-dark-text);
	font-size: 15px;
	font-family: var(--font-body);
}

.field input:focus {
	outline: none;
	border-color: var(--color-red);
}

.field-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 13px;
	margin-bottom: 24px;
}

.field-row a {
	color: var(--color-red);
	font-weight: 600;
}

.btn-submit {
	width: 100%;
	padding: 13px 26px;
	border-radius: 999px;
	border: none;
	background: var(--color-red);
	color: var(--color-white);
	font-family: var(--font-body);
	font-weight: 600;
	font-size: 16px;
	cursor: pointer;
}

.btn-submit:hover {
	background: var(--color-red-dark);
}

.signup-line {
	text-align: center;
	font-size: 14px;
	color: var(--color-dark-muted);
	margin-top: 24px;
}

.signup-line a {
	color: var(--color-red);
	font-weight: 600;
}

.form-note {
	display: none;
	text-align: center;
	font-size: 13px;
	color: var(--color-red);
	margin-top: 14px;
}
</style>
</head>
<body>

	<header class="site-nav">
		<div class="wrap">
			<a class="brand" href="index.html">SwadExpress</a> 
		</div>
	</header>

	<div class="login-shell">
		<div class="login-bg"></div>
		<div class="login-overlay"></div>
		<div class="login-card">
			<h1>Welcome Back</h1>
			<p>Log in to track your orders and manage your plan.</p>
			<%
				String error = request.getParameter("error");
				String left = request.getParameter("left");
				if(error != null){
			%>
			<div style="background: #ffe6e6; color: #b00020; padding: 12px; border-radius: 8px; margin-bottom: 18px; font-size: 14px; font-weight: 500;">
				<%= error %>
				<%
					if(left!=null){
				%>
				<br> Attempts Remaining : <strong><%= left %></strong>
				<%
					}
				%>
			</div>	
			<%
				}
			%>
			<form action="login" method="post">
				<div class="field">
					<label for="name">Full Name</label> <input type="text" id="name"
						name="name" placeholder="Enter your full name (not email)" required>
				</div>
				<div class="field">
					<label for="password">Password</label> <input type="password"
						id="password" name="password" placeholder="••••••••" required>
				</div>
				<div class="field-row">
					<span></span> <a href="#">Forgot password?</a>
				</div>
				<button class="btn-submit" type="submit">Log in</button>
			</form>
			<div class="signup-line">
				Don't have an account? <a href="signup.jsp">Sign up</a>
			</div>
		</div>
	</div>

</body>
</html>
