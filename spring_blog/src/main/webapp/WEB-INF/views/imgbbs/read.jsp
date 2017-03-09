<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
	width: 100px;
	height: 80px;
}
.ncurImg{
	margin-right:0;
	width: 100px;
	height: 80px;
}
</style> 
<script type="text/javascript">
  function icreate(){
    var url = "${pageContext.request.contextPath}/imgbbs/create";
    location.href=url;
  }
  
  function iupdate(){
    var url = "${pageContext.request.contextPath}/imgbbs/update";
    url += "?no=${no}";
    url += "&col=${col}";
    url += "&word=${word}";
    url += "&nowPage=${nowPage}";
    location.href=url;
  }
  
  function idelete(){
    var url = "${pageContext.request.contextPath}/imgbbs/delete";
    url += "?no=${no}";
    url += "&col=${col}";
    url += "&word=${word}";
    url += "&nowPage=${nowPage}";
    url += "&oldfile=${dto.filename}";
    location.href=url;
  }
  function ireply(){
    var url = "${pageContext.request.contextPath}/imgbbs/reply";
    url += "?no=${no}";
    url += "&col=${col}";
    url += "&word=${word}";
    url += "&nowPage=${nowPage}";
    location.href=url;
  }
  
  function ilist(){
    var url = "${pageContext.request.contextPath}/imgbbs/list";
    url += "?col=${col}";
    url += "&word=${word}";
    url += "&nowPage=${nowPage}";
    location.href=url;
  }
  
  function down(filename){
    var url = "${pageContext.request.contextPath}/download";
    url += "?dir=/imgbbs/storage";
    url += "&filename="+filename;
    
    location.href = url;
    
  }
  function readGo(no){
	  var url = "${pageContext.request.contextPath}/imgbbs/read";
	  url = url +"?no="+no;
	  url += "&col=${col}";
	  url += "&word=${word}";
	  url += "&nowPage=${nowPage}";
	  
	  location.href=url;
	}
</script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<DIV class="title">조회</DIV>
  <TABLE>
    <TR>
    	<TD colspan="2">
    	<img src="${pageContext.request.contextPath}/imgbbs/storage/${dto.filename}">
    	</TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD>${dto.title}</TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD>${dto.content}</TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD>${dto.name}</TD>
    </TR>
    <TR>
      <TH>조회수</TH>
      <TD>${dto.viewcnt}</TD>
    </TR>
    <TR>
      <TH>등록일</TH>
      <TD>${dto.wdate}</TD>
    </TR>
    <TR>
      <TH>파일 다운</TH>
      <TD>
      
      <c:choose>
      	<c:when test="${empty dto.filename}">파일없음</c:when>
      	<c:otherwise>
	      	${dto.filename}
	      <a href="javascript:down('${dto.filename}')">
	      <span class='glyphicon glyphicon-file'></span>
	      </a>      	
      	</c:otherwise>      
        </c:choose>
      </TD>
    </TR>
  </TABLE>
  
   <TABLE style="width: 50%">
  <TR>	
		<c:forEach begin="0" end="4" var="i">
			<c:choose>
			<c:when test="${empty files[i]}"><td><img class="curImg" src="${pageContext.request.contextPath}/imgbbs/storage/default.jpg" width="100%"><td></c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${noArr[i]==dto.no}">
						<td class="td_padding"><a href="javascript:readGo('${noArr[i]})">
  						<img class="curImg" src="${pageContext.request.contextPath}/imgbbs/storage/${files[i]}" width="100%" border="0">
  						</a></td>					
					</c:when>
					<c:otherwise>
						<td class="td_padding"><a href="javascript:readGo('${noArr[i]}')">
  						<img class="ncurImg" src="${pageContext.request.contextPath}/imgbbs/storage/${files[i]}" width="100%" border="0">
  						</a></td>
					</c:otherwise>				
				</c:choose>
			</c:otherwise>
		</c:choose>
  </c:forEach> 
  </TR>
  </TABLE>  
  <DIV class='bottom'>
   	<input type="button" value="등록" onclick="icreate()">
	<input type="button" value="목록" onclick="ilist()">
	<input type="button" value="수정" onclick="iupdate()">
	<input type="button" value="삭제" onclick="idelete()">
	<input type="button" value="답변" onclick="ireply()">
  </DIV>
</body>
