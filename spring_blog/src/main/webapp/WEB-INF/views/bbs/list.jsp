<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/ELFunctions" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title></title> 
<style type="text/css"> 
*{ 
  font-size: 20px; 
} 
.search{
	width: 80%;
	text-align: center;
	margin: 2px auto;
}
</style> 
<script type="text/javascript">
function read(bbsno) {
  var url = "read";
  	  url += "?bbsno=" + bbsno;
      url += "&col=${col}";
      url += "&word=${word}";
      url += "&nowPage=${nowPage}";
  
  location.href = url;
}
function down(filename){
	var url = "${pageContext.request.contextPath}/download";
	url += "?dir=/bbs/storage";
	url += "&filename="+filename;
	
	location.href = url;
	
}
</script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">

</head>
 <DIV class="search"> 
  <FORM method='post' action="./list.do"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='wname' <c:if test="${col=='wname'}">selected='selected'</c:if>>성 명</OPTION> 
    <OPTION value='title' <c:if test="${col=='title'}">selected='selected'</c:if>>제 목</OPTION> 
    <OPTION value='content' <c:if test="${col=='content'}">selected='selected'</c:if>>내 용</OPTION> 
    <OPTION value='total'>전체출력</OPTION> 
  </SELECT> 
  <input type='text' name='word' value='${word}'> <!-- 검색어 -->
  <input type='submit' value='검색' class="button_mini" > 
  <input type='button' value='등록' class="button_mini" onclick="location.href='./create'"> 
  </FORM> 
</DIV> 
 
 
<DIV class="title"> 게시판 목록 </DIV>
 

	<TABLE>
   <TR>
    <TH>번호</TH>
    <TH>제목</TH>
    <TH>성명</TH>
    <TH>조회수</TH>
    <TH>등록일</TH>
    <TH>파일명</TH>
    
  </TR>
  <c:choose>
  	<c:when test="${fn:length(list) == 0}">
    <TR>
      <TD colspan='8' align='center'>등록된 글이 없습니다.</TD>
    </TR>
    </c:when>
    <c:otherwise>
    	<c:forEach items="${list}" var="dto">
    		<TR>
      			<TD>${dto.bbsno}</TD>
      			<TD>
      			<c:forEach begin="1" end="${dto.indent}">&nbsp;&nbsp;</c:forEach>
      				<c:if test="${dto.indent > 0}"><img src="${pageContext.request.contextPath}/images/reply.JPG" style=" width:10px; height:10px;"></c:if>
      				<c:set var="rcount" value="${util:rcount(dto.bbsno,idao) }"/>
      				<a href="javascript:read('${dto.bbsno}')">${dto.title}
      				<c:if test="${rcount>0 }">
            			<span style="color:red;">(${rcount})</span>
          			</c:if>
      				</a>
      				<c:if test="${util:compareDay(fn:substring(dto.wdate, 0, 10))}"><img src="${pageContext.request.contextPath}/images/new.gif"></c:if>
      			</TD>
      			<TD>${dto.wname}</TD>
      			<TD>${dto.viewcnt}</TD>
      			<TD>${dto.wdate}</TD>
      			<td>
      				<c:choose>
      					<c:when test="${empty dto.filename}">파일 없음.</c:when>
      					<c:otherwise>
      						  <a href="javascript:down('${dto.filename}')">
							  <span class='glyphicon glyphicon-file'></span>
							  </a>
      					</c:otherwise>
      				</c:choose>
      				</TD>
      			</TR>
    	</c:forEach>
    </c:otherwise> 
  </c:choose>
  </TABLE>
  
  <DIV class='bottom'>
  	${paging}
  </DIV>
 <DIV class='bottom'>
    <input type='button' value='등록' class="button" onclick="location.href='./create'">
    <input type='button' value='이전' class="button" onclick="location.href=history.back()">
 </DIV>
</body>
</html> 