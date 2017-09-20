<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.align-center {
text-align: center;
}
</style>
</head>
<body>
	<div id="left">
		<img id="logo" src="" />
		<fieldset id="log" class="align-center">
			<img id="ID_picture" src="" /><br>
			${empID}(${empName})
			<br>
			/ ${empPosition}, ${empDeptName} /		 
			<br> <input id="logout" type="button" value="퇴근" />
		</fieldset>
		<div id="mini_calendar">
			<!-- 미니 달력 -->
		</div>
	</div>
	<div id="menu">
		<ul class="tab">
			<li data-tab="tab1"><a href="#">근태관리</a></li>
			<li data-tab="tab2"><a href="#">주소록</a></li>
			<li data-tab="tab3"><a href="#">캘린더</a></li>
			<li data-tab="tab4"><a href="#">커뮤니티</a></li>
			<li data-tab="tab5"><a href="#">공지게시판</a></li>
			<li data-tab="tab6"><a href="#">마이페이지</a></li>
			<c:if test="${empDeptID == 'PRMT' }">
				<li data-tab="tab7"><a href="emp_admin.do">사원관리</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>