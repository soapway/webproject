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
<script type="text/javascript">
	function formCheck() {
		let password = document.forms["userform"]["password"].value;
		let passwordCheck = document.forms["userform"]["checkPassword"].value;
		let idCheck = document.forms["userform"]["idCheck"].value;

		if (passwordCheck == "") {
			alert("confirm your password");
			return false;
		}
		if (password != passwordCheck) {
			alert("check password");
			return false;
		}else if(password.length < 4 || password.lengh > 20){
			alert("password must be more than 4, less then 20");
			return false;
		}
		if (idCheck != "checkId") {
			alert("click ID check button");
			return false;
		}

	}

	function idCheckBtn() {
		let myForm = document.forms["userform"];
		let id = document.forms["userform"]["id"].value;
		if (id.length == 0 || id == "") {
			alert("enter your ID");
			return false;
		} else {
			window.open("/WebProject/IdCheckAction.do?user_id=" + id, "",
					"width=500, height=300");
		}
	}
</script>
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
					action="./SignUpSubmitAction.do" onsubmit="return formCheck()"
					method="post" enctype="multipart/form-data">
					<div class="row g-3">
						<div class="col-12">
						<label for="id" class="form-label">ID</label>
							<div class="input-group">
								 <input
									type="email" class="form-control" name="id" id="id"
									placeholder="type your e-mail" required> <input
									type="hidden" name="idCheck" value="uncheckId">
								<button type="button" class="btn btn-outline-secondary"
									onclick="idCheckBtn()">ID check</button>
							</div>
						</div>

						<div class="col-12">
							<label for="password" class="form-label">Password</label> <input
								type="password" class="form-control" name="password"
								id="password" placeholder="less then 20" required>
						</div>

						<div class="col-12">
							<label for="checkPassword" class="form-label">Check
								Password</label> <input type="password" class="form-control"
								name="checkPassword" id="checkPassword" required>
						</div>

						<div class="col-12">
							<label for="username" class="form-label">User name</label> <input
								type="text" class="form-control" name="username" id="username"
								placeholder="Username" required>
						</div>
					</div>

					<hr class="my-4">

					<h4 class="mb-3">User Image</h4>
					<div class="col-12">
						<div class="form-check">
							<input type="file" class="form-control" name="userimg"
								id="userimg" required>
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