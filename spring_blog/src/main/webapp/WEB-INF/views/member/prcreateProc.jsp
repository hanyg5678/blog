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
 
<DIV class="title">아이디 및 이메일 중복 확인</DIV>
  <DIV class='bottom'>
${str}<br>
    <input type='submit' value='다시시도' onclick="history.back()">
  </DIV>
</body>
</html>