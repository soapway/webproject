<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" href="./src/bootstrap.min.css" />
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

.mymy {
	padding-top: 8rem;
	padding-bottom: 4rem;
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
	<div class="container mymy">
		<div class="container-fluid py-5">
			<form action="<c:url value="./SearchAction.do"/>" method="post">
				<div class="row mb-3">
					<div class="col-sm-2">
						<select class="form-select" name="items">
							<option value="all">all</option>
							<option value="title">title</option>
							<option value="artist">artist</option>
						</select>
					</div>
					<div class="col-8">
						<input class="form-control" type="text" placeholder="Search"
							aria-label="Search" name="text">
					</div>
					<div class="col-2">
						<button type="submit" class="btn btn-primary" id="btnGo">Go</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>