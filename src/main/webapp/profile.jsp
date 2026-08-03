<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User, com.tap.model.Address, java.util.List, com.tap.model.OrderTable, com.tap.model.OrderItem, com.tap.model.Restaurant,java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Account Settings | SwadExpress</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<style>
:root {
	--color-red: #ff7a1a;
	--color-red-dark: #e35f00;
	--color-maroon: #1a0f05;
	--color-blush: #24160a;
	--color-ink: #f3efe9;
	--color-gray: #b3aca3;
	--color-border: rgba(255, 255, 255, 0.14);
	--color-white: #fff6ee;
	--color-bg: #0d0d0d;
	--color-green: #4fae6a;
	--font-display: 'Poppins', Arial, sans-serif;
	--font-body: 'Inter', Arial, sans-serif;
}

* {
	box-sizing: border-box;
}

html {
	scroll-behavior: smooth;
}

html, body {
	margin: 0;
	padding: 0;
	background: var(--color-bg);
	color: var(--color-ink);
	font-family: var(--font-body);
}

a {
	color: inherit;
	text-decoration: none;
}

img {
	max-width: 100%;
	display: block;
}

ul {
	margin: 0;
	padding: 0;
	list-style: none;
}

button {
	font-family: var(--font-body);
}

input {
	font-family: var(--font-body);
}

.wrap {
	max-width: 1240px;
	margin: 0 auto;
	padding: 0 40px;
}

h1, h2, h3, h4 {
	font-family: var(--font-display);
	margin: 0;
}

/* ---------- MINI NAV (matches restaurant/menu pages) ---------- */
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
	height: 44px;
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

.back-link:hover {
	color: var(--color-red);
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
}

.icon-btn:hover {
	background: var(--color-red);
	border-color: var(--color-red);
	color: var(--color-white);
}

.icon-btn.active {
	background: var(--color-red);
	border-color: var(--color-red);
	color: var(--color-white);
}

.icon-btn svg {
	width: 18px;
	height: 18px;
	stroke: currentColor;
}

.nav-icon-group {
	display: flex;
	align-items: center;
	gap: 12px;
}

.nav-divider {
	width: 1px;
	height: 28px;
	background: rgba(255, 255, 255, 0.35);
}

/* ---------- BUTTONS ---------- */
.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	font-weight: 600;
	font-size: 14px;
	padding: 11px 22px;
	border-radius: 999px;
	cursor: pointer;
	border: 2px solid transparent;
	white-space: nowrap;
}

.btn-filled-red {
	background: var(--color-red);
	color: var(--color-white);
}

.btn-filled-red:hover {
	background: var(--color-red-dark);
}

.btn-outline {
	background: transparent;
	color: var(--color-ink);
	border-color: var(--color-border);
}

.btn-outline:hover {
	border-color: var(--color-red);
	color: var(--color-red);
}

.btn-text-red {
	background: none;
	border: none;
	color: var(--color-red);
	font-weight: 600;
	font-size: 14px;
	cursor: pointer;
	padding: 0;
}

.btn-text-red:hover {
	color: var(--color-red-dark);
}

.btn-small {
	padding: 8px 16px;
	font-size: 13px;
}

/* ---------- PAGE HEADER ---------- */
.page-heading {
	padding: 48px 0 8px;
}

.page-heading h1 {
	font-size: 30px;
	font-weight: 800;
	letter-spacing: -0.01em;
}

/* ---------- LAYOUT ---------- */
.layout {
	display: grid;
	grid-template-columns: 260px 1fr;
	gap: 48px;
	align-items: start;
	padding: 32px 0 96px;
}

/* ---------- SIDEBAR ---------- */
.sidebar {
	position: sticky;
	top: 24px;
}

.profile-card {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 28px;
	padding-bottom: 24px;
	border-bottom: 1px solid var(--color-border);
}

.avatar-md {
	width: 48px;
	height: 48px;
	border-radius: 50%;
	flex-shrink: 0;
	overflow: hidden;
	background: #2c1607;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: var(--font-display);
	font-weight: 700;
	font-size: 17px;
	color: var(--color-white);
}

.profile-card-name {
	font-size: 15px;
	font-weight: 700;
}

.profile-card-email {
	font-size: 12px;
	color: var(--color-gray);
	margin-top: 2px;
	word-break: break-all;
}

.account-nav {
	display: flex;
	flex-direction: column;
	gap: 2px;
	margin-bottom: 24px;
}

.account-nav a {
	display: flex;
	align-items: center;
	gap: 10px;
	font-size: 14px;
	font-weight: 500;
	color: var(--color-gray);
	padding: 11px 12px;
	border-left: 3px solid transparent;
	border-radius: 4px;
}

.account-nav a svg {
	width: 17px;
	height: 17px;
	stroke: currentColor;
	flex-shrink: 0;
}

.account-nav a:hover {
	color: var(--color-ink);
}

.account-nav a.active {
	color: var(--color-red);
	border-left-color: var(--color-red);
	background: var(--color-blush);
	font-weight: 600;
}

.logout-link {
	display: flex;
	align-items: center;
	gap: 10px;
	font-size: 14px;
	font-weight: 600;
	color: var(--color-gray);
	padding: 11px 12px;
	border-top: 1px solid var(--color-border);
	cursor: pointer;
}

.logout-link svg {
	width: 17px;
	height: 17px;
	stroke: currentColor;
	flex-shrink: 0;
}

.logout-link:hover {
	color: var(--color-red);
}

/* ---------- CONTENT ---------- */
.settings-section {
	margin-bottom: 40px;
	scroll-margin-top: 24px;
}

.settings-card {
	border: 1px solid var(--color-border);
	border-radius: 14px;
	background: var(--color-blush);
	padding: 28px 32px;
}

.settings-card-head {
	display: flex;
	align-items: flex-start;
	justify-content: space-between;
	margin-bottom: 22px;
}

.settings-card-head h2 {
	font-size: 19px;
	font-weight: 700;
	margin-bottom: 4px;
}

.settings-card-head .sub {
	font-size: 13px;
	color: var(--color-gray);
}

.form-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-bottom: 18px;
}

.field label {
	display: block;
	font-size: 13px;
	font-weight: 600;
	color: var(--color-gray);
	margin-bottom: 7px;
}

.field input {
	width: 100%;
	background: var(--color-bg);
	color: var(--color-ink);
	border: 1px solid var(--color-border);
	border-radius: 10px;
	padding: 12px 14px;
	font-size: 14px;
}

.field input:focus {
	outline: none;
	border-color: var(--color-red);
}

.field input:disabled, .field input[readonly] {
	color: var(--color-gray);
	cursor: default;
}

/* photo editor */
.photo-row {
	display: flex;
	align-items: center;
	gap: 16px;
	margin-bottom: 26px;
}

.avatar-lg {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	overflow: hidden;
	border: 2px solid var(--color-border);
	flex-shrink: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #2c1607;
	font-family: var(--font-display);
	font-weight: 700;
	font-size: 22px;
	color: var(--color-white);
}

.avatar-lg img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.photo-row .edit-photo {
	font-size: 14px;
	font-weight: 600;
	color: var(--color-red);
	display: none;
	align-items: center;
	gap: 6px;
	cursor: pointer;
}

.photo-row .edit-photo:hover {
	text-decoration: underline;
}

.photo-row .hint {
	font-size: 12px;
	color: var(--color-gray);
	margin-top: 4px;
}

/* location block inside personal info */
.divider-line {
	border-top: 1px solid var(--color-border);
	margin: 26px 0;
}

.location-row {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.location-row .addr-label {
	font-size: 13px;
	font-weight: 600;
	color: var(--color-gray);
	margin-bottom: 6px;
}

.location-row .addr-value {
	font-size: 14px;
}

/* promo codes */
.promo-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 16px;
	padding: 16px 0;
	border-bottom: 1px solid var(--color-border);
}

.promo-item:last-child {
	border-bottom: none;
}

.promo-code {
	font-family: var(--font-display);
	font-weight: 700;
	font-size: 14px;
	color: var(--color-red);
	border: 1px dashed var(--color-red);
	border-radius: 8px;
	padding: 6px 12px;
	display: inline-block;
	margin-bottom: 6px;
	letter-spacing: 0.02em;
}

.promo-desc {
	font-size: 13px;
	color: var(--color-gray);
}

.promo-status {
	font-size: 12px;
	font-weight: 700;
	padding: 5px 12px;
	border-radius: 999px;
	white-space: nowrap;
}

.promo-status.active {
	background: rgba(79, 174, 106, 0.15);
	color: var(--color-green);
}

.promo-status.expired {
	background: rgba(255, 255, 255, 0.08);
	color: var(--color-gray);
}

/* connected accounts */
.connect-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 16px;
	padding: 16px 0;
	border-bottom: 1px solid var(--color-border);
}

.connect-item:last-child {
	border-bottom: none;
}

.connect-left {
	display: flex;
	align-items: center;
	gap: 14px;
}

.connect-icon {
	width: 38px;
	height: 38px;
	border-radius: 50%;
	flex-shrink: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	background: var(--color-bg);
	border: 1px solid var(--color-border);
	font-family: var(--font-display);
	font-weight: 700;
	font-size: 15px;
}

.connect-name {
	font-size: 14px;
	font-weight: 700;
}

.connect-meta {
	font-size: 12px;
	color: var(--color-gray);
	margin-top: 2px;
}

/* payments */
.card-item {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 16px;
	padding: 16px 0;
	border-bottom: 1px solid var(--color-border);
}

.card-item:last-child {
	border-bottom: none;
}

.card-left {
	display: flex;
	align-items: center;
	gap: 14px;
}

.card-chip {
	width: 46px;
	height: 32px;
	border-radius: 6px;
	flex-shrink: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: var(--font-display);
	font-weight: 800;
	font-size: 10px;
	color: var(--color-white);
}

.card-chip.visa {
	background: linear-gradient(135deg, #2b5fce, #1a3a86);
}

.card-chip.mc {
	background: linear-gradient(135deg, #eb5b2f, #b8352e);
}

.card-chip.upi {
	background: linear-gradient(135deg, #4fae6a, #2f7d47);
}

.card-name {
	font-size: 14px;
	font-weight: 700;
}

.card-meta {
	font-size: 12px;
	color: var(--color-gray);
	margin-top: 2px;
}

.card-default {
	font-size: 11px;
	font-weight: 700;
	color: var(--color-red);
	border: 1px solid var(--color-red);
	border-radius: 999px;
	padding: 3px 9px;
	margin-left: 8px;
}

.add-payment-btn {
	width: 100%;
	margin-top: 6px;
	background: transparent;
	color: var(--color-ink);
	border: 1px dashed var(--color-border);
	border-radius: 10px;
	padding: 13px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
}

.add-payment-btn:hover {
	border-color: var(--color-red);
	color: var(--color-red);
}

/* login & security */
.security-row {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 16px;
	padding: 18px 0;
	border-bottom: 1px solid var(--color-border);
}

.security-row:last-of-type {
	border-bottom: none;
}

.security-label {
	font-size: 14px;
	font-weight: 700;
	margin-bottom: 3px;
}

.security-value {
	font-size: 13px;
	color: var(--color-gray);
	letter-spacing: 0.12em;
}

.session-list {
	margin-top: 8px;
}

.session-item {
	display: flex;
	align-items: center;
	gap: 14px;
	padding: 14px 0;
	border-bottom: 1px solid var(--color-border);
}

.session-item:last-child {
	border-bottom: none;
}

.session-icon {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	flex-shrink: 0;
	background: var(--color-bg);
	border: 1px solid var(--color-border);
	display: flex;
	align-items: center;
	justify-content: center;
}

.session-icon svg {
	width: 18px;
	height: 18px;
	stroke: var(--color-gray);
}

.session-device {
	font-size: 14px;
	font-weight: 600;
}

.session-meta {
	font-size: 12px;
	color: var(--color-gray);
	margin-top: 2px;
}

.session-current {
	font-size: 11px;
	font-weight: 700;
	color: var(--color-green);
	border: 1px solid var(--color-green);
	border-radius: 999px;
	padding: 3px 9px;
}

/* ---------- RESPONSIVE ---------- */
@media ( max-width : 900px) {
	.wrap {
		padding: 0 20px;
	}
	.layout {
		grid-template-columns: 1fr;
	}
	.sidebar {
		position: static;
	}
	.form-row {
		grid-template-columns: 1fr;
	}
	.settings-card {
		padding: 22px;
	}
	.promo-item, .connect-item, .card-item {
		flex-wrap: wrap;
	}
}
/* ---------- LOGOUT CONFIRM MODAL ---------- */
.modal-overlay {
	display: none;
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, 0.6);
	z-index: 1000;
	align-items: center;
	justify-content: center;
}

.modal-overlay.open {
	display: flex;
}

.modal-box {
	background: var(--color-blush);
	border: 1px solid var(--color-border);
	border-radius: 16px;
	padding: 28px;
	max-width: 360px;
	width: 90%;
}

.modal-box h3 {
	font-size: 18px;
	font-weight: 700;
	margin-bottom: 8px;
}

.modal-box p {
	font-size: 14px;
	color: var(--color-gray);
	margin: 0 0 22px;
	line-height: 1.5;
}

.modal-actions {
	display: flex;
	gap: 12px;
	justify-content: flex-end;
}
</style>
</head>
<body>

	<header class="site-nav">
		<div class="wrap">
			<a class="brand" href="#"> <img
				src="<%=request.getContextPath()%>/images/logo.png"
				alt="SwadExpress logo"
				style="height: 48px; vertical-align: middle; margin-right: 8px;">
				SwadExpress
			</a>
			<div class="nav-icon-group">
				<a class="back-link" href="<%=request.getContextPath()%>/restaurant">←
					Back to restaurants</a> <span class="nav-divider"></span> <a
					class="icon-btn" href="cart" aria-label="Cart"> <svg
						viewBox="0 0 24 24" fill="none" stroke-width="2"
						stroke-linecap="round" stroke-linejoin="round">
            			<circle cx="9" cy="21" r="1"></circle>
            			<circle cx="20" cy="21" r="1"></circle>
            			<path
							d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
          			</svg>
				</a> <a class="icon-btn active" href="<%=request.getContextPath()%>/profile" aria-label="Profile">
					<svg viewBox="0 0 24 24" fill="none" stroke-width="2"
						stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
            <circle cx="12" cy="7" r="4"></circle>
          </svg>
				</a>
			</div>
		</div>
	</header>

	<div class="wrap">
		<div class="page-heading">
			<h1>Account settings</h1>
		</div>

		<%
		User u = (User) session.getAttribute("loggedInUser");
		if (u == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		String profileImagePath = (u.getImage() != null && !u.getImage().trim().isEmpty())
				? request.getContextPath() + "/" + u.getImage()
				: request.getContextPath() + "/images/user.png";
		%>

		<div class="layout">

			<!-- ============ SIDEBAR ============ -->
			<aside class="sidebar">
				<div class="profile-card">
					<div class="avatar-md">
						<img src="<%=profileImagePath%>" alt="Profile"
							style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
					</div>
					<div>
						<div class="profile-card-name"><%=u.getUsername()%></div>
						<div class="profile-card-email"><%=u.getEmail()%></div>
					</div>
				</div>

				<nav class="account-nav">
					<a href="#personal-info" class="active"> <svg
							viewBox="0 0 24 24" fill="none" stroke-width="2"
							stroke-linecap="round" stroke-linejoin="round">
							<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
							<circle cx="12" cy="7" r="4"></circle></svg> Personal info
					</a>
					<a href="#order-history"> <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <path d="M3 3v5h5"></path><path d="M3.05 13A9 9 0 1 0 6 5.3L3 8"></path><path d="M12 7v5l4 2"></path></svg> Order History
</a>
					 <a href="#promo-codes"> <svg viewBox="0 0 24 24" fill="none"
							stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<path
								d="M20.59 13.41 11 3.83A2 2 0 0 0 9.59 3.24L4 3a1 1 0 0 0-1 1l.24 5.59a2 2 0 0 0 .59 1.41l9.58 9.58a2 2 0 0 0 2.83 0l4.35-4.35a2 2 0 0 0 0-2.82Z"></path>
							<circle cx="8.5" cy="8.5" r="1.5"></circle></svg> Promo codes
					</a> <a href="#connected-accounts"> <svg viewBox="0 0 24 24"
							fill="none" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
							<circle cx="12" cy="12" r="10"></circle>
							<line x1="12" y1="8" x2="12" y2="16"></line>
							<line x1="8" y1="12" x2="16" y2="12"></line></svg> Connected accounts
					</a> <a href="#payments"> <svg viewBox="0 0 24 24" fill="none"
							stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<rect x="1" y="4" width="22" height="16" rx="2"></rect>
							<line x1="1" y1="10" x2="23" y2="10"></line></svg> Payments &amp;
						shipping
					</a> <a href="#login-security"> <svg viewBox="0 0 24 24"
							fill="none" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
							<rect x="3" y="11" width="18" height="11" rx="2"></rect>
							<path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg> Login &amp; security
					</a>
					
				</nav>

				<a class="logout-link" href="#" id="logoutTrigger"
					onclick="openLogoutModal(event)"> <svg viewBox="0 0 24 24"
						fill="none" stroke-width="2" stroke-linecap="round"
						stroke-linejoin="round">
    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
    <polyline points="16 17 21 12 16 7"></polyline>
    <line x1="21" y1="12" x2="9" y2="12"></line>
  </svg> Log out
				</a>
			</aside>

			<!-- ============ CONTENT ============ -->
			<div class="content">

				<!-- PERSONAL INFO -->
				<section class="settings-section" id="personal-info">
					<div class="settings-card">
						<form id="personalInfoForm"
							action="<%=request.getContextPath()%>/UpdateProfileServlet"
							method="post" enctype="multipart/form-data">

							<div class="settings-card-head">
								<div>
									<h2>Personal info</h2>
									<div class="sub">Verify your personal details.</div>
								</div>
								<button type="button" id="editToggleBtn" class="btn-text-red"
									onclick="toggleEditMode()">Edit</button>
							</div>

							<div class="photo-row">
								<div class="avatar-lg">
									<img id="profilePreview" src="<%=profileImagePath%>"
										alt="Profile Picture">
								</div>
								<div>
									<label for="profileImage" id="editPhotoLabel"
										class="edit-photo">Change photo</label> <input type="file"
										id="profileImage" name="profileImage" accept=".jpg,.jpeg,.png"
										style="display: none" onchange="previewImage(event)">
									<div class="hint">Square images are best. Max size: 2 MB.</div>
								</div>
							</div>

							<div class="form-row">
								<div class="field">
									<label>User name</label> <input type="text" name="username"
										id="usernameInput" value="<%=u.getUsername()%>" readonly>
								</div>
							</div>

							<div class="form-row" style="grid-template-columns: 1fr">
								<div class="field">
									<label>Email</label> <input type="email"
										value="<%=u.getEmail()%>" readonly disabled>
								</div>
							</div>

							<button type="submit" id="saveBtn" class="btn btn-filled-red"
								style="display: none;">Save</button>

							<div class="divider-line"></div>
							</form>

<%
    List<Address> userAddresses = (List<Address>) request.getAttribute("userAddresses");
    if (userAddresses == null) userAddresses = new java.util.ArrayList<Address>();
%>

<div class="location-row" style="align-items:flex-start; flex-direction:column; gap:14px;">
    <div class="addr-label">Location</div>

    <% if (userAddresses.isEmpty()) { %>
        <div class="addr-value">No address on file.</div>
    <% } else { %>
        <% for (Address a : userAddresses) { %>
            <div style="display:flex; align-items:flex-start; justify-content:space-between; gap:14px; width:100%; padding:12px 0; border-bottom:1px solid var(--color-border);">
                <div>
                    <div style="font-size:14px; font-weight:700; margin-bottom:3px;"><%=a.getLabel()%></div>
                    <div class="addr-value" style="color:var(--color-gray);"><%=a.getFullAddress()%></div>
                </div>

                <% if (a.isDefault()) { %>
                    <span style="font-size:11px; font-weight:700; color:var(--color-red); border:1px solid var(--color-red); border-radius:999px; padding:4px 11px; white-space:nowrap;">✓ Default</span>
                <% } else if (userAddresses.size() > 1) { %>
                    <form action="<%=request.getContextPath()%>/setDefaultAddress" method="post" style="flex-shrink:0;">
                        <input type="hidden" name="addressID" value="<%=a.getAddressID()%>">
                        <button type="submit" style="background:transparent; border:1px solid var(--color-border); color:var(--color-gray); border-radius:999px; padding:4px 11px; font-size:11px; font-weight:700; cursor:pointer;">Set as Default</button>
                    </form>
                <% } %>
            </div>
        <% } %>
    <% } %>
</div>
						
					</div>
				</section>
<section class="settings-section" id="order-history">
    <div class="settings-card">
        <div class="settings-card-head">
            <div>
                <h2>Order History</h2>
                <div class="sub">Your past orders with SwadExpress.</div>
            </div>
        </div>

        <%
            List<OrderTable> userOrders = (List<OrderTable>) request.getAttribute("userOrders");
            Map<Integer, List<OrderItem>> orderItemsMap = (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");
            Map<Integer, Restaurant> orderRestaurantMap = (Map<Integer, Restaurant>) request.getAttribute("orderRestaurantMap");
            if (userOrders == null) userOrders = new java.util.ArrayList<OrderTable>();
        %>

        <% if (userOrders.isEmpty()) { %>
            <div class="addr-value">You haven't placed any orders yet.</div>
        <% } else { %>
            <% for (OrderTable order : userOrders) {
                List<OrderItem> items = orderItemsMap.get(order.getOrderId());
                Restaurant r = orderRestaurantMap.get(order.getRestaurantId());
            %>
            <div class="promo-item" style="flex-direction:column; align-items:stretch; gap:10px;">
                <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                    <div>
                        <div style="font-size:14px; font-weight:700;">
                            <%= r != null ? r.getRestaurantName() : "Restaurant" %>
                        </div>
                        <div class="promo-desc"><%= order.getOrderDate() %></div>
                    </div>
                    <span class="promo-status active"><%= order.getStatus() %></span>
                </div>

                <% if (items != null) { for (OrderItem oi : items) { %>
                    <div style="display:flex; justify-content:space-between; font-size:13px; color:var(--color-gray);">
                        <span><%= oi.getItemName() %> x <%= oi.getQuantity() %></span>
                        <span>₹<%= String.format("%.2f", oi.getItemTotal()) %></span>
                    </div>
                <% } } %>

                <div style="display:flex; justify-content:space-between; font-weight:700; border-top:1px solid var(--color-border); padding-top:8px; margin-top:4px;">
                    <span>Total</span>
                    <span>₹<%= String.format("%.2f", order.getTotalAmount()) %></span>
                </div>
            </div>
            <% } %>
        <% } %>
    </div>
</section>
				<!-- PROMO CODES -->
				<section class="settings-section" id="promo-codes">
					<div class="settings-card">
						<div class="settings-card-head">
							<div>
								<h2>Promo codes</h2>
								<div class="sub">Codes you've saved to your account.</div>
							</div>
						</div>

						<div class="promo-item">
							<div>
								<span class="promo-code">WELCOME50</span>
								<div class="promo-desc">50% off, up to ₹100 · Expires Aug
									31, 2026</div>
							</div>
							<span class="promo-status active">Active</span>
						</div>
						<div class="promo-item">
							<div>
								<span class="promo-code">FREESHIP</span>
								<div class="promo-desc">Free delivery on orders above ₹299
									· No expiry</div>
							</div>
							<span class="promo-status active">Active</span>
						</div>
					</div>
				</section>

				<!-- CONNECTED ACCOUNTS -->
				<section class="settings-section" id="connected-accounts">
					<div class="settings-card">
						<div class="settings-card-head">
							<div>
								<h2>Connected accounts</h2>
								<div class="sub">Sign in faster using accounts you already
									have.</div>
							</div>
						</div>

						<div class="connect-item">
							<div class="connect-left">
								<div class="connect-icon">G</div>
								<div>
									<div class="connect-name">Google</div>
									<div class="connect-meta">
										Connected ·
										<%=u.getEmail()%></div>
								</div>
							</div>
							<button class="btn btn-outline btn-small">Disconnect</button>
						</div>
						<div class="connect-item">
							<div class="connect-left">
								<div class="connect-icon">f</div>
								<div>
									<div class="connect-name">Facebook</div>
									<div class="connect-meta">Not connected</div>
								</div>
							</div>
							<button class="btn btn-outline btn-small">Connect</button>
						</div>
					</div>
				</section>

				<!-- PAYMENTS & SHIPPING -->
				<section class="settings-section" id="payments">
					<div class="settings-card">
						<div class="settings-card-head">
							<div>
								<h2>Payments &amp; shipping</h2>
								<div class="sub">Cards and UPI IDs saved for checkout.</div>
							</div>
						</div>

						<div class="card-item">
							<div class="card-left">
								<div class="card-chip visa">VISA</div>
								<div>
									<div class="card-name">
										Visa ending 4242 <span class="card-default">Default</span>
									</div>
									<div class="card-meta">Expires 08/28</div>
								</div>
							</div>
							<button class="btn-text-red">Remove</button>
						</div>
						<div class="card-item">
							<div class="card-left">
								<div class="card-chip upi">UPI</div>
								<div>
									<div class="card-name"><%=u.getUsername()%>@okhdfcbank
									</div>
									<div class="card-meta">UPI ID</div>
								</div>
							</div>
							<button class="btn-text-red">Remove</button>
						</div>
						<div class="card-item">
							<div class="card-left">
								<div class="card-chip upi">UPI</div>
								<div>
									<div class="card-name"><%=u.getUsername()%>@ybl
									</div>
									<div class="card-meta">UPI ID</div>
								</div>
							</div>
							<button class="btn-text-red">Remove</button>
						</div>

						<button class="add-payment-btn">+ Add payment method</button>
					</div>
				</section>

				<!-- LOGIN & SECURITY -->
				<section class="settings-section" id="login-security">
					<div class="settings-card">
						<div class="settings-card-head">
							<div>
								<h2>Login &amp; security</h2>
								<div class="sub">Manage your password and see where you're
									signed in.</div>
							</div>
						</div>

						<div class="security-row">
    <div>
        <div class="security-label">Password</div>
        <div class="security-value">••••••••••••</div>
    </div>
    <a href="<%=request.getContextPath()%>/forgotPassword.jsp" class="btn btn-outline btn-small">Reset password</a>
</div>

						<div class="security-row"
							style="border-bottom: none; padding-bottom: 6px;">
							<div>
								<div class="security-label">Where you're signed in</div>
								<div class="sub">Devices currently logged into your
									account.</div>
							</div>
						</div>

						<div class="session-list">
							<div class="session-item">
								<div class="session-icon">
									<svg viewBox="0 0 24 24" fill="none" stroke-width="2"
										stroke-linecap="round" stroke-linejoin="round">
										<rect x="2" y="3" width="20" height="14" rx="2"></rect>
										<line x1="8" y1="21" x2="16" y2="21"></line>
										<line x1="12" y1="17" x2="12" y2="21"></line></svg>
								</div>
								<div style="flex: 1;">
									<div class="session-device">Chrome on Windows</div>
									<div class="session-meta">Bengaluru, India · Today, 10:42
										AM</div>
								</div>
								<span class="session-current">This device</span>
							</div>
							<div class="session-item">
								<div class="session-icon">
									<svg viewBox="0 0 24 24" fill="none" stroke-width="2"
										stroke-linecap="round" stroke-linejoin="round">
										<rect x="5" y="2" width="14" height="20" rx="2"></rect>
										<line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
								</div>
								<div style="flex: 1;">
									<div class="session-device">Safari on iPhone</div>
									<div class="session-meta">Bengaluru, India · Jul 12,
										2026, 8:15 PM</div>
								</div>
								<button class="btn-text-red">Sign out</button>
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
	<div class="modal-overlay" id="logoutModal">
		<div class="modal-box">
			<h3>Log out?</h3>
			<p>Are you sure you want to log out of your account?</p>
			<div class="modal-actions">
				<button type="button" class="btn btn-outline btn-small"
					onclick="closeLogoutModal()">Cancel</button>
				<button type="button" class="btn btn-filled-red btn-small"
					onclick="confirmLogout()">Yes, log out</button>
			</div>
		</div>
	</div>

	<script>
		(function() {
			var navLinks = document.querySelectorAll('.account-nav a');
			var sections = Array.from(navLinks).map(function(link) {
				return document.querySelector(link.getAttribute('href'));
			});

			function setActive() {
				var pos = window.scrollY + 140;
				var current = 0;
				sections.forEach(function(sec, i) {
					if (sec && sec.offsetTop <= pos)
						current = i;
				});
				navLinks.forEach(function(l, i) {
					l.classList.toggle('active', i === current);
				});
			}
			window.addEventListener('scroll', setActive, {
				passive : true
			});
			setActive();

			navLinks.forEach(function(link) {
				link.addEventListener('click', function(e) {
					e.preventDefault();
					var target = document.querySelector(link
							.getAttribute('href'));
					if (target)
						window.scrollTo({
							top : target.offsetTop - 24,
							behavior : 'smooth'
						});
				});
			});
		})();

		function previewImage(event) {
			var image = document.getElementById("profilePreview");
			if (event.target.files.length > 0) {
				image.src = URL.createObjectURL(event.target.files[0]);
			}
		}
		// Edit / Save toggle for the Personal Info card.
		// - Not editing: username + email are readonly, password row and Save button hidden.
		// - Editing: username becomes editable, password row appears (optional), Save button shows,
		//   "Change photo" label appears so the file picker only invites clicks while editing.
		// Email always stays readonly+disabled, in edit mode or not.
		function toggleEditMode() {
    var usernameInput = document.getElementById('usernameInput');
    var saveBtn = document.getElementById('saveBtn');
    var editBtn = document.getElementById('editToggleBtn');
    var editPhotoLabel = document.getElementById('editPhotoLabel');

    var isCurrentlyEditing = editBtn.textContent.trim() === 'Cancel';

    if (!isCurrentlyEditing) {
        usernameInput.removeAttribute('readonly');
        saveBtn.style.display = 'inline-flex';
        editBtn.textContent = 'Cancel';
        editPhotoLabel.style.display = 'flex';
    } else {
        usernameInput.setAttribute('readonly', true);
        usernameInput.value = usernameInput.defaultValue;
        saveBtn.style.display = 'none';
        editBtn.textContent = 'Edit';
        editPhotoLabel.style.display = 'none';
    }
}

		function openLogoutModal(e) {
			e.preventDefault();
			document.getElementById('logoutModal').classList.add('open');
		}
		function closeLogoutModal() {
			document.getElementById('logoutModal').classList.remove('open');
		}
		function confirmLogout() {
			window.location.href = '<%=request.getContextPath()%>/logout';
    	}
  </script>

</body>
</html>
