<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#main_gongzi").load("someNotice.do",function(responseTxt, statusTxt, xhr){
			if(statusTxt == "success")
                //alert("External content loaded successfully!");
            if(statusTxt == "error")
                alert("Error: " + xhr.status + ": " + xhr.statusText);
		});
	});
</script>
<style type="text/css">
	#main_gongzi {
		border: 1px solid #183346;
		border-radius: 10px;
	}
</style>
</head>
<body >
	<form id="main_form">
	<jsp:include page="layout.jsp" />
		<div id="main_board"> 
		<h2>공지 게시판</h2>
			<div id="main_gongzi">
				<!-- 게시판 내용목록 -->
				
			</div>
			<!-- <div>
				<h2>설문 조사  <a href="go_poll.do">+</a></h2>
				설문조사 내용목록
			</div> -->
		</div>
	</form>
</body>
</html>