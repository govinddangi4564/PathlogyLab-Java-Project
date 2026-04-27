<%@page import="com.pathology.model.Appointment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Appointments | PathLab</title>

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">

<style>
:root {
	--bg-grad: radial-gradient(circle at 12% 18%, #e3f2ff 0%, #f8fbff 36%, #eef5ff 100%
		);
	--panel-bg: rgba(255, 255, 255, 0.95);
	--border: #dbe6f2;
	--text: #0f172a;
	--muted: #64748b;
	--primary: #2563eb;
	--shadow: 0 20px 38px rgba(15, 23, 42, 0.08);
}

body {
	font-family: "Outfit", sans-serif;
	background: var(--bg-grad);
	color: var(--text);
	min-height: 100vh;
}

.dashboard-wrap {
	max-width: 1240px;
	margin: 0 auto;
}

.page-head {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	gap: 14px;
	margin-bottom: 18px;
	flex-wrap: wrap;
}

.page-title {
	font-size: 1.9rem;
	font-weight: 700;
	margin: 0;
}

.page-subtitle {
	margin: 4px 0 0;
	color: var(--muted);
}

.summary-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
	gap: 12px;
	margin-bottom: 16px;
}

.summary-card {
	background: var(--panel-bg);
	border: 1px solid var(--border);
	border-radius: 14px;
	padding: 14px;
	box-shadow: 0 8px 18px rgba(15, 23, 42, 0.04);
}

.summary-label {
	font-size: 0.82rem;
	color: var(--muted);
	margin-bottom: 2px;
}

.summary-value {
	font-size: 1.4rem;
	font-weight: 700;
	line-height: 1.1;
}

.panel {
	background: var(--panel-bg);
	border: 1px solid var(--border);
	border-radius: 18px;
	box-shadow: var(--shadow);
	padding: 16px;
}

.table-wrap {
	border: 1px solid #e2e8f0;
	border-radius: 14px;
	overflow: hidden;
	background: #fff;
}

.table .view-btn {
	min-width: 86px;
	font-size: 0.8rem;
	font-weight: 600;
	border-radius: 9px;
}

.appointment-details-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 10px;
}

.detail-item {
	background: #f8fbff;
	border: 1px solid #e8eef7;
	border-radius: 12px;
	padding: 10px 12px;
}

.detail-label {
	display: block;
	font-size: 0.73rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.4px;
	color: var(--muted);
	margin-bottom: 4px;
}

.detail-value {
	font-size: 0.92rem;
	font-weight: 600;
	color: var(--text);
	word-break: break-word;
}

.appointment-actions {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
}

.modal {
	z-index: 2000;
}

.modal-backdrop {
	z-index: 1990;
}

.filter-row .form-control, .filter-row .form-select {
	border-radius: 11px;
	border: 1px solid #d2ddeb;
	min-height: 42px;
}

.table thead th {
	background: #0f172a;
	color: #fff;
	font-weight: 600;
	font-size: 0.88rem;
	border: none;
	white-space: nowrap;
}

.table tbody td {
	vertical-align: middle;
	white-space: nowrap;
}

.table tbody tr:hover {
	background: #f8fbff;
}

.status-pill {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 5px 10px;
	border-radius: 999px;
	font-size: 0.76rem;
	font-weight: 700;
	border: 1px solid transparent;
}

.status-confirmed {
	background: #dcfce7;
	color: #166534;
	border-color: #bbf7d0;
}

.status-pending {
	background: #fef3c7;
	color: #92400e;
	border-color: #fde68a;
}

.status-cancelled {
	background: #ffe4e6;
	color: #9f1239;
	border-color: #fecdd3;
}

.action-btn {
	height: 32px;
	min-width: 86px;
	font-size: 0.8rem;
	font-weight: 600;
	border-radius: 9px;
}

.section-label {
	font-size: 0.82rem;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.6px;
	color: var(--muted);
	margin-bottom: 12px;
}

@media ( max-width : 768px) {
	.page-title {
		font-size: 1.45rem;
	}
	.appointment-details-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>

<body data-admin-page="appointments">
	<%@ include file="Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
	if ("ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role)) {
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
	}
	%>

	<%
	List<Appointment> list = (List<Appointment>) request.getAttribute("appointmentList");
	%>

	<div class="main-content">

		<%@include file="Components/message.jsp"%>

		<div class="dashboard-wrap">
			<div class="page-head">
				<div>
					<h1 class="page-title">Appointments Overview</h1>
					<p class="page-subtitle">View, search, and manage appointment
						bookings from one place.</p>
				</div>
				<button class="btn btn-primary" type="button">
					<i class="fa-solid fa-plus me-2"></i>New Appointment
				</button>
			</div>

			<div class="summary-grid">
				<div class="summary-card">
					<div class="summary-label">Total Appointments</div>
					<div class="summary-value">128</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">Confirmed</div>
					<div class="summary-value">84</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">Pending</div>
					<div class="summary-value">31</div>
				</div>
				<div class="summary-card">
					<div class="summary-label">Cancelled</div>
					<div class="summary-value">13</div>
				</div>
			</div>

			<div class="panel">
				<div class="row g-2 filter-row mb-3">
					<div class="col-12 col-md-4">
						<input type="text" class="form-control"
							placeholder="Search by patient, email, or mobile">
					</div>
					<div class="col-6 col-md-2">
						<select class="form-select">
							<option selected>All Tests</option>
							<option>Blood Test</option>
							<option>X-Ray</option>
							<option>MRI</option>
							<option>CT Scan</option>
							<option>ECG</option>
						</select>
					</div>
					<div class="col-6 col-md-2">
						<select class="form-select">
							<option selected>All Status</option>
							<option>Confirmed</option>
							<option>Pending</option>
							<option>Cancelled</option>
						</select>
					</div>
					<div class="col-6 col-md-2">
						<input type="date" class="form-control">
					</div>
					<div class="col-6 col-md-2 d-grid">
						<button class="btn btn-outline-secondary" type="button">Apply
							Filter</button>
					</div>
				</div>

				<div class="section-label">Appointments</div>
				<div class="table-wrap table-responsive">
					<table class="table table-hover mb-0 align-middle">
						<thead>
							<tr>
								<th>#</th>
								<th>Patient Name</th>
								<th>Test Name</th>
								<th>Appointment Date</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<%
							int count = 1;
							if (list != null && !list.isEmpty()) {
								for (Appointment ap : list) {
									String status = ap.getStatus();
									String statusClass = "status-pending";
									if ("Confirmed".equalsIgnoreCase(status)) {
								statusClass = "status-confirmed";
									} else if ("Cancelled".equalsIgnoreCase(status)) {
								statusClass = "status-cancelled";
									}
									String modalId = "appointmentModal" + ap.getId();
							%>
							<tr>
								<td><%=count%></td>
								<td><%=ap.getPatientName()%></td>
								<td><%=ap.getTestName()%></td>
								<td><%=ap.getAppointmentDate()%></td>
								<td><span class="status-pill <%=statusClass%>"> <%=status%>
								</span></td>
								<td>
									<button type="button"
										class="btn btn-outline-primary btn-sm view-btn"
										data-bs-toggle="modal" data-bs-target="#<%=modalId%>">
										<i class="fa-solid fa-eye me-1"></i>View
									</button>
								</td>
							</tr>
							<%
							count++;
							}
							} else {
							%>
							<tr>
								<td colspan="6" class="text-center text-muted py-4">No
									appointments found.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>

	<%
	if (list != null && !list.isEmpty()) {
		for (Appointment ap : list) {
			String status = ap.getStatus();
			String statusClass = "status-pending";
			if ("Confirmed".equalsIgnoreCase(status)) {
		statusClass = "status-confirmed";
			} else if ("Cancelled".equalsIgnoreCase(status)) {
		statusClass = "status-cancelled";
			}
			String modalId = "appointmentModal" + ap.getId();
	%>
	<div class="modal fade" id="<%=modalId%>" tabindex="-1"
		aria-labelledby="<%=modalId%>Label" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="<%=modalId%>Label">
						Appointment Details -
						<%=ap.getPatientName()%>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="appointment-details-grid">
						<div class="detail-item">
							<span class="detail-label">Patient ID</span>
							<div class="detail-value">
								<%=ap.getPatientId()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Patient Name</span>
							<div class="detail-value">
								<%=ap.getPatientName()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Email</span>
							<div class="detail-value">
								<%=ap.getPatientEmail()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Mobile</span>
							<div class="detail-value">
								<%=ap.getPatientMobile()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Test Name</span>
							<div class="detail-value">
								<%=ap.getTestName()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Appointment Date</span>
							<div class="detail-value">
								<%=ap.getAppointmentDate()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Appointment Time</span>
							<div class="detail-value">
								<%=ap.getAppointmentTime()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Lab Location</span>
							<div class="detail-value">
								<%=ap.getLabLocation()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Priority</span>
							<div class="detail-value">
								<%=ap.getPriority()%>
							</div>
						</div>
						<div class="detail-item">
							<span class="detail-label">Status</span>
							<div class="detail-value">
								<span class="status-pill <%=statusClass%>"> <%=status%>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-outline-secondary"
						data-bs-dismiss="modal">Close</button>
					<form
						action="<%=request.getContextPath()%>/appointmentConfirmation"
						method="post" class="appointment-actions m-0">
						<input type="hidden" name="id" value="<%=ap.getId()%>">
						<button type="submit" name="status" value="Confirmed"
							class="btn btn-success btn-sm action-btn">Confirm</button>
						<button type="submit" name="status" value="Cancelled"
							class="btn btn-warning btn-sm action-btn">Cancel</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	}
	%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>
</body>

</html>