<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%
String sessionId = (String) session.getAttribute("sessionId");
%>
<nav class="py-2 bg-light border-bottom">
	<div class="container d-flex flex-wrap">
		<ul class="nav me-auto">
			<li class="nav-item"><a href="home.jsp"
				class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
			<li class="nav-item"><a href="about.jsp"
				class="nav-link link-dark px-2">About</a></li>
		</ul>
		<ul class="nav">
			<c:choose>
				<c:when test="${empty sessionId}">
					<li class="nav-item"><a href="login.jsp"
						class="nav-link link-dark px-2">Login</a></li>
					<li class="nav-item"><a
						href="<c:url value="./signUpAction.do"/>"
						class="nav-link link-dark px-2">Sign up</a></li>
				</c:when>
				<c:otherwise>
					<%
					String id = sessionId;
					String folder = "./imgupload/";
					String userimg = (String) request.getAttribute("userimg");
					%>
					<li class="nav-item"><img alt="user img"
						src="<%=folder%><%=userimg%>"
						class="rounded-circle" width="40px" height="40px"></li>
					<li class="nav-item"><a
						href="<c:url value="./LogoutAction.do"/>"
						class="nav-link link-dark px-2">logout</a></li>
					<li class="nav-item"><a href="writeform.jsp"
						class="nav-link link-dark px-2">write</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>
<header class="py-3 mb-4 border-bottom">
	<div class="container d-flex flex-wrap justify-content-center">
		<a href="home.jsp"
			class="d-flex align-items-center text-dark text-decoration-none">
			<img alt="logo" src="./src/sound.png" class="bi me-2"
			style="width: 32px; height: 32px"> <span class="fs-4">Lyrictionary</span>
		</a>
		<!--       <form class="col-12 col-lg-auto mb-3 mb-lg-0">
        <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
      </form> -->
	</div>
</header>