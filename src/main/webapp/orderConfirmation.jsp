<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List,com.tap.model.Cart,com.tap.model.User, com.tap.model.Address, com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed | SwadExpress</title>
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
    --color-green: #2fae6b;
    --color-green-dark: #23935a;

    --font-display: 'Poppins', Arial, sans-serif;
    --font-body: 'Inter', Arial, sans-serif;
  }

  * { box-sizing: border-box; }
  html, body {
    margin: 0; padding: 0;
    background: var(--color-bg);
    color: var(--color-ink);
    font-family: var(--font-body);
  }
  a { color: inherit; text-decoration: none; }
  img { max-width: 100%; display: block; }

  .wrap { max-width: 1240px; margin: 0 auto; padding: 0 40px; }
  h1, h2, h3, h4 { font-family: var(--font-display); margin: 0; }

  /* ---------- HEADER / NAVBAR (same as checkout.jsp) ---------- */
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
    display: flex;
    align-items: center;
  }
  .brand-mark {
    width: 40px; height: 40px; border-radius: 11px;
    background: var(--color-red);
    display: flex; align-items: center; justify-content: center;
    font-family: var(--font-display); font-weight: 800; font-size: 19px; color: var(--color-white);
    margin-right: 10px;
  }
  .icon-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 38px;
    height: 38px;
    border-radius: 50%;
    border: 1px solid var(--color-border);
    color: var(--color-ink);
    position: relative;
  }
  .icon-btn:hover { background: var(--color-red); border-color: var(--color-red); color: var(--color-white); }
  .icon-btn.active { background: var(--color-red); border-color: var(--color-red); color: var(--color-white); }
  .icon-btn svg { width: 18px; height: 18px; stroke: currentColor; }
  .nav-icon-group { display: flex; align-items: center; gap: 10px; }

  /* ---------- CONFIRMATION HERO ---------- */
  .confirm-wrap {
    max-width: 1240px;
    margin: 0 auto;
    padding: 56px 40px 96px;
  }

  .confirm-header { text-align: center; margin-bottom: 40px; }

  .confirm-layout {
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 28px;
    align-items: start;
  }

  .confirm-left, .confirm-right { text-align: left; }
  .confirm-right { position: sticky; top: 24px; }

  @media (max-width: 900px) {
    .confirm-layout { grid-template-columns: 1fr; }
    .confirm-right { position: static; }
  }

  .success-badge{
    width:170px;
    height:170px;
    margin:0 auto 20px;
    display:flex;
    justify-content:center;
    align-items:center;
    background:none;
    border:none;
}
  .success-badge svg { width: 40px; height: 40px; stroke: var(--color-green); }

  .confirm-title { font-size: 28px; font-weight: 800; margin-bottom: 10px; }
  .confirm-sub { font-size: 15px; color: var(--color-gray); margin-bottom: 6px; }
  .order-id-chip {
    display: inline-flex; align-items: center; gap: 8px;
    background: var(--color-blush); border: 1px solid var(--color-border);
    border-radius: 999px; padding: 8px 18px; margin-top: 18px;
    font-size: 13px; font-weight: 700; color: var(--color-red); letter-spacing: 0.02em;
  }

  /* ---------- ETA CARD ---------- */
  .eta-card {
    background: var(--color-blush);
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 28px 30px;
    display: flex;
    align-items: center;
    gap: 20px;
    text-align: left;
  }
  .eta-icon {
    width: 54px; height: 54px; border-radius: 12px; flex-shrink: 0;
    background: var(--color-maroon);
    border: 1px solid var(--color-red);
    display: flex; align-items: center; justify-content: center;
  }
  .eta-icon svg { width: 26px; height: 26px; stroke: var(--color-red); }
  .eta-card h3 { font-size: 15px; font-weight: 700; margin-bottom: 4px; }
  .eta-card p { font-size: 13px; color: var(--color-gray); margin: 0; }
  .eta-time { margin-left: auto; text-align: right; }
  .eta-time span { display: block; font-size: 22px; font-weight: 800; color: var(--color-red); }
  .eta-time small { font-size: 11px; color: var(--color-gray); text-transform: uppercase; letter-spacing: 0.05em; }

  /* ---------- STATUS TRACKER ---------- */
  .tracker {
    background: var(--color-blush);
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 30px 30px 26px;
    margin-top: 20px;
    text-align: left;
  }
  .tracker h4 {
    font-size: 12px; text-transform: uppercase; letter-spacing: 0.05em;
    color: var(--color-gray); font-weight: 700; margin-bottom: 22px;
  }
  .tracker-steps { display: flex; align-items: flex-start; }
  .tracker-step { flex: 1; text-align: center; position: relative; }
  .tracker-step .dot {
    width: 30px; height: 30px; border-radius: 50%;
    background: var(--color-red); color: var(--color-white);
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 10px; position: relative; z-index: 2;
  }
  .tracker-step .dot svg { width: 15px; height: 15px; stroke: currentColor; }
  .tracker-step.pending .dot { background: var(--color-maroon); border: 1px solid var(--color-border); color: var(--color-gray); }
  .tracker-step .line {
    position: absolute; top: 15px; left: -50%; width: 100%; height: 2px;
    background: var(--color-red); z-index: 1;
  }
  .tracker-step:first-child .line { display: none; }
  .tracker-step.pending .line { background: var(--color-border); }
  .tracker-step span { font-size: 12px; font-weight: 600; color: var(--color-gray); }
  .tracker-step.active span, .tracker-step .dot:not(.pending) ~ span {}
  .tracker-step:not(.pending) span { color: var(--color-ink); }

  /* ---------- ORDER SUMMARY ---------- */
  .summary-card {
    background: var(--color-blush);
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 26px 30px;
    margin-top: 20px;
    text-align: left;
  }
  .summary-card h4 {
    font-size: 12px; text-transform: uppercase; letter-spacing: 0.05em;
    color: var(--color-gray); font-weight: 700; margin-bottom: 18px;
  }
  .summary-restaurant { display: flex; gap: 12px; align-items: center; margin-bottom: 18px; }
  .summary-restaurant img { width: 48px; height: 48px; border-radius: 10px; object-fit: cover; flex-shrink: 0; }
  .summary-restaurant h5 { font-size: 15px; font-weight: 700; margin-bottom: 2px; }
  .summary-restaurant span { font-size: 12px; color: var(--color-gray); }
  .summary-divider { border-top: 1px solid var(--color-border); margin: 4px 0 16px; }

  .order-item-row {
    display: flex; justify-content: space-between; font-size: 14px;
    padding: 10px 0; border-bottom: 1px solid var(--color-border);
  }
  .order-item-row:last-of-type { border-bottom: none; }
  .order-item-name { display: flex; align-items: center; gap: 8px; font-weight: 600; }
  .veg-mark {
    width: 13px; height: 13px; border: 1.5px solid var(--color-red); border-radius: 3px;
    display: inline-flex; align-items: center; justify-content: center; flex-shrink: 0;
  }
  .veg-mark::after { content: ""; width: 6px; height: 6px; border-radius: 50%; background: var(--color-red); }
  .order-item-qty { color: var(--color-gray); font-size: 12px; margin-left: 6px; }
  .order-item-price { font-weight: 700; white-space: nowrap; }

  .bill-total-row {
    display: flex; justify-content: space-between; align-items: center;
    border-top: 1px solid var(--color-border); padding-top: 16px; margin-top: 8px;
  }
  .bill-total-row span:first-child { font-size: 15px; font-weight: 700; }
  .bill-total-row span:last-child { font-size: 19px; font-weight: 800; color: var(--color-red); }

  .deliver-to {
    display: flex; gap: 12px; align-items: flex-start;
    margin-top: 18px; padding-top: 18px; border-top: 1px solid var(--color-border);
  }
  .deliver-to svg { width: 18px; height: 18px; stroke: var(--color-red); flex-shrink: 0; margin-top: 2px; }
  .deliver-to h5 { font-size: 13px; font-weight: 700; margin-bottom: 4px; }
  .deliver-to p { font-size: 13px; color: var(--color-gray); margin: 0; line-height: 1.5; }

  /* ---------- ACTIONS ---------- */
  .confirm-actions { display: flex; gap: 14px; margin-top: 32px; }
  .btn-primary {
    flex: 1;
    background: var(--color-red);
    color: var(--color-white);
    border: none; border-radius: 10px;
    padding: 15px; font-size: 14px; font-weight: 700;
    letter-spacing: 0.02em; text-transform: uppercase;
    cursor: pointer;
  }
  .btn-primary:hover { background: var(--color-red-dark); }
  .btn-secondary {
    flex: 1;
    background: transparent;
    color: var(--color-ink);
    border: 1px solid var(--color-border); border-radius: 10px;
    padding: 15px; font-size: 14px; font-weight: 700;
    letter-spacing: 0.02em; text-transform: uppercase;
    cursor: pointer;
  }
  .btn-secondary:hover { border-color: var(--color-red); color: var(--color-red); }

  @media (max-width: 640px) {
    .wrap { padding: 0 20px; }
    .confirm-wrap { padding: 48px 20px 72px; }
    .eta-card { flex-wrap: wrap; }
    .eta-time { margin-left: 0; text-align: left; }
    .confirm-actions { flex-direction: column; }
  }

</style>
</head>
<body>
<%
	User navUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
	    if (navUser == null) {
	        response.sendRedirect(request.getContextPath() + "/login.jsp");
	        return;
	    }
		List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
		Address defaultAddress = (Address) request.getAttribute("defaultAddress");
		double subtotal = 0;
	    int totalQty = 0;
	    if (cartItems != null) {
	        for (Cart ci : cartItems) {
	            subtotal += ci.getLineTotal();
	            totalQty += ci.getQuantity();
	        }
	    }
	    double deliveryFee = (cartItems != null && !cartItems.isEmpty()) ? 4.99 : 0;
	    double tax = subtotal * 0.08;
	    double total = subtotal + deliveryFee + tax;
	%>
  <header class="site-nav">
    <div class="wrap">
      <a class="brand" href="#"> <img
				src="<%=request.getContextPath()%>/images/logo.png"
				alt="SwadExpress logo"
				style="height: 48px; vertical-align: middle; margin-right: 8px;">
				SwadExpress
			</a>
      <div class="nav-icon-group">
        <a class="icon-btn" href="<%=request.getContextPath()%>/cart" aria-label="Cart">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="9" cy="21" r="1"></circle>
            <circle cx="20" cy="21" r="1"></circle>
            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
          </svg>
        </a>
        <a class="icon-btn active" href="<%=request.getContextPath()%>/profile" aria-label="Profile">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
            <circle cx="12" cy="7" r="4"></circle>
          </svg>
        </a>
      </div>
    </div>
  </header>

  <div class="confirm-wrap">

    <div class="confirm-header">
      <div class="success-badge">
    <dotlottie-player
        src="<%=request.getContextPath()%>/animations/Success.lottie"
        background="transparent"
        speed="1"
        style="width:160px;height:160px"
        autoplay
        loop>
    </dotlottie-player>
</div>

      <h1 class="confirm-title">Order Confirmed!</h1>
      <p class="confirm-sub">Thanks for ordering with SwadExpress — your food is being prepared.</p>
      
    </div>

    <div class="confirm-layout">

      <!-- LEFT: ETA + Order Status -->
      <div class="confirm-left">

        <div class="eta-card">
          <div class="eta-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
          </div>
          <div>
            <h3>Estimated Delivery</h3>
            <p>Your order will arrive hot and fresh</p>
          </div>
          <div class="eta-time">
            <span>35 mins</span>
            <small>ETA</small>
          </div>
        </div>

        <div class="tracker">
          <h4>Order Status</h4>
          <div class="tracker-steps">
            <div class="tracker-step">
              <div class="dot"><svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg></div>
              <span>Placed</span>
            </div>
            <div class="tracker-step">
              <div class="line"></div>
              <div class="dot"><svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path></svg></div>
              <span>Preparing</span>
            </div>
            <div class="tracker-step pending">
              <div class="line"></div>
              <div class="dot pending"><svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="5.5" cy="17.5" r="2.5"></circle><circle cx="18.5" cy="17.5" r="2.5"></circle><path d="M15 18H9M2 8h13l4 5v5h-3M2 8v10h3M2 8l2-5h9l3 5"></path></svg></div>
              <span>On the way</span>
            </div>
            <div class="tracker-step pending">
              <div class="line"></div>
              <div class="dot pending"><svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg></div>
              <span>Delivered</span>
            </div>
          </div>
        </div>

        <div class="confirm-actions">
          
          <button class="btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/restaurant'">Back to Home Page</button>
        </div>

      </div>
<%
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");    
if (cartItems != null && !cartItems.isEmpty() && restaurant!=null) {
%>
      <!-- RIGHT: Order Summary -->
      <div class="confirm-right">
        <div class="summary-card" style="margin-top:0;">
          <h4>Order Summary</h4>

          <div class="summary-restaurant">
            <img src="<%=restaurant.getImage()%>" alt="<%=restaurant.getRestaurantName() %>">
            <div>
              <h5><%=restaurant.getRestaurantName()%></h5>
              <span><%= restaurant.getCuisineType()%></span>
            </div>
          </div>
          <div class="summary-divider"></div>

<%
        for (Cart c : cartItems) {
%>
          <div class="order-item-row">
            <div class="order-item-name">
              <span class="veg-mark"></span>
              <%=c.getItemName() %> <span class="order-item-qty"><%=c.getQuantity()%></span>
            </div>
            <div class="order-item-price">₹<%=String.format("%.2f", c.getLineTotal())%></div>
          </div>
<%
        }
%>
<% } else { %>
<div class="order-item-row">
            <div class="order-item-name">
              <span class="veg-mark"></span>
              no items in cart <span class="order-item-qty"></span>
            </div>
            <div class="order-item-price"></div>
          </div>
<% } %>
          <div class="bill-total-row">
            <span>Total Paid</span>
            <span>₹<%=String.format("%.2f", total)%></span>
          </div>

          <div class="deliver-to">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
           <% if (defaultAddress != null) { %>
           <div>
              <h5>Delivering to — <%=defaultAddress.getLabel()%></h5>
              <p><%=defaultAddress.getFullAddress()%></p>
              <% } else { %>
              <h5>Delivering to — null</h5>
              <p>No address selected</p>
            </div>
            <% } %>
          </div>
        </div>
      </div>

    </div>

  </div>
	<script src="https://unpkg.com/@dotlottie/player-component@2.7.12/dist/dotlottie-player.mjs" type="module"></script>
</body>
</html>
