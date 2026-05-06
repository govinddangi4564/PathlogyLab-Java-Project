<%@page import="com.pathology.model.Patient"%>
<%@page import="com.pathology.dao.PatientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Appointments</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
:root {
	--sidebar-width: 260px;
}

body {
	background: radial-gradient(circle at 12% 8%, #dff2ff 0%, #f5f9ff 34%, #eef3fa 100%);
}

.main-content {
	margin-left: var(--sidebar-width);
	padding: 28px 24px;
	min-height: calc(100vh - 70px);
}

.page-header {
	margin-bottom: 32px;
}

.page-header h2 {
	font-size: 2rem;
	font-weight: 700;
	margin: 0 0 8px;
	color: #0f172a;
}

.page-header p {
	margin: 0;
	color: #64748b;
	font-size: 1rem;
}

.card-hover {
	transition: all 0.3s ease;
	border: 1px solid #dbe6f2;
	background: rgba(255, 255, 255, 0.92);
	display: flex;
	flex-direction: column;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(15, 23, 42, 0.06);
	padding: 24px;
}

.card-hover:hover {
	transform: translateY(-8px);
	box-shadow: 0 12px 28px rgba(15, 23, 42, 0.12);
}

.card-hover .card-body {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	flex-grow: 1;
	padding: 0;
}

.card-icon {
	font-size: 3rem;
	margin-bottom: 16px;
}

.card-title {
	font-size: 1.2rem;
	font-weight: 700;
	color: #0f172a;
	margin-bottom: 12px;
}

.card-description {
	color: #64748b;
	font-size: 0.95rem;
	margin-bottom: 20px;
	flex-grow: 1;
}

.btn-card {
	align-self: flex-start;
	margin-top: auto;
	padding: 10px 24px;
	font-weight: 600;
	border-radius: 10px;
	white-space: nowrap;
}

.btn-card.btn-success {
	background: linear-gradient(90deg, #0f766e 0%, #115e59 100%);
	border: none;
	color: #fff;
}

.btn-card.btn-success:hover {
	background: linear-gradient(90deg, #0d5f57 0%, #0e4f48 100%);
	color: #fff;
}

.btn-card.btn-primary {
	background: linear-gradient(90deg, #2563eb 0%, #3b82f6 100%);
	border: none;
	color: #fff;
}

.btn-card.btn-primary:hover {
	background: linear-gradient(90deg, #1d4ed8 0%, #2563eb 100%);
	color: #fff;
}

.btn-card.btn-secondary:disabled {
	background: #cbd5e1;
	color: #64748b;
	cursor: not-allowed;
}

.appointments-grid {
	display: grid;
	gap: 24px;
}

/* Mobile Responsive */
@media ( max-width : 992px) {
	.main-content {
		margin-left: 0;
		padding: 16px 14px;
		padding-top: 90px;
	}
	.page-header {
		margin-bottom: 24px;
	}
	.page-header h2 {
		font-size: 1.6rem;
	}
	.card-icon {
		font-size: 2.5rem;
	}
	.card-title {
		font-size: 1.1rem;
	}
	.btn-card {
		width: 100%;
		text-align: center;
	}
	.appointments-grid {
		grid-template-columns: repeat(1, 1fr);
	}
}

/* Tablet View */
@media ( min-width : 768px) and (max-width: 992px) {
	.appointments-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

/* Desktop View */
@media ( min-width : 993px) {
	.appointments-grid {
		grid-template-columns: repeat(3, 1fr);
	}
}

/* Mobile Portrait */
@media ( max-width : 576px) {
	.main-content {
		padding: 12px 12px;
		padding-top: 80px;
	}
	.page-header h2 {
		font-size: 1.4rem;
	}
	.page-header p {
		font-size: 0.9rem;
	}
	.card-icon {
		font-size: 2.2rem;
	}
	.card-title {
		font-size: 1rem;
	}
	.card-description {
		font-size: 0.9rem;
	}
	.btn-card {
		padding: 8px 16px;
		font-size: 0.9rem;
	}
	.card-hover {
		padding: 16px;
	}
}
</style>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-user-page="appointments">
	<%@ include file="../Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	int userId = u.getId();
	PatientDao dao = new PatientDao();
	Patient p = dao.getPatientId(userId);
	String patientId = (p != null) ? p.getPatientId() : null;
	if ("USER".equals(role)) {
	%>
	<jsp:include page="userSidebar.jsp" />

	<div class="main-content">

		<div class="page-header">
			<div class="d-flex justify-content-between align-items-start">
				<div>
					<h2 class="fw-bold">Manage Appointments</h2>
					<p>Book, view, or manage your appointments</p>
				</div>
				<button onclick="history.back()"
					class="btn btn-outline-secondary btn-sm">
					<i class="fas fa-arrow-left me-2"></i>Back
				</button>
			</div>
		</div>

		<div class="appointments-grid">

			<div class="card card-hover">
				<div class="card-body text-center">
					<i class="bi bi-briefcase-fill card-icon text-success"></i>
					<h4 class="card-title">Book Appointment for Myself</h4>
					<p class="card-description">No need to enter details — we'll
						use your registered information.</p>

					<a
						href="<%=request.getContextPath()%>/Pages/User/bookAppointmentSelf.jsp"
						class="btn btn-success btn-card"> <i class="bi bi-plus"></i>
						Book Now
					</a>
				</div>
			</div>

			<div class="card card-hover">
				<div class="card-body text-center">
					<i class="bi bi-people-fill card-icon text-primary"></i>
					<h4 class="card-title">Book for Other Patient</h4>
					<p class="card-description">Provide patient details manually
						(Name, Email, Phone).</p>

					<a href="<%=request.getContextPath()%>/Pages/bookAppointment.jsp"
						class="btn btn-primary btn-card"> <i class="bi bi-plus"></i>
						Book Now
					</a>
				</div>
			</div>

			<div class="card card-hover">
				<div class="card-body text-center">
					<i class="bi bi-calendar-check-fill card-icon text-primary"></i>
					<h4 class="card-title">View My Appointment</h4>
					<p class="card-description">View details, reschedule, or cancel
						your appointment.</p>

					<%
					if (patientId != null && !patientId.isEmpty()) {
					%>
					<a
						href="<%=request.getContextPath()%>/viewMyAppointment?pId=<%=patientId%>"
						class="btn btn-primary btn-card"> <i class="bi bi-eye"></i>
						View Details
					</a>
					<%
					} else {
					%>
					<button class="btn btn-secondary btn-card" type="button" disabled>
						<i class="bi bi-exclamation-circle"></i> Profile Missing
					</button>
					<%
					}
					%>
				</div>
			</div>

		</div>

	</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
		
	</script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>

</body>

</html>