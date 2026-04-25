<%@page import="com.pathology.model.Report"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
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

<body data-user-page="reports">

	<%@ include file="userSidebar.jsp"%>

	<%
	List<Report> list = (List<Report>) request.getAttribute("reportList");
	%>


	<div class="main-content">
		<h2 class="page-title">All Reports</h2>
		<p class="page-subtitle">Review uploaded records, check statuses,
			and download Reports.</p>

		<div class="summary-grid">
			<div class="summary-box">
				<div class="title">Total Reports</div>
				<div class="count">5</div>
			</div>
		</div>

		<div class="panel">
			<div class="row g-2 filter-row mb-3">
				<div class="col-md-5">
					<input type="text" id="searchInput" class="form-control"
						placeholder="Search by patient ID, email, or mobile">
				</div>
				<div class="col-md-3">
					<select class="form-select">
						<option selected>All Types</option>
						<option>Blood Test</option>
						<option>X-Ray</option>
						<option>MRI</option>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-select">
						<option selected>All Status</option>
						<option>Published</option>
						<option>Pending</option>
					</select>
				</div>
				<div class="col-md-2 d-grid">
					<button class="btn btn-outline-secondary">Filter</button>
				</div>
			</div>

			<table class="table table-hover align-middle mb-0">
				<thead>
					<tr>
						<th>S.No</th>
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

				<%
				String status = r.getStatus();
				String displayText;
				String badgeClass = "bg-secondary";

				switch (status != null ? status.toLowerCase() : "") {
					case "pending" :
						displayText = "Processing";
						badgeClass = "bg-warning text-dark";
						break;
					case "completed" :
						displayText = "Ready";
						badgeClass = "bg-primary";
						break;
					case "delivered" :
						displayText = "Delivered";
						badgeClass = "bg-success";
						break;
					default :
						displayText = "Unknown";
				}
				%>
				<tbody id="reportTable">
					<tr>
						<td><%=count++%></td>
						<td><%=r.getReportName()%></td>
						<td><%=r.getReportDate()%></td>
						<td><span class="badge <%=badgeClass%>"> <%=displayText%>
						</span></td>

						<td><a href="downloadReport?file=/<%=r.getReportPath()%>"
							class="btn btn-success btn-sm"> Download </a></td>
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
