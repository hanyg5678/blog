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
  font-size: 24px; 
} 

</style> 
<script type="text/javascript">

function input(frm){
	if(frm.title.value==""){
		alert("제목 넣어라");
		frm.title.focus();
		return false;
	}
	if(frm.content.value==""){
		alert("내용 넣어라");
		frm.content.focus();
		return false;
	}
	
}
</script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<div class="title"> 수정 </div>
<form name='frm' method='POST' action='./update'
onsubmit="return input(this)" >

	<input type="hidden" name='memono' size='30' value='${param.memono}'>
	<input type='hidden' name='col' size='30' value='${param.col}'>
	<input type='hidden' name='word' size='30' value='${param.word}'>
	<input type='hidden' name='nowPage' size='30' value='${param.nowPage}'>
	<table>
		<tr>
		<th>제목</th>
		<td><input type="text" name='title' size='30' value='${dto.title}'></td>
		</tr>
		<tr>
		<th>내용</th>
		<td><textarea name='content' rows='10' cols='30'>${dto.content}</textarea></td>
		</tr>
	
	</table>
	<div class="bottom">
	<input type="submit" value="등록">
	</div>
</form>
</body> 
</html> 

