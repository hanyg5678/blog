<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read() {
	var url = "read";
	url += "?id=${id}";
	
	location.href = url;
}
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body> 
<DIV class="title">사진변경</DIV>
<div class="content">
<c:choose>
	<c:when test="${flag}">사진을 변경했습니다.</c:when>
	<c:otherwise>사진변경을 실패했습니다.</c:otherwise>
</c:choose>
</div>  
  <DIV class='bottom'>
	<c:choose>
		<c:when test="${flag}">
			<input type='submit' value='나의 정보' onclick="read()">
		</c:when>
		<c:otherwise>
    <input type='button' value='다시시도' onclick="history.back()">
		</c:otherwise>
	</c:choose>
  </DIV>
</body>
</html>