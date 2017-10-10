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
	width: 180px;
	height: inherit;	
}
.float_left {
	padding: 0px;
	margin: 0 0 0 10px;
	float: left;
	border: 1px solid #aaa;
	width: 680px;
	height: inherit;	
}

 #cmView{
	width: inherit-15;
	height: inherit;
}

/*#ar_table {
	width: 100%;
	border: 1px solid #aaa;
}
#ar_table th {
	height: 30px;
}

.display-none{
	display: none;
} */
</style>
<script type="text/javascript">
 function selectCommunity(groupID){
	 //alert(groupID);
	$("#cmView").load("list_community.do?groupID="+groupID);
};

</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
				<c:forEach var="k" items="${list}" varStatus="i">
					<a href="#" onclick="selectCommunity(${k.groupID})">${k.groupName}</a><br>
				</c:forEach>
			</div>
			<div class="float_left use-scroll" >
				<div id="cmView">
					
				</div>
			</div>
			
		</div>
	</form>
</body>
</html>