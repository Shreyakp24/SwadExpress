<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.tap.model.Cart,com.tap.model.User, com.tap.model.Address, com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Secure Checkout | SwadExpress</title>
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

  /* ---------- TOP BAR ---------- */

  .brand { display: flex; align-items: center; gap: 10px; }
  .brand-mark {
    width: 40px; height: 40px; border-radius: 11px;
    background: var(--color-red);
    display: flex; align-items: center; justify-content: center;
    font-family: var(--font-display); font-weight: 800; font-size: 19px; color: var(--color-white);
  }
  .brand-label {
    font-family: var(--font-display); font-weight: 700; font-size: 13px;
    letter-spacing: 0.08em; text-transform: uppercase; color: var(--color-gray);
  }
  .nav-right { display: flex; align-items: center; gap: 26px; }
  .nav-link { display: flex; align-items: center; gap: 7px; font-size: 14px; font-weight: 600; color: var(--color-gray); }
  .nav-link svg { width: 17px; height: 17px; stroke: currentColor; }
  .nav-user { display: flex; align-items: center; gap: 9px; font-size: 14px; font-weight: 600; }
  .nav-user .avatar-chip {
    width: 30px; height: 30px; border-radius: 50%;
    background: var(--color-blush); border: 1px solid var(--color-border);
    display: flex; align-items: center; justify-content: center;
    font-size: 13px; font-weight: 700; color: var(--color-red);
  }

  /* ---------- LAYOUT ---------- */
  .checkout-layout {
    display: grid;
    grid-template-columns: 1fr 360px;
    gap: 32px;
    padding: 40px 0 96px;
    align-items: start;
  }

  /* ---------- STEP BLOCKS ---------- */
  .step-block { display: flex; gap: 18px; }
  .step-rail-line {
    width: 2px; background: var(--color-border);
    margin: 4px 0; margin-left: 16px;
    min-height: 24px;
  }
  .step-marker {
    width: 34px; height: 34px; border-radius: 50%; flex-shrink: 0;
    background: var(--color-red); color: var(--color-white);
    display: flex; align-items: center; justify-content: center;
    font-size: 15px;
    transition: background 0.2s ease, border-color 0.2s ease, color 0.2s ease;
  }
  .step-marker.done { background: var(--color-maroon); border: 1px solid var(--color-green); color: var(--color-green); }
  .step-marker.pending { background: var(--color-maroon); border: 1px solid var(--color-border); color: var(--color-gray); }
  .step-marker svg { width: 16px; height: 16px; stroke: currentColor; }

  /* ---------- PANELS ---------- */
  .panel {
    background: var(--color-blush);
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 26px 30px;
    width: 100%;
  }

  .panel-title-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 4px; }
  .panel-title-row h2 { font-size: 18px; font-weight: 700; display: flex; align-items: center; gap: 10px; }
  .panel-title-row h2 svg { width: 19px; height: 19px; stroke: var(--color-green); }
  .panel-sub { margin: 4px 0 0; font-size: 13px; color: var(--color-gray); }
  .change-link { font-size: 13px; font-weight: 700; color: var(--color-red); cursor: pointer; }
  .change-link:hover { color: var(--color-red-dark); }

  /* --- Step 1: address grid --- */
  .address-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    margin-top: 22px;
  }

  .address-card {
    border: 1px solid var(--color-border);
    border-radius: 12px;
    padding: 20px;
    background: var(--color-maroon);
    display: flex;
    flex-direction: column;
    position: relative;
    transition: border-color 0.15s ease;
  }
  .address-card:hover { border-color: rgba(255,122,26,0.5); }
  .address-card.is-default { border-color: var(--color-red); }

  .default-tag {
    position: absolute; top: 16px; right: 16px;
    font-size: 10px; font-weight: 700; letter-spacing: 0.04em; text-transform: uppercase;
    color: var(--color-red); border: 1px solid var(--color-red);
    padding: 3px 9px; border-radius: 999px;
  }

  .address-label-row { display: flex; align-items: center; gap: 9px; margin-bottom: 10px; }
  .address-label-row svg { width: 18px; height: 18px; stroke: var(--color-red); flex-shrink: 0; }
  .address-label-row h3 { font-size: 15px; font-weight: 700; }

  .address-text {
    font-size: 13px; line-height: 1.55; color: var(--color-gray);
    margin: 0 0 14px; flex: 1;
  }

  .eta-row {
    font-size: 12px; font-weight: 700; color: var(--color-ink);
    letter-spacing: 0.02em; margin-bottom: 16px;
    display: flex; align-items: center; gap: 6px;
  }
  .eta-row svg { width: 14px; height: 14px; stroke: var(--color-gray); }

  .btn-deliver {
    width: 100%;
    background: var(--color-red);
    color: var(--color-white);
    border: none; border-radius: 8px;
    padding: 11px; font-size: 13px; font-weight: 700;
    letter-spacing: 0.03em; text-transform: uppercase;
    cursor: pointer;
  }
  .btn-deliver:hover { background: var(--color-red-dark); }

  .address-card.add-new {
    border-style: dashed;
    align-items: flex-start;
    justify-content: flex-start;
    background: transparent;
  }
  .btn-add-new {
    background: transparent;
    color: var(--color-red);
    border: 1px solid var(--color-red);
    border-radius: 8px;
    padding: 11px 18px; font-size: 13px; font-weight: 700;
    letter-spacing: 0.03em; text-transform: uppercase;
    cursor: pointer; width: 100%; margin-top: auto;
  }
  .btn-add-new:hover { background: var(--color-red); color: var(--color-white); }

  /* --- Step 1, collapsed/confirmed state --- */
  .address-confirmed-summary { display: none; }
  .address-confirmed-summary.show { display: block; margin-top: 16px; }
  .address-name { font-size: 15px; font-weight: 700; margin-bottom: 6px; }
  .address-detail { font-size: 13px; color: var(--color-gray); line-height: 1.6; margin-bottom: 10px; }

  /* --- Step 2: payment trigger --- */
  .step-two-wrap { margin-top: 20px; transition: opacity 0.25s ease; }
  .step-two-wrap.locked { opacity: 0.45; pointer-events: none; }

  .btn-proceed {
    width: 100%;
    background: var(--color-red);
    color: var(--color-white);
    border: none; border-radius: 10px;
    padding: 16px; font-size: 15px; font-weight: 700;
    letter-spacing: 0.03em; text-transform: uppercase;
    cursor: pointer; margin-top: 18px;
  }
  .btn-proceed:hover { background: var(--color-red-dark); }
  .btn-proceed:disabled { cursor: not-allowed; }

  .locked-hint { font-size: 12px; color: var(--color-gray); margin-top: 4px; }

  /* ---------- ORDER SUMMARY (SIDE) ---------- */
  .summary-panel {
    background: var(--color-blush);
    border: 1px solid var(--color-border);
    border-radius: 16px;
    padding: 24px;
    position: sticky;
    top: 24px;
  }
  .summary-restaurant { display: flex; gap: 12px; align-items: center; margin-bottom: 18px; }
  .summary-restaurant img {
    width: 54px; height: 54px; border-radius: 10px; object-fit: cover; flex-shrink: 0;
  }
  .summary-restaurant h4 { font-size: 15px; font-weight: 700; margin-bottom: 2px; }
  .summary-restaurant span { font-size: 12px; color: var(--color-gray); }
  .summary-divider { border-top: 1px solid var(--color-border); margin: 6px 0 16px; }

  .summary-item-row {
    display: flex; align-items: center; justify-content: space-between;
    gap: 12px; margin-bottom: 18px;padding: 12px 0;border-bottom: 1px solid var(--color-border);
  }

  .summary-item-name { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 600; align-items:center;}

  .veg-mark {
    width: 14px; height: 14px; border: 1.5px solid var(--color-red); border-radius: 3px;
    display: inline-flex; align-items: center; justify-content: center; flex-shrink: 0;
  }
  .veg-mark::after { content: ""; width: 6px; height: 6px; border-radius: 50%; background: var(--color-red); }

  .stepper-pill {
    display: inline-flex; align-items: center; gap: 14px;
    background: var(--color-maroon); border: 1px solid var(--color-border);
    border-radius: 999px; padding: 6px 14px;
  }
  .stepper-pill button {
    background: transparent; border: none; color: var(--color-red);
    font-size: 15px; font-weight: 700; cursor: pointer; padding: 0;
    width: 16px; height: 16px; display: flex; align-items: center; justify-content: center;
  }
  .qty-num{
    display: inline-block;
    width: fit-content;

    margin-top: 8px;
    padding: 5px 12px;

    border: 1px solid var(--color-border);
    border-radius: 999px;

    background: var(--color-maroon);

    color: var(--color-white);
    font-size: 12px;
    font-weight: 600;

    text-align: center;
}

  .summary-item-price { font-size: 14px; min-width: 48px; text-align: right; font-weight:bold;
    white-space:nowrap;}

  .suggestion-box {
    background: var(--color-maroon);
    border: 1px solid var(--color-border);
    border-radius: 10px;
    padding: 13px 16px;
    font-size: 13px; color: var(--color-gray);
    margin-bottom: 18px;
  }

  .contact-check {
    display: flex; gap: 12px; align-items: flex-start;
    border: 1px solid var(--color-border); border-radius: 10px;
    padding: 14px 16px; margin-bottom: 18px;
  }
  .contact-check input[type="checkbox"] { margin-top: 2px; accent-color: var(--color-red); width: 16px; height: 16px; flex-shrink: 0; }
  .contact-check .cc-title { font-size: 13px; font-weight: 700; margin-bottom: 3px; }
  .contact-check .cc-sub { font-size: 12px; color: var(--color-gray); line-height: 1.5; }

  .coupon-box {
    display: flex; align-items: center; gap: 10px;
    border: 1px dashed var(--color-border); border-radius: 10px;
    padding: 13px 16px; margin-bottom: 22px;
    font-size: 13px; font-weight: 700; color: var(--color-red);
    cursor: pointer;
  }
  .coupon-box svg { width: 17px; height: 17px; stroke: var(--color-red); flex-shrink: 0; }

  .bill-details h4 {
    font-size: 12px; text-transform: uppercase; letter-spacing: 0.05em;
    color: var(--color-gray); margin-bottom: 12px; font-weight: 700;
  }
  .bill-row { display: flex; justify-content: space-between; font-size: 13px; color: var(--color-gray); margin-bottom: 10px; }
  .bill-row span:last-child { color: var(--color-ink); font-weight: 600; }
  .bill-row .info-dot {
    display: inline-flex; width: 13px; height: 13px; border-radius: 50%;
    border: 1px solid var(--color-gray); align-items: center; justify-content: center;
    font-size: 9px; margin-left: 5px; vertical-align: middle;
  }

  .bill-total {
    display: flex; justify-content: space-between; align-items: center;
    border-top: 1px solid var(--color-border); padding-top: 14px; margin-top: 4px;
  }
  .bill-total span:first-child { font-size: 15px; font-weight: 700; }
  .bill-total span:last-child { font-size: 18px; font-weight: 800; color: var(--color-red); }

  @media (max-width: 900px) {
    .wrap { padding: 0 20px; }
    .checkout-layout { grid-template-columns: 1fr; }
    .address-grid { grid-template-columns: 1fr; }
    .nav-link span { display: none; }
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
  .nav-icon-group { display: flex; align-items: center; gap: 10px; }

.summary-left{
    display:flex;
    flex-direction:column;
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
        
        <a class="icon-btn active" href="<%=request.getContextPath()%>/cart" aria-label="Cart">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="9" cy="21" r="1"></circle>
            <circle cx="20" cy="21" r="1"></circle>
            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
          </svg>
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

  <div class="wrap">
    <div class="checkout-layout">
      <div>
        <!-- ============ STEP 1: DELIVERY ADDRESS ============ -->
        <div class="step-block">
          <div>
            <div class="step-marker" id="step1Marker">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
            </div>
            <div class="step-rail-line"></div>
          </div>

          <div class="panel" style="margin-bottom: 20px;">

            <!-- header row: switches between "choose address" and "confirmed address + change" -->
            <div class="panel-title-row">
              <h2 id="step1Title">Choose a delivery address</h2>
              <a class="change-link" id="changeAddressLink" style="display:none;" onclick="showAddressGrid()">Change</a>
            </div>
            <p class="panel-sub" id="step1Sub">Multiple addresses in this location</p>

            <!-- grid of selectable addresses -->
<%
    List<Address> userAddresses = (List<Address>) request.getAttribute("userAddresses");
    if (userAddresses == null) userAddresses = new java.util.ArrayList<Address>();
%>

<div class="address-grid" id="addressGrid">

<%
    for (Address addr : userAddresses) {
%>
    <div class="address-card <%= addr.isDefault() ? "is-default" : "" %>">
        <% if (addr.isDefault()) { %>
            <span class="default-tag">Default</span>
        <% } %>
        <div class="address-label-row">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
            <h3><%= addr.getLabel() %></h3>
        </div>
        <p class="address-text">
            <%= addr.getFullAddress() %>
        </p>
        <div class="eta-row">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
            35 mins
        </div>
        <button class="btn-deliver" onclick="confirmAddress(
            '<%= addr.getLabel().replace("'", "\\'") %>',
            '<%= addr.getFullAddress().replace("'", "\\'") %>',
            '35 mins',
            <%= addr.getAddressID() %>
        )">Deliver here</button>
    </div>
<%
    }

    if (userAddresses.size() < 4) {
%>
    <div class="address-card add-new">
        <div class="address-label-row">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><line x1="12" y1="7" x2="12" y2="13"></line><line x1="9" y1="10" x2="15" y2="10"></line></svg>
            <h3>Add New Address</h3>
        </div>
        <p class="address-text">
            Add a new delivery address to your account.
        </p>
        <button class="btn-add-new" onclick="showAddAddressForm()">Add new</button>
    </div>
<%
    }
%>

</div>

<!-- inline "add new address" form, toggled in place of the grid -->
<div class="address-add-form" id="addAddressForm" style="display:none;">
    <form action="<%=request.getContextPath()%>/checkout" method="post">
        <input type="hidden" name="action" value="addAddress">

        <label style="display:block; font-size:13px; margin-bottom:6px; color:var(--color-gray);">Address Label (e.g. Home, Office, College)</label>
        <input type="text" name="label" required maxlength="50"
               style="width:100%; padding:10px; margin-bottom:16px; border-radius:8px; border:1px solid var(--color-border); background:var(--color-maroon); color:var(--color-ink); font-size:14px;">

        <label style="display:block; font-size:13px; margin-bottom:6px; color:var(--color-gray);">Full Address</label>
        <textarea name="fullAddress" rows="3" required maxlength="500"
                  style="width:100%; padding:10px; margin-bottom:16px; border-radius:8px; border:1px solid var(--color-border); background:var(--color-maroon); color:var(--color-ink); font-size:14px;"></textarea>

        <label style="display:flex; align-items:center; gap:8px; font-size:13px; color:var(--color-gray); margin-bottom:18px;">
            <input type="checkbox" name="isDefault" value="true" style="width:auto; accent-color:var(--color-red);">
            Set as default address
        </label>

        <div style="display:flex; gap:10px;">
            <button type="button" class="btn-add-new" style="flex:1;" onclick="cancelAddAddress()">Cancel</button>
            <button type="submit" class="btn-deliver" style="flex:1;">Save Address</button>
        </div>
    </form>
</div>

            <!-- confirmed address summary, shown after "Deliver here" is clicked -->
            <div class="address-confirmed-summary" id="confirmedSummary">
              <div class="address-name" id="confirmedName"></div>
              <p class="address-detail" id="confirmedDetail"></p>
              <div class="eta-row">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                <span id="confirmedEta"></span>
              </div>
            </div>
			<input type="hidden" id="selectedAddressID" value="">
          </div>
        </div>

        <!-- ============ STEP 2: PAYMENT TRIGGER ============ -->
        <div class="step-block">
          <div>
            <div class="step-marker pending" id="step2Marker">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="4" width="22" height="16" rx="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
            </div>
          </div>
          <div class="panel step-two-wrap locked" id="step2Panel">
            <div class="panel-title-row">
              <h2>Choose payment method</h2>
            </div>
            <p class="locked-hint" id="lockedHint">Select a delivery address above to continue.</p>
            <form id="proceedForm" action="<%=request.getContextPath()%>/payment" method="get">
    <input type="hidden" name="addressID" id="proceedAddressID">
    <button type="button" class="btn-proceed" id="proceedBtn" disabled onclick="submitProceed()">Proceed to Pay</button>
</form>
          </div>
        </div>

      </div>

<!-- ============ ORDER SUMMARY (SIDE) ============ -->
<aside class="summary-panel">
<%
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");    
if (cartItems != null && !cartItems.isEmpty() && restaurant!=null) {
%>
    <div class="summary-restaurant">
        <img src="<%=restaurant.getImage()%>" alt="<%=restaurant.getRestaurantName()%>">
        <div>
            <h4><%=restaurant.getRestaurantName()%></h4>
        </div>
    </div>
    <div class="summary-divider"></div>

<%
        for (Cart c : cartItems) {
%>
<div class="summary-item-row">

    <div class="summary-left">

        <div class="summary-item-name">
            <span class="veg-mark"></span>
            <%=c.getItemName()%>
        </div>

        <div class="qty-num">
            Quantity: <%=c.getQuantity()%>
        </div>

    </div>

    <div class="summary-item-price">
        ₹<%=String.format("%.2f", c.getLineTotal())%>
    </div>

</div>
<%
        }
%>

    <div class="suggestion-box">
        "&nbsp;Any suggestions? We will pass it on...&nbsp;"
    </div>

    <label class="contact-check">
        <input type="checkbox">
        <span>
            <div class="cc-title">Opt in for No-contact Delivery</div>
            <div class="cc-sub">Unwell, or avoiding contact? Please select no-contact delivery. Partner will safely place the order outside your door (not for COD)</div>
        </span>
    </label>

    <div class="coupon-box">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.59 13.41 13.42 20.58a2 2 0 0 1-2.83 0L2 12.01V2h10.01l8.58 8.58a2 2 0 0 1 0 2.83z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
        Apply Coupon
    </div>

    <div class="bill-details">
        <h4>Bill Details</h4>
        <div class="bill-row"><span>Item Total</span><span>₹<%=String.format("%.2f", subtotal)%></span></div>
        <div class="bill-row"><span>Delivery Fee | 8.0 kms<span class="info-dot">i</span></span><span>₹<%=String.format("%.2f", deliveryFee)%></span></div>
        <div class="bill-row"><span>GST &amp; Other Charges<span class="info-dot">i</span></span><span>₹<%=String.format("%.2f", tax)%></span></div>
        <div class="bill-total"><span>To Pay</span><span>₹<%=String.format("%.2f", total)%></span></div>
    </div>
<%
    } else {
%>
    <p style="color:var(--color-gray); font-size:14px;">Your cart is empty.</p>
<%
    }
%>
</aside>

    </div>
  </div>

<script>

  // ---------- step 1 -> step 2 flow, all on this one page ----------
  function confirmAddress(name, detail, eta, addressID) {
    // fill in the confirmed summary
    document.getElementById('selectedAddressID').value = addressID;
    document.getElementById('confirmedName').textContent = name;
    document.getElementById('confirmedDetail').textContent = detail;
    document.getElementById('confirmedEta').textContent = eta;

    // swap step 1 from "grid" view to "confirmed" view
    document.getElementById('addressGrid').style.display = 'none';
    document.getElementById('confirmedSummary').classList.add('show');
    document.getElementById('step1Title').textContent = 'Delivery address';
    document.getElementById('step1Sub').style.display = 'none';
    document.getElementById('changeAddressLink').style.display = 'inline';

    // mark step 1 as done
    var marker1 = document.getElementById('step1Marker');
    marker1.classList.remove('pending');
    marker1.classList.add('done');
    marker1.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>';

    // unlock step 2
    var marker2 = document.getElementById('step2Marker');
    marker2.classList.remove('pending');
    marker2.classList.add('done');

    document.getElementById('step2Panel').classList.remove('locked');
    document.getElementById('lockedHint').style.display = 'none';
    document.getElementById('proceedBtn').disabled = false;

    // scroll the payment section into view, since it appeared below
    document.getElementById('step2Panel').scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  function showAddressGrid() {
    // re-open the grid so the user can pick a different address
    document.getElementById('addressGrid').style.display = 'grid';
    document.getElementById('confirmedSummary').classList.remove('show');
    document.getElementById('step1Title').textContent = 'Choose a delivery address';
    document.getElementById('step1Sub').style.display = 'block';
    document.getElementById('changeAddressLink').style.display = 'none';

    var marker1 = document.getElementById('step1Marker');
    marker1.classList.remove('done');
    marker1.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>';

    // re-lock step 2 until a new address is confirmed
    var marker2 = document.getElementById('step2Marker');
    marker2.classList.remove('done');
    marker2.classList.add('pending');

    document.getElementById('step2Panel').classList.add('locked');
    document.getElementById('lockedHint').style.display = 'block';
    document.getElementById('proceedBtn').disabled = true;
  }
  function showAddAddressForm() {
	    document.getElementById('addressGrid').style.display = 'none';
	    document.getElementById('addAddressForm').style.display = 'block';
	}

	function cancelAddAddress() {
	    document.getElementById('addAddressForm').style.display = 'none';
	    document.getElementById('addressGrid').style.display = 'grid';
	}
	function submitProceed() {
	    var addressID = document.getElementById('selectedAddressID').value;
	    document.getElementById('proceedAddressID').value = addressID;
	    document.getElementById('proceedForm').submit();
	}
</script>

</body>
</html>
