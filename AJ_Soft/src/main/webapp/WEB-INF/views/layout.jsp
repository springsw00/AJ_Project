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

	<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="resources/datepicker/datepicker.min.js"></script>

<!-- Include English language -->
<script src="resources/datepicker/i18n/datepicker.en.js"></script>

<!-- jquery ui -->
<link rel="stylesheet" href="resources/css/jquery-ui.min.css">
<script src="resources/js/jquery-ui.min.js"></script>

<meta charset="UTF-8">
<title>AJ SOFT</title>
<link rel="stylesheet"
	href="resources/css/layout.css?ver=003">
<style>
.tab>li>a:hover {
	background: #4C5870;
	color: #fff;
}

#msg-count {
	font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
	font-size: 0.8em;
}

.badge {
	background-color:#4CAF50;
	color: #fff;
	display: inline-block;
	padding-left: 8px;
	padding-right: 8px;
	padding-top: 2px;
	padding-bottom: 2px;
	text-align: center;
	border-radius: 50%;
}

@keyframes blink {
 0% {background-color: red;}
 50% {background-color: #4CAF50;}
}
 
/* for Chrome, Safari */
@-webkit-keyframes blink {
 0% {background-color: red;}
 50% {background-color: #4CAF50;}
}

.blink {
	animation: blink 1s step-end infinite;
 	-webkit-animation: blink 1s step-end infinite;
}
</style>
<script type="text/javascript">
	$(function(){
		var websocket;
		//alert(sessionStorage.ws);
		if("WebSocket" in window ){
			var loc = window.location;
			websocket = new WebSocket("ws://"+loc.host+"/"+loc.pathname.split('/')[1]+"/msgCount?empID=${empID}");
			
			websocket.onopen = function(evt){
				//onOpen(evt);
				websocket.send("${empID}");
			};
			websocket.onmessage = function(evt){
				onMessage(evt);
			};
			websocket.onerror = function(evt){
				onError(evt);
			};
			
			sessionStorage.setItem("ws", websocket);
			//sessionStorage.ws = websocket;
			//alert("socket저장");
			
			
		}
		
		function onMessage(evt){
			//alert(evt.data);
			$('#msg-count').text(evt.data);
			if(evt.data > 0){
				$('#msg-count').addClass("blink");
			}else{
				$('#msg-count').removeClass("blink");
			}
		}
		function onError(evt){
			alert("error");
		}
	});
	
	function msgWindow(){
		
		var url = 'msgWindow.do?id=${empID}';
		var title = '메세지함';
		var w = 400;
		var h = 435;
		
		var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
	    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
	 
	    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
	    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
	 
	    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
	    var top = ((height / 2) - (h / 2)) + dualScreenTop;
	    var newWindow = window.open(url, title, 'location=no, scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	 
	    // Puts focus on the newWindow
	    if (window.focus) {
	        newWindow.focus();
	    }
	}

	jQuery.noConflict(false);
	
	////////////////////////////////////// websocket
	
	
	
	
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
			<a href="getOff.do" class="myButton"><i class="fa fa-sign-out" aria-hidden="true"></i></a> 
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
			<li data-tab="tab8"><a href="#" onclick="msgWindow()">
			<i class="fa fa-commenting-o fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;<span id="msg-count" class="badge"></span></a></li>
			
			<!-- <li data-tab="tab8"><a href="go_test.do">testPage</a></li> -->
		</ul>
	</div>
</body>
</html>