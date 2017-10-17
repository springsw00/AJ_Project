<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="resources/datepicker/datepicker.min.css" rel="stylesheet"
	type="text/css">
	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="resources/datepicker/datepicker.min.js"></script>

<!-- Include English language -->
<script src="resources/datepicker/i18n/datepicker.en.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="resources/css/layout.css?ver=05">
<style> 
	 
	.tab>li>a:hover{
		background: #4C5870;
		color: #fff;
	}
</style>
<script type="text/javascript">

/* 	$(".tab li").click(function(){
		$(".tab li").addClass('menu_active');
		$(this).removeClass('menu_active');
	}); */

	jQuery.noConflict(false);
</script>
</head>
<body>
	<div id="left">
		<a href="main.do"><img id="logo" src="resources/Image/Logo.bmp" /></a> 
		<div id="log" class="align-center">
			<img id="ID_picture"
				src='<c:url value="resources/personImage/${empImgPath}" />' />
				<br>
			${empID}(${empName}) <br> / ${empPosition}, ${empDeptName} / <br>
			<a href="getOff.do">퇴근</a> 
			<!-- <input id="logout" type="button" value="퇴근" /> -->
		</div>
		<div id="mini_calendar" class="datepicker-here" data-language='en'></div>
	</div>
	<div id="menu">
		<ul class="tab">
			<li data-tab="tab1"><a href="go_myAr.do">근태관리</a></li>
			<li data-tab="tab2"><a href="go_contact.do">주소록</a></li>
			<li data-tab="tab3"><a href="goCalendar.do">캘린더</a></li>
			<li data-tab="tab4"><a href="go_community.do">커뮤니티</a></li>
			<li data-tab="tab5"><a href="Notice_go.do">공지게시판</a></li>
			<li data-tab="tab6"><a href="myPage.do?empID=${empID}">마이페이지</a></li>
			<c:if test="${empDeptID == 'PRMT' }">
				<li data-tab="tab7"><a href="emp_admin.do">사원관리</a></li>
			</c:if>
			<!-- <li data-tab="tab8"><a href="go_test.do">testPage</a></li> -->
		</ul>
	</div>
</body>
</html>