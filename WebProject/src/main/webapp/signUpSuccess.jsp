<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>you're now one of us!</title>
<link rel="stylesheet" href="./src/bootstrap.min.css" />
<style type="text/css">
.myimg {
	width: 24rem;
	margin: 1.25rem;
}
</style>
</head>
<body class="bg-light">
	<jsp:include page="menu.jsp" />
	<main class="text-center">
		<h1>you're now one of us!</h1>
		<img alt="sign up success" src="./src/dutch2.jpg" class="myimg">
		<p class="fs-5">your sign up information is successfully saved.</p>
		<p class="fs-5">go home and login.</p>
		<a class="btn btn-outline-secondary btn-lg" href="home.jsp">home</a>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>