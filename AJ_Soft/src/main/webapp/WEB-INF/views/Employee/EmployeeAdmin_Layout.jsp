<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
<script src="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.contextMenu.js" type="text/javascript"></script>
<script src="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.ui.position.min.js" type="text/javascript"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.float_left_menu {
	padding: 10px 10px 0 10px;
	margin: 0px;
	float: left;
	border: 1px solid #aaa;
	width: 150px;
	height: inherit;	
}
.float_left {
	padding: 10px 0px 0 0px;
	margin: 0 0 0 10px;
	float: left;
	border: 1px solid #aaa;
	width: 710px;
	height: inherit;	
}

 #contactList{
	height: inherit;
	width: 100%;
}
#contact-ul{
	list-style: none;
	padding: 0;
}
#contact-ul li{
	margin-left: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
}

</style>
<script type="text/javascript">
	$(function(){
		
		$(function() {
			$("#modify_id").keyup(function() {
				///alert($(this).val().length);
				if($(this).val().length >= 4){
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
		$(".goAddEmployee").click(function(){
			
			$('#adminView').load('addEmp_page.do');
			
		});
		
		
		
	});
	
	function go_findEmp(f) {
		var modify_id = $("#modify_id").val();
		$('#adminView').load("find_emp.do?modify_id=" + modify_id);
		//alert(modify_id);
		/* f.action = "find_emp.do?modify_id=" + modify_id;
		f.submit(); */
	}
	
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
			
				
				<h4 class="goAddEmployee btn">사원추가</h4>
				
				<h4>사원찾기</h4>
				<input id="modify_id" name="modify_id" type="text" size="12"/><a
					onclick="go_findEmp($(this).closest('form')[0])"> <img alt="find" src="resources/Image/find_person.png" width="15px" height="15px" class="btn"> </a> 
				<p style="color: red" id="id_ajax"></p>
				
			</div>
			<div class="float_left use-scroll" >
				<div id="adminView">
					
				</div>
			</div>
			
		</div>
	</form>
</body>
</html>