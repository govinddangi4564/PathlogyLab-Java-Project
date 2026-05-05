<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Appointment | PathLab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/Css/bookAppointment.css">
</head>

<body>
	<%@ include file="Components/auth.jsp"%>
	<%@ include file="Components/loader.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");

	if ("ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role) || "USER".equalsIgnoreCase(role)) {
	%>

	<%
	if ("STAFF".equals(role)) {
	%>
	<jsp:include page="Staff/staffSidebar.jsp" />
	<%
	} else if ("ADMIN".equals(role)) {
	%>
	<jsp:include page="adminSidebar.jsp" />
	<%
	} else if ("USER".equals(role)) {
	%>
	<jsp:include page="User/userSidebar.jsp" />
	<%
	}
	%>

	<div class="page-wrap">
		<%@include file="Components/message.jsp"%>
		<div class="booking-panel">
			<div class="panel-head">
				<div class="icon-chip">
					<i class="fa-solid fa-calendar-plus"></i>
				</div>
				<div>
					<h1 class="panel-title">Appointment Booking System</h1>
					<p class="panel-subtitle">Fill in your details to book a
						diagnostic test appointment.</p>
				</div>
			</div>

			<form id="appointmentForm"
				action="<%=request.getContextPath()%>/bookAppointment" method="post">
				<div class="row g-3">
					<div class="col-md-4">
						<label for="patientName" class="form-label">Patient Name</label> <input
							type="text" id="patientName" name="patientName"
							class="form-control" placeholder="Enter patient name" required>
					</div>

					<div class="col-md-4">
						<label for="patientEmail" class="form-label">Patient Email</label>
						<input type="email" id="patientEmail" name="patientEmail"
							class="form-control" placeholder="Enter email address" required>
					</div>

					<div class="col-md-4">
						<label for="patientMobile" class="form-label">Patient
							Mobile</label> <input type="tel" id="patientMobile" name="patientMobile"
							class="form-control" placeholder="Enter mobile number"
							pattern="[0-9]{10}" required>
					</div>

					<div class="col-md-6">
						<label for="testName" class="form-label">Test Name</label> <select
							id="testName" name="testName" class="form-select" required>
							<option value="">Select test</option>
							<option value="Blood Test">Blood Test</option>
							<option value="X-Ray">X-Ray</option>
							<option value="MRI">MRI</option>
							<option value="CT Scan">CT Scan</option>
							<option value="ECG">ECG</option>
						</select>
					</div>

					<div class="col-md-6">
						<label for="appointmentDate" class="form-label">Appointment
							Date</label> <input type="date" id="appointmentDate"
							name="appointmentDate" class="form-control" required>
					</div>

					<%
					if ("USER".equals(role)) {
					%>

					<div class="col-md-6">
						<label for="timeSlot" class="form-label">Time Slot</label> <select
							id="timeSlot" name="appointmentTime" class="form-select" required>
							<option value="">Select time slot</option>
							<option value="10:00">10:00-10:30</option>
							<option value="10:30">10:30-11:00</option>
							<option value="11:00">11:00-11:30</option>
							<option value="11:30">11:30-12:00</option>
							<option value="14:00">14:00-14:30</option>
							<option value="14:30">14:30-15:00</option>
						</select>
					</div>
					<%
					}
					%>

					<div class="col-md-6">
						<label for="labLocation" class="form-label">Lab Location</label> <select
							id="labLocation" name="labLocation" class="form-select" required>
							<option value="">Select location</option>
							<option value="Central PathLab - Downtown">Central
								PathLab - Downtown</option>
							<option value="North Branch Lab">North Branch Lab</option>
							<option value="City Diagnostic Center">City Diagnostic
								Center</option>
							<option value="Home Sample Collection">Home Sample
								Collection</option>
						</select>
					</div>

					<div class="col-12">
						<label class="form-label">Priority</label>
						<div class="priority-wrap">
							<label class="priority-option" for="priorityNormal"> <input
								type="radio" name="priority" id="priorityNormal" value="Normal"
								checked> Normal
							</label> <label class="priority-option" for="priorityUrgent"> <input
								type="radio" name="priority" id="priorityUrgent" value="Urgent">
								Urgent
							</label>
						</div>
					</div>

					<%
					if ("USER".equals(role)) {
					%>

					<input type="hidden" name="mode" value="Online"> <input
						type="hidden" name="status" value="Booked">

					<%
					}
					%>

					<%
					if ("ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role)) {
					%>

					<input type="hidden" name="mode" value="Offline"> <input
						type="hidden" name="status" value="Confirmed">

					<%
					}
					%>

					<div class="col-12 mt-1">
						<button type="submit" class="btn-book">
							<i class="fa-solid fa-paper-plane me-2"></i>Book Appointment
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script>
		const appointmentDate = document.getElementById("appointmentDate");
		const today = new Date();
		today.setHours(0, 0, 0, 0);
		const localMinDate = today.getFullYear() + "-"
				+ String(today.getMonth() + 1).padStart(2, "0") + "-"
				+ String(today.getDate()).padStart(2, "0");
		appointmentDate.min = localMinDate;
	</script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>
</body>

</html>