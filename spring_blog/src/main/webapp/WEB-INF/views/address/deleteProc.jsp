<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
}
</style> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function alist(){
	var url = "list";
	url += "?col=${param.col}";
    url += "&word=${param.word}";
    url += "&nowPage=${param.nowPage}";
	location.href=url;
}
</script> 
</head> 
<body> 
<div class="content">
<c:choose>
	<c:when test="${flag}">삭제 성공.</c:when>
	<c:otherwise>삭제 실패.</c:otherwise>
</c:choose>
<br>
</div>
<div class="bottom">
<input type='button' value='목록' onclick="alist()">
</div>
</body> 
</html> 
