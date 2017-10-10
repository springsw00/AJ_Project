<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#myPage-modifyTable th{
		text-align: right;
		padding: 10px 20px 10px 0;
		width: 100px;
		border-right: 1px solid #aaa;
	}
	
	#myPage-modifyTable td{
		padding: 0px 0px 0px 10px;
	}
	
	tr {
		padding: 4px 10px;
	}
	a{
		text-decoration: none;
	}
	table{
		margin: 30px;
		width: 700px;
	}
	input{
		width: 100%;
	}
</style>
<script type="text/javascript">
/* 	function modify_ok(f) {
		f.action = "/myPage_ok.do";
		f.submit();
	} */
	$(function(){
		$("#myPage_modiBtn").click(function(){
			
			$("#main_form").attr('action', "/myPage_ok.do");
			$("#main_form").submit();
			
		});
	});
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
		<h2 class="align-center">내 정보</h2>
		<hr>
			<table id="myPage-modifyTable">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" value="${vo.id}"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="text" name="password" value="${vo.password}"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" value="${vo.name}"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" value="${vo.email}"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" value="${vo.address}"></td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td><input type="text" name="cellPhone" value="${vo.cellPhone}"></td>
				</tr>
				<tr>
					<th>내선번호</th>
					<td><input type="text" name="phone" value="${vo.phone}"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="number" name="birth" value="${vo.birth}"></td>
				</tr>
					<tr>
						<td colspan="2"  class="align-center">
						<a id="myPage_modiBtn" href="#" >완료</a>
						<input type="hidden" name="position" value="${vo.position}"> 
						<input type="hidden" name="profile" value="${vo.profile}">
						<input type="hidden" name="departmentID" value="${vo.departmentID}">
						<input type="hidden" name="hired_date" value="${vo.hired_date}"></td> 
					</tr>
			</table>
		</div>
	</form>
</body>
</html>