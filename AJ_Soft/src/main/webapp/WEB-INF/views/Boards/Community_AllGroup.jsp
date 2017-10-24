<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style type="text/css">
	
	#Commu_GroupView, #Commu_GroupView a{
		color: black;
	}
	#Commu_GroupView th {
		background-color: #CFD8DC;
	}
	
	#Commu_GroupView table {
		width: 90%;
		margin: auto;
		
		/* border: 1px solid #aaa;	 */
	}
	#Commu_GroupView table td {
		margin: 0px;
		padding: 0px;
		border-bottom: 1px solid #aaa;
		border-spacing: 0px;
	}
	#paging_commu, .commu_GroupView_num{
		text-align:center;
	}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".hide_addGroup").hide();
		
		$("#show_input").click(function(){
			$(".hide_addGroup").show();
		});
	});

	$(function(){
		$("#groupName_add").click(function(){
			
			$("#commu_groupNameAdd").attr('action', "add_groupName.do");
			$("#commu_groupNameAdd").submit();
			
		});
	});
	
</script>
<body>
	<form id="commu_groupNameAdd">
		<div id="Commu_GroupView">
			<h3> 모든 그룹</h3>
			<table>
				<tr>
					<th>그룹 이름</th>
					<th width="150px">그룹 생성일</th>
					<th width="100px">가능한 선택</th>
				</tr>
				<c:set var="tmp" value="0"/>
				<c:forEach items="${list}" var="k" varStatus="i">
					<tr>
						<td>${k.groupName}</td>
						<td>${k.startDate.substring(0,10)}</td>
						<td>
							<c:set var="gID" value="/${k.groupID}/" />
						 	<c:choose>
						 		<c:when test="${fn:contains(mygStr, gID)}">
									<a href="deleteGroupMember.do?groupID=${k.groupID}" >탈퇴</a>							
						 		</c:when>
								<c:otherwise>
									<a href="insertGroupMember.do?groupID=${k.groupID}" >가입</a>
								</c:otherwise>
							</c:choose> 
						</td>
						 
					</tr>
				</c:forEach>
				<tr>
					<td colspan="3" style="text-align:right">
						<a id="show_input" href="#"><i class="fa fa-plus-circle" aria-hidden="true"></i> 그룹 추가</a>
						<input class="hide_addGroup" type="text" name="groupName"><a onclick="add_groupName(this.form)" class="hide_addGroup" href="#"><i class="fa fa-plus" aria-hidden="true"></i></a>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
