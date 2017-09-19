<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@font-face {
	font-family: 'NanumBarungothic';
	src: url('${pageContext.request.contextPath}/resources/fonts/NanumBarunGothic.eot') format('embedded-opentype'),
		 url('${pageContext.request.contextPath}/resources/fonts/NANUMBARUNGOTHIC.woff') format('woff');
}

#main_form {
	font-family: NanumBarungothic;
	width: 1300px;
	height: 680px;
	margin: auto;
	margin-top: 100px;
	border: 1px solid black;
}

#left {
	float: left;
}

#log {
	width: 250px;
	height: 260px;
	margin: 30px 40px 0 40px;
}

#main_board {
	float: left;
	width: 820px;
	height: 510px;
	border: 1px solid black;
	margin: 0 0 0 20px;
	padding: 0 30px 30px 30px;
}

#menu {
	float: left;
	margin: 40px 0px 0px 20px;
}

#logo {
	width: 250px;
	height: 60px;
	border: 1px solid black;
	margin: 40px 0 0 55px;
}

#mini_calendar {
	width: 280px;
	height: 200px;
	border: 1px solid black;
	margin: 20px 0 0 40px;
}

.tab {
	list-style: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

.tab li {
	float: left;
}

.tab li a {
	display: inline-block;
	color: #000;
	background-color: skyblue;
	text-align: center;
	text-decoration: none;
	padding: 15px;
	transition: 0.3s;
}

#ID_picture {
	width: 150px;
	height: 170px;
	margin: 8px 45px 8px 45px;
	border: 1px solid black;
}
</style>
</head>
<body>
	<form id="main_form">
	<jsp:include page="layout.jsp" />
		<div id="main_board">
			<div>
				<h2>공지 게시판</h2>
				<!-- 게시판 내용목록 -->
				<input type="button" src="" onclick="">
			</div>
			<div>
				<h2>설문 조사</h2>
				
				<!-- 설문조사 내용목록 -->
			</div>
		</div>
	</form>
</body>
</html>