<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/ELFunctions" %>
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
<script type="text/javascript">
function read(memono){
	//alert(memono);
	var url = "read";
	url += "?memono="+memono;
	url += "&col=${col}";
	url += "&word=${word}";
	url += "&nowPage=${nowPage}";
	
	location.href=url;
}
</script> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<div class="title">
메모목록
</div>
 <DIV class="search" align="center"> 
  <FORM method='post' action="./list"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='title' <c:if test="${col=='title'}">selected='selected'</c:if>>제 목</OPTION> 
    <OPTION value='content' <c:if test="${col=='content'}">selected='selected'</c:if>>내 용</OPTION> 
    <OPTION value='total'>전체출력</OPTION> 
  </SELECT> 
  <input type='text' name='word' value='${word}''> <!-- 검색어 -->
  <input type='submit' value='검색'> 
  <input type='button' value='등록' onclick="location.href='./create'"> 
  </FORM> 
</DIV> 
<table>
<tr>
<th>번호</th>
<th>제목</th>
<th>날짜</th>
<th>조회수</th>
</tr>
<c:choose>
	<c:when test="${fn:length(list)==0}">
		<tr>
			<td colspan='4'>등록된 메모가 없습니다.</td>
		</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${list}" var="dto">
			<tr>
      			<td>${dto.memono}</td>
      			<c:set var="rcount" value="${util:rcount(dto.memono, idao)}"/>
      			<td><a href="javascript:read('${dto.memono}')">${dto.title}
      				<c:if test="${rcount>0 }">
            			<span style="color:red;">(${rcount})</span>
          			</c:if>
      			</a></td>
      			<td>${dto.wdate}</td>
      			<td>${dto.viewcnt}</td>      
    		</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
</table>
<div class="bottom">
${paging}
<input type="button" value="등록" onclick="location.href='./create'">
</div>
</body> 
</html>

