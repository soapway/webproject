<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%
int count = ((Integer) request.getAttribute("count")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sign up</title>
<link rel="stylesheet" href="./src/bootstrap.min.css" />
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
<link rel="stylesheet" href="./src/form-validation.css" />
</head>
<body class="bg-light">
	<div class="container">

		<div class="py-5 text-center">
			<img alt="music icon" src="./src/sound.png"
				style="width: 70px; height: 70px" class="d-block mx-auto mb-4">
			<h1>Sign up</h1>
			<p class="lead">
				thank you for join us! you're now one of
				<%=count%>+ members
			</p>
		</div>
		<div class="row g-5">
			<div>
				<h4 class="mb-3">User Info</h4>
				<form class="needs-validation" name="userform" id="userform"
					action="./SignUpSubmitAction.do" method="post"
					enctype="multipart/form-data">
					<div class="row g-3">
						<div class="col-12">
							<label for="id" class="form-label">ID</label> <input type="text"
								class="form-control" name="id" id="id"
								placeholder="more then 4, less then 10" required>
						</div>

						<div class="col-12">
							<label for="password" class="form-label">Password</label> <input
								type="password" class="form-control" name="password"
								id="password" placeholder="less then 20" value="" required>
						</div>

						<div class="col-12">
							<label for="username" class="form-label">User name</label> <input
								type="text" class="form-control" name="username" id="username"
								placeholder="Username" placeholder="less then 10"  required>
						</div>
					</div>

					<hr class="my-4">

					<h4 class="mb-3">User Image</h4>
					<div class="col-12">
						<div class="form-check">
							<input type="file" class="form-control" name="userimg"
								id="userimg">
						</div>
					</div>
					<hr class="my-4">

					<input class="w-100 btn btn-primary btn-lg" type="submit"
						value="Submit">
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>