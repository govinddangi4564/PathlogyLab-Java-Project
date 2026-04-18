<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Add patient</title>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
	rel="stylesheet">

<style>
:root {
	--primary-color: #0b7a75;
	--primary-hover: #0a6662;
	--secondary-color: #64748b;
	--glass-bg: rgba(255, 255, 255, 0.92);
	--glass-border: rgba(255, 255, 255, 0.3);
	--card-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
	--input-focus: rgba(11, 122, 117, 0.2);
}

body {
	background: radial-gradient(circle at top right, #f0f9ff 0%, #e0f2fe 50%, #f1f5f9
		100%);
	font-family: 'Outfit', sans-serif;
	min-height: 100vh;
	color: #1e293b;
}

.main-content {
	padding: 32px;
	animation: fadeIn 0.8s ease-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.upload-container {
	max-width: 850px;
	margin: 0 auto;
}

.glass-card {
	background: var(--glass-bg);
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	border: 1px solid var(--glass-border);
	border-radius: 24px;
	box-shadow: var(--card-shadow);
	padding: 3rem;
	position: relative;
	overflow: hidden;
}

.glass-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 6px;
	background: linear-gradient(90deg, #0b7a75, #14b8a6, #0b7a75);
}

.header-section {
	text-align: center;
	margin-bottom: 3rem;
}

.header-section h2 {
	font-weight: 700;
	color: #0f172a;
	margin-top: 1rem;
	font-size: 2rem;
}

.header-section p {
	color: var(--secondary-color);
	font-size: 1.1rem;
}

.icon-circle {
	width: 70px;
	height: 70px;
	background: linear-gradient(135deg, #e6fffb 0%, #d1fae5 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto;
	color: var(--primary-color);
	font-size: 1.8rem;
	box-shadow: 0 10px 20px rgba(11, 122, 117, 0.1);
}

.form-label {
	font-weight: 500;
	margin-bottom: 0.6rem;
	color: #475569;
	font-size: 0.95rem;
}

.form-control {
	border-radius: 12px;
	padding: 12px 16px;
	border: 1.5px solid #e2e8f0;
	background-color: #f8fafc;
	transition: all 0.3s ease;
	font-size: 1rem;
}

.form-control:focus {
	background-color: #fff;
	border-color: var(--primary-color);
	box-shadow: 0 0 0 4px var(--input-focus);
	outline: none;
}

/* Custom File Upload */
.file-upload-wrapper {
	position: relative;
	cursor: pointer;
	border: 2px dashed #cbd5e1;
	border-radius: 16px;
	padding: 2rem;
	text-align: center;
	transition: all 0.3s ease;
	background: #f1f5f9;
}

.file-upload-wrapper:hover {
	border-color: var(--primary-color);
	background: #f8fafc;
}

.file-upload-wrapper i {
	font-size: 2.5rem;
	color: var(--primary-color);
	margin-bottom: 1rem;
}

.file-upload-input {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	opacity: 0;
	cursor: pointer;
}

.file-name {
	margin-top: 10px;
	font-weight: 500;
	color: var(--primary-color);
}

.btn-upload {
	background: linear-gradient(90deg, #0b7a75, #14b8a6);
	color: white;
	border: none;
	padding: 14px 40px;
	border-radius: 14px;
	font-weight: 600;
	font-size: 1.1rem;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
	box-shadow: 0 10px 20px rgba(11, 122, 117, 0.2);
	margin-top: 1.5rem;
}

.btn-upload:hover {
	transform: translateY(-2px);
	box-shadow: 0 15px 30px rgba(11, 122, 117, 0.3);
	color: white;
}

.admin-note {
	background: #f0fdfa;
	border: 1px solid #99f6e4;
	border-radius: 12px;
	padding: 12px 14px;
	font-size: 0.92rem;
	color: #0f766e;
	margin-top: 18px;
}

.btn-upload:active {
	transform: translateY(0);
}

@media ( max-width : 992px) {
	.main-content {
		margin-left: 0;
		padding: 20px;
	}
	.sidebar {
		display: none;
	}
}
</style>
</head>

<body data-admin-page="upload">

	<%@ include file="adminSidebar.jsp"%>

	<div class="main-content">

		<%
		String msg = (String) session.getAttribute("msg");
		if (msg != null) {
		%>
		<div id="alertMsg"
			class="alert alert-success alert-dismissible fade show" role="alert">
			<%=msg%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
		</div>
		<%
		session.removeAttribute("msg");
		}
		%>

		<div class="upload-container">
			<div class="glass-card">

				<div class="header-section">
					<div class="icon-circle">
						<i class="fas fa-file-medical"></i>
					</div>
					<h2>Add Patient</h2>
					<p>Enter patient details for patient portal access.</p>
				</div>

				<form action="${pageContext.request.contextPath}/addPatient"
					method="post">
					<div class="row g-4">
						<div class="col-md-6">
							<label class="form-label">Full Name</label> <input type="text"
								name="patientName" class="form-control"
								placeholder="Enter Patient Name" required>
						</div>

						<div class="col-md-6">
							<label class="form-label">Email Address</label> <input
								type="email" name="email" class="form-control"
								placeholder="Enter Patient Email">
						</div>

						<div class="col-md-6">
							<label class="form-label">Mobile Number</label> <input type="tel"
								name="mobile" class="form-control"
								placeholder="Enter Patient Mobile Number">
						</div>
					</div>

					<div class="text-center">
						<button type="submit" class="btn btn-upload">Submit
							details</button>
					</div>
				</form>
			</div>
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

</body>

</html>