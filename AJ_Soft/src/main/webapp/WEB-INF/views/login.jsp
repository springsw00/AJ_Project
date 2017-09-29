<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#login_form{
		width: 1300px; 
		height: 680px;
		margin: auto;
		margin-top: 100px;
		border:1px solid black ;
	}
	#logo{
		width:300px;
		height: 120px;
		margin-bottom: 30px;
		border:1px solid black;
	}
	#login_page{
		width:300px;
		height: 80px;
		margin: auto;
		margin-top: 200px;
		text-align: center;
	}
	body {
		background-color: #4C5870;
	}
</style>
<script type="text/javascript">
	function login_go(f){
		f.action = "login.do";
		f.submit();
	}
	 function onEnterLogin(){
			var keyCode = window.event.keyCode;

			if (keyCode == 13) { //엔터키 이면

				loginForm.action = "login.do";
				loginForm.submit();
			}
		}
</script>
</head>
<body>
	<form id="login_form" method="post">
		<div id="login_page">
			<img id="logo" src="" /><br>
			아이디 : <input name="id" type="text" placeholder="아이디" /><br><br>
			비밀번호 : <input name="password" type="password" placeholder="비밀번호" /><br><br>
			<input type="Button" value="로그인" onclick="login_go(this.form)" /><br><br>
			<c:if test="${msg == 'fail'}">
				<div style="color: red">
					아이디와 비밀번호가 일치하지 않습니다.
				</div>
			</c:if>
		</div>
	</form>
</body>
</html>