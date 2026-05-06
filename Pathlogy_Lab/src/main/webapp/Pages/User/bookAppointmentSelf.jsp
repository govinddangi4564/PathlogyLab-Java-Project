<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

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

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
:root {
	--sidebar-width: 260px;
	--primary: #2563eb;
	--success: #0f766e;
	--text-dark: #0f172a;
	--text-muted: #64748b;
	--border-light: #dbe6f2;
}

body {
	background: radial-gradient(circle at 12% 8%, #dff2ff 0%, #f5f9ff 34%, #eef3fa 100%);
	font-family: 'Outfit', sans-serif;
}

.page-wrap {
	margin-left: var(--sidebar-width);
	padding: 28px 24px;
	min-height: calc(100vh - 70px);
}

.booking-panel {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	padding: 32px;
	box-shadow: 0 4px 20px rgba(15, 23, 42, 0.08);
	border: 1px solid var(--border-light);
	max-width: 700px;
	margin: 0 auto;
}

.panel-head {
	display: flex;
	gap: 20px;
	margin-bottom: 32px;
	align-items: flex-start;
}

.icon-chip {
	width: 60px;
	height: 60px;
	background: linear-gradient(135deg, var(--primary) 0%, #3b82f6 100%);
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.8rem;
	color: white;
	flex-shrink: 0;
}

.panel-title {
	font-size: 1.8rem;
	font-weight: 700;
	color: var(--text-dark);
	margin: 0 0 8px 0;
}

.panel-subtitle {
	color: var(--text-muted);
	margin: 0;
	font-size: 0.95rem;
}

.form-label {
	font-weight: 600;
	color: var(--text-dark);
	margin-bottom: 10px;
	font-size: 0.95rem;
}

.form-select, .form-control {
	border: 1px solid var(--border-light);
	border-radius: 10px;
	padding: 10px 14px;
	font-size: 0.95rem;
	transition: all 0.3s ease;
}

.form-select:focus, .form-control:focus {
	border-color: var(--primary);
	box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.priority-wrap {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
}

.priority-option {
	display: flex;
	align-items: center;
	gap: 8px;
	cursor: pointer;
	font-weight: 500;
	color: var(--text-muted);
}

.priority-option input[type="radio"] {
	cursor: pointer;
	accent-color: var(--primary);
}

.btn-book {
	width: 100%;
	padding: 12px 24px;
	background: linear-gradient(90deg, var(--primary) 0%, #3b82f6 100%);
	color: white;
	border: none;
	border-radius: 10px;
	font-weight: 600;
	font-size: 1rem;
	cursor: pointer;
	transition: all 0.3s ease;
	margin-top: 20px;
}

.btn-book:hover {
	background: linear-gradient(90deg, #1d4ed8 0%, #2563eb 100%);
	transform: translateY(-2px);
	box-shadow: 0 8px 16px rgba(37, 99, 235, 0.3);
}

/* Mobile Responsive */
@media ( max-width : 992px) {
	.page-wrap {
		margin-left: 0;
		padding: 16px 14px;
		padding-top: 90px;
	}
	.booking-panel {
		padding: 24px;
	}
	.panel-head {
		gap: 16px;
	}
	.icon-chip {
		width: 50px;
		height: 50px;
		font-size: 1.4rem;
	}
	.panel-title {
		font-size: 1.4rem;
	}
	.panel-subtitle {
		font-size: 0.9rem;
	}
}

/* Tablet View */
@media ( min-width : 768px) and (max-width: 992px) {
	.booking-panel {
		max-width: 600px;
	}
}

/* Mobile Portrait */
@media ( max-width : 576px) {
	.page-wrap {
		padding: 12px 12px;
		padding-top: 80px;
	}
	.booking-panel {
		padding: 18px;
		border-radius: 12px;
	}
	.panel-head {
		flex-direction: column;
		gap: 12px;
	}
	.icon-chip {
		width: 48px;
		height: 48px;
		font-size: 1.3rem;
	}
	.panel-title {
		font-size: 1.3rem;
	}
	.panel-subtitle {
		font-size: 0.85rem;
	}
	.form-label {
		font-size: 0.9rem;
	}
	.form-select, .form-control {
		padding: 8px 10px;
		font-size: 0.9rem;
	}
	.priority-wrap {
		gap: 16px;
	}
	.btn-book {
		padding: 10px 16px;
		font-size: 0.9rem;
	}
}
</style>
</head>

<body>
	<%@ include file="../Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("USER".equals(role)) {
	%>
	<jsp:include page="userSidebar.jsp" />

	<div class="page-wrap">
		<%@include file="../Components/message.jsp"%>
		<div class="booking-panel">
			<div class="panel-head">
				<div
					style="display: flex; gap: 20px; align-items: flex-start; width: 100%; justify-content: space-between;">
					<div style="display: flex; gap: 20px; align-items: flex-start;">
						<div class="icon-chip">
							<i class="fas fa-calendar-plus"></i>
						</div>
						<div>
							<h1 class="panel-title">Book Your Appointment</h1>
							<p class="panel-subtitle">Fill in your details to book a
								diagnostic test appointment.</p>
						</div>
					</div>
					<button onclick="history.back()"
						class="btn btn-outline-secondary btn-sm" title="Go back">
						<i class="fas fa-arrow-left"></i>
					</button>
				</div>
			</div>
			<!-- Keep the old structure hidden -->
			<div style="display: none;">
				<div class="icon-chip">
					<i class="fas fa-calendar-plus"></i>
				</div>
				<div>
					<h1 class="panel-title">Book Your Appointment</h1>
					<p class="panel-subtitle">Fill in your details to book a
						diagnostic test appointment.</p>
				</div>
			</div>

			<form id="appointmentForm"
				action="<%=request.getContextPath()%>/bookAppointment" method="post">
				<div class="row g-3">
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

					<input type="hidden" name="mode" value="Online"> <input
						type="hidden" name="status" value="Booked"> <input
						type="hidden" name="patientName" value="<%=u.getName()%>">
					<input type="hidden" name="patientEmail" value="<%=u.getEmail()%>">
					<input type="hidden" name="patientMobile"
						value="<%=u.getMobile()%>">

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