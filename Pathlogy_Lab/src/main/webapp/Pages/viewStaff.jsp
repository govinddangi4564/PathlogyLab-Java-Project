<%@page import="com.pathology.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/Css/app-theme.css">
</head>

<body data-admin-page="reports">

	<%@ include file="Components/auth.jsp"%>

	<%
	String role = (String) mySession.getAttribute("role");

	if ("ADMIN".equals(role)) {
	%>
	<jsp:include page="adminSidebar.jsp" />

	<%
	List<User> list = (List<User>) request.getAttribute("staffList");
	%>

	<%
	UserDao dao = new UserDao();
	%>

	<div class="main-content">
		<h2 class="page-title">All Staff</h2>
		<p class="page-subtitle">Review Staff records, and take admin
			actions.</p>

		<div class="panel">
			<div class="row g-2 filter-row mb-3">
				<form action="searchReport" method="get" class="d-flex w-100 gap-2">

					<div class="col-md-4">
						<input type="text" id="searchInput" class="form-control"
							name="search"
							placeholder="Search by patient ID, report name or status">
					</div>
				</form>
			</div>

			<table class="table table-hover align-middle mb-0">
				<thead>
					<tr>
						<th>S.No</th>
						<th>Name</th>
						<th>Email</th>
						<th>Mobile</th>
						<th>Role</th>
						<th>Join Date</th>
						<th>Action</th>
					</tr>
				</thead>

				<%
				int count = 1;
				if (list != null) {
					for (User l : list) {
				%>


				<tbody id="reportTable">
					<tr>
						<td><%=count++%></td>
						<td><%=l.getName()%></td>
						<td><%=l.getEmail()%></td>
						<td><%=l.getMobile()%></td>
						<td><%=l.getRole()%></td>
						<td><%=l.getDate()%></td>

						<td><a href="deleteStaff?id=<%=l.getId()%>"
							class="btn btn-outline-danger btn-sm"
							onclick="return confirm('Are you sure you want to delete this report?');">
								Delete </a></td>
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
setTimeout(function() {
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

	<%
	} else {
	response.sendRedirect(request.getContextPath() + "/Pages/unauthorizedUser.jsp");
	return;
	}
	%>

</body>

</html>
