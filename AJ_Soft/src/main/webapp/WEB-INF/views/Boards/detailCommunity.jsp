<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	/* tr {
		padding: 4px 10px;
		background-color: #F6F6F6;
	}
	a{
		text-decoration: none;
		color: #000;
	}
	table{
		margin: auto;
		width: 650px;
	}
	
	tfoot{
		text-align: center;
	}
	.display-none{
		display: none;
	}
	th {
		text-align:left;
		padding: 4px 10px;
		margin-right: 20px;
	    width: 150px;
	} */
	#importLev{
		width: 350px;
	}
	#Commu_detail th {
		background-color: #CFD8DC;
	}
	
	#Commu_detail table {
		width: 100%;
		
		/* border: 1px solid #aaa;	 */
	}
	#Commu_detail table td {
		margin: 0px;
		padding: 0px;
		border-bottom: 1px solid #aaa;
		border-spacing: 0px;
	}
</style>
<script type="text/javascript">

 /* function list_go(f) {
	 f.action ="go_community.do";
	 f.submit();
 } */
 
 function delete_go(f) {
	 f.action ="del_Community.do";
	 f.submit();
	
 }
 
</script>
<body>
	<form>
			<div id="Commu_detail"><br>
				<table>
				<tr>
					<th>제목</th>
					<td>${vo.title}
					<input type="hidden" name="title" value="${vo.title}" /></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${vo.writer}
					<input type="hidden" name="writer" value="${vo.writer}" /></td>
				</tr>
				<tr>
					<th>작성 날짜</th>
					<td>${vo.writeDate.substring(0,10)}
					<input type="hidden" name="writeDate" value="${vo.writeDate}" /></td>
				</tr>
				<tr>
					<td colspan="2">${vo.content}
					<input type="hidden" name="content" value='${vo.content}' /></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<!-- 목록으로 안가고 Community_Layout으로 가게 해놓음;; -->
						<a href="#" onclick="CommuList_go(${vo.groupID})">목록</a>&nbsp;
						<c:if test="${empID == vo.writer}">
							<input type="button" value="수정" onclick="modi_Community_go(${vo.community_no})" /> 
							<input type="button" value="삭제" onclick="delete_go(this.form)" />
						</c:if>
						<input type="hidden" name="cPage" value="${cPage}" />
						<input type="hidden" name="community_no" value="${vo.community_no}" />
						<input type="hidden" name="groupID" value="${vo.groupID}" /></td>
				</tr>
				</table>
			</div>
	</form>

	
</body>
