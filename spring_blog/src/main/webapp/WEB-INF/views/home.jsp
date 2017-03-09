<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
	<c:when test="${empty sessionScope.id}">
		<c:set var="str">트와이스 히라이 모모 메인 페이지.(Spring MVC blog)</c:set>
	</c:when>
	
	<c:otherwise>
		<c:set var="str">안녕하세요 ${sessionScope.id} 님!!</c:set>
	</c:otherwise>
</c:choose>

<c:set var="title">트와이스 <br> 히라이 모모(Spring MVC blog)</c:set>
	<c:if test="${not empty sessionScope.id && sessionScope.grade=='A'}">
		<c:set var="title">관리자 페이지</c:set>
	</c:if>
<html>
<head>
	<title>Home</title>
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<h1>${str}</h1>
<div class="bg-1">
  <div class="container text-center">
    <h3>11.09</h3>
    <h1>What time is?</h1>
    <img src="${pageContext.request.contextPath}/images/모모5.JPG" alt="Bird" width="350" height="350">
    <H1>It's MoMoSi!!</H1>
  	<P>  The time on the server is ${serverTime}. </P>
  	<c:choose>
	    	<c:when test="${empty sessionScope.id }">
	    	<ul class="nav navbar-nav navbar-right">
	    		 <li><a href="${pageContext.request.contextPath}/member/login"><span class="glyphicon glyphicon-log-out"></span>Login</a></li>
	    		 </ul>
	    	</c:when>	    	
	    	<c:otherwise>
	    		<ul class="nav navbar-nav navbar-right">
     				 <li><a href="${pageContext.request.contextPath}/member/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
      			</ul>
	    	</c:otherwise>
	    </c:choose>
  </div>
</div>
</body>
</html>
