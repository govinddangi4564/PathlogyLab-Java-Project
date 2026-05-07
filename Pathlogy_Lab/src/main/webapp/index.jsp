<%@page import="com.pathology.dao.FeedbackDao"%>
<%@page import="com.pathology.model.Feedback"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Pathology Lab | Smart Report Portal</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Sora:wght@500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.2/css/all.min.css">

<link rel="stylesheet" href="Css/app-theme.css">
<link rel="stylesheet" href="Css/style.css">

</head>

<body>

	<nav class="navbar navbar-expand-lg sticky-top top-nav">
		<div class="container py-2">
			<a class="navbar-brand fw-bold d-flex align-items-center gap-2"
				href="#"><i class="fa-solid fa-microscope"></i> Pathology Lab</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#mainNav"
				aria-controls="mainNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="mainNav">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0 gap-lg-2">
					<li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
					<li class="nav-item"><a class="nav-link" href="#portals">Portals</a></li>
					<li class="nav-item"><a class="nav-link" href="#how-it-works">How
							It Works</a></li>
					<li class="nav-item"><a class="nav-link" href="#faq">FAQ</a></li>
					<li class="nav-item"><a class="btn btn-outline-brand"
						href="Pages/login.jsp">Login</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<header class="section-gap">

		<%@ include file="Pages/Components/message.jsp"%>

		<div class="container">
			<div class="row align-items-center g-4">
				<div class="col-lg-7 reveal">
					<span class="badge-pill">Trusted by Clinics and Diagnostic
						Centers</span>
					<h1 class="hero-title mt-3 fw-bold">One Portal for Every
						Pathology Report</h1>
					<p class="lead text-secondary mt-3">Manage report delivery with
						speed and security. Your staff uploads reports in seconds, and
						patients access them 24/7 from any device.</p>
					<div class="d-flex flex-wrap gap-2 mt-4">
						<a href="Pages/login.jsp" class="btn btn-brand">Access My
							Reports</a> <a href="Pages/login.jsp" class="btn btn-outline-brand">Admin
							Login</a>
					</div>
					<div class="mt-4">
						<span class="trust-chip"><i
							class="fa-solid fa-shield-heart"></i> Role-based Access</span> <span
							class="trust-chip"><i class="fa-solid fa-file-pdf"></i>
							PDF Download Ready</span> <span class="trust-chip"><i
							class="fa-solid fa-mobile-screen-button"></i> Mobile Friendly</span>
					</div>
				</div>
				<div class="col-lg-5 reveal delay-1">
					<div class="hero-card">
						<h5 class="fw-bold mb-3">Operational Highlights</h5>
						<div class="row g-3">
							<div class="col-6">
								<div class="hero-metric">
									<h3>2 min</h3>
									<p class="mb-0 small text-secondary">Average report upload</p>
								</div>
							</div>
							<div class="col-6">
								<div class="hero-metric">
									<h3>99.9%</h3>
									<p class="mb-0 small text-secondary">Portal uptime</p>
								</div>
							</div>
							<div class="col-6">
								<div class="hero-metric">
									<h3>24x7</h3>
									<p class="mb-0 small text-secondary">Patient access</p>
								</div>
							</div>
							<div class="col-6">
								<div class="hero-metric">
									<h3>100%</h3>
									<p class="mb-0 small text-secondary">Digital report history</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>

	<section class="quick-role-strip pb-3">
		<div class="container">
			<div class="row g-3">
				<div class="col-md-4 reveal">
					<div class="quick-role-card">
						<div class="d-flex align-items-center gap-3">
							<div class="quick-role-icon">
								<i class="fa-solid fa-user"></i>
							</div>
							<div>
								<h6>Patient Login</h6>
								<p>View reports and download PDFs</p>
							</div>
						</div>
						<a href="Pages/login.jsp" class="btn btn-sm btn-brand">Open</a>
					</div>
				</div>
				<div class="col-md-4 reveal delay-1">
					<div class="quick-role-card">
						<div class="d-flex align-items-center gap-3">
							<div class="quick-role-icon">
								<i class="fa-solid fa-user-gear"></i>
							</div>
							<div>
								<h6>Admin Console</h6>
								<p>Manage patients and reports</p>
							</div>
						</div>
						<a href="Pages/login.jsp" class="btn btn-sm btn-outline-brand">Open</a>
					</div>
				</div>
				<div class="col-md-4 reveal delay-2">
					<div class="quick-role-card">
						<div class="d-flex align-items-center gap-3">
							<div class="quick-role-icon">
								<i class="fa-solid fa-vial-circle-check"></i>
							</div>
							<div>
								<h6>Staff Workspace</h6>
								<p>Upload and track diagnostics</p>
							</div>
						</div>
						<a href="Pages/login.jsp" class="btn btn-sm btn-outline-brand">Open</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="portals" class="section-gap pt-0">
		<div class="container">
			<div class="text-center mb-4 reveal">
				<h2 class="fw-bold">Choose Your Portal</h2>
				<p class="text-secondary mb-0">Separate access for patients and
					admins with role-based functionality.</p>
			</div>
			<div class="row g-4">
				<div class="col-lg-6 reveal">
					<div class="info-card h-100">
						<div class="icon-wrap">
							<i class="fa-solid fa-user"></i>
						</div>
						<h4 class="fw-bold">Patient Portal</h4>
						<p class="text-secondary">Patients can securely sign in, view
							their test reports, and download PDF copies from anywhere.</p>
						<ul class="text-secondary mb-4">
							<li>Secure report access</li>
							<li>Mobile-friendly viewing</li>
							<li>Anytime download</li>
						</ul>
						<a href="Pages/login.jsp" class="btn btn-brand">Login Now</a>
					</div>
				</div>
				<div class="col-lg-6 reveal delay-1">
					<div class="info-card h-100">
						<div class="icon-wrap">
							<i class="fa-solid fa-user-gear"></i>
						</div>
						<h4 class="fw-bold">Admin Portal</h4>
						<p class="text-secondary">Lab admins can manage uploads,
							maintain report records, and monitor daily report workflow
							efficiently.</p>
						<ul class="text-secondary mb-4">
							<li>Upload and manage reports</li>
							<li>Central report tracking</li>
							<li>Operational dashboard</li>
						</ul>
						<a href="Pages/login.jsp" class="btn btn-outline-brand">Login
							Now</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="features" class="section-gap pt-0">
		<div class="container">
			<div class="text-center mb-5 reveal delay-1">
				<h2 class="fw-bold">Why Teams Choose Pathology Lab</h2>
				<p class="text-secondary mb-0">Built to reduce manual follow-up
					and improve patient satisfaction.</p>
			</div>
			<div class="row g-4">
				<div class="col-md-6 col-lg-4 reveal">
					<div class="info-card">
						<div class="icon-wrap">
							<i class="fa-solid fa-upload"></i>
						</div>
						<h5 class="fw-bold">Fast Report Upload</h5>
						<p class="text-secondary mb-0">Admins can upload reports
							instantly with patient details and report date in one step.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 reveal delay-1">
					<div class="info-card">
						<div class="icon-wrap">
							<i class="fa-solid fa-lock"></i>
						</div>
						<h5 class="fw-bold">Secure Login Access</h5>
						<p class="text-secondary mb-0">Patients access only their own
							reports through authenticated credentials.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 reveal delay-2">
					<div class="info-card">
						<div class="icon-wrap">
							<i class="fa-solid fa-file-arrow-down"></i>
						</div>
						<h5 class="fw-bold">Instant PDF Download</h5>
						<p class="text-secondary mb-0">Download finalized reports
							anytime, reducing repeated visits to the lab.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 reveal">
					<div class="info-card">
						<div class="icon-wrap">
							<i class="fa-solid fa-user-check"></i>
						</div>
						<h5 class="fw-bold">Patient-friendly Portal</h5>
						<p class="text-secondary mb-0">Simple interface with quick
							navigation for all ages and mobile usage.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 reveal delay-1">
					<div class="info-card">
						<div class="icon-wrap">
							<i class="fa-solid fa-clock-rotate-left"></i>
						</div>
						<h5 class="fw-bold">Report History</h5>
						<p class="text-secondary mb-0">Every uploaded report stays
							available in one place for future reference.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-4 reveal delay-2">
					<div class="info-card">
						<div class="icon-wrap">
							<i class="fa-solid fa-hospital"></i>
						</div>
						<h5 class="fw-bold">Lab-ready Workflow</h5>
						<p class="text-secondary mb-0">Designed for daily pathology
							operations with minimal training effort.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="how-it-works" class="section-gap">
		<div class="container">
			<div class="stat-strip mb-5 reveal delay-1">
				<div class="row g-3 text-center text-md-start">
					<div class="col-md-4">
						<h3 class="mb-0">15K+</h3>
						<p class="mb-0">Reports delivered digitally</p>
					</div>
					<div class="col-md-4">
						<h3 class="mb-0">180+</h3>
						<p class="mb-0">Daily active patients</p>
					</div>
					<div class="col-md-4">
						<h3 class="mb-0">35%</h3>
						<p class="mb-0">Lower front desk follow-up calls</p>
					</div>
				</div>
			</div>
			<div class="text-center mb-4 reveal">
				<h2 class="fw-bold">How It Works</h2>
				<p class="text-secondary mb-0">Three simple steps from upload to
					download.</p>
			</div>
			<div class="row g-4">
				<div class="col-md-4 reveal">
					<div class="step-card">
						<div class="step-number">Step 01</div>
						<div class="step-icon">
							<i class="fa-solid fa-user-plus"></i>
						</div>
						<h5 class="fw-bold">Register Patient</h5>
						<p class="text-secondary mb-0">Collect basic patient details
							once to make report tracking easy.</p>
					</div>
				</div>
				<div class="col-md-4 reveal delay-1">
					<div class="step-card">
						<div class="step-number">Step 02</div>
						<div class="step-icon">
							<i class="fa-solid fa-file-medical"></i>
						</div>
						<h5 class="fw-bold">Upload Diagnostics</h5>
						<p class="text-secondary mb-0">Admin uploads the report
							securely and links it to the patient's account.</p>
					</div>
				</div>
				<div class="col-md-4 reveal delay-2">
					<div class="step-card">
						<div class="step-number">Step 03</div>
						<div class="step-icon">
							<i class="fa-solid fa-eye"></i>
						</div>
						<h5 class="fw-bold">View or Download</h5>
						<p class="text-secondary mb-0">Patient logs in, opens reports,
							and downloads PDF copies anytime.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%
	FeedbackDao dao = new FeedbackDao();
	List<Feedback> list = dao.viewFeedback();
	%>

	<section class="section-gap pt-0">
		<div class="container">

			<div class="text-center mb-4 reveal">
				<h2 class="fw-bold">What Patients Say</h2>
				<p class="text-secondary">Real feedback from our patients</p>
			</div>

			<div class="row g-4">

				<%
				if (list != null) {
					for (Feedback f : list) {
				%>

				<div class="col-md-4 reveal">
					<div class="testimonial-card p-3 shadow-sm rounded">

						<div class="mb-2 text-warning">
							<%
							int rating = f.getRating();
							for (int i = 1; i <= 5; i++) {
								if (i <= rating) {
							%>
							<i class="fa-solid fa-star"></i>
							<%
							} else {
							%>
							<i class="fa-regular fa-star"></i>
							<%
							}
							}
							%>
						</div>

						<p class="mb-3">
							<%=f.getMessage()%>
						</p>

						<h6 class="mb-0 fw-bold">
							<%=f.getName()%>
						</h6>
						<small class="text-secondary">Patient</small>

					</div>
				</div>

				<%
				}
				}
				%>

			</div>
		</div>
	</section>

	<section id="faq" class="section-gap pt-0">
		<div class="container">
			<div class="row g-4 align-items-start">
				<div class="col-lg-5 reveal">
					<h2 class="fw-bold">Frequently Asked Questions</h2>
					<p class="text-secondary">Everything your patients and staff
						usually ask before starting.</p>
				</div>
				<div class="col-lg-7 reveal delay-1">
					<div class="faq-box">
						<div class="accordion accordion-flush" id="faqAccordion">
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse" data-bs-target="#faqOne"
										aria-expanded="true" aria-controls="faqOne">How do
										patients access reports?</button>
								</h2>
								<div id="faqOne" class="accordion-collapse collapse show"
									data-bs-parent="#faqAccordion">
									<div class="accordion-body">Patients log in using their
										credentials and can open or download available PDF reports.</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#faqTwo"
										aria-expanded="false" aria-controls="faqTwo">Is
										report data secure?</button>
								</h2>
								<div id="faqTwo" class="accordion-collapse collapse"
									data-bs-parent="#faqAccordion">
									<div class="accordion-body">Yes. Access is
										authentication-based and users can only view records mapped to
										their account.</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#faqThree"
										aria-expanded="false" aria-controls="faqThree">Can
										admin upload reports before registration?</button>
								</h2>
								<div id="faqThree" class="accordion-collapse collapse"
									data-bs-parent="#faqAccordion">
									<div class="accordion-body">Yes, admin can prepare upload
										records and link them to patient profiles as needed.</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="section-gap pt-0">
		<div class="container">
			<div class="contact-box reveal">
				<div class="row g-4 align-items-center">

					<!-- Left Content -->
					<div class="col-lg-5">
						<h3 class="fw-bold">Patient Feedback</h3>
						<p class="text-secondary mb-0">We value your experience.
							Please share your feedback to help us improve our services.</p>
					</div>

					<!-- Feedback Form -->
					<div class="col-lg-7">
						<form action="<%=request.getContextPath()%>/submitFeedback"
							method="post">
							<div class="row g-3">

								<div class="col-md-6">
									<input type="text" name="name" class="form-control"
										placeholder="Patient Name" required>
								</div>

								<div class="col-md-6">
									<input type="email" name="email" class="form-control"
										placeholder="Email Address">
								</div>

								<div class="col-md-6">
									<input type="text" name="phone" class="form-control"
										placeholder="Phone Number">
								</div>

								<div class="col-md-6">
									<select name="rating" class="form-control" required>
										<option value="">Rate Our Service</option>
										<option value="5">Excellent ⭐⭐⭐⭐⭐</option>
										<option value="4">Good ⭐⭐⭐⭐</option>
										<option value="3">Average ⭐⭐⭐</option>
										<option value="2">Poor ⭐⭐</option>
										<option value="1">Very Poor ⭐</option>
									</select>
								</div>

								<div class="col-12">
									<textarea name="message" class="form-control" rows="3"
										placeholder="Your Feedback" required></textarea>
								</div>

							</div>

							<button class="btn btn-brand mt-3" type="submit">Submit
								Feedback</button>
						</form>
					</div>

				</div>
			</div>
		</div>
	</section>

	<footer class="footer py-5 mt-3">
		<div class="container">
			<div class="row g-4">
				<div class="col-lg-4">
					<h5 class="fw-bold">Pathology Lab</h5>
					<p class="mb-2">Digital healthcare solution for modern
						diagnostic labs.</p>
					<p class="mb-0 small">
						&copy; <span id="currentYear"></span> Pathology Lab. All rights
						reserved.
					</p>
				</div>
				<div class="col-lg-4">
					<h6 class="fw-bold">Quick Links</h6>
					<p class="mb-1">
						<a href="#features">Features</a>
					</p>
					<p class="mb-1">
						<a href="#how-it-works">How It Works</a>
					</p>
					<p class="mb-0">
						<a href="Pages/login.jsp">Login</a>
					</p>
				</div>
				<div class="col-lg-4">
					<h6 class="fw-bold">Contact</h6>
					<p class="mb-1">
						<i class="fa-solid fa-envelope me-2"></i>support@lab.com
					</p>
					<p class="mb-1">
						<i class="fa-solid fa-phone me-2"></i>+91 99999 99999
					</p>
					<p class="mb-0">
						<i class="fa-solid fa-location-dot me-2"></i>City Center, India
					</p>
				</div>
			</div>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>
	<script>
		document.getElementById('currentYear').textContent = new Date()
				.getFullYear();
	</script>

</body>

</html>