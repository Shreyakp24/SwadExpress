<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List,com.tap.model.Cart,com.tap.model.User, com.tap.model.Address, com.tap.model.Restaurant"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment | SwadExpress</title>
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

  /* header uses the wide wrap, matching every other page in the app */
  .wrap { max-width: 1240px; margin: 0 auto; padding: 0 40px; }

  /* page content stays narrower, like a checkout column */
  .content-wrap { max-width: 640px; margin: 0 auto; padding: 0 40px; }

  h1, h2, h3, h4 { font-family: var(--font-display); margin: 0; }

  /* ---------- NAV ---------- */
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

  /* ---------- HEADER ROW ---------- */
  .page-head {
    display: flex; align-items: flex-start; gap: 5px;
    padding: 32px 0 22px;flex-direction: column;
  }
  
  .page-head h2 { font-size: 20px; font-weight: 700; margin-bottom: 4px; }
  .page-head p { margin: 0; font-size: 13px; color: var(--color-gray); }

  /* ---------- ORDER STRIP ---------- */
  .order-strip {
    display: flex; gap: 12px; margin-bottom: 22px; padding-left: 4px;
  }
  .order-strip-rail { display: flex; flex-direction: column; align-items: center; padding-top: 4px; }
  .rail-dot { width: 9px; height: 9px; border-radius: 50%; background: var(--color-red); flex-shrink: 0; }
  .rail-line { width: 2px; flex: 1; background: var(--color-border); margin: 4px 0; }
  .order-strip-text { font-size: 13px; line-height: 1.9; }
  .order-strip-text .restaurant-line { font-weight: 700; }
  .order-strip-text .restaurant-line .muted { font-weight: 500; color: var(--color-gray); }
  .order-strip-text .address-line { color: var(--color-gray); }
  .order-strip-text .address-line strong { color: var(--color-ink); font-weight: 700; }

  /* ---------- SECTION LABEL ---------- */
  .pay-section-label {
    display: flex; align-items: center; gap: 10px;
    font-size: 20px; font-weight: bold;
    color: var(--color-ink);
    margin-bottom: 16px;
  }
  
  /* ---------- PAYMENT OPTIONS — stacked, one below the other ---------- */
  .pay-option-list {
    display: flex;
    flex-direction: column;
    gap: 14px;
    margin-bottom: 28px;
  }

  .pay-option {
    display: flex; align-items: center; gap: 16px;
    background: var(--color-blush);
    border: 1px solid var(--color-border);
    border-radius: 14px;
    padding: 18px 20px;
    cursor: pointer;
    transition: border-color 0.15s ease, background 0.15s ease;
  }
  .pay-option:hover { border-color: rgba(255,122,26,0.5); }
  .pay-option.selected {
    border-color: var(--color-red);
    background: rgba(255,122,26,0.08);
  }

  .pay-option .icon-box {
    width: 42px; height: 42px; border-radius: 10px;
    background: var(--color-maroon);
    border: 1px solid var(--color-border);
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
  }
  .pay-option .icon-box svg { width: 20px; height: 20px; stroke: var(--color-gray); }
  .pay-option.selected .icon-box { border-color: var(--color-red); }
  .pay-option.selected .icon-box svg { stroke: var(--color-red); }

  .pay-option .pay-copy { flex: 1; }
  .pay-option .pay-title { font-size: 15px; font-weight: 700; margin-bottom: 3px; }
  .pay-option .pay-sub { font-size: 12px; color: var(--color-gray); }

  .radio-dot {
    width: 20px; height: 20px; border-radius: 50%;
    border: 2px solid var(--color-border);
    flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
  }
  .radio-dot.selected { border-color: var(--color-red); }
  .radio-dot.selected::after {
    content: ""; width: 10px; height: 10px; border-radius: 50%; background: var(--color-red);
  }

  .btn-pay-now {
    width: 100%;
    background: var(--color-green);
    color: var(--color-white);
    border: none; border-radius: 12px;
    padding: 16px; font-size: 15px; font-weight: 700;
    letter-spacing: 0.03em; text-transform: uppercase;
    cursor: pointer;
    margin-bottom: 60px;
  }
  .btn-pay-now:hover { opacity: 0.92; }
  .btn-pay-now:disabled { opacity: 0.5; cursor: not-allowed; }

  /* ---------- CONFIRM MODAL ---------- */
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
  .modal-btn {
    padding: 10px 20px; border-radius: 999px; font-size: 14px; font-weight: 600;
    cursor: pointer; border: 2px solid transparent; font-family: var(--font-body);
  }
  .modal-btn-outline { background: transparent; color: var(--color-ink); border-color: var(--color-border); }
  .modal-btn-outline:hover { border-color: var(--color-red); color: var(--color-red); }
  .modal-btn-filled { background: var(--color-red); color: var(--color-white); }
  .modal-btn-filled:hover { background: var(--color-red-dark); }

  @media (max-width: 640px) {
    .wrap, .content-wrap { padding: 0 20px; }
    .back-link span { display: none; }
  }
</style>
</head>
<body>

  <header class="site-nav">
    <div class="wrap">
      <a class="brand">
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
	<%
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
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
  <div class="content-wrap">

	<% if (cartItems != null && !cartItems.isEmpty() && restaurant != null) { %>
    <div class="page-head">
        <h2>Payment Options</h2>
        <p id="orderMeta"><%=totalQty%> item<%=(totalQty == 1 ? "" : "s")%> • Total: ₹<%=String.format("%.2f", total)%></p>
      </div>

    <div class="order-strip">
      <div class="order-strip-rail">
        <span class="rail-dot"></span>
        <span class="rail-line"></span>
        <span class="rail-dot" style="background: var(--color-gray);"></span>
      </div>
      <div class="order-strip-text">
        <div class="restaurant-line"><%=restaurant.getRestaurantName()%> <span class="muted">| Delivery in: 50 mins</span></div>
        <div class="address-line">
                <% if (defaultAddress != null) { %>
                    <strong><%=defaultAddress.getLabel()%></strong> | <%=defaultAddress.getFullAddress()%>
                <% } else { %>
                    <strong>No address selected</strong>
                <% } %>
            </div>
      	</div>
      </div>
      <% } else { %>
    <div class="page-head">
        <div>
            <h2>Payment Options</h2>
            <p>Your cart is empty.</p>
        </div>
    </div>

<% } %>
    <div class="pay-section-label">
      Payment Method
    </div>

    <div class="pay-option-list" id="payOptionList">

      <div class="pay-option" data-method="UPI" onclick="selectPayment(this)">
        <div class="icon-box">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-6l-2 3h-4l-2-3H2"></path><path d="M5.45 5.11 2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.45-6.89A2 2 0 0 0 16.76 4H7.24a2 2 0 0 0-1.79 1.11z"></path></svg>
        </div>
        <div class="pay-copy">
          <div class="pay-title">UPI Payment</div>
          <div class="pay-sub">Google Pay, PhonePe, Paytm or other UPI apps</div>
        </div>
        <div class="radio-dot"></div>
      </div>

      <div class="pay-option" data-method="CARD" onclick="selectPayment(this)">
        <div class="icon-box">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="4" width="22" height="16" rx="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
        </div>
        <div class="pay-copy">
          <div class="pay-title">Card Payment</div>
          <div class="pay-sub">Credit card or debit card</div>
        </div>
        <div class="radio-dot"></div>
      </div>

      <div class="pay-option" data-method="COD" onclick="selectPayment(this)">
        <div class="icon-box">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
        </div>
        <div class="pay-copy">
          <div class="pay-title">Cash on Delivery</div>
          <div class="pay-sub">Pay when your food is delivered</div>
        </div>
        <div class="radio-dot"></div>
      </div>

      <div class="pay-option" data-method="NETBANKING" onclick="selectPayment(this)">
        <div class="icon-box">
          <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21h18"></path><path d="M5 21V9l7-5 7 5v12"></path><path d="M9 21v-6h6v6"></path></svg>
        </div>
        <div class="pay-copy">
          <div class="pay-title">Net Banking</div>
          <div class="pay-sub">Pay directly using your bank account</div>
        </div>
        <div class="radio-dot"></div>
      </div>

    </div>

    <button class="btn-pay-now" id="payNowBtn" disabled onclick="openConfirmModal()">Pay Now</button>

  </div>

  <!-- ============ PAYMENT CONFIRMATION MODAL ============ -->
  <div class="modal-overlay" id="confirmModal">
    <div class="modal-box">
      <h3>Confirm Payment</h3>
      <p>Do you really want to make the payment via <span id="confirmMethodName">this method</span>?</p>
      <div class="modal-actions">
        <button type="button" class="modal-btn modal-btn-outline" onclick="closeConfirmModal()">No</button>
       <button type="button" class="modal-btn modal-btn-filled" onclick="proceedPayment()">Yes</button>
      </div>
    </div>
  </div>

<script>
  var selectedMethod = null;

  function selectPayment(el) {
    document.querySelectorAll('.pay-option').forEach(function (opt) {
      opt.classList.remove('selected');
      opt.querySelector('.radio-dot').classList.remove('selected');
    });
    el.classList.add('selected');
    el.querySelector('.radio-dot').classList.add('selected');

    selectedMethod = el.getAttribute('data-method');
    document.getElementById('payNowBtn').disabled = false;
  }

  function openConfirmModal() {
    if (!selectedMethod) return;

    var labels = {
      UPI: 'UPI',
      CARD: 'Card Payment',
      COD: 'Cash on Delivery',
      NETBANKING: 'Net Banking'
    };
    document.getElementById('confirmMethodName').textContent = labels[selectedMethod] || 'this method';
    document.getElementById('confirmModal').classList.add('open');
  }

  function closeConfirmModal() {
    document.getElementById('confirmModal').classList.remove('open');
  }

  function proceedPayment() {
	    closeConfirmModal();

	    var form = document.createElement('form');
	    form.method = 'POST';
	    form.action = '<%=request.getContextPath()%>/orderconfirmed';

	    var actionInput = document.createElement('input');
	    actionInput.type = 'hidden';
	    actionInput.name = 'action';
	    actionInput.value = 'placeOrder';
	    form.appendChild(actionInput);

	    var methodInput = document.createElement('input');
	    methodInput.type = 'hidden';
	    methodInput.name = 'method';
	    methodInput.value = selectedMethod;
	    form.appendChild(methodInput);

	    var addressInput = document.createElement('input');
	    addressInput.type = 'hidden';
	    addressInput.name = 'addressID';
	    addressInput.value = '<%=defaultAddress != null ? defaultAddress.getAddressID() : ""%>';
	    form.appendChild(addressInput);

	    document.body.appendChild(form);
	    form.submit();
	}
</script>

</body>
</html>

