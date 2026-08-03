<%@page import="java.util.List, com.tap.model.Menu, com.tap.model.Restaurant, com.tap.model.User, java.util.HashMap, java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<%
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
if (restaurant == null) {
    response.sendRedirect(request.getContextPath() + "/restaurant");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Spice Route — Menu | SwadExpress</title>
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
  html { scroll-behavior: smooth; }
  html, body {
    margin: 0; padding: 0;
    background: var(--color-bg);
    color: var(--color-ink);
    font-family: var(--font-body);
  }
  a { color: inherit; text-decoration: none; }
  img { max-width: 100%; display: block; }
  ul { margin: 0; }

  .wrap {
    max-width: 1240px;
    margin: 0 auto;
    padding: 0 40px;
  }

  h1, h2, h3, h4 { font-family: var(--font-display); margin: 0; }

  /* ---------- BUTTONS ---------- */
  .btn {
    display: inline-flex; align-items: center; justify-content: center; gap: 8px;
    font-family: var(--font-body); font-weight: 600; font-size: 15px;
    padding: 11px 22px; border-radius: 999px; cursor: pointer;
    border: 2px solid transparent; white-space: nowrap;
  }
  .btn-filled-red { background: var(--color-red); color: var(--color-white); }
  .btn-filled-red:hover { background: var(--color-red-dark); }
  .btn-outline-white { background: transparent; color: var(--color-white); border-color: rgba(255,255,255,0.6); }
  .btn-outline-red { background: transparent; color: var(--color-red); border-color: var(--color-red); }
  .btn-outline-red:hover { background: var(--color-red); color: var(--color-white); }
  .btn-small { padding: 8px 16px; font-size: 13px; }
  .btn-toggle {
    background: transparent; color: var(--color-gray); border: 1px solid var(--color-border);
    font-weight: 600; font-size: 14px; padding: 10px 20px; border-radius: 999px; cursor: pointer;
  }
  .btn-toggle.active { background: var(--color-red); color: var(--color-white); border-color: var(--color-red); }

  /* ---------- MINI NAV ---------- */
  header.site-nav { padding: 18px 0; border-bottom: 1px solid var(--color-border); }
  .site-nav .wrap { display: flex; align-items: center; justify-content: space-between; }
  .brand {font-family: var(--font-display);font-weight: 700;font-size: 20px;color: var(--color-red);display: flex;align-items: center;}
  .brand img {height: 44px;display: inline-block;margin-right: 8px;}
  .back-link { font-size: 14px; font-weight: 500; color: var(--color-gray); display: flex; align-items: center; gap: 8px; }
  .back-link:hover { color: var(--color-red); }
  .icon-btn {
    display: inline-flex; align-items: center; justify-content: center;
    width: 38px; height: 38px; border-radius: 50%; border: 1px solid var(--color-border);
    color: var(--color-ink);position: relative;
  }
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

@keyframes cartPulse {
  0% { transform: scale(1); }
  40% { transform: scale(1.18); background: var(--color-red); border-color: var(--color-red); color: var(--color-white); }
  100% { transform: scale(1); }
}
.icon-btn.pulse { animation: cartPulse 0.4s ease; }

.toast {
  position: fixed;
  bottom: 24px; right: 24px;
  background: var(--color-blush);
  border: 1px solid var(--color-red);
  color: var(--color-ink);
  padding: 14px 20px;
  border-radius: 12px;
  font-size: 14px; font-weight: 600;
  display: flex; align-items: center; gap: 10px;
  box-shadow: 0 8px 24px rgba(0,0,0,0.4);
  transform: translateY(20px);
  opacity: 0;
  pointer-events: none;
  transition: transform 0.25s ease, opacity 0.25s ease;
  z-index: 1000;
}
.toast.show { transform: translateY(0); opacity: 1; }
.toast svg { width: 18px; height: 18px; stroke: var(--color-red); flex-shrink: 0; }
  .icon-btn:hover { background: var(--color-red); border-color: var(--color-red); color: var(--color-white); }
  .icon-btn svg { width: 18px; height: 18px; stroke: currentColor; }
  .nav-icon-group { display: flex; align-items: center; gap: 10px; }

  /* ---------- COVER + LOGO ---------- */
  .cover-wrap { position: relative; }
  .cover-photo {
    width: 100%; height: 260px; overflow: hidden;
    background: linear-gradient(135deg, #f2b451 0%, #e8734a 45%, #a83a1e 100%);
  }
  .cover-photo img { width: 100%; height: 100%; object-fit: cover; opacity: 0.92; }
  .restaurant-logo {
    position: absolute; left: 40px; bottom: -46px;
    width: 96px; height: 96px; border-radius: 50%;
    background: var(--color-maroon);
    border: 4px solid var(--color-bg);
    display: flex; align-items: center; justify-content: center;
    font-family: var(--font-display); font-weight: 800; font-size: 26px;
    color: var(--color-red);
    box-shadow: 0 6px 18px rgba(0,0,0,0.4);
  }

  /* ---------- HEADING BAR ---------- */
  .restaurant-heading { padding: 62px 0 32px; }
  .restaurant-heading h1 {
    font-size: 34px; font-weight: 800; letter-spacing: -0.01em; margin-bottom: 4px;
  }
  .restaurant-heading .tagline { color: var(--color-gray); font-size: 14px; }

  /* ---------- LAYOUT: SIDEBAR + CONTENT ---------- */
  .layout {
    display: grid;
    grid-template-columns: 280px 1fr;
    gap: 48px;
    align-items: start;
    padding-bottom: 96px;
  }

  /* ---------- SIDEBAR ---------- */
  .sidebar { position: sticky; top: 24px; }

  .badge-loyalty {
    display: inline-flex; align-items: center; gap: 8px;
    font-size: 13px; font-weight: 600; color: var(--color-red);
    border: 1px solid var(--color-red); border-radius: 999px;
    padding: 6px 14px; margin-bottom: 16px;
  }

  .rating-row { display: flex; align-items: center; gap: 8px; font-size: 15px; font-weight: 600; margin-bottom: 6px; }
  .rating-row .stars { color: var(--color-red); }
  .rating-row .count { color: var(--color-gray); font-weight: 500; }

  .meta-row { color: var(--color-gray); font-size: 14px; margin-bottom: 14px; }
  .meta-row span + span::before { content: "·"; margin: 0 8px; }

  .tag-row { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 16px; }
  .pill {
    font-size: 12px; font-weight: 600; color: var(--color-ink);
    background: var(--color-blush); border: 1px solid var(--color-border);
    padding: 5px 11px; border-radius: 999px;
  }
  .pill.accent { color: var(--color-red); border-color: var(--color-red); }

  .address-block {
    font-size: 13px; color: var(--color-gray); line-height: 1.6;
    margin-bottom: 16px; padding: 12px 14px;
    border-left: 2px solid var(--color-red);
    background: var(--color-blush);
    border-radius: 0 8px 8px 0;
  }

  .fee-note {
    font-size: 13px; color: var(--color-gray); display: flex; align-items: center; gap: 6px;
    margin-bottom: 22px;
  }

  .see-more-btn {
    width: 100%; background: transparent; color: var(--color-ink);
    border: 1px solid var(--color-border); border-radius: 10px;
    padding: 11px; font-size: 14px; font-weight: 600; cursor: pointer; margin-bottom: 32px;
  }
  .see-more-btn:hover { border-color: var(--color-red); color: var(--color-red); }

  .sidebar-divider { border-top: 1px solid var(--color-border); padding-top: 24px; }

  .hours-block h4 {
    font-size: 13px; text-transform: uppercase; letter-spacing: 0.04em;
    color: var(--color-gray); margin-bottom: 6px;
  }
  .hours-block .hours-value { font-size: 15px; font-weight: 700; margin-bottom: 20px; }

  .menu-nav { display: flex; flex-direction: column; gap: 2px; }
  .menu-nav a {
    font-size: 14px; color: var(--color-gray); padding: 10px 12px; border-left: 3px solid transparent;
    border-radius: 4px;
  }
  .menu-nav a:hover { color: var(--color-ink); }
  .menu-nav a.active { color: var(--color-red); border-left-color: var(--color-red); background: var(--color-blush); font-weight: 600; }

  /* ---------- CONTENT ---------- */
  .order-toggle-row { display: flex; align-items: center; justify-content: space-between; gap: 20px; flex-wrap: wrap; margin-bottom: 24px; }
  .toggle-group { display: flex; gap: 10px; }

  .promo-banner {
    background: var(--color-blush); border: 1px solid var(--color-red);
    border-radius: 12px; padding: 14px 20px;
    display: flex; align-items: center; gap: 10px;
  }
  .promo-banner .promo-title { font-size: 14px; font-weight: 700; color: var(--color-red); }
  .promo-banner .promo-sub { font-size: 12px; color: var(--color-gray); }

  .content-section { margin-bottom: 56px; scroll-margin-top: 24px; }
  .content-section h2 {
    font-size: 22px; font-weight: 700; margin-bottom: 18px;
  }

  /* ---------- MENU ITEM CARDS ---------- */
  .item-grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
  .item-grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }

  .menu-item-card {
    display: flex; gap: 0; border: 1px solid var(--color-border);
    border-radius: 14px; overflow: hidden; position: relative;
    background: var(--color-blush);
  }
  .menu-item-copy { padding: 18px; flex: 1; display: flex; flex-direction: column; }
  .menu-item-copy h3 { font-size: 16px; font-weight: 700; margin-bottom: 6px; }
  .menu-item-copy p {
    font-size: 13px; color: var(--color-gray); line-height: 1.5; margin: 0 0 14px;
    flex: 1;
  }
  .item-price-row { display: flex; align-items: center; justify-content: space-between; font-size: 14px; }
  .item-price { font-weight: 700; color: var(--color-ink); }
  .menu-item-photo { width: 130px; flex-shrink: 0; position: relative; }
  .menu-item-photo img { width: 100%; height: 100%; object-fit: cover; }

  /* ---------- FULL MENU LIST STYLE ---------- */
  .menu-category { margin-bottom: 40px; scroll-margin-top: 24px; }
  .menu-category h3 {
    font-size: 18px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.02em;
    color: var(--color-red); margin-bottom: 16px;
    padding-bottom: 10px; border-bottom: 1px solid var(--color-border);
  }
  .list-item {
    display: flex; align-items: center; gap: 16px;
    padding: 14px 0; border-bottom: 1px solid var(--color-border);
  }
  .list-item:last-child { border-bottom: none; }
  .list-item-copy { flex: 1; }
  .list-item-copy h4 { font-size: 15px; font-weight: 700; margin-bottom: 4px; }
  .list-item-copy p { font-size: 13px; color: var(--color-gray); margin: 0 0 6px; line-height: 1.5; }
  .list-item-price { font-size: 14px; font-weight: 700; color: var(--color-ink); }
  .list-item-thumb {
    width: 64px; height: 64px; border-radius: 10px; flex-shrink: 0; overflow: hidden;
  }
  .list-item-thumb img { width: 100%; height: 100%; object-fit: cover; }
  .list-add-btn {
    width: 30px; height: 30px; border-radius: 50%; flex-shrink: 0;
    background: transparent; border: 1.5px solid var(--color-red); color: var(--color-red);
    font-size: 16px; font-weight: 700; cursor: pointer;
  }
  .list-add-btn:hover { background: var(--color-red); color: var(--color-white); }

  /* ---------- REVIEWS ---------- */
  .reviews-summary-row { display: flex; align-items: center; gap: 20px; margin-bottom: 24px; }
  .rating-circle {
    width: 78px; height: 78px; border-radius: 50%;
    border: 4px solid var(--color-red);
    display: flex; flex-direction: column; align-items: center; justify-content: center;
    font-family: var(--font-display);
  }
  .rating-circle .num { font-size: 22px; font-weight: 800; line-height: 1; }
  .rating-circle .of5 { font-size: 10px; color: var(--color-gray); }
  .reviews-summary-text { font-size: 14px; color: var(--color-gray); }
  .reviews-summary-text strong { color: var(--color-ink); }

  .review-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
  .review-card {
    border: 1px solid var(--color-border); border-radius: 14px; padding: 20px;
    background: var(--color-blush);
  }
  .review-head { display: flex; align-items: center; gap: 12px; margin-bottom: 12px; }
  .avatar {
    width: 40px; height: 40px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-weight: 700; font-size: 15px; color: var(--color-white);
    flex-shrink: 0;
  }
  .avatar.a1 { background: #e35f00; }
  .avatar.a2 { background: #c9962b; }
  .avatar.a3 { background: #a8433a; }
  .review-name { font-size: 14px; font-weight: 700; }
  .review-contrib { font-size: 12px; color: var(--color-gray); }
  .review-stars-row { font-size: 13px; color: var(--color-red); margin-bottom: 8px; }
  .review-stars-row .date { color: var(--color-gray); margin-left: 6px; }
  .review-text { font-size: 14px; color: var(--color-ink); line-height: 1.55; }
  .review-text strong { color: var(--color-red); }

  /* ---------- FOOTER ---------- */
  .footer-band { background: var(--color-red); color: var(--color-white); padding: 28px 0; margin-top: 40px; }
  .footer-band .brand-line { font-family: var(--font-display); font-weight: 700; font-size: 18px; }
  .footer-band p { margin: 4px 0 0; font-size: 13px; opacity: 0.9; }

  /* ---------- RESPONSIVE ---------- */
  @media (max-width: 900px) {
    .wrap { padding: 0 20px; }
    .layout { grid-template-columns: 1fr; }
    .sidebar { position: static; }
    .item-grid-2, .item-grid-3 { grid-template-columns: 1fr; }
    .review-grid { grid-template-columns: 1fr; }
    .restaurant-logo { left: 20px; width: 76px; height: 76px; font-size: 20px; bottom: -38px; }
    .restaurant-heading { padding-top: 54px; }
    .cover-photo { height: 190px; }
  }
  .nav-icon-group{
    display: flex;
    align-items: center;
    gap: 12px;
}

.nav-divider{
    width: 1px;
    height: 28px;
    background: rgba(255,255,255,0.35);
}
/* ---------- CART CONFLICT MODAL ---------- */
.modal-overlay {
  display: none;
  position: fixed; inset: 0;
  background: rgba(0,0,0,0.6);
  z-index: 1000;
  align-items: center; justify-content: center;
}
.modal-overlay.open { display: flex; }
.modal-box {
  background: var(--color-blush);
  border: 1px solid var(--color-border);
  border-radius: 16px;
  padding: 28px;
  max-width: 360px;
  width: 90%;
}
.modal-box h3 { font-size: 18px; font-weight: 700; margin-bottom: 8px; }
.modal-box p { font-size: 14px; color: var(--color-gray); margin: 0 0 22px; line-height: 1.5; }
.modal-actions { display: flex; gap: 12px; justify-content: flex-end; }
.qty-stepper {
  position: absolute;
  bottom: 12px;
  right: 12px;
  display: flex;
  align-items: center;
  gap: 10px;
  background: var(--color-blush);
  border: 1px solid var(--color-border);
  border-radius: 999px;
  padding: 6px 10px;
}

.qty-plus,
.qty-minus {
  background: transparent;
  border: none;
  color: var(--color-red);
  font-size: 18px;
  font-weight: 700;
  cursor: pointer;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
}
.qty-plus:hover,
.qty-minus:hover {
  background: var(--color-red);
  color: var(--color-white);
}

.qty-value {
  font-size: 14px;
  font-weight: 700;
  color: var(--color-white);
  min-width: 12px;
  text-align: center;
}
</style>
</head>
<body>

  <header class="site-nav">
    <div class="wrap">
			<a class="brand" href="#">
  <img src="<%=request.getContextPath()%>/images/logo.png" alt="SwadExpress logo" style="height:48px; vertical-align:middle; margin-right:8px;">
  SwadExpress
</a>
<%
    User navUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
%>
<div class="nav-icon-group">
  <a class="back-link" href="restaurant">← Back to restaurants</a>
  <span class="nav-divider"></span>
<a class="icon-btn" href="cart" aria-label="Cart">
  <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <circle cx="9" cy="21" r="1"></circle>
    <circle cx="20" cy="21" r="1"></circle>
    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
  </svg>
  <span class="cart-count-badge" id="navCartBadge" style="display:none;">0</span>
</a>
<% if (navUser != null) { %>
    <a class="icon-btn" href="<%=request.getContextPath()%>/profile" aria-label="Profile">
      <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
        <circle cx="12" cy="7" r="4"></circle>
      </svg>
    </a>
    <span class="nav-divider"></span>
    <span class="nav-username"><%=navUser.getUsername()%></span>

<% } else { %>
    <a class="btn btn-outline-red btn-small" href="<%=request.getContextPath()%>/login.jsp">Log in</a>
<% } %>
</div>
    </div>
  </header>
  <div class="cover-wrap">
    <div class="cover-photo">
      <img src="<%=restaurant.getImage()%>" alt="<%=restaurant.getRestaurantName()%>">
    </div>
    <div class="wrap" style="position:relative;">
      <div class="restaurant-logo"></div>
    </div>
  </div>

  <div class="wrap">
    <div class="restaurant-heading">
      <h1><%=restaurant.getRestaurantName() %></h1>
      <div class="tagline"><%= restaurant.getTagline() %></div>
    </div>

    <div class="layout">

      <!-- ============ SIDEBAR ============ -->
      <aside class="sidebar">
        <div class="badge-loyalty">★ SwadExpress Plus</div>

        <div class="rating-row">
          <span class="stars">★ <%= restaurant.getRatings() %></span>
          <span class="count">(200+ ratings)</span>
        </div>
        <div class="meta-row">
          <span><%= restaurant.getETA() %></span>
          <span>₹₹₹</span>
          <span><%=restaurant.getCuisineType() %></span>
        </div>

        <div class="tag-row">
          <span class="pill accent">Customer favorite</span>
        </div>

        <div class="address-block">
         📍 <%=restaurant.getAddress()%>
        </div>

        <div class="fee-note">
          ⓘ Service fees apply — pricing &amp; fees
        </div>

        <button class="see-more-btn">See more</button>

        <div class="sidebar-divider">
          <div class="hours-block">
            <h4>Full Menu</h4>
            <div class="hours-value">11:00 am – 10:00 pm</div>
          </div>

          <nav class="menu-nav">
            <a href="#most-liked" class="active">Most Liked Items From The Menu</a>
            <a href="#reviews">Reviews</a>
            <a href="#full-menu">Full Menu</a>
            <a href="#appetizers">Appetizers</a>
            <a href="#mains">Mains</a>
            <a href="#breads-rice">Breads &amp; Rice</a>
            <a href="#desserts-drinks">Desserts &amp; Drinks</a>
          </nav>
        </div>
      </aside>

      <!-- ============ CONTENT ============ -->
      <div class="content">

        <div class="order-toggle-row">
          <div class="toggle-group">
            <button class="btn-toggle active">Delivery</button>
            <button class="btn-toggle">Pickup</button>
            <button class="btn-toggle">Group Order</button>
          </div>
          <div class="promo-banner">
            <span class="promo-title"><%=restaurant.getDiscount()%></span>
            <span class="promo-sub">at <%=restaurant.getRestaurantName()%></span>
          </div>
        </div>

        <!-- MOST LIKED -->
        <section class="content-section" id="most-liked">
          <h2>Most Liked Items From The Menu</h2>
          <div class="item-grid-2">
          <% 
          Map<Integer, Integer> cartQuantities = (Map<Integer, Integer>) request.getAttribute("cartQuantities");
          if (cartQuantities == null) cartQuantities = new HashMap<>();

          List<Menu> menuByRestaurantId = (List<Menu>)request.getAttribute("menuByRestaurantId");
          for(Menu menu : menuByRestaurantId){
              Integer existingQty = cartQuantities.get(menu.getMenuId());
              boolean hasQty = existingQty != null && existingQty > 0;
          %>
			<div class="menu-item-card">
              <div class="menu-item-copy">
                <h3><%=menu.getItemName() %></h3>
                <p><%=menu.getDescription() %></p>
                <div class="item-price-row">
                  <span class="item-price">₹<%=menu.getPrice() %></span>
                </div>
              </div>
              <div class="menu-item-photo">
                <img src="<%=menu.getImages()%>" alt="<%=menu.getItemName()%>" style="width:100%;height:100%;object-fit:cover;">
<div class="qty-stepper" data-menu-id="<%=menu.getMenuId()%>">
    <button type="button" class="qty-minus" style="<%=hasQty ? "" : "display:none;"%>">−</button>
    <span class="qty-value" style="<%=hasQty ? "" : "display:none;"%>"><%=hasQty ? existingQty : ""%></span>
    <form action="<%=request.getContextPath()%>/cart" method="post" style="display:contents;">
        <input type="hidden" name="menuID" value="<%=menu.getMenuId()%>">
        <input type="hidden" name="restaurantId" value="<%=restaurant.getRestaurantID()%>">
        <input type="hidden" name="action" value="add">
        <button type="submit" class="qty-plus">+</button>
    </form>
</div>
            
              </div>
            </div>
          <%
            }
          %>
          </div>
        </section>

        <!-- REVIEWS -->
        <section class="content-section" id="reviews">
          <h2>Reviews</h2>
          <div class="reviews-summary-row">
            <div class="rating-circle">
              <span class="num">4.7</span>
              <span class="of5">of 5 stars</span>
            </div>
            <div class="reviews-summary-text">
              <strong>200+ ratings</strong> · 10+ public reviews
            </div>
          </div>

          <div class="review-grid">
            <div class="review-card">
              <div class="review-head">
                <div class="avatar a1">R</div>
                <div>
                  <div class="review-name">Riya S</div>
                  <div class="review-contrib">4 contributions</div>
                </div>
              </div>
              <div class="review-stars-row">★★★★★ <span class="date">7/2/26 · SwadExpress order</span></div>
              <div class="review-text">The <strong>Butter Chicken</strong> tasted just like my grandmother's recipe. Packaging kept it piping hot too.</div>
            </div>

            <div class="review-card">
              <div class="review-head">
                <div class="avatar a2">K</div>
                <div>
                  <div class="review-name">Karan M</div>
                  <div class="review-contrib">9 contributions</div>
                </div>
              </div>
              <div class="review-stars-row">★★★★☆ <span class="date">6/24/26 · SwadExpress order</span></div>
              <div class="review-text"><strong>Paneer Tikka Masala</strong> was great, only wish the naan came a little more toasted.</div>
            </div>

            <div class="review-card">
              <div class="review-head">
                <div class="avatar a3">N</div>
                <div>
                  <div class="review-name">Neha P</div>
                  <div class="review-contrib">2 contributions</div>
                </div>
              </div>
              <div class="review-stars-row">★★★★★ <span class="date">6/11/26 · SwadExpress order</span></div>
              <div class="review-text">Fast delivery and generous portions. The <strong>Mango Lassi</strong> was the perfect finish.</div>
            </div>
          </div>
        </section>

        <!-- FULL MENU -->
        <section class="content-section" id="full-menu">
          <h2>Full Menu</h2>

          <div class="menu-category" id="appetizers">
            <h3>Appetizers</h3>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/1.jpg" alt="Vegetable Samosa" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Vegetable Samosa (2 pc)</h4>
                <p>Crisp pastry filled with spiced potatoes and peas, served with tamarind chutney.</p>
              </div>
              <span class="list-item-price">₹120</span>
              <button class="list-add-btn">+</button>
            </div>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/2.jpg" alt="Paneer Tikka" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Paneer Tikka</h4>
                <p>Chargrilled marinated paneer skewers with mint chutney.</p>
              </div>
              <span class="list-item-price">₹180</span>
              <button class="list-add-btn">+</button>
            </div>
          </div>

          <div class="menu-category" id="mains">
            <h3>Mains</h3>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/3.jpg" alt="Butter Chicken" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Butter Chicken</h4>
                <p>Tandoori chicken in tomato-butter gravy with cream and fenugreek.</p>
              </div>
              <span class="list-item-price">₹320</span>
              <button class="list-add-btn">+</button>
            </div>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/4.jpg" alt="Paneer Tikka Masala" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Paneer Tikka Masala</h4>
                <p>Chargrilled paneer in a smoky spiced masala sauce with peppers and onion.</p>
              </div>
              <span class="list-item-price">₹280</span>
              <button class="list-add-btn">+</button>
            </div>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/5.jpg" alt="Dal Makhani" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Dal Makhani</h4>
                <p>Slow-simmered black lentils finished with cream and a touch of ghee.</p>
              </div>
              <span class="list-item-price">₹220</span>
              <button class="list-add-btn">+</button>
            </div>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/6.jpg" alt="Chicken Biryani" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Chicken Biryani</h4>
                <p>Basmati rice layered with spiced chicken, fried onions and saffron.</p>
              </div>
              <span class="list-item-price">₹260</span>
              <button class="list-add-btn">+</button>
            </div>
          </div>

          <div class="menu-category" id="breads-rice">
            <h3>Breads &amp; Rice</h3>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/7.jpg" alt="Garlic Naan" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Garlic Naan</h4>
                <p>Tandoor-baked flatbread brushed with garlic butter and cilantro.</p>
              </div>
              <span class="list-item-price">₹60</span>
              <button class="list-add-btn">+</button>
            </div>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/8.jpg" alt="Jeera Rice" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Jeera Rice</h4>
                <p>Basmati rice tempered with cumin seeds and ghee.</p>
              </div>
              <span class="list-item-price">₹80</span>
              <button class="list-add-btn">+</button>
            </div>
          </div>

          <div class="menu-category" id="desserts-drinks">
            <h3>Desserts &amp; Drinks</h3>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/9.jpg" alt="Gulab Jamun" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Gulab Jamun (2 pc)</h4>
                <p>Warm milk-solid dumplings soaked in rose-cardamom syrup.</p>
              </div>
              <span class="list-item-price">₹90</span>
              <button class="list-add-btn">+</button>
            </div>
            <div class="list-item">
              <div class="list-item-thumb"><img src="images/menu/10.jpg" alt="Mango Lassi" style="width:100%;height:100%;object-fit:cover;"></div>
              <div class="list-item-copy">
                <h4>Mango Lassi</h4>
                <p>Creamy yogurt drink blended with ripe mango pulp.</p>
              </div>
              <span class="list-item-price">₹80</span>
              <button class="list-add-btn">+</button>
            </div>
          </div>
        </section>

      </div>
    </div>
  </div>

  <div class="footer-band">
    <div class="wrap">
      <div class="brand-line">SwadExpress</div>
      <p>Seasonal meals, cooked fresh and delivered daily.</p>
    </div>
  </div>
  
    <div class="modal-overlay" id="cartConflictModal">
    <div class="modal-box">
      <h3>Start a new order?</h3>
      <p>Your cart already has items from a different restaurant. Adding this item will clear your current cart.</p>
      <div class="modal-actions">
        <button type="button" class="btn btn-outline-red btn-small" onclick="closeCartConflictModal()">Cancel</button>
        <button type="button" class="btn btn-filled-red btn-small" onclick="confirmCartConflict()">Yes, start new order</button>
      </div>
    </div>
  </div>

  <form id="forceAddForm" action="<%=request.getContextPath()%>/cart" method="post" style="display:none;">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="force" value="true">
    <input type="hidden" name="menuID" id="forceAddMenuID">
    <input type="hidden" name="restaurantId" value="<%=request.getParameter("restaurantId")%>">
  </form>
  <div class="toast" id="cartToast">
  <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <path d="M20 6 9 17l-5-5"></path>
  </svg>
  <span id="cartToastText">Added to your cart</span>
</div>

<script>
(function () {
  var navLinks = document.querySelectorAll('.menu-nav a');
  var sections = Array.from(navLinks).map(function (link) {
    return document.querySelector(link.getAttribute('href'));
  });

  function setActive() {
    var pos = window.scrollY + 120;
    var current = 0;
    sections.forEach(function (sec, i) {
      if (sec && sec.offsetTop <= pos) current = i;
    });
    navLinks.forEach(function (l, i) {
      l.classList.toggle('active', i === current);
    });
  }
  window.addEventListener('scroll', setActive, { passive: true });
  setActive();

  var toggles = document.querySelectorAll('.btn-toggle');
  toggles.forEach(function (btn) {
    btn.addEventListener('click', function () {
      toggles.forEach(function (b) { b.classList.remove('active'); });
      btn.classList.add('active');
    });
  });
})();

<% if ("true".equals(request.getParameter("cartConflict"))) { %>
document.addEventListener('DOMContentLoaded', function () {
  document.getElementById('forceAddMenuID').value = '<%=request.getParameter("pendingMenuID")%>';
  document.getElementById('cartConflictModal').classList.add('open');
});
<%}%>

function closeCartConflictModal() {
  document.getElementById('cartConflictModal').classList.remove('open');
}

function updateCartBadge(count) {
  var badge = document.getElementById('navCartBadge');
  if (!badge) return;
  badge.textContent = count;
  badge.style.display = 'flex';
}

function pulseCartIcon() {
  var cartIcon = document.querySelector('.icon-btn[aria-label="Cart"]');
  if (!cartIcon) return;
  cartIcon.classList.add('pulse');
  setTimeout(function () { cartIcon.classList.remove('pulse'); }, 400);
}

function showCartToast(message) {
  var toast = document.getElementById('cartToast');
  document.getElementById('cartToastText').textContent = message;
  toast.classList.add('show');
  clearTimeout(window._cartToastTimer);
  window._cartToastTimer = setTimeout(function () { toast.classList.remove('show'); }, 2200);
}


document.querySelectorAll('form[action$="/cart"]').forEach(function (form) {
  var actionInput = form.querySelector('input[name="action"]');
  if (!actionInput || actionInput.value !== 'add') return; // only "+" forms

  var stepper = form.closest('.qty-stepper');
  var menuId = stepper ? stepper.dataset.menuId : null;
  var qtyEl = stepper ? stepper.querySelector('.qty-value') : null;
  var minusBtn = stepper ? stepper.querySelector('.qty-minus') : null;

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    e.stopPropagation();
    var formData = new FormData(form);
    console.log('Submitting to cart:', form.getAttribute('action'), Object.fromEntries(formData));
    fetch(form.getAttribute('action'), { method: 'POST', body: formData })
      .then(function (res) { return res.text(); })
      .then(function (text) {
        var lines = text.trim().split('\n');
        if (lines[0] === 'conflict') {
          document.getElementById('forceAddMenuID').value = formData.get('menuID');
          document.getElementById('cartConflictModal').classList.add('open');
        } else if (lines[0] === 'success') {
          if (menuId) {
            quantities[menuId] = (quantities[menuId] || 0) + 1;
            if (qtyEl) { qtyEl.textContent = quantities[menuId]; qtyEl.style.display = 'inline'; }
            if (minusBtn) { minusBtn.style.display = 'inline-flex'; }
          }
          updateCartBadge(lines[1]);
          showCartToast('Added to your cart');
          pulseCartIcon();
        }
      })
      .catch(function (err) { console.error('Add to cart failed', err); });
  });

  if (minusBtn) {
    minusBtn.addEventListener('click', function (e) {
      e.preventDefault();
      if (!quantities[menuId]) return;
      var formData = new FormData();
      formData.append('menuID', menuId);
      formData.append('restaurantId', form.querySelector('[name="restaurantId"]').value);
      formData.append('action', 'decrease');
      fetch(form.getAttribute('action'), { method: 'POST', body: formData })
        .then(function (res) { return res.text(); })
        .then(function (text) {
          var lines = text.trim().split('\n');
          if (lines[0] === 'success') {
            quantities[menuId] -= 1;
            if (quantities[menuId] <= 0) {
              quantities[menuId] = 0;
              qtyEl.style.display = 'none';
              minusBtn.style.display = 'none';
            } else {
              qtyEl.textContent = quantities[menuId];
            }
            updateCartBadge(lines[1]);
          }
        });
    });
  }
});

function confirmCartConflict() {
	  var form = document.getElementById('forceAddForm');
	  var menuId = document.getElementById('forceAddMenuID').value;

	  fetch(form.getAttribute('action'), { method: 'POST', body: new FormData(form) })
	    .then(function (res) { return res.text(); })
	    .then(function (text) {
	      closeCartConflictModal();
	      var lines = text.trim().split('\n');
	      if (lines[0] === 'success') {
	        // update in-memory quantity + this item's stepper UI
	        quantities[menuId] = 1;
	        var stepper = document.querySelector('.qty-stepper[data-menu-id="' + menuId + '"]');
	        if (stepper) {
	          var qtyEl = stepper.querySelector('.qty-value');
	          var minusBtn = stepper.querySelector('.qty-minus');
	          if (qtyEl) { qtyEl.textContent = 1; qtyEl.style.display = 'inline'; }
	          if (minusBtn) { minusBtn.style.display = 'inline-flex'; }
	        }

	        updateCartBadge(lines[1]);
	        showCartToast('New order started');
	        pulseCartIcon();
	      }
	    });
	}
var quantities = {
		<%
		    boolean first = true;
		    for (Map.Entry<Integer, Integer> entry : cartQuantities.entrySet()) {
		        if (!first) out.print(",");
		        out.print(entry.getKey() + ": " + entry.getValue());
		        first = false;
		    }
		%>
		};
</script>

</body>
</html>
