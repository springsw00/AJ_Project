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

.empAdmin_box {
	float: left;
	background-color: skyblue;
	text-align: center;
	width: 200px;
	height: 200px;
	border: 1px solid #fff;
}


.empAdmin_box a {
	display: inline-block;
	color: #000;
	text-decoration: none;
	transition: 0.3s;
}
</style>
<script type="text/javascript">
	function go_findEmp(){
		alert($("#modify_id").val());
		//find_emp.do/?modify_id=
	}
</script>
</head>
<body>
	<form id="main_form">
	<jsp:include page="layout.jsp" />
		<div id="main_board">
			<div class="empAdmin_box">
				<a href="addEmp_page.do">사원추가</a>
			</div>
			<div class="empAdmin_box">
				<input id="modify_id" name="modify_id" type="text" /><br>
				<a href="#" onclick="go_findEmp()">사원찾기</a>
			</div>
		</div>
	</form>
</body>
</html>