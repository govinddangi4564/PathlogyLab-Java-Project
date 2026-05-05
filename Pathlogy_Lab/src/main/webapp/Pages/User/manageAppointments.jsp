<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Appointments</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
.card-hover:hover {
	transform: translateY(-5px);
	transition: 0.3s;
}

.main-content {
	padding: 20px;
}
</style>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-admin-page="patients">
	<%@ include file="../Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");

	if ("USER".equals(role)) {
	%>
	<jsp:include page="userSidebar.jsp" />

	<div class="main-content">

		<div class="mb-4">
			<h2 class="fw-bold">Manage Appointments</h2>
			<p class="text-muted">View Appointments and Book Appointment</p>
		</div>

		<div class="row g-4">

			<div class="col-md-6">
				<div class="card shadow border-0 card-hover h-100">
					<div class="card-body text-center">

						<i class="bi bi-briefcase-fill fs-1 text-success"></i>

						<h4 class="mt-3">Book Appointment for Myself</h4>
						<p class="text-muted">No need to enter details — we’ll use
							your registered information.</p>

						<a
							href="<%=request.getContextPath()%>/Pages/User/bookAppointmentSelf.jsp"
							class="btn btn-success px-4"> <i class="bi bi-plus"></i> Book
							Appointment
						</a>

					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="card shadow border-0 card-hover h-100">
					<div class="card-body text-center">

						<i class="bi bi-people-fill fs-1 text-primary"></i>

						<h4 class="mt-3">Book Appointment for Other Patient</h4>
						<p class="text-muted">Provide patient details manually (Name,
							Email, Phone).</p>

						<a href="<%=request.getContextPath()%>/Pages/bookAppointment.jsp"
							class="btn btn-primary px-4"> <i class="bi bi-plus"></i> View
							Patients
						</a>

					</div>
				</div>
			</div>
			
			<div class="col-md-6">
				<div class="card shadow border-0 card-hover h-100">
					<div class="card-body text-center">

						<i class="bi bi-people-fill fs-1 text-primary"></i>

						<h4 class="mt-3">View My Appointment</h4>
						<p class="text-muted">View Appointment, Change time-slot, Date, Location and Cancel Appointment.</p>

						<a href="<%=request.getContextPath()%>/viewMyAppointment"
							class="btn btn-primary px-4"> <i class="bi bi-eye"></i> View
							Patients
						</a>

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
