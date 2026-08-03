<%@page
	import="java.util.List, com.tap.model.Restaurant,com.tap.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SwadExpress — Fresh meals, delivered daily</title>
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

.wrap {
	max-width: 1240px;
	margin: 0 auto;
	padding: 0 40px;
}

h1, h2, h3, h4 {
	font-family: var(--font-display);
	margin: 0;
}

/* ---------- BUTTONS ---------- */
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

.btn-filled-red {
	background: var(--color-red);
	color: var(--color-white);
}

.btn-filled-red:hover {
	background: var(--color-red-dark);
}

.btn-outline-white {
	background: transparent;
	color: var(--color-white);
	border-color: rgba(255, 255, 255, 0.6);
}

.btn-outline-white:hover {
	border-color: var(--color-white);
}

.btn-filled-white {
	background: var(--color-white);
	color: var(--color-red);
}

.btn-outline-red {
	background: transparent;
	color: var(--color-red);
	border-color: var(--color-red);
}

.btn-small {
	padding: 9px 18px;
	font-size: 14px;
}

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
  height: 44px;
  display: inline-block;
  margin-right: 8px;
}
.nav-links {
	display: flex;
	align-items: center;
	gap: 15px;
	font-size: 15px;
	font-weight: 500;
}

.nav-links a:hover {
	color: var(--color-red);
}

.nav-about {
	font-weight: 500;
}

.nav-icon-group {
	display: flex;
	align-items: center;
	gap: 10px;
	padding-left: 8px;
	border-left: 1px solid var(--color-border);
}

.nav-auth-group {
	display: flex;
	align-items: center;
	gap: 10px;
	padding-left: 8px;
	border-left: 1px solid var(--color-border);
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
	transition: background 0.15s ease, border-color 0.15s ease, color 0.15s
		ease;
}

.icon-btn:hover {
	background: var(--color-red);
	border-color: var(--color-red);
	color: var(--color-white);
}

.icon-btn svg {
	width: 18px;
	height: 18px;
	stroke: currentColor;
}

/* ---------- HERO ---------- */
.hero {
	position: relative;
	padding: 160px 0;
	overflow: hidden;
	isolation: isolate;
}

.hero-bg {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	width: 100%;
	height: 100%;
	background: linear-gradient(135deg, #f2b451 0%, #e8734a 55%, #a83a1e 100%);
	filter: blur(1px) brightness(1.15);
	transform: scale(1.08);
	z-index: 0;
}

.hero-overlay {
	position: absolute;
	inset: 0;
	background: linear-gradient(180deg, rgba(13, 8, 3, 0.72),
		rgba(13, 8, 3, 0.9));
	z-index: 1;
}

.hero .wrap {
	position: relative;
	z-index: 2;
}

.hero-content {
	max-width: 640px;
	margin: 0 auto;
	text-align: center;
}

.hero h1 {
	font-size: 44px;
	font-weight: 800;
	line-height: 1.15;
	letter-spacing: -0.01em;
	color: var(--color-white);
	margin-bottom: 20px;
	text-transform: uppercase;
}

.hero h1 .accent {
	color: var(--color-red);
}

.hero p {
	color: rgba(255, 255, 255, 0.85);
	font-size: 17px;
	line-height: 1.6;
	max-width: 460px;
	margin: 0 auto 32px;
}

.hero-actions {
	display: flex;
	gap: 16px;
	flex-wrap: wrap;
	justify-content: center;
}

/* ---------- BROWSE BY CUISINE ---------- */
.cuisine-carousel {
	position: relative;
	display: flex;
	align-items: center;
	gap: 12px;
	margin: 0 -24px;
}

.cuisine-scroller {
	display: flex;
	gap: 40px;
	overflow-x: auto;
	scroll-behavior: smooth;
	scrollbar-width: none;
	padding: 4px 2px 16px;
}

.cuisine-scroller::-webkit-scrollbar {
	display: none;
}

.cuisine-chip {
	flex: 0 0 auto;
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 12px;
	background: none;
	border: none;
	cursor: pointer;
	font-family: var(--font-body);
	padding: 0;
}

.cuisine-chip-photo {
	width: 100px;
	height: 100px;
	border-radius: 18px;
	overflow: hidden;
	border: 2px solid var(--color-border);
	transition: border-color 0.2s ease, transform 0.2s ease;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 34px;
}

.cuisine-chip-photo.all {
	background: linear-gradient(135deg, #f2b451, #a83a1e);
}

.cuisine-chip-photo.burgers {
	background: linear-gradient(135deg, #e8b768, #7a3418);
}

.cuisine-chip-photo.pizza {
	background: linear-gradient(135deg, #e89a4a, #8c3d10);
}

.cuisine-chip-photo.sushi {
	background: linear-gradient(135deg, #9fd0c7, #1f5248);
}

.cuisine-chip-photo.healthy {
	background: linear-gradient(135deg, #a7c98f, #33511f);
}

.cuisine-chip-photo.dessert {
	background: linear-gradient(135deg, #e8a2c0, #5c1330);
}

.cuisine-chip-photo.coffee {
	background: linear-gradient(135deg, #b98a63, #3c2414);
}

.cuisine-chip-photo.asian {
	background: linear-gradient(135deg, #d8b7e8, #4a2470);
}

.cuisine-chip-photo.indian {
	background: linear-gradient(135deg, #e8b768, #7a3418);
}

.why-photo {
	aspect-ratio: 4/3.2;
	border-radius: 20px;
	overflow: hidden;
	background: linear-gradient(135deg, #7fae7a 0%, #4c7a52 55%, #274d33 100%);
}

.article-photo {
	aspect-ratio: 16/10;
	border-radius: 16px;
	margin-bottom: 20px;
	overflow: hidden;
}

.article-photo.p1 {
	background: linear-gradient(135deg, #f2b451, #e8734a 55%, #a83a1e);
}

.article-photo.p2 {
	background: linear-gradient(135deg, #9fd0c7, #4f9c8c 55%, #1f5248);
}

.article-photo.p3 {
	background: linear-gradient(135deg, #d8b7e8, #9a5ec9 55%, #4a2470);
}

.final-photo {
	aspect-ratio: 16/10;
	border-radius: 20px;
	overflow: hidden;
	background: linear-gradient(135deg, #e8a2c0, #b23d6e 55%, #5c1330);
}

.hero-bg img, .why-photo img, .article-photo img, .final-photo img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.cuisine-chip-photo img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.cuisine-chip span {
	font-size: 13px;
	font-weight: 600;
	color: var(--color-gray);
	transition: color 0.2s ease;
}

.cuisine-chip:hover .cuisine-chip-photo, .cuisine-chip.active .cuisine-chip-photo
	{
	border-color: var(--color-red);
	transform: translateY(-2px);
}

.cuisine-chip:hover span, .cuisine-chip.active span {
	color: var(--color-red);
}

/* ---------- RESTAURANT CAROUSEL ---------- */
.restaurant-carousel {
	position: relative;
	display: flex;
	align-items: center;
	gap: 12px;
	margin: 0 -24px;
}

.restaurant-track {
	display: flex;
	gap: 24px;
	overflow-x: auto;
	scroll-behavior: smooth;
	scrollbar-width: none;
	padding: 4px 2px 12px;
}

.restaurant-track::-webkit-scrollbar {
	display: none;
}

.restaurant-card {
	flex: 0 0 260px;
	border: 1px solid var(--color-border);
	border-radius: 16px;
	overflow: hidden;
	transition: opacity 0.2s ease, transform 0.2s ease;
}

.restaurant-card.is-hidden {
	display: none;
}

.restaurant-photo {
	aspect-ratio: 4/3;
	overflow: hidden;
}

.restaurant-photo img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.restaurant-copy {
	padding: 18px;
}

.restaurant-copy h3 {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 6px;
}

.restaurant-meta {
	font-size: 13px;
	color: var(--color-gray);
	margin-bottom: 10px;
}

.carousel-arrow {
	flex-shrink: 0;
	width: 44px;
	height: 44px;
	border-radius: 50%;
	border: 1px solid var(--color-border);
	background: var(--color-white);
	color: var(--color-red);
	font-size: 22px;
	line-height: 1;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: background 0.15s ease, border-color 0.15s ease, color 0.15s
		ease, opacity 0.15s ease;
}

.carousel-arrow:hover {
	background: var(--color-red);
	border-color: var(--color-red);
	color: var(--color-white);
}

.carousel-arrow:disabled {
	opacity: 0.35;
	cursor: not-allowed;
	background: var(--color-white);
	color: var(--color-red);
}

/* ---------- FEATURE CARDS ---------- */
.section {
	padding: 88px 0;
}

.section-head {
	text-align: center;
	max-width: 640px;
	margin: 0 auto 48px;
}

.section-head h2 {
	font-size: 34px;
	font-weight: 800;
	color: var(--color-red);
	text-transform: uppercase;
	line-height: 1.25;
}

.section-head p {
	color: var(--color-gray);
	font-size: 16px;
	margin-top: 12px;
}

.card-grid-3 {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.feature-card {
	border: 1px solid var(--color-border);
	border-radius: 16px;
	padding: 32px;
}

.feature-icon {
	width: 48px;
	height: 48px;
	border-radius: 50%;
	background: var(--color-blush);
	color: var(--color-red);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 22px;
	margin-bottom: 24px;
}

.feature-card h3 {
	font-size: 18px;
	font-weight: 700;
	text-transform: uppercase;
	margin-bottom: 10px;
}

.feature-card p {
	font-size: 15px;
	color: var(--color-gray);
	line-height: 1.55;
	margin: 0 0 16px;
}

.link-red {
	color: var(--color-red);
	font-weight: 600;
	font-size: 15px;
}

/* ---------- PINK "WHY" SECTION ---------- */
.why-section {
	background: var(--color-blush);
	padding: 88px 0;
}

.why-section .wrap {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 64px;
	align-items: center;
}

.why-section h2 {
	font-size: 32px;
	font-weight: 800;
	color: var(--color-red);
	text-transform: uppercase;
	margin-bottom: 40px;
	line-height: 1.25;
}

.why-list {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 32px 24px;
}

.why-item .feature-icon {
	background: var(--color-white);
	margin-bottom: 14px;
}

.why-item h4 {
	font-size: 15px;
	font-weight: 700;
	text-transform: uppercase;
	margin-bottom: 8px;
}

.why-item p {
	font-size: 14px;
	color: var(--color-gray);
	line-height: 1.55;
	margin: 0;
}

/* ---------- GET STARTED ---------- */
.plans {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 24px;
	max-width: 880px;
	margin: 0 auto;
}

.plan-card {
	border: 1px solid var(--color-border);
	border-radius: 16px;
	padding: 36px;
}

.plan-card h3 {
	font-size: 20px;
	font-weight: 700;
	text-transform: uppercase;
	color: var(--color-red);
	margin-bottom: 20px;
}

.plan-card ul {
	list-style: none;
	margin: 0 0 28px;
	padding: 0;
}

.plan-card li {
	display: flex;
	align-items: flex-start;
	gap: 10px;
	font-size: 15px;
	color: var(--color-ink);
	margin-bottom: 12px;
}

.check {
	flex-shrink: 0;
	width: 18px;
	height: 18px;
	border-radius: 50%;
	background: var(--color-red);
	color: var(--color-white);
	font-size: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 2px;
}

/* ---------- ARTICLES ---------- */
.article-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.article-card {
	
}

.article-tag {
	font-size: 13px;
	font-weight: 600;
	color: var(--color-red);
	text-transform: uppercase;
	margin-bottom: 10px;
}

.article-card h3 {
	font-size: 18px;
	font-weight: 700;
	line-height: 1.35;
	margin-bottom: 10px;
}

.article-card p {
	font-size: 14px;
	color: var(--color-gray);
	line-height: 1.55;
	margin: 0 0 16px;
}

.article-meta {
	font-size: 13px;
	color: var(--color-gray);
	margin-bottom: 12px;
}

/* ---------- FINAL CTA ---------- */
.final-cta {
	background: var(--color-maroon);
	padding: 72px 0;
}

.final-cta .wrap {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 48px;
	align-items: center;
}

.final-cta h2 {
	font-size: 32px;
	font-weight: 800;
	color: var(--color-white);
	text-transform: uppercase;
	line-height: 1.2;
	margin-bottom: 24px;
}

.final-cta h2 .accent {
	color: var(--color-red);
}

/* ---------- FOOTER ---------- */
.footer-band {
	background: var(--color-red);
	color: var(--color-white);
	padding: 32px 0;
}

.footer-band .brand-line {
	font-family: var(--font-display);
	font-weight: 700;
	font-size: 20px;
}

.footer-band p {
	margin: 6px 0 0;
	font-size: 14px;
	opacity: 0.9;
}

.footer-links {
	padding: 56px 0 32px;
}

.footer-cols {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 32px;
}

.footer-cols h4 {
	font-size: 14px;
	font-weight: 700;
	text-transform: uppercase;
	margin-bottom: 16px;
}

.footer-cols ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.footer-cols li {
	margin-bottom: 10px;
}

.footer-cols a {
	font-size: 14px;
	color: var(--color-gray);
}

.footer-cols a:hover {
	color: var(--color-red);
}

.footer-bottom {
	border-top: 1px solid var(--color-border);
	padding: 24px 0;
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 12px;
	font-size: 13px;
	color: var(--color-gray);
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

.footer-bottom .legal-links {
	display: flex;
	gap: 20px;
}

@media ( max-width : 860px) {
	.wrap {
		padding: 0 24px;
	}
	.why-section .wrap, .final-cta .wrap {
		grid-template-columns: 1fr;
	}
	.article-grid {
		grid-template-columns: 1fr;
	}
	.plans, .why-list, .footer-cols {
		grid-template-columns: 1fr 1fr;
	}
	.hero {
		padding: 90px 0;
	}
	.hero h1 {
		font-size: 32px;
	}
	.nav-links {
		gap: 16px;
		font-size: 14px;
	}
	.carousel-arrow {
		width: 36px;
		height: 36px;
		font-size: 18px;
	}
	.restaurant-card {
		flex: 0 0 220px;
	}
	.cuisine-chip-photo {
		width: 84px;
		height: 84px;
	}
	.cuisine-scroller {
		gap: 28px;
	}
	.cuisine-carousel, .restaurant-carousel {
		margin: 0 -12px;
	}
}

@media ( max-width : 520px) {
	.restaurant-card {
		flex: 0 0 78vw;
	}
	.cuisine-chip-photo {
		width: 72px;
		height: 72px;
	}
	.cuisine-chip span {
		font-size: 12px;
	}
	.cuisine-scroller {
		gap: 24px;
	}
	.cuisine-carousel, .restaurant-carousel {
		margin: 0 -8px;
	}
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
			<nav class="nav-links">
				<a class="nav-about" href="#why-choose">About Us</a>
				<div class="nav-icon-group">
					<a class="icon-btn" href="cart" aria-label="Cart"> <svg
							viewBox="0 0 24 24" fill="none" stroke-width="2"
							stroke-linecap="round" stroke-linejoin="round">
              <circle cx="9" cy="21" r="1"></circle>
              <circle cx="20" cy="21" r="1"></circle>
              <path
								d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
					</a> <a class="icon-btn" href="profile" aria-label="Profile"> <svg
							viewBox="0 0 24 24" fill="none" stroke-width="2"
							stroke-linecap="round" stroke-linejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
					</a>
				</div>
				<%
    User navUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
%>
				<div class="nav-auth-group">
					<% if (navUser != null) { %>
					<a class="nav-username"
						href="<%=request.getContextPath()%>/profile"><%=navUser.getUsername()%></a>
					<a class="btn btn-outline-red btn-small" href="#"
						onclick="openLogoutModal(event)">Log out</a>
					<% } else { %>
					<a class="btn btn-outline-red btn-small" href="login.jsp">Log
						in</a> <a class="btn btn-outline-red btn-small" href="signup.jsp">Sign
						Up</a>
					<% } %>
				</div>
			</nav>
		</div>
	</header>

	<section class="hero">
		<div class="hero-bg">
			<img src="${pageContext.request.contextPath}/images/hero.jpg"
				alt="SwadExpress seasonal plates">
		</div>
		<div class="hero-overlay"></div>
		<div class="wrap hero-inner">
			<div class="hero-content">
				<h1>
					SEASONAL MEALS, <span class="accent">MADE FRESH</span> DELIVERED
					DAILY
				</h1>
				<p>SwadExpress brings chef-cooked, seasonal plates to your door
					— no reservations, no dishes, no compromise.</p>
				<div class="hero-actions">
					<a class="btn btn-filled-red" href="#restaurants">Order now</a> <a
						class="btn btn-outline-white" href="#browse-cuisine">View menu</a>
				</div>
			</div>
		</div>
	</section>

	<section class="section" id="browse-cuisine"
		style="padding-bottom: 0; scroll-margin-top: 24px;">
		<div class="wrap">
			<div class="section-head" style="margin-bottom: 28px;">
				<h2>Browse by Cuisine</h2>
				<p>Tap a cuisine to filter the restaurants below.</p>
			</div>
			<!--
        These chips are a client-side filter over the cards rendered below.
        Each chip's data-cuisine is matched (case-insensitively) against each
        restaurant's getCuisineType() value, so restaurants tagged with a
        matching cuisine in the database will show/hide automatically.
        Add/remove <button class="cuisine-chip"> entries here if your actual
        cuisine list differs from this starter set.
      -->
			<div class="cuisine-carousel">
				<button class="carousel-arrow carousel-arrow-left" id="cuisinePrev"
					aria-label="Previous cuisines">‹</button>
				<div class="cuisine-scroller" id="cuisineScroller">
					<button class="cuisine-chip active" data-cuisine="all">
						<div class="cuisine-chip-photo all">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/all.jpg"
								alt="All">
						</div>
						<span>All</span>
					</button>
					<button class="cuisine-chip" data-cuisine="american">
						<div class="cuisine-chip-photo burgers">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/burgers.jpg"
								alt="Burgers">
						</div>
						<span>Burgers</span>
					</button>
					<button class="cuisine-chip" data-cuisine="mexican">
						<div class="cuisine-chip-photo pizza">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/pizza.jpg"
								alt="Pizza">
						</div>
						<span>Mexican</span>
					</button>
					<button class="cuisine-chip" data-cuisine="chinese">
						<div class="cuisine-chip-photo asian">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/asian.jpg"
								alt="Asian">
						</div>
						<span>Chinese</span>
					</button>
					<button class="cuisine-chip" data-cuisine="indian">
						<div class="cuisine-chip-photo indian">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/indian.jpg"
								alt="Indian">
						</div>
						<span>Indian</span>
					</button>
					<button class="cuisine-chip" data-cuisine="sushi">
						<div class="cuisine-chip-photo sushi">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/sushi.jpg"
								alt="Sushi">
						</div>
						<span>Sushi</span>
					</button>
					<button class="cuisine-chip" data-cuisine="healthy">
						<div class="cuisine-chip-photo healthy">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/healthy.jpg"
								alt="Healthy">
						</div>
						<span>Healthy</span>
					</button>
					<button class="cuisine-chip" data-cuisine="dessert">
						<div class="cuisine-chip-photo dessert">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/dessert.jpg"
								alt="Dessert">
						</div>
						<span>Dessert</span>
					</button>
					<button class="cuisine-chip" data-cuisine="coffee">
						<div class="cuisine-chip-photo coffee">
							<img
								src="${pageContext.request.contextPath}/images/cuisine/coffee.jpg"
								alt="Coffee">
						</div>
						<span>Coffee</span>
					</button>
				</div>
				<button class="carousel-arrow carousel-arrow-right" id="cuisineNext"
					aria-label="Next cuisines">›</button>
			</div>
		</div>
	</section>

	<section class="section" id="restaurants"
		style="scroll-margin-top: 24px;">
		<div class="wrap">
			<div class="section-head">
				<h2>Get Great Food From These Restaurants in Minutes</h2>
				<p>Browse top-rated kitchens near you and get your order moving
					in just a few taps.</p>
			</div>
			<div class="restaurant-carousel">
				<button class="carousel-arrow carousel-arrow-left"
					id="restaurantPrev" aria-label="Previous restaurants">‹</button>
				<div class="restaurant-track" id="restaurantTrack">
					<%
        	List<Restaurant> allRestaurants = (List<Restaurant>)request.getAttribute("allRestaurants");
			for (Restaurant restaurant : allRestaurants) {
				String cuisineAttr = restaurant.getCuisineType() == null ? "" : restaurant.getCuisineType().toLowerCase();
		%>
					<div class="restaurant-card" data-cuisine="<%=cuisineAttr %>">
						<div class="restaurant-photo">
							<img src="<%=restaurant.getImage() %>"
								alt="Cozy Italian restaurant interior">
						</div>
						<div class="restaurant-copy">
							<h3><%=restaurant.getRestaurantName() %></h3>
							<div class="restaurant-meta"><%=restaurant.getCuisineType() %>
								·
								<%=restaurant.getRatings() %>
								·
								<%=restaurant.getETA() %></div>
							<a class="link-red"
								href="menu?restaurantId=<%= restaurant.getRestaurantID() %>">View
								menu →</a>
						</div>
					</div>
					<%
			}
        %>
				</div>
				<button class="carousel-arrow carousel-arrow-right"
					id="restaurantNext" aria-label="Next restaurants">›</button>
			</div>
		</div>
	</section>

	<section class="why-section" id="why-choose">
		<div class="wrap">
			<div>
				<h2>Why Choose SwadExpress?</h2>
				<div class="why-list">
					<div class="why-item">
						<div class="feature-icon">👨‍🍳</div>
						<h4>Chef-Driven Menus</h4>
						<p>Every dish is developed in-house, tested, and plated the
							same way you'd get in the dining room.</p>
					</div>
					<div class="why-item">
						<div class="feature-icon">🌱</div>
						<h4>Transparent Sourcing</h4>
						<p>We list every farm and supplier behind your meal, right
							down to the produce.</p>
					</div>
					<div class="why-item">
						<div class="feature-icon">♻️</div>
						<h4>Zero-Waste Packaging</h4>
						<p>Compostable containers and utensils on every single order,
							no exceptions.</p>
					</div>
					<div class="why-item">
						<div class="feature-icon">📞</div>
						<h4>Always-On Support</h4>
						<p>A real person is available by phone or chat any time your
							order needs attention.</p>
					</div>
				</div>
			</div>
			<div class="why-photo">
				<img src="${pageContext.request.contextPath}/images/why-choose.jpg"
					alt="Fresh farm ingredients">
			</div>
		</div>
	</section>

	<section class="section">
		<div class="wrap">
			<div class="section-head">
				<h2>Get Started With SwadExpress</h2>
				<p>Choose the ordering style that fits how you eat.</p>
			</div>
			<div class="plans">
				<div class="plan-card">
					<h3>Order À La Carte</h3>
					<ul>
						<li><span class="check">✓</span> No commitment, order
							whenever</li>
						<li><span class="check">✓</span> Full access to the weekly
							menu</li>
						<li><span class="check">✓</span> Pay per order, cancel
							anytime</li>
						<li><span class="check">✓</span> Live delivery tracking</li>
					</ul>
					<a class="btn btn-filled-red" href="#">Browse menu</a>
				</div>
				<div class="plan-card">
					<h3>Subscribe &amp; Save</h3>
					<ul>
						<li><span class="check">✓</span> 10% off every order</li>
						<li><span class="check">✓</span> Priority delivery windows</li>
						<li><span class="check">✓</span> Free dessert on your first
							box</li>
						<li><span class="check">✓</span> Pause or cancel anytime</li>
					</ul>
					<a class="btn btn-outline-red" href="#">Start a plan</a>
				</div>
			</div>
		</div>
	</section>

	<section class="section">
		<div class="wrap">
			<div class="section-head">
				<h2>From the Kitchen</h2>
				<p>Notes on ingredients, technique, and what's coming up on the
					menu.</p>
			</div>
			<div class="article-grid">
				<div class="article-card">
					<div class="article-photo p1">
						<img
							src="${pageContext.request.contextPath}/images/article-seasonal.jpg"
							alt="Seasonal vegetables and produce">
					</div>
					<div class="article-tag">Seasonal</div>
					<h3>What's In Season This Month, and Why It Matters</h3>
					<p>A look at how our menu shifts with the harvest, and what
						that means for flavor.</p>
					<div class="article-meta">Jul 2, 2026 · 4 min read</div>
					<a class="link-red" href="#">Read more →</a>
				</div>
				<div class="article-card">
					<div class="article-photo p2">
						<img
							src="${pageContext.request.contextPath}/images/article-kitchen.jpg"
							alt="Inside a zero-waste kitchen">
					</div>
					<div class="article-tag">Behind the Scenes</div>
					<h3>Inside Our Zero-Waste Kitchen</h3>
					<p>How we cut packaging waste without cutting corners on
						freshness.</p>
					<div class="article-meta">Jun 18, 2026 · 6 min read</div>
					<a class="link-red" href="#">Read more →</a>
				</div>
				<div class="article-card">
					<div class="article-photo p3">
						<img
							src="${pageContext.request.contextPath}/images/article-family.jpg"
							alt="A plated family meal">
					</div>
					<div class="article-tag">Guide</div>
					<h3>How to Build a Family Meal Plan That Actually Sticks</h3>
					<p>A practical guide to setting up recurring orders your whole
						household will eat.</p>
					<div class="article-meta">Jun 4, 2026 · 5 min read</div>
					<a class="link-red" href="#">Read more →</a>
				</div>
			</div>
		</div>
	</section>

	<section class="final-cta">
		<div class="wrap">
			<div>
				<h2>
					Ready to <span class="accent">taste</span> the difference?
				</h2>
				<a class="btn btn-filled-red" href="#">Get started</a>
			</div>
			<div class="final-photo">
				<img src="${pageContext.request.contextPath}/images/cta-final.jpg"
					alt="Elegant dining experience">
			</div>
		</div>
	</section>

	<div class="footer-band">
		<div class="wrap">
			<div class="brand-line">SwadExpress</div>
			<p>Seasonal meals, cooked fresh and delivered daily.</p>
		</div>
	</div>

	<div class="footer-links">
		<div class="wrap">
			<div class="footer-cols">
				<div>
					<h4>Company</h4>
					<ul>
						<li><a href="#">About</a></li>
						<li><a href="#">Careers</a></li>
						<li><a href="#">Press</a></li>
					</ul>
				</div>
				<div>
					<h4>Order</h4>
					<ul>
						<li><a href="#">Menu</a></li>
						<li><a href="#">Cart</a></li>
						<li><a href="#">Gift Cards</a></li>
					</ul>
				</div>
				<div>
					<h4>Occasions</h4>
					<ul>
						<li><a href="#">Family Meals</a></li>
						<li><a href="#">Office Catering</a></li>
						<li><a href="#">Gifting</a></li>
					</ul>
				</div>
				<div>
					<h4>Support</h4>
					<ul>
						<li><a href="#">FAQ</a></li>
						<li><a href="#">Contact Us</a></li>
						<li><a href="#">Blog</a></li>
					</ul>
				</div>
			</div>
			<div class="footer-bottom">
				<div>© 2026 SwadExpress</div>
				<div class="legal-links">
					<a href="#">Terms</a> <a href="#">Privacy</a> <a href="#">Do
						Not Sell My Info</a>
				</div>
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
    (function () {
      var track = document.getElementById('restaurantTrack');
      var prev = document.getElementById('restaurantPrev');
      var next = document.getElementById('restaurantNext');
      var scroller = document.getElementById('cuisineScroller');
      var cuisinePrev = document.getElementById('cuisinePrev');
      var cuisineNext = document.getElementById('cuisineNext');

      function makeCarousel(trackEl, prevEl, nextEl, itemSelector) {
        if (!trackEl || !prevEl || !nextEl) return null;

        function getStep() {
          var item = trackEl.querySelector(itemSelector + ':not(.is-hidden)');
          if (!item) return trackEl.clientWidth * 0.8;
          var gap = parseFloat(getComputedStyle(trackEl).columnGap || getComputedStyle(trackEl).gap || '24') || 24;
          return item.getBoundingClientRect().width + gap;
        }

        function updateArrows() {
          var maxScroll = trackEl.scrollWidth - trackEl.clientWidth;
          prevEl.disabled = trackEl.scrollLeft <= 4;
          nextEl.disabled = trackEl.scrollLeft >= maxScroll - 4;
        }

        prevEl.addEventListener('click', function () {
          trackEl.scrollBy({ left: -getStep(), behavior: 'smooth' });
        });
        nextEl.addEventListener('click', function () {
          trackEl.scrollBy({ left: getStep(), behavior: 'smooth' });
        });

        trackEl.addEventListener('scroll', updateArrows, { passive: true });
        window.addEventListener('resize', updateArrows);
        updateArrows();

        return { updateArrows: updateArrows };
      }

      var restaurantCarousel = makeCarousel(track, prev, next, '.restaurant-card');
      var cuisineCarousel = makeCarousel(scroller, cuisinePrev, cuisineNext, '.cuisine-chip');

      if (scroller && track) {
        var chips = scroller.querySelectorAll('.cuisine-chip');
        var cards = track.querySelectorAll('.restaurant-card');
        chips.forEach(function (chip) {
          chip.addEventListener('click', function () {
            chips.forEach(function (c) { c.classList.remove('active'); });
            chip.classList.add('active');
            var cuisine = chip.getAttribute('data-cuisine');
            cards.forEach(function (card) {
              var match = cuisine === 'all' || card.getAttribute('data-cuisine') === cuisine;
              card.classList.toggle('is-hidden', !match);
            });
            track.scrollTo({ left: 0, behavior: 'smooth' });
            if (restaurantCarousel) setTimeout(restaurantCarousel.updateArrows, 300);
          });
        });
      }
    })();
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
