<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign up — SwadExpress</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>

  :root {
    --color-red: #ff7a1a;
    --color-red-dark: #e35f00;
    --color-maroon: #1a0f05;
    --color-maroon-deep: #0f0803;
    --color-blush: #24160a;
    --color-ink: #f3efe9;
    --color-gray: #b3aca3;
    --color-border: rgba(255,255,255,0.14);
    --color-white: #fff6ee;
    --color-bg: #0d0d0d;
    --color-dark-text: #1a1409;
    --color-dark-muted: #6f6a62;

    --font-display: 'Poppins', Arial, sans-serif;
    --font-body: 'Inter', Arial, sans-serif;
  }

  * { box-sizing: border-box; }

  html, body {
    margin: 0;
    padding: 0;
    background: var(--color-bg);
    color: var(--color-ink);
    font-family: var(--font-body);
    height: 100%;
    overflow: hidden;
  }

  a { color: inherit; text-decoration: none; }

  .wrap {
    max-width: 1240px;
    margin: 0 auto;
    padding: 0 40px;
  }

  header.site-nav {
    padding: 12px 0;
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

  .back-link:hover { color: var(--color-red); }

  .signup-shell {
    height: calc(100vh - 53px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 16px 24px;
    position: relative;
    overflow: hidden;
  }

  .signup-bg {
    position: absolute;
    inset: -20px;
    background-image: url('<%= request.getContextPath() %>/images/signup.jpg');
    background-size: cover;
    background-position: center;
    filter: blur(1px) brightness(0.95);
    transform: scale(1.05);
    z-index: 0;
  }

  .signup-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(180deg, rgba(13,8,3,0.68), rgba(13,8,3,0.87));
    z-index: 1;
  }

  .signup-card {
    position: relative;
    z-index: 2;
    width: 100%;
    max-width: 460px;
    max-height: 100%;
    overflow: hidden;
    background: var(--color-white);
    color: var(--color-dark-text);
    border-radius: 18px;
    padding: 22px 32px;
    box-shadow: 0 30px 60px rgba(0,0,0,0.5);
  }

  .signup-card h1 {
    font-family: var(--font-display);
    font-size: 21px;
    font-weight: 800;
    color: var(--color-red);
    text-transform: uppercase;
    margin: 0 0 4px;
  }

  .signup-card > p {
    font-size: 13px;
    margin: 0 0 14px;
  }

  .field-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0 12px;
  }

  .field { margin-bottom: 10px; }

  .field label {
    display: block;
    font-size: 12px;
    font-weight: 600;
    margin-bottom: 4px;
  }

  .field input,
  .field textarea,
  .field select {
    width: 100%;
    padding: 8px 12px;
    border-radius: 9px;
    border: 1px solid rgba(26,20,9,0.18);
    background: #ffffff;
    color: var(--color-dark-text);
    font-size: 14px;
    font-family: var(--font-body);
    transition: border-color 0.15s ease, box-shadow 0.15s ease, transform 0.15s ease;
  }

  .field textarea { resize: none; }

  .field:hover input,
  .field:hover textarea,
  .field:hover select {
    border-color: rgba(255,122,26,0.55);
    box-shadow: 0 4px 14px rgba(255,122,26,0.12);
    transform: translateY(-1px);
  }

  .field input:focus,
  .field textarea:focus,
  .field select:focus {
    outline: none;
    border-color: var(--color-red);
    box-shadow: 0 4px 14px rgba(255,122,26,0.2);
  }

  .field-hint {
    font-size: 11px;
    color: var(--color-dark-muted);
    margin-top: 4px;
  }

  .terms-row {
    display: flex;
    align-items: flex-start;
    gap: 8px;
    font-size: 12px;
    color: var(--color-dark-muted);
    margin-bottom: 12px;
  }

  .terms-row input { margin-top: 3px; }
  .terms-row a { color: var(--color-red); font-weight: 600; }

  .btn-submit {
    width: 100%;
    padding: 11px 26px;
    border-radius: 999px;
    border: none;
    background: var(--color-red);
    color: var(--color-white);
    font-family: var(--font-body);
    font-weight: 600;
    font-size: 15px;
    cursor: pointer;
    transition: background 0.15s ease, transform 0.15s ease, box-shadow 0.15s ease;
  }

  .btn-submit:hover {
    background: var(--color-red-dark);
    transform: translateY(-1px);
    box-shadow: 0 8px 18px rgba(255,122,26,0.35);
  }

  .login-line {
    text-align: center;
    font-size: 13px;
    color: var(--color-dark-muted);
    margin-top: 12px;
  }

  .login-line a { color: var(--color-red); font-weight: 600; }

  .form-note {
    display: none;
    text-align: center;
    font-size: 13px;
    color: var(--color-red);
    margin-top: 14px;
  }
  .password-container{
    position: relative;
}

.password-container input{
    width: 100%;
    padding-right: 40px;
    box-sizing: border-box;
}

.toggle-password{
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    user-select: none;
    font-size: 18px;
}
.error-message{
    background: #ffe5e5;
    color: #c62828;
    border: 1px solid #ef9a9a;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 15px;
    text-align: center;
    font-size: 14px;
}
</style>
</head>
<body>

  <header class="site-nav">
    <div class="wrap">
      <a class="brand" href="index.html">SwadExpress</a>
    </div>
  </header>

  <div class="signup-shell">
    <div class="signup-bg"></div>
    <div class="signup-overlay"></div>
    <div class="signup-card">
      <h1>Create Your Account</h1>
      <p>Join SwadExpress and start ordering seasonal meals today.</p>
      <%
		String error = request.getParameter("error");
		if(error != null){
	  %>
    <div class="error-message">
        <%= error %>
    </div>
	<%
		}
	%>
      <form action="register" method="post">
        <div class="field-grid">
          <div class="field">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Jamie Rivera" required>
          </div>
          <div class="field">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required>
          </div>
        </div>
        <div class="field">
          <label for="address">Address</label>
          <textarea id="address" name="address" rows="2" placeholder="Street, city, state, ZIP" required></textarea>
        </div>
        <div class="field-grid">
		 <div class="field">
    <label for="password">Password</label>

    <div class="password-container">
        <input type="password"
               id="password"
               name="password"
               placeholder="••••••••"
               required>

        <span class="toggle-password" onclick="togglePassword('password', this)">
            👁
        </span>
    </div>
    <div class="field-hint" id="passwordStrength">
    Password strength: -
</div>
</div>

<div class="field">
    <label for="confirmPassword">Confirm Password</label>

    <div class="password-container">
        <input type="password"
               id="confirmPassword"
               name="confirmPassword"
               placeholder="••••••••"
               required>

        <span class="toggle-password" onclick="togglePassword('confirmPassword', this)">
            👁
        </span>
    </div>
</div>
<div class="field-hint" id="passwordMatch">
</div>
          <div class="field">
            <label for="role">Role</label>
            <select id="role" name="role" required>
              <option value="">--Select Role--</option>
              <option value="customer">Customer</option>
              <option value="restaurantAdmin">Restaurant Admin</option>
              <option value="Admin">Admin</option>
            </select>
          </div>
        </div>
        <button class="btn-submit" type="submit">Register</button>
      </form>
      <div class="login-line">Already have an account? <a href="login.jsp">Log in</a></div>
    </div>
  </div>
  <script>
function togglePassword(id, icon) {

    const input = document.getElementById(id);

    if (input.type === "password") {
        input.type = "text";
        icon.textContent = "🙈"; // Hide icon
    } else {
        input.type = "password";
        icon.textContent = "👁"; // Show icon
    }
}
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirmPassword");

const strength = document.getElementById("passwordStrength");
const match = document.getElementById("passwordMatch");

password.addEventListener("input", checkPasswordStrength);
password.addEventListener("input", checkPasswords);

confirmPassword.addEventListener("input", checkPasswords);

function checkPasswordStrength() {

    let pwd = password.value;

    let score = 0;

    if (pwd.length >= 8) score++;
    if (/[A-Z]/.test(pwd)) score++;
    if (/[a-z]/.test(pwd)) score++;
    if (/[0-9]/.test(pwd)) score++;
    if (/[^A-Za-z0-9]/.test(pwd)) score++;

    switch(score){

        case 0:
        case 1:
        case 2:
            strength.textContent = "Password strength: Weak";
            strength.style.color = "red";
            break;

        case 3:
        case 4:
            strength.textContent = "Password strength: Medium";
            strength.style.color = "orange";
            break;

        case 5:
            strength.textContent = "Password strength: Strong";
            strength.style.color = "green";
            break;
    }
}

function checkPasswords(){

    if(confirmPassword.value === ""){
        match.textContent = "";
        return;
    }

    if(password.value === confirmPassword.value){

        match.textContent = "✓ Passwords match";
        match.style.color = "green";

    }else{

        match.textContent = "✗ Passwords do not match";
        match.style.color = "red";
    }
}
</script>
</body>
</html>