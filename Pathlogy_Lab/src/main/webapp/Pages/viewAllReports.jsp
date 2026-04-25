<%@page import="com.pathology.dao.ReportDao"%>
<%@page import="jakarta.websocket.Session"%>
<%@page import="java.util.List"%>
<%@page import="com.pathology.model.Report"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>View Reports | Admin Panel</title>

<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	font-family: 'Outfit', sans-serif;
	background: #f8fafc;
}

.page-title {
	font-weight: 700;
	font-size: 1.8rem;
	margin-bottom: 4px;
}

.page-subtitle {
	color: #64748b;
	margin-bottom: 18px;
}

.summary-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
	gap: 12px;
	margin-bottom: 18px;
}

.summary-box {
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 14px;
	padding: 14px;
}

.summary-box .title {
	font-size: 0.85rem;
	color: #64748b;
}

.summary-box .count {
	font-size: 1.35rem;
	font-weight: 700;
	margin: 2px 0 0;
}

.panel {
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 16px;
	padding: 16px;
	box-shadow: 0 10px 22px rgba(15, 23, 42, 0.05);
}

.filter-row .form-control, .filter-row .form-select {
	border-radius: 10px;
}

.table thead th {
	background: #0f172a;
	color: #fff;
	font-weight: 600;
	font-size: 0.9rem;
	border: none;
}

.table tbody td {
	vertical-align: middle;
}

.table tbody tr:hover {
	background: #f8fafc;
}

.badge-soft {
	padding: 6px 10px;
	border-radius: 999px;
	font-size: 0.75rem;
	font-weight: 700;
}

.badge-published {
	background: #dcfce7;
	color: #166534;
}

.badge-pending {
	background: #fef3c7;
	color: #92400e;
}

.badge-soft {
	padding: 5px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
}

/* Pending - Yellow */
.badge-pending {
	background-color: #fff3cd;
	color: #856404;
}

/* Completed - Blue */
.badge-completed {
	background-color: #cce5ff;
	color: #004085;
}

/* Delivered - Green */
.badge-delivered {
	background-color: #d4edda;
	color: #155724;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-admin-page="reports">

	<%@ include file="Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");
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
	List<Report> list = (List<Report>) request.getAttribute("reportList");
	%>

	<%
	ReportDao dao = new ReportDao();
	int totalReport = dao.totalReports();
	int pending = dao.totalPendingReports();
	int complete = dao.totalCompletedReports();
	int delivered = dao.totalDeliveredReports();
	%>

	<div class="main-content">

		<%@ include file="Components/message.jsp"%>

		<h2 class="page-title">All Reports</h2>
		<p class="page-subtitle">Review uploaded records, check statuses,
			and take admin actions.</p>

		<div class="summary-grid">
			<div class="summary-box">
				<div class="title">Total Reports</div>
				<div class="count">
					<%=totalReport%>
				</div>
			</div>

			<div class="summary-box">
				<div class="title">Pending Reports</div>
				<div class="count">
					<%=pending%>
				</div>
			</div>
			<div class="summary-box">
				<div class="title">Complete Reports</div>
				<div class="count">
					<%=complete%>
				</div>
			</div>
			<div class="summary-box">
				<div class="count">
					<%=delivered%>
				</div>
				<div class="title">Delivered reports</div>
			</div>
		</div>

		<div class="panel">
			<div class="row g-2 filter-row mb-3">
				<form action="<%=request.getContextPath()%>/filterReport"
					method="get" class="d-flex w-100 gap-3">

					<!-- Search Input -->
					<div class="col-md-3">
						<input type="text" id="searchInput" class="form-control"
							name="search"
							placeholder="Search by patient ID, report name or status">
					</div>

					<!-- Report Type -->
					<div class="col-md-2">
						<select class="form-select" name="type">
							<option value="">All Types</option>
							<option value="Blood Test">Blood Test</option>
							<option value="X-Ray">X-Ray</option>
							<option value="MRI Scan">MRI Scan</option>
							<option value="CT Scan">CT Scan</option>
							<option value="Ultrasound">Ultrasound</option>
							<option value="Urine Test">Urine Test</option>
							<option value="Biopsy">Biopsy</option>
							<option value="ECG">ECG</option>
							<option value="Other">Other</option>
						</select>
					</div>

					<!-- Status -->
					<div class="col-md-2">
						<select class="form-select" name="status">
							<option value="">All Status</option>
							<option value="Pending">Pending</option>
							<option value="Completed">Complete</option>
							<option value="Delivered">Delivered</option>
						</select>
					</div>

					<!-- Sort -->
					<div class="col-md-2">
						<select class="form-select" name="sort">
							<option value="">Sort By</option>
							<option value="date_desc">Newest First</option>
							<option value="date_asc">Oldest First</option>
							<option value="name_asc">Name (A → Z)</option>
							<option value="name_desc">Name (Z → A)</option>
						</select>
					</div>

					<!-- Button -->
					<div class="col-md-2 d-grid">
						<button type="submit" class="btn btn-outline-secondary">
							Filter</button>
					</div>

				</form>
			</div>


			<table class="table table-hover align-middle mb-0">
				<thead>
					<tr>
						<th>S.No</th>
						<th>Patient ID</th>
						<th>Patient Name</th>
						<th>Report Name</th>
						<th>Date</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>

				<%
				int count = 1;
				if (list != null) {
					for (Report r : list) {
				%>


				<tbody id="reportTable">
					<tr>
						<td><%=count++%></td>
						<td><%=r.getPatientId()%></td>
						<td><%=r.getPatientName()%></td>
						<td><%=r.getReportName()%></td>
						<td><%=r.getReportDate()%></td>
						<td>
							<%
							String status = r.getStatus();
							String badgeClass = "";
							if ("Pending".equalsIgnoreCase(status)) {
								badgeClass = "badge-pending";
							} else if ("Completed".equalsIgnoreCase(status)) {
								badgeClass = "badge-completed";
							} else if ("Delivered".equalsIgnoreCase(status)) {
								badgeClass = "badge-delivered";
							}
							%> <span class="badge-soft <%=badgeClass%>"> <%=status%>
						</span>
						</td>

						<td>
							<div class="d-flex gap-2 align-items-center">

								<!-- Download -->
								<a href="downloadReport?file=<%=r.getReportPath()%>"
									class="btn btn-outline-success btn-sm"> Download </a>

								<!-- Delete -->
								<a href="deleteReport?id=<%=r.getId()%>"
									class="btn btn-outline-danger btn-sm"
									onclick="return confirm('Are you sure you want to delete this report?');">
									Delete </a>

								<!-- Send / Resend -->
								<form action="sendReport" method="post" class="m-0">
									<input type="hidden" name="id" value="<%=r.getId()%>">
									<button type="submit" class="btn btn-outline-primary btn-sm">
										<%=r.isEmailSent() ? "Resend" : "Send"%>
									</button>
								</form>

								<!-- Mark as Delivered -->
								<%
								String sts = r.getStatus();
								if ("Completed".equalsIgnoreCase(sts)) {
								%>
								<form action="updateReportStatus" method="post" class="m-0">
									<input type="hidden" name="id" value="<%=r.getId()%>">
									<button type="submit" class="btn btn-outline-success btn-sm">
										Mark as Delivered</button>
								</form>
								<%
								}
								%>

							</div>
						</td>
					</tr>
				</tbody>

				<%
				}
				}
				%>

			</table>
		</div>
	</div>

	<script>
		setTimeout(function () {
		let alert = document.getElementById("alertMsg");
			if (alert) {
				alert.classList.remove("show");
				alert.classList.add("fade");
				setTimeout(() => alert.remove(), 500);
			}
		}, 3000); // 3 seconds
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../Js/admin-dashboard.js"></script>

</body>

</html>