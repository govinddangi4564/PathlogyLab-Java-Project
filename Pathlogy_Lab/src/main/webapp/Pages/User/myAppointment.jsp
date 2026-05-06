<%@page import="com.pathology.model.Appointment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Appointment</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
:root {
	--page-bg: radial-gradient(circle at top left, #e0f2fe 0%, #f8fbff 34%, #eef4fb
		100%);
	--sidebar-width: 260px;
	--card-bg: rgba(255, 255, 255, 0.92);
	--ink: #0f172a;
	--muted: #64748b;
	--line: #dbe5f1;
	--primary: #2563eb;
	--primary-soft: #dbeafe;
	--success: #0f766e;
	--warning: #b45309;
	--danger: #be123c;
	--shadow: 0 20px 40px rgba(15, 23, 42, 0.12);
	--radius: 22px;
}

body {
	margin: 0;
	font-family: 'Outfit', sans-serif;
	background: var(--page-bg);
	color: var(--ink);
}

.page-shell {
	min-height: calc(100vh - 70px);
	margin-left: var(--sidebar-width);
	padding: 28px 22px;
}

.page-wrap {
	max-width: 1180px;
	margin: 0 auto;
}

.hero {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 18px;
	flex-wrap: wrap;
	margin-bottom: 22px;
}

.hero-copy h1 {
	font-size: clamp(2rem, 3vw, 2.8rem);
	font-weight: 800;
	margin: 0 0 10px;
}

.hero-copy p {
	margin: 0;
	color: var(--muted);
	max-width: 760px;
}

.back-link {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 10px 16px;
	border-radius: 999px;
	text-decoration: none;
	font-weight: 700;
	color: var(--primary);
	background: #eff6ff;
	border: 1px solid #bfdbfe;
	white-space: nowrap;
}

.back-link:hover {
	background: #dbeafe;
	color: #1d4ed8;
}

.appointment-card {
	background: var(--card-bg);
	border: 1px solid var(--line);
	border-radius: var(--radius);
	box-shadow: var(--shadow);
	overflow: hidden;
}

.card-top {
	padding: 28px;
	background: linear-gradient(135deg, #eff6ff 0%, #f8fbff 48%, #eefdfb 100%);
	border-bottom: 1px solid var(--line);
}

.summary-grid {
	display: grid;
	grid-template-columns: repeat(12, minmax(0, 1fr));
	gap: 16px;
}

.summary-panel {
	grid-column: span 12;
	padding: 24px;
	background: rgba(255, 255, 255, 0.8);
	border: 1px solid rgba(219, 229, 241, 0.95);
	border-radius: 18px;
	backdrop-filter: blur(8px);
}

.status-chip {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 8px 14px;
	border-radius: 999px;
	font-weight: 700;
	font-size: 0.92rem;
	background: #ecfeff;
	color: var(--success);
}

.status-chip i {
	font-size: 0.95rem;
}

.appointment-id {
	margin-top: 16px;
	font-size: 2.2rem;
	font-weight: 800;
	letter-spacing: 0.2px;
}

.meta-row {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-top: 14px;
}

.meta-pill {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 9px 14px;
	border-radius: 999px;
	background: #ffffff;
	border: 1px solid var(--line);
	color: var(--ink);
	font-weight: 600;
}

.meta-pill i {
	color: var(--primary);
}

.field-section {
	padding: 26px 28px 30px;
}

.section-heading {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 12px;
	margin-bottom: 18px;
	flex-wrap: wrap;
}

.section-heading h2 {
	margin: 0;
	font-size: 1.35rem;
	font-weight: 800;
}

.section-heading p {
	margin: 0;
	color: var(--muted);
}

.field-grid {
	display: grid;
	grid-template-columns: repeat(12, minmax(0, 1fr));
	gap: 16px;
}

.info-box {
	grid-column: span 12;
	padding: 18px 18px 16px;
	background: #ffffff;
	border: 1px solid var(--line);
	border-radius: 16px;
	box-shadow: 0 10px 22px rgba(15, 23, 42, 0.05);
}

.info-label {
	display: flex;
	align-items: center;
	gap: 10px;
	font-size: 0.88rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.08em;
	color: var(--muted);
	margin-bottom: 10px;
}

.info-label i {
	width: 30px;
	height: 30px;
	border-radius: 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	background: var(--primary-soft);
	color: var(--primary);
}

.info-value {
	font-size: 1.05rem;
	font-weight: 700;
	color: var(--ink);
}

.info-note {
	margin-top: 6px;
	color: var(--muted);
	font-size: 0.93rem;
}

.priority-high {
	color: var(--danger);
}

.priority-medium {
	color: var(--warning);
}

.priority-normal {
	color: var(--success);
}

.footer-note {
	margin-top: 18px;
	padding: 14px 18px;
	border-radius: 14px;
	background: #f8fafc;
	border: 1px dashed #cbd5e1;
	color: var(--muted);
}

.section-divider {
	margin: 32px 0 24px;
	padding: 16px;
	background: linear-gradient(90deg, #eff6ff 0%, transparent 100%);
	border-left: 4px solid var(--primary);
	border-radius: 0 12px 12px 0;
}

.section-divider h3 {
	margin: 0;
	font-size: 1.15rem;
	font-weight: 800;
	color: var(--primary);
	display: flex;
	align-items: center;
	gap: 10px;
}

.section-divider i {
	font-size: 1.3rem;
}

.highlight-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 16px;
	margin-bottom: 24px;
}

.highlight-card {
	background: linear-gradient(135deg, #ffffff 0%, #f8fbff 100%);
	border: 2px solid var(--primary);
	border-radius: 16px;
	padding: 24px;
	text-align: center;
	box-shadow: 0 8px 16px rgba(37, 99, 235, 0.12);
	transition: all 0.3s ease;
}

.highlight-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 24px rgba(37, 99, 235, 0.18);
}

.highlight-label {
	font-size: 0.75rem;
	text-transform: uppercase;
	letter-spacing: 1px;
	font-weight: 700;
	color: var(--muted);
	margin-bottom: 8px;
	display: block;
}

.highlight-value {
	font-size: 1.8rem;
	font-weight: 800;
	color: var(--primary);
	line-height: 1.2;
	margin-bottom: 12px;
}

.highlight-card i {
	font-size: 2rem;
	color: var(--primary);
	margin-bottom: 8px;
	display: block;
}

.simple-info-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	gap: 16px;
	margin-bottom: 24px;
}

.simple-info-item {
	background: #ffffff;
	border: 1px solid var(--line);
	border-radius: 14px;
	padding: 18px;
	box-shadow: 0 4px 12px rgba(15, 23, 42, 0.05);
}

.simple-info-item-label {
	font-size: 0.8rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	font-weight: 700;
	color: var(--muted);
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.simple-info-item-label i {
	font-size: 1.1rem;
	color: var(--primary);
}

.simple-info-item-value {
	font-size: 1.2rem;
	font-weight: 700;
	color: var(--ink);
}

.action-required {
	background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
	border: 2px solid #f59e0b;
	border-radius: 14px;
	padding: 20px;
	margin-bottom: 24px;
}

.action-required h4 {
	margin: 0 0 12px;
	color: #b45309;
	font-size: 1.1rem;
	display: flex;
	align-items: center;
	gap: 10px;
}

.action-required i {
	font-size: 1.3rem;
}

.action-required p {
	margin: 0;
	color: #92400e;
	line-height: 1.6;
	font-weight: 500;
}

@media ( min-width : 768px) {
	.summary-panel {
		grid-column: span 5;
	}
	.highlight-grid {
		grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
	}
}

@media ( min-width : 992px) {
	.summary-panel {
		grid-column: span 4;
	}
	.highlight-grid {
		grid-template-columns: repeat(3, 1fr);
	}
	.simple-info-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 992px) {
	.page-shell {
		margin-left: 0;
		padding: 20px 14px;
	}
	.highlight-card {
		padding: 16px;
	}
	.highlight-value {
		font-size: 1.4rem;
	}
}
</style>
</head>

<body data-user-page="appointments">

	<%@ include file="../Components/auth.jsp"%>

	<%
	List<Appointment> list = (List<Appointment>) request.getAttribute("myAppointment");
	Appointment ap = (list != null && !list.isEmpty()) ? list.get(0) : null;
	%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("USER".equals(role)) {
	%>
	<jsp:include page="userSidebar.jsp" />

	<div class="page-shell">
		<div class="page-wrap">
			<div class="hero">
				<div class="hero-copy">
					<h1>My Appointment</h1>
				</div>
				<button onclick="history.back()"
					class="btn btn-outline-secondary btn-sm">
					<i class="fas fa-arrow-left me-2"></i>Back
				</button>
			</div>
			<a
				href="<%=request.getContextPath()%>/Pages/User/manageAppointments.jsp"
				class="back-link"><i class="bi bi-arrow-left"></i> Back to
				dashboard</a>
		</div>

		<%
		if (ap != null) {
		%>
		<div class="appointment-card">
			<div class="card-top">
				<div class="summary-grid">
					<div class="summary-panel">
						<span class="status-chip"><i
							class="bi bi-check-circle-fill"></i> <%=ap.getStatus()%> </span>
						<div class="appointment-id">
							Appointment #<%=ap.getId()%>
						</div>
						<div class="meta-row">
							<span class="meta-pill"><i class="bi bi-calendar-event"></i>
								<%=ap.getAppointmentDate()%> </span> <span class="meta-pill"><i
								class="bi bi-clock"></i> <%=ap.getAppointmentTime()%> </span>
						</div>
					</div>

					<div class="summary-panel">
						<div class="info-label">
							<i class="bi bi-capsule-pill"></i> Test
						</div>
						<div class="info-value">
							<%=ap.getTestName()%>
						</div>
						<div class="info-note">Diagnostic test scheduled</div>
					</div>

					<div class="summary-panel">
						<div class="info-label">
							<i class="bi bi-geo-alt"></i> Lab Location
						</div>
						<div class="info-value">
							<%=ap.getLabLocation()%>
						</div>
						<div class="info-note">Please arrive 10 minutes early</div>
					</div>
				</div>
			</div>

			<div class="field-section">

				<!-- Important Alert -->
				<div class="action-required">
					<h4>
						<i class="bi bi-exclamation-circle-fill"></i> Important - Please
						Read
					</h4>
					<p>
						✓ Arrive <strong>10 minutes early</strong> to your appointment <br>✓
						Bring a valid <strong>ID & Medical Insurance card</strong> (if
						applicable) <br>✓ Come <strong>fasting</strong> (if required
						for your test - check your confirmation email) <br>✓ Wear
						comfortable, loose-fitting clothing for easy sample collection
					</p>
				</div>

				<!-- When Section -->
				<div class="section-divider">
					<h3>
						<i class="bi bi-calendar3-event"></i> When is your appointment?
					</h3>
				</div>

				<div class="highlight-grid">
					<div class="highlight-card">
						<i class="bi bi-calendar2-check"></i> <span
							class="highlight-label">Date</span> <span class="highlight-value">
							<%=ap.getAppointmentDate()%>
						</span>
					</div>
					<div class="highlight-card">
						<i class="bi bi-clock-fill"></i> <span class="highlight-label">Time</span>
						<span class="highlight-value"> <%=ap.getAppointmentTime()%>
						</span>
					</div>
					<div class="highlight-card">
						<i class="bi bi-hourglass-split"></i> <span
							class="highlight-label">Status</span> <span
							class="highlight-value" style="color: var(--success);"> <%=ap.getStatus()%>
						</span>
					</div>
					<%
					if (ap.getToken() > 0) {
					%>
					<div class="highlight-card">
						<i class="bi bi-ticket-perforated"></i> <span
							class="highlight-label">Token</span> <span
							class="highlight-value"> <%=ap.getToken()%>
						</span>
					</div>
					<%
					}
					%>
				</div>

				<!-- What Section -->
				<div class="section-divider">
					<h3>
						<i class="bi bi-stethoscope"></i> What test are you taking?
					</h3>
				</div>

				<div class="simple-info-grid">
					<div class="simple-info-item">
						<span class="simple-info-item-label"> <i
							class="bi bi-capsule"></i> Test Name
						</span>
						<div class="simple-info-item-value">
							<%=ap.getTestName()%>
						</div>
					</div>
					<div class="simple-info-item">
						<span class="simple-info-item-label"> <i
							class="bi bi-lightning"></i> Priority
						</span>
						<div class="simple-info-item-value">
							<%=ap.getPriority()%>
						</div>
					</div>
				</div>

				<!-- Where Section -->
				<div class="section-divider">
					<h3>
						<i class="bi bi-geo-alt"></i> Where to go?
					</h3>
				</div>

				<div class="simple-info-grid">
					<div class="simple-info-item">
						<span class="simple-info-item-label"> <i
							class="bi bi-building"></i> Lab Location
						</span>
						<div class="simple-info-item-value">
							<%=ap.getLabLocation()%>
						</div>
					</div>
					<div class="simple-info-item">
						<span class="simple-info-item-label"> <i
							class="bi bi-diagram-3"></i> Booking Type
						</span>
						<div class="simple-info-item-value">
							<%=ap.getMode()%>
						</div>
					</div>
				</div>

				<!-- Helpful Footer -->
				<div class="footer-note">
					<i class="bi bi-info-circle me-2"></i><strong>Need Help?</strong>
					Check your email for your appointment confirmation letter with
					additional details. If you need to reschedule, contact us at least
					24 hours before your appointment.
				</div>
			</div>
		</div>
		<%
		} else {
		%>
		<div class="appointment-card">
			<div class="field-section">
				<div class="section-heading">
					<div>
						<h2>No Appointment Found</h2>
						<p>We could not find any appointment details for your account.</p>
					</div>
				</div>
				<div class="footer-note">
					<i class="bi bi-info-circle me-2"></i>Please book an appointment
					from the appointments page.
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>
	</div>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>
</body>

</html>