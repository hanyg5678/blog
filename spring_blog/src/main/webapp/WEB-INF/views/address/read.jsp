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
function create(){
	var url = "create";
	location.href=url;
}
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
<div class="title">조회</div>
<div class="content">
<table>

<tr>
<th>번호</th>
<td>${dto.no}</td>
</tr>
<tr>
<th>이름</th>
<td>${dto.name}</td>
</tr>
<tr>
<th>전화번호</th>
<td>${dto.phone}</td>
</tr>
<tr>
<th>우편번호</th>
<td>${dto.zipcode}</td>
</tr>
<tr>
<th>주소</th>
<td>${dto.address1}</td>
</tr>
<tr>
<th>상세주소</th>
<td>${dto.address2}</td>
</tr>
<tr>
<th>가입일자</th>
<td>${dto.wdate}</td>
</tr>
<tr>
<td colspan="2">
<input type="button" value="생성" onclick="create()">
<input type="button" value="목록" onclick="alist()">
</td>

</tr>
</table>
</div>
</body> 
</html> 

