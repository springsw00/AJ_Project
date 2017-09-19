<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@font-face {
	font-family: 'NanumBarungothic';
	src: url('/resources/NanumBarunGothic.eot') format('embedded-opentype'),
		 url('/resources/NANUMBARUNGOTHIC.woff') format('woff');
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
		<div id="left">
			<img id="logo" src="" />
			<fieldset id="log">
				<img id="ID_picture" src="" /> 출근한 시간 : <br>
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
				<li data-tab="tab7"><a href="#">사원관리</a></li>
			</ul>
		</div>
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