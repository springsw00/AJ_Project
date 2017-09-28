<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	 $(function() {
		$("#modify_id").keyup(function() {
			///alert($(this).val().length);
			if($(this).val().length > 4){
				$.ajax({
					url : 'idCheck_ajax.do',
					type : 'get',
					data : {id : $(this).val()},
					dataType : 'text',
					success : function(data) {
						//alert(data);
						if (data != 0) {
							$("#id_ajax").text("있는 아이디입니다.");
						} else {
							$("#id_ajax").text("없는 아이디입니다.");
							$(this).text("");
							$(this).focus();
						}
					},
					error : function() {
						alert("error");
					}
	
				})
			}

		});
	}); 
	 
	function go_findEmp(f) {
		var modify_id = $("#modify_id").val();
		//alert(modify_id);
		f.action = "find_emp.do?modify_id=" + modify_id;
		f.submit();
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
				<input id="modify_id" name="modify_id" type="text" /><br> <a
					onclick="go_findEmp($(this).closest('form')[0])">사원찾기</a> 
				<p style="color: red" id="id_ajax"></p>
			</div>
		</div>
	</form>
</body>
</html>