<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
	padding: 0px;
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

</style>
<script type="text/javascript">
	$(function(){
		
		$(".goDeptContact").click(function(){
			var deptId = $(this).attr("id");
			$('#contactList').load('/getContactDept.do?deptId='+deptId);
		});
		$("#addContact").click(function(){
			$('#contactList').load('/go_addContactView.do');
		});
		
		$("#go_cListView").click(function(){
			var gName = $(this).text();
			$('#contactList').load('/getContactMy.do?gName='+gName);
			
		});
		
		
	});
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
				
				<h4>개인 주소록</h4>
				
				<c:if test="${!empty cList }">
					<c:forEach items="${cList }" var="k">
						<a class="indent1 btn" id="go_cListView">${k.contact_group}</a> <br>
					
					</c:forEach>
				</c:if>
				
				<a class="indent1 t-grey btn" id="addContact"> + 연락처 추가</a>
				
				<h4>사내 주소록</h4>
				<!-- 팀별로 공유될 주소록 -->
				<!-- 사내 팀 목록 -->
				<c:if test="${!empty deptList  }">
					<c:forEach items="${deptList }" var="l">
						<a id="${l.departmentID }" href="#" class="goDeptContact indent1">${l.departmentName }</a> <br>
					</c:forEach>
				</c:if>
			</div>
			<div class="float_left use-scroll" >
				<div id="contactList">
					
				</div>
			</div>
			
		</div>
	</form>
</body>
</html>