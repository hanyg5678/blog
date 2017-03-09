<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(id) {
	var url = "${pageContext.request.contextPath}/member/read";
	url += "?id=" + id;
	url += "&nowPage=${nowPage}";
	url += "&col=${col}";
	url += "&word=${word}";
	
	location.href = url;
}
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
}
/* 검색 폼 */
.search {
	width: 80%;
	text-align: center;
	margin: 1px auto;
} 
</style> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
 
<DIV class="title">회원목록</DIV>
<div class="search"> 
<FORM name='frm' method='POST' action='./list'>
<select name="col">
	<option value="mname" 
	<c:if test="${col=='mname'}">selected='selected'</c:if>
	 >성명</option>
	<option value="email"
	<c:if test="${col=='email'}">selected='selected'</c:if>
	>이메일</option>
	<option value="id"
	<c:if test="${col=='id'}">selected='selected'</c:if>
	>ID</option>
	<option value="total">전체출력</option>
</select>
<input type="text" name="word" value='${word}'>
<input type="submit" value="검색">
<input type="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/agree'">
</FORM> 
</div>
<c:forEach items="${list}" var="dto">
  <TABLE style="width: 80%;">
    <TR>
      <TD rowspan="5" width="30%">
      <img src='${pageContext.request.contextPath}/member/storage/${dto.fname}' style= "width:250px; height:200px;">
      </TD>
      <th width="20%">아이디</th>
      <TD width="50%">
      <a href="javascript:read('${dto.id}')">${dto.id}</a></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD>${dto.mname}</TD>
    </TR>
    <TR>
      <TH >전화번호</TH>
      <TD>${dto.tel}</TD>
    </TR>
    <TR>
      <TH>이메일</TH>
      <TD>${dto.email}</TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>${dto.address1}
      ${dto.address2}</TD>
    </TR>
  </TABLE>
 </c:forEach>
  <DIV class='bottom'>
    ${paging}
  </DIV>
</body>
</html>