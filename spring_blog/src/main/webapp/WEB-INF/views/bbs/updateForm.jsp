<%@ page contentType="text/html; charset=UTF-8" %>
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

function incheck(f) {
	if(f.wname.value==""){
		alert("이름을 입력하세요");
		f.wname.focus();
		return false;
	}
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		return false;
	}
	/* if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		return false;
	} */
	if (CKEDITOR.instances['content'].getData() == '') {
	      window.alert('내용을 입력해 주세요.');
	      CKEDITOR.instances['content'].focus();
	      return false;
	    }
	if(f.passwd.value==""){
		alert("비밀번호을 입력하세요");
		f.passwd.focus();
		return false;
	}
}
</script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
 <script type="text/JavaScript">
   window.onload=function(){
     CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
 </script>
</head> 
<body>
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./update' 
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">
	<input type='hidden' name='bbsno' size='30' value='${dto.bbsno}'>
	<input type='hidden' name='col' size='30' value='${param.col}'>
	<input type='hidden' name='word' size='30' value='${param.word}'>
	<input type='hidden' name='nowPage' size='30' value='${param.nowPage }'>
	<input type='hidden' name='oldfile' size='30' value='${dto.filename}'>
  <TABLE class='table'>
     <TR>
      <TH>제목</TH>
      <TD><input type='text' name='title' size='40' value='${dto.title}'></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><TEXTAREA name='content' rows='10' cols='40'>${dto.content}</TEXTAREA></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><input type='text' name='wname' size='40' value='${dto.wname}'></TD>
    </TR>  
    <TR>
      <TH>패스워드</TH>
      <TD><input type='password' name='passwd' size='40' value=''></TD>
    </TR>    
  <TR>
      <TH>파일등록</TH>
      <TD><input type="file" name="fileMF" size="40">${dto.filename}</TD>
    </TR> 
  </TABLE>
 
  <DIV style='text-align: center; margin-top: 20px; margin-bottom: 20px;'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back();"> 
  </DIV>  
</Form>>
</body>
</html> 