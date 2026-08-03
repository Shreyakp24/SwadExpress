<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Set Up Your Restaurant | SwadExpress</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root {
    --color-red: #ff7a1a;
    --color-red-dark: #e35f00;
    --color-maroon: #1a0f05;
    --color-blush: #24160a;
    --color-ink: #f3efe9;
    --color-gray: #b3aca3;
    --color-border: rgba(255,255,255,0.14);
    --color-white: #fff6ee;
    --color-bg: #0d0d0d;
    --font-display: 'Poppins', Arial, sans-serif;
    --font-body: 'Inter', Arial, sans-serif;
  }
  * { box-sizing: border-box; }
  html, body { margin:0; padding:0; background:var(--color-bg); color:var(--color-ink); font-family:var(--font-body); }
  h1,h2 { font-family: var(--font-display); margin:0; }
  .wrap { max-width: 640px; margin: 0 auto; padding: 64px 40px; }
  .brand { font-family: var(--font-display); font-weight:700; font-size:20px; color: var(--color-red); text-align:center; margin-bottom: 8px; }
  .page-title { font-size: 26px; font-weight: 800; text-align:center; margin-bottom: 6px; }
  .page-sub { font-size: 14px; color: var(--color-gray); text-align:center; margin-bottom: 34px; }
  .form-card { background: var(--color-blush); border:1px solid var(--color-border); border-radius:16px; padding: 30px; }
  .field { margin-bottom: 18px; }
  .field label { display:block; font-size:13px; font-weight:600; color: var(--color-gray); margin-bottom:6px; }
  .field input, .field select, .field textarea {
    width:100%; background: var(--color-maroon); color: var(--color-ink);
    border:1px solid var(--color-border); border-radius:10px; padding:12px 14px; font-size:14px; font-family: var(--font-body);
  }
  .field input:focus, .field select:focus, .field textarea:focus { outline:none; border-color: var(--color-red); }
  .form-row { display:grid; grid-template-columns:1fr 1fr; gap:16px; }
  .btn-submit {
    width:100%; background: var(--color-red); color: var(--color-white); border:none; border-radius:10px;
    padding:15px; font-size:14px; font-weight:700; letter-spacing:0.03em; text-transform:uppercase; cursor:pointer; margin-top:10px;
  }
  .btn-submit:hover { background: var(--color-red-dark); }
</style>
</head>
<body>
<%
  User u = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
  if (u == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
%>
  <div class="wrap">
    <div class="brand">SwadExpress</div>
    <div class="page-title">Set up your restaurant</div>
    <p class="page-sub">Tell us about your restaurant to start managing your menu and orders.</p>

    <div class="form-card">
      <form action="<%=request.getContextPath()%>/restaurantAdminDashboard" method="post">
        <input type="hidden" name="action" value="createRestaurant">

        <div class="field">
          <label>Restaurant Name</label>
          <input type="text" name="restaurantName" required maxlength="100">
        </div>

        <div class="form-row">
          <div class="field">
            <label>Cuisine Type</label>
            <input type="text" name="cuisineType" placeholder="e.g. North Indian, Chinese" required maxlength="100">
          </div>
          <div class="field">
            <label>Estimated Delivery Time</label>
            <input type="text" name="ETA" placeholder="e.g. 35 mins" required maxlength="30">
          </div>
        </div>

        <div class="field">
          <label>Tagline</label>
          <input type="text" name="tagline" placeholder="A short line describing your restaurant" maxlength="150">
        </div>

        <div class="field">
          <label>Address</label>
          <textarea name="address" rows="3" required maxlength="300"></textarea>
        </div>

        <div class="form-row">
          <div class="field">
            <label>Discount (optional)</label>
            <input type="text" name="discount" placeholder="e.g. 20% OFF">
          </div>
          <div class="field">
            <label>Image URL</label>
            <input type="text" name="image" placeholder="Link to a restaurant image">
          </div>
        </div>

        <button type="submit" class="btn-submit">Create Restaurant</button>
      </form>
    </div>
  </div>
</body>
</html>