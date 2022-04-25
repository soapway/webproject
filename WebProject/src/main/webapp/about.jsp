<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about</title>
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
</head>
<body>
	<jsp:include page="menu.jsp" />
	<main class="container">
		<div class="container px-4 py-5">
			<h2 class="pb-2 border-bottom">Concept</h2>
			<div class="feature col">
				<p>a community page for lyric sharing. basically you can search
					lyric that someone wrote. if you sign in, you can add lyrics!</p>
			</div>
		</div>
		<div class="container px-4 py-5">
			<h2 class="pb-2 border-bottom">This page is based on..</h2>
			<div class="row g-4 py-5 row-cols-1 row-cols-lg-3">
				<div class="feature col">
					<div class="feature-icon">
						<img alt="icon1" src="./src/blockchain.png" class="bi"
							style="width: 40px; height: 40px">
					</div>
					<h2>MVC</h2>
					<p>view, controller, database model</p>
				</div>
				<div class="feature col">
					<div class="feature-icon">
						<img alt="icon1" src="./src/web-programming.png" class="bi"
							style="width: 40px; height: 40px">
					</div>
					<h2>Web Programming</h2>
					<p>HTML5, CSS3(with bootstrap), JavaScript</p>
				</div>
				<div class="feature col">
					<div class="feature-icon"></div>
					<h2>Else...</h2>
					<p>JSTL, Oracle Database</p>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>