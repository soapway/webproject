<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sorry, but your request is failed</title>
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
		<h1>Sorry, Something wrong with this..</h1>
		<img alt="sign up success" src="./src/dutch.jpg" class="myimg">
		<p class="fs-5">There is something wrong.</p>
		<p class="fs-5">go home and try again.</p>
		<a class="btn btn-outline-secondary btn-lg" href="home.jsp">home</a>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>