<%@ page contentType="text/html; charset=UTF-8" %> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
<script type="text/javascript">
function inCheck(f) {
	if(f.fname.value=="") {
		alert("사진을 선택하세요.");
		f.fname.focus();
		return false;
	}
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
 
<DIV class="title">사진 수정</DIV>
 
<FORM name='frm' method='POST' action='./updateFile' enctype="multipart/form-data" onsubmit="return inCheck(this)">
<input type="hidden" name="id" value="${param.id}">
<input type="hidden" name="oldfile" value="${param.oldfile}">
  <TABLE>
    <TR>
      <TH>원본파일</TH>
      <TD>
      	<img src="${pageContext.request.contextPath}/member/storage/${param.oldfile}">
      	원본파일명 : ${param.oldfile}
      </TD>
    </TR>
    <TR>
      <TH>변경파일</TH>
      <TD>
      	<input type="file" name="fnameMF" accept=".png, .gif, .jpg">
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='변경'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
</body>
</html>