<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%
String sessionId = (String) session.getAttribute("sessionId");
List boardList = (List) request.getAttribute("boardlist");
int total_record = ((Integer) request.getAttribute("total_record")).intValue();
int total_page = ((Integer) request.getAttribute("total_page")).intValue();
int pageNum = ((Integer) request.getAttribute("pageNum")).intValue();
String items = (String) request.getAttribute("items");
String text = (String) request.getAttribute("text");

String folder = "./albumart/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result for "<%=text%>"
</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<main>
		<div
			class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
			<div class="col-md-5 p-lg-5 mx-auto my-5">
				<h1 class="display-4 fw-normal">
					result for <strong><%=text%></strong>
				</h1>
				<p class="lead fw-normal">
					find
					<%=total_record%>
					result by <strong><%=items%></strong> <br> you can't find what
					you want? then write now!
				</p>
				<c:choose>
					<c:when test="${empty sessionId}">
						<a class="btn btn-outline-secondary" href="login.jsp"> Go
							write</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-outline-secondary" href="writeform.jsp"
							onclick="return checkId()">Go write</a>
					</c:otherwise>
				</c:choose>

			</div>
			<div class="product-device shadow-sm d-none d-md-block"></div>
			<div
				class="product-device product-device-2 shadow-sm d-none d-md-block"></div>
		</div>
		<div class="container">
			<div class="my-3 p-3 bg-body rounded shadow-sm">
				<%
				for (int i = 0; i < boardList.size(); i++) {
					BoardDTO bd = (BoardDTO) boardList.get(i);
				%>
				<div class="d-flex text-muted pt-3">

					<img alt="album art" src="<%=folder%><%=bd.getAlbum_art()%>"
						class="bd-placeholder-img flex-shrink-0 me-2 rounded"
						style="width: 40px; height: 40px">
					<p class="pb-3 mb-0 small lh-sm border-bottom"
						style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
						<a
							href="./ViewAction.do?num=<%=bd.getNum()%>&pageNum=<%=pageNum%>"
							class="d-block text-dark text-decoration-none"><strong><%=bd.getTitle()%></strong></a>
						<%=bd.getLyric()%>
					</p>

				</div>
				<%
				}
				%>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%=pageNum%>" />
				<c:forEach var="i" begin="1" end="<%=total_page%>">
					<a href="<c:url value="./SearchAction.do?pageNum=${i}" /> "> <c:choose>
							<c:when test="${pageNum==i}">
								<font color='4C5317'><b> [${i}]</b></font>
							</c:when>
							<c:otherwise>
								<font color='4C5317'> [${i}]</font>

							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
		</div>

	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>