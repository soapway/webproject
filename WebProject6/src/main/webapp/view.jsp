<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.BoardDTO"%>
<%
BoardDTO bd = (BoardDTO) request.getAttribute("board");
int num = ((Integer) request.getAttribute("num")).intValue();
int nowpage = ((Integer) request.getAttribute("page"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view</title>
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

.title {
	padding: 0 !important;
	position: relative;
	overflow: hidden;
	heigth: 100px;
	box-sizing: content-box;
}

.title>div:first-child {
	width: 100%;
	height: 1rem;
}

.title>div:first-child>h1 {
	position: absolute;
	z-index: 2;
	top: 50%;
	transform: translateY(-50%);
	left: 3rem;
}

.custombg {
	background: url("./src/moralpanic.jpg") no-repeat;
	background-size: cover;
	background-position: center;
	filter: blur(20px);
	position: absolute;
	left: 0;
	top: 0;
	z-index: 1;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<main class="container">
		<div class="p-5 mb-4 bg-light rounded-3 title">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=bd.getTitle()%></h1>
			</div>
			<div class="custombg p-5"></div>
		</div>
		<p class="col-12 text-muted"><%=bd.getArtist()%>
			|
			<%=bd.getAlbum()%>
			|
			<%=bd.getGenre()%>
			|
			<%=bd.getUser_id()%></p>
		<p class="col-12 fs-4">
			<%=bd.getLyric()%>
		</p>
		<div class="form-group row">
			<div style="text-align: right">
				<c:set var="userId" value="<%=bd.getUser_id()%>">
					<c:if test="${sessionId == userID}">
						<a class="btn btn-primary btn-lg">delete</a>
						<a class="btn btn-outline-secondary btn-lg">update</a>
					</c:if>
				</c:set>
			</div>
		</div>

	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>