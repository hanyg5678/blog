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
  font-size: 20px; 
} 
</style>
<script type="text/javascript">
function ilist(){
	var url = "${pageContext.request.contextPath}/imgbbs/list.do";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	location.href=url;
}
</script> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<DIV class="title">삭제처리</DIV>

<div class="content">
	<c:choose>
		<c:when test="${not pflag}">패스워드 불일치</c:when>
		<c:when test="${flag}">글을 삭제하였습니다.</c:when>
		<c:otherwise>글삭제를 실패했습니다.</c:otherwise>
	</c:choose>
</div>
<c:choose>
	<c:when test="${not pflag}">
		<DIV class='bottom'>
	    <input type='button' value='다시시도'onclick="history.back()">
	    <input type='button' value='목록' onclick="ilist()">
	  </DIV>
	</c:when>
	<c:otherwise>
	  	<DIV class='bottom'>
	    <input type='submit' value='다시등록'onclick="location='./create.do'">
	    <input type='button' value='목록' onclick="ilist()">
	  	</DIV>
  </c:otherwise>
</c:choose>
</body>
</html> 