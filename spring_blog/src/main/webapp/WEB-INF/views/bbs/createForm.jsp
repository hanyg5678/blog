<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
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
 
<DIV class="title">등록</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./create' 
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="wname" size="40"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="40"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD>
		<textarea rows="10" cols="40" name="content"></textarea>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd" size="40"></TD>
    </TR>
    <TR>
      <TH>파일등록</TH>
      <TD><input type="file" name="fileMF" size="40"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록' class="button" >
    <input type='button' value='취소' class="button" onclick="history.back()">
  </DIV>
</FORM>
</body>
</html> 