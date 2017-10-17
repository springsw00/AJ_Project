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
	border-radius: 5px;
}
.float_left {
	padding: 10px 0px 0 0px;
	margin: 0 0 0 10px;
	float: left;
	border: 1px solid #aaa;
	width: 710px;
	height: inherit;
	border-radius: 5px;	
}

 #cmView{
	width: inherit-15;
	height: inherit;
}

#community-ul,#community-ul ul {
	list-style: none;
	padding: 0;
}

#community-ul li {
	margin-left: 2px;
	margin-top: 10px;
	margin-bottom: 10px;
}
#community-ul li li {
	margin-left: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
}

</style>
<script type="text/javascript" charset="utf-8">
/* function selectCommunity(groupID, groupName){
	 alert(groupID+","+groupName);
	$("#cmView").load("list_community.do?groupID="+groupID+"&groupName="+groupName);
}; */

function selectCommunity(groupID){ 
	// alert(groupID);
	$("#cmView").load("list_community.do?groupID="+groupID);
};

function detailCommunity(cPage, community_no){
	 //alert(cPage+","+ community_no);
	$("#cmView").load("detailCommu.do?cPage="+cPage+"&community_no="+community_no);

	//$("#Community_list").addClass("display-none");
};

function addCommunity_go(cPage, groupID){
	// alert(groupID);
	$("#cmView").load("addCommunity_go.do?cPage="+cPage+"&groupID="+groupID);

	//$("#Community_list").addClass("display-none");
};

function modi_Community_go(community_no){
	 //alert(community_no);
	$("#cmView").load("modi_Community_go.do?community_no="+community_no);
};

function CommuList_go(groupID){
	 //alert(groupID);
	 $("#cmView").load("list_community.do?groupID="+groupID);
};

function CommuGroup_addGo(){
	 $("#cmView").load("CommuGroup_addGo.do");
};


$(function(){
	$('li a').removeClass('menu_active');
	$('li[data-tab=tab4] a').addClass('menu_active');
});
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
				<c:forEach var="k" items="${list}" varStatus="i">
					<%-- <h4><a href="#" onclick="selectCommunity(${k.groupID},${k.groupName})">${k.groupName}</a></h4><br> --%>
					<h4><i class="fa fa-user-circle-o" aria-hidden="true"></i><a href="#" onclick="selectCommunity(${k.groupID})"> ${k.groupName}</a></h4>
				</c:forEach><br>
				
				<ul id="community-ul">
					<li><a href="#" class="t-grey btn" onclick="CommuGroup_addGo()" ><i
								class="fa fa-plus-square-o" aria-hidden="true"></i> 그룹 추가</a></li>
					<li><a href="#" class="t-grey btn" onclick="CommuGroup_addGo()" ><i class="fa fa-search" aria-hidden="true"></i> 그룹 보기</a></li>
				</ul>
				
				
			</div>
			<div class="float_left use-scroll" >
				<div id="cmView">
					
				</div>
			</div>
		</div>
	</form>
</body>
</html>