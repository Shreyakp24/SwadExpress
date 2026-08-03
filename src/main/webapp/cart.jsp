<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List,com.tap.model.Cart,com.tap.model.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Cart | SwadExpress</title>
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
  }

  a { color: inherit; text-decoration: none; }
  img { max-width: 100%; display: block; }

  .wrap {
    max-width: 1240px;
    margin: 0 auto;
    padding: 0 40px;
  }

  h1, h2, h3 { font-family: var(--font-display); margin: 0; }

  .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    font-family: var(--font-body);
    font-weight: 600;
    font-size: 16px;
    padding: 13px 26px;
    border-radius: 999px;
    cursor: pointer;
    border: 2px solid transparent;
    white-space: nowrap;
  }

  .btn-filled-red { background: var(--color-red); color: var(--color-white); border: none; }
  .btn-filled-red:hover { background: var(--color-red-dark); }
  .btn-filled-red:disabled { opacity: 0.5; cursor: not-allowed; }

  .btn-outline-red {
    background: transparent;
    color: var(--color-red);
    border-color: var(--color-red);
  }
  .btn-outline-red:hover { background: var(--color-red); color: var(--color-white); }

  .btn-small { padding: 9px 18px; font-size: 14px; }

  /* ---------- NAV (matches restaurant/menu/account pages) ---------- */
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
  .brand img {
    height: 40px;
    display: inline-block;
    margin-right: 8px;
  }

  .back-link {
    font-size: 14px;
    font-weight: 500;
    color: var(--color-gray);
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .back-link:hover { color: var(--color-red); }

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

  .cart-count-badge {
    position: absolute;
    top: -4px; right: -4px;
    width: 16px; height: 16px;
    border-radius: 50%;
    background: var(--color-white);
    color: var(--color-red-dark);
    font-size: 10px;
    font-weight: 800;
    display: flex; align-items: center; justify-content: center;
    border: 2px solid var(--color-bg);
  }

  .nav-icon-group { display: flex; align-items: center; gap: 10px; }

  /* ---------- PAGE HEAD ---------- */
  .page-head { padding: 48px 0 8px; display: flex; align-items: flex-end; justify-content: space-between; gap: 20px; flex-wrap: wrap; }

  .page-head h1 {
    font-size: 30px;
    font-weight: 800;
    letter-spacing: -0.01em;
  }

  .page-head p {
    color: var(--color-gray);
    font-size: 14px;
    margin-top: 8px;
  }

  /* ---------- CART LAYOUT ---------- */
  .cart-shell {
    padding: 32px 0 100px;
    display: grid;
    grid-template-columns: 1fr 360px;
    gap: 40px;
    align-items: start;
  }

  .cart-items { display: flex; flex-direction: column; gap: 20px; }

  .cart-item {
    display: grid;
    grid-template-columns: 96px 1fr auto;
    gap: 20px;
    align-items: center;
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 16px;
    background: var(--color-blush);
  }

  .cart-item-photo {
    width: 96px;
    height: 96px;
    border-radius: 12px;
    overflow: hidden;
  }

  .cart-item-photo img { width: 100%; height: 100%; object-fit: cover; }

  .cart-item-info h3 { font-size: 17px; font-weight: 700; margin-bottom: 6px; }
  .cart-item-info .cart-item-meta { font-size: 13px; color: var(--color-gray); margin-bottom: 10px; }
  .cart-item-info .remove-link { font-size: 13px; color: var(--color-red); font-weight: 600; cursor: pointer; border: none; background: none; padding: 0; font-family: var(--font-body); }

  .cart-item-controls {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 12px;
  }

  .qty-stepper {
    display: flex;
    align-items: center;
    gap: 12px;
    border: 1px solid var(--color-border);
    border-radius: 999px;
    padding: 6px 14px;
  }

  .qty-stepper button {
    background: none;
    border: none;
    color: var(--color-red);
    font-size: 18px;
    font-weight: 700;
    cursor: pointer;
    width: 18px;
    line-height: 1;
    font-family: var(--font-body);
  }

  .qty-stepper .qty-value { font-size: 15px; font-weight: 600; min-width: 16px; text-align: center; }

  .item-price { font-size: 16px; font-weight: 700; }

  .add-more-row {
    display: flex;
    justify-content: flex-start;
  }

  .add-more-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: transparent;
    color: var(--color-ink);
    border: 1px dashed var(--color-border);
    border-radius: 999px;
    padding: 12px 22px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    font-family: var(--font-body);
  }
  .add-more-btn:hover { border-color: var(--color-red); color: var(--color-red); }

  .empty-cart {
    border: 1px dashed var(--color-border);
    border-radius: 16px;
    padding: 60px 24px;
    text-align: center;
    color: var(--color-gray);
  }

  /* ---------- SUMMARY ---------- */
  .summary-card {
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 28px;
    position: sticky;
    top: 24px;
    background: var(--color-blush);
  }

  .summary-card h3 {
    font-size: 16px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.02em;
    margin-bottom: 20px;
    color: var(--color-red);
  }

  .summary-row {
    display: flex;
    justify-content: space-between;
    font-size: 14px;
    color: var(--color-gray);
    margin-bottom: 14px;
  }

  .summary-row.total {
    color: var(--color-ink);
    font-size: 17px;
    font-weight: 700;
    border-top: 1px solid var(--color-border);
    padding-top: 16px;
    margin-top: 6px;
    margin-bottom: 24px;
  }

  .promo-row {
    display: flex;
    gap: 10px;
    margin-bottom: 24px;
  }

  .promo-row input {
    flex: 1;
    padding: 11px 14px;
    border-radius: 10px;
    border: 1px solid var(--color-border);
    background: var(--color-bg);
    color: var(--color-ink);
    font-size: 14px;
    font-family: var(--font-body);
  }

  .promo-row input::placeholder { color: var(--color-gray); }
  .promo-row input:focus { outline: none; border-color: var(--color-red); }

  @media (max-width: 900px) {
    .wrap { padding: 0 20px; }
    .cart-shell { grid-template-columns: 1fr; }
    .cart-item { grid-template-columns: 72px 1fr; }
    .cart-item-controls { grid-column: 1 / -1; flex-direction: row; justify-content: space-between; align-items: center; }
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
      <a class="brand" href="<%=request.getContextPath()%>/restaurant.jsp">
        <img src="<%=request.getContextPath()%>/images/logo.png" alt="SwadExpress logo">
        SwadExpress
      </a>
      <div class="nav-icon-group">
        <a class="back-link" href="<%=request.getContextPath()%>/restaurant">← Back to restaurants</a>
        <a class="icon-btn active" href="<%=request.getContextPath()%>/cart" aria-label="Cart">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="9" cy="21" r="1"></circle>
            <circle cx="20" cy="21" r="1"></circle>
            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
          </svg>
          <span class="cart-count-badge"><%=totalQty%></span>
        </a>
        <a class="icon-btn" href="<%=request.getContextPath()%>/profile" aria-label="Profile">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
            <circle cx="12" cy="7" r="4"></circle>
          </svg>
        </a>
      </div>
    </div>
  </header>

<%
Integer cartRestaurantId = (Integer) request.getAttribute("cartRestaurantId");
String addMoreUrl = (cartRestaurantId != null)
    ? request.getContextPath() + "/menu?restaurantId=" + cartRestaurantId
    : request.getContextPath() + "/restaurant";
%>
  <div class="wrap page-head">
    <div>
      <h1>Your Cart</h1>
      <p>Review your order before checkout.</p>
    </div>
    <a class="add-more-btn" href="<%=addMoreUrl%>">+ Add more items</a>
  </div>

  <div class="wrap cart-shell">

    <div class="cart-items" id="cartItems">
    <%
    if (cartItems == null || cartItems.isEmpty()) {
    %>
      <div class="empty-cart">
        Your cart is empty.
        <a href="<%=request.getContextPath()%>/restaurant#restaurants" style="color:var(--color-red); font-weight:600;">Browse the menu →</a>
      </div>
    <%
    } else {
        for (Cart c : cartItems) {
    %>
      <div class="cart-item">
        <div class="cart-item-photo">
          <img src="<%=c.getImage()%>" alt="<%=c.getItemName()%>">
        </div>
        <div class="cart-item-info">
          <h3><%=c.getItemName()%></h3>
          <div class="cart-item-meta"><%=c.getRestaurantName()%></div>
          <form action="<%=request.getContextPath()%>/cart" method="post">
            <input type="hidden" name="action" value="remove">
            <input type="hidden" name="cartItemID" value="<%=c.getCartItemID()%>">
            <button type="submit" class="remove-link">Remove</button>
          </form>
        </div>
        <div class="cart-item-controls">
          <div class="item-price">₹<%=String.format("%.2f", c.getLineTotal())%></div>
          <form class="qty-stepper" action="<%=request.getContextPath()%>/cart" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="cartItemID" value="<%=c.getCartItemID()%>">
            <button type="submit" name="quantity" value="<%=c.getQuantity() - 1%>" aria-label="Decrease quantity">−</button>
            <span class="qty-value"><%=c.getQuantity()%></span>
            <button type="submit" name="quantity" value="<%=c.getQuantity() + 1%>" aria-label="Increase quantity">+</button>
          </form>
        </div>
      </div>
    <%
        }
    }
    %>
    </div>

    <div class="summary-card">
      <h3>Order Summary</h3>
      <div class="summary-row"><span>Subtotal</span><span>₹<%=String.format("%.2f", subtotal)%></span></div>
      <div class="summary-row"><span>Delivery fee</span><span>₹<%=String.format("%.2f", deliveryFee)%></span></div>
      <div class="summary-row"><span>Tax</span><span>₹<%=String.format("%.2f", tax)%></span></div>
      <div class="summary-row total"><span>Total</span><span>₹<%=String.format("%.2f", total)%></span></div>
      <div class="promo-row">
        <input type="text" placeholder="Promo code">
        <button class="btn btn-outline-red btn-small" type="button">Apply</button>
      </div>
      <% if (cartItems == null || cartItems.isEmpty()) { %>
    <button class="btn btn-filled-red" style="width:100%;" disabled>Checkout</button>
<% } else { %>
    <a class="btn btn-filled-red" style="width:100%; text-align:center;" href="<%=request.getContextPath()%>/checkout">Checkout</a>
<% } %>
    </div>
  </div>
</body>
</html>
