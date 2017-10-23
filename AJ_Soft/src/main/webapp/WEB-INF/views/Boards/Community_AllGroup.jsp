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
		width: 100%;
		
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
<script type="text/javascript">
$(document).ready(function(){
	$(".hide_addGroup").hide();
	
	$("#show_input").click(function(){
		$(".hide_addGroup").show();
	});
});
	function add_groupName(f){
		//alert("ddd");
		f.action="add_groupName.do";
		f.submit();
	}
</script>
<body>
	<form>
		<div id="Commu_GroupView">
			<h3> 모든 그룹</h3>
				<table>
				<th>그룹 이름</th>
				<th>그룹 생성일</th>
				<th>가능한 선택</th>
				<c:set var="tmp" value="0"/>
				<c:forEach items="${list}" var="k" varStatus="i">
					<tr>
						<td>${k.groupName}</td>
						<td>${k.startDate.substring(0,10)}</td>
						<td>
							<c:set var="gID" value="/${k.groupID}/" />
						 	<c:choose>
						 		<c:when test="${fn:contains(mygStr, gID)}">
									<a href="#" onclick="deleteGroupMember(${k.groupName})">탈퇴</a>							
						 		</c:when>
								<c:otherwise>
									<a href="#" onclick="insertGroupMember(${k.groupName})">가입</a>
								</c:otherwise>
							</c:choose> 
						</td>
						 
					</tr>
				</c:forEach>
				<tr>
					<td colspan="3"><a id="show_input" href="#"><i class="fa fa-plus" aria-hidden="true"></i> 그룹 추가</a>
						<a class="hide_addGroup" href="#"><input type="text" name="groupName"><i onclick="add_groupName(this.form)" class="fa fa-plus-square" aria-hidden="true"></i></a>
					</td>
				</tr>
				</table>
			</div>
		</div>
	</form>
</body>
