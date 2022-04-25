<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
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
<link href="./src/signin.css" rel="stylesheet">
</head>
<body class="text-center">
	<main class="form-signin">
		<form action="./LoginAction.do" method="post">
			<a href="home.jsp"> <img class="mb-4" src="./src/sound.png"
				alt="logo" width="72" height="57">
			</a>
			<h1 class="h3 mb-3 fw-normal">Please sign in</h1>

			<div class="form-floating">
				<input type="text" class="form-control" id="floatingID" name="id"
					placeholder="ID"> <label for="floatingID">ID</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="floatingPassword"
					name="password" placeholder="Password"> <label
					for="floatingPassword">Password</label>
			</div>
			<%!String error = "";%>
			<%
			error = request.getParameter("error");
			%>
			<c:choose>
				<c:when test="${empty error}">
				</c:when>
				<c:otherwise>
					<div class="w-100">
						<small class="mysmallwarn">check your id and password</small>
					</div>
				</c:otherwise>
			</c:choose>
			<button class="w-100 btn btn-lg btn-primary" type="submit">Sign
				in</button>
			<p class="mt-5 mb-3 text-muted">
				&copy;2022<br>if you click the logo, you'll go home
			</p>
		</form>
	</main>
</body>
</html>