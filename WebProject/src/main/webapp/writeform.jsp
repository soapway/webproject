<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
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

form>div {
	padding: 1rem;
}
</style>
<link href="./src/form-validation.css" rel="stylesheet">
<%!BoardDTO bd;
	int num;
	int nowpage;
	String actionURL;%>
<%
String sessionId = (String) session.getAttribute("sessionId");
String boardAction = (String) request.getAttribute("boardAction");
%>
<c:choose>
	<c:when test="${boardAction == 'update'}">
		<%
		bd = (BoardDTO) request.getAttribute("board");
		num = ((Integer) request.getAttribute("num")).intValue();
		nowpage = ((Integer) request.getAttribute("page")).intValue();
		actionURL = "./WriteFormAction.do?Act=update";
		%>
	</c:when>
	<c:otherwise>
		<%
		actionURL = "./WriteFormAction.do?Act=insert";
		%>
	</c:otherwise>
</c:choose>

</head>
<body>
	<jsp:include page="menu.jsp" />
	<main class="container">
		<div class="py-5 text-center">
			<img class="d-block mx-auto mb-4" src="./src/sound.png" alt="logo"
				width="72" height="57">
			<h2>Add new Lyric</h2>
		</div>
		<form action="<%=actionURL%>" class="form-horizontal" name="newWrite"
			id="newWrite" method="post" enctype="multipart/form-data">
			<input name="userid" type="hidden" class="form-control"
				value="<%=sessionId%>">
			<div class="form-group row">
				<label class="col-sm-2 form-label">Title</label>
				<div class="col-sm-3">
					<c:choose>
						<c:when test="${boardAction == 'update'}">
							<input name="title" id="title" type="text" class="form-control"
								placeholder="title" value="<%=bd.getTitle()%>" required>
						</c:when>
						<c:otherwise>
							<input name="title" id="title" type="text" class="form-control"
								placeholder="title" required>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">Artist</label>
				<div class="col-sm-5">
					<c:choose>
						<c:when test="${boardAction == 'update'}">
							<input name="artist" type="text" class="form-control"
								placeholder="artist" value="<%=bd.getArtist()%>" required>
						</c:when>
						<c:otherwise>
							<input name="artist" type="text" class="form-control"
								placeholder="artist" required>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">Album</label>
				<div class="col-sm-5">
					<c:choose>
						<c:when test="${boardAction == 'update'}">
							<input name="album" type="text" class="form-control"
								placeholder="album" value="<%=bd.getAlbum()%>" required>
						</c:when>
						<c:otherwise>
							<input name="album" type="text" class="form-control"
								placeholder="album" required>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">Album Art</label>
				<div class="col-sm-5">
					<c:choose>
						<c:when test="${boardAction == 'update'}">
							<input name="albumart" type="file" class="form-control"
								value="<%=getServletContext().getRealPath("/") + "albumart"%><%=bd.getAlbum_art()%>">
						</c:when>
						<c:otherwise>
							<input name="albumart" type="file" class="form-control">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-sm-5">
					<small>Upload under 15MB image file</small>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">Genre</label>
				<div class="col-sm-5">
					<select class="form-select" id="genre" name="genre" required>
						<option value="none">Choose...</option>
						<option value="alternative">Alternative</option>
						<option value="blues">Blues</option>
						<option value="country">Country</option>
						<option value="dance">Dance</option>
						<option value="pop">Pop</option>
						<option value="rock">Rock</option>
						<option value="hiphop">Hip hop</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label">Lyric</label>
				<div class="col-sm-8">
					<c:choose>
						<c:when test="${boardAction == 'update'}">
							<textarea name="lyric" id="lyric" cols="50" rows="10"
								class="form-control" maxlength="8000" required><%=bd.getLyric()%></textarea>
						</c:when>
						<c:otherwise>
							<textarea name="lyric" id="lyric" cols="50" rows="10"
								class="form-control" maxlength="8000" required></textarea>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 " style="text-align: right">
					<input type="submit" class="btn btn-primary btn-lg" value="submit">
					<input type="reset" class="btn btn-outline-secondary btn-lg"
						value="reset">
				</div>
			</div>
		</form>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>