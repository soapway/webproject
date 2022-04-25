<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String user_id = request.getParameter("user_id");
int result = ((Integer) request.getAttribute("result")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>check id</title>
<link rel="stylesheet" href="./src/bootstrap.min.css" />
<style type="text/css">
.idCheckForm{
padding: 5rem;
}
</style>
</head>
<script type="text/javascript">
function sendCheckVal() {
	let opener = window.opener.document.userform;
// 	let ok = document.forms["idCheckForm"]["okVal"].value;
// 	let id = document.forms["idCheckForm"].querySelector("h1").innerText;
	
	opener.idCheck.value = "checkId";
// 	opener.id.value = id;
	opener.id.readOnly = true;
	window.close();
}
</script>
<body class="text-center bg-dark text-white">
	<main class="container">
	<form name="idCheckForm" class="idCheckForm">
		<h1><%=user_id%></h1>
		<c:choose>
		<c:when test="${result == 0}">
		<p>is already taken.</p>
		<button type="button" class="btn btn-outline-secondary" onclick="window.close()">close</button>
		</c:when>
		<c:when test="${result == 1}">
		<p>you can use it.</p>
<!-- 		<input type="hidden" name="okVal" value="ok"> -->
		<button type="button" class="btn btn-outline-secondary" onclick="sendCheckVal()">ok</button>
		</c:when>
		</c:choose>
		</form>
	</main>
</body>
</html>