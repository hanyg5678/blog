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
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<div class="content">
패스워드 오류입니다.<br>
패스워드를 다시 입력하세요.
</div> 
  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>
</body>
</html>