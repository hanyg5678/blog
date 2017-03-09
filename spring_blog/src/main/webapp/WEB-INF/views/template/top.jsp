<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.container {
      padding: 80px 120px;
  }
ul#menu li{
display : inline;
}
ul#menu li a{
background-color: black;
color:white;
pading : 10px 20px;
text-decoration:none;
border-radius:4px 4px 0 0;
}
ul#menu li a:hover{
background-color: orange;
}
.table {
widht: 100%;
}
.table, .td{
border-style: none;
}
.img {
width: 100%;
height: 100%;
}
* {
text-align: center;
margin: 1px auto 
}
li#admin{
padding-right: 10px;
}
.bg-1 { 
      background-color: #B2EBF4;
      color: #ffffff;
  }
.bg-2 { 
      background-color: #474e5d; /* Dark Blue */
      color: #ffffff;
  }
  .carousel-inner {
      width: 50%; /* Set width to 100% */
      margin: auto;
  }
</style>
<script type="text/javascript">
	$(document).ready(function() {
		if('$(sessionScope.id)'!='' && '${sessionScope.grade}'!='A') {
			$("#login").hide();
			$("#logout").show();
			$("admin").hide();
		} else if('${sessionScope.id}'!=null && '${sessionScope.grade}'=='A') {
			$("admin").show();
			$("#login").hide();
			$("#logout").show();
		} else {
			$("#login").show();
			$("#logout").hide();
			$("admin").hide();
		}
	});
</script>
</head>
<body>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
        <img src="${pageContext.request.contextPath}/images/모모3.gif" width="30%">
        <div class="carousel-caption">
        </div>      
      </div>

      <div class="item">
        <img src="${pageContext.request.contextPath}/images/모모4.gif" width="30%">
        <div class="carousel-caption">
        </div>      
      </div>
    
      <div class="item">
        <img src="${pageContext.request.contextPath}/images/모모5.gif" width="30%">
        <div class="carousel-caption">
        </div>      
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
</div>
<!-- 상단 메뉴 -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" >Spring MVC</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="${pageContext.request.contextPath}/">홈</a></li>
      <c:choose>
     	<c:when test="${empty sessionScope.id }">
     		<li><a href="${pageContext.request.contextPath}/member/agree">회원가입</a></li>
     		<li><a href="${pageContext.request.contextPath}/member/login"><span class="glyphicon glyphicon-log-out"></span>Login</a></li>
     	</c:when>
     	
     	<c:when test="${not empty sessionScope.id && sessionScope.grade == 'H' }">
	     	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">MEMO<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
					<li><a href="${pageContext.request.contextPath}/memo/list">메모목록</a></li>
		     		<li><a href="${pageContext.request.contextPath}/memo/create">메모생성</a></li>
	    		</ul>
	    	</li> 
	    	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">A & T<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
		     		<li><a href="${pageContext.request.contextPath}/address/list">주소목록</a></li>
		     		<li><a href="${pageContext.request.contextPath}/address/create">주소생성</a></li>
		     		<li><a href="${pageContext.request.contextPath}/team/list">팀목록</a></li>
		     		<li><a href="${pageContext.request.contextPath}/team/create">팀생성</a></li>
	    		</ul>
	    	</li>
	    	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">B & I<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
		     		<li><a href="${pageContext.request.contextPath}/bbs/list">게시판목록</a></li>
		     		<li><a href="${pageContext.request.contextPath}/bbs/create">게시판생성</a></li>
		     		<li><a href="${pageContext.request.contextPath}/imgbbs/list">이미지목록</a></li>
		     		<li><a href="${pageContext.request.contextPath}/imgbbs/create">이미지생성</a></li>
	    		</ul>
	    	</li>
	    	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">U & M & D<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
		     		<li><a href="${pageContext.request.contextPath}/member/read"><span class="glyphicon glyphicon-user"></span>나의정보</a></li>
	    			<li><a href="${pageContext.request.contextPath}/member/update">회원정보수정</a></li>
	    			<li><a href="${pageContext.request.contextPath}/member/delete">회원탈퇴</a></li>
	    		</ul>
	    	</li>
	    	<li><a href="${pageContext.request.contextPath}/member/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
		</c:when>
		<c:when test="${not empty sessionScope.id && sessionScope.grade == 'A' }">
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">MEMO<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
			    	 <li><a href="${pageContext.request.contextPath}/memo/list">메모목록</a></li>
				     <li><a href="${pageContext.request.contextPath}/memo/create">메모생성</a></li>
	     		</ul>
	     	</li>
	     	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">A & T<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
				     <li><a href="${pageContext.request.contextPath}/address/list">주소목록</a></li>
				     <li><a href="${pageContext.request.contextPath}/address/create">주소생성</a></li>
				     <li><a href="${pageContext.request.contextPath}/team/list">팀목록</a></li>
				     <li><a href="${pageContext.request.contextPath}/team/create">팀생성</a></li>
	     		</ul>
	     	</li>
	     	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">B & I<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
			     <li><a href="${pageContext.request.contextPath}/bbs/list">게시판목록</a></li>
			     <li><a href="${pageContext.request.contextPath}/bbs/create">게시판생성</a></li>
			     <li><a href="${pageContext.request.contextPath}/imgbbs/list">이미지목록</a></li>
			     <li><a href="${pageContext.request.contextPath}/imgbbs/create">이미지생성</a></li>
	     		</ul>
	     	</li>
	     	<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">ADMINLIST<span class="caret"></span></a>
	     		<ul class="dropdown-menu">
	    	 		<li id="admin"><a href="${pageContext.request.contextPath}/admin/list">회원목록</a></li>
	    	 		<li id="admin"><a href="${pageContext.request.contextPath}/admin/cal/calendar">일정관리</a></li>
	     		</ul>
	     	</li>
		     <li><a href="${pageContext.request.contextPath}/member/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
			</c:when>
     </c:choose>
     </ul>
  </div>
</nav>
<!-- 상단 메뉴 끝 -->
  
<!-- 내용 시작 -->
<div style="width: 100%; padding-top: 10px;">