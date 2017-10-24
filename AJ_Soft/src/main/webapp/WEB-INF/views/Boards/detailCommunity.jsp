<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	#Commu_detail th {
		background-color: #CFD8DC;
		width : 120px;
	}
	
	#Commu_detail table {
		width: 90%;
		margin: auto;
		
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

 function delete_go(f) {
	 f.action ="del_Community.do";
	 f.submit();
	
 }
 
 function reply_insert(f) {
	$("#detailCommu_form").attr('action', "reply_insert.do");
	$("#detailCommu_form").submit();
 }
 
</script>
<body>
	<form id="detailCommu_form">
		<div id="Commu_detail">
			<h3> ${groupName}</h3>
				<table>
				<tr>
					<th>제목</th>
					<td colspan="3">${vo.title}
					<input type="hidden" name="title" value="${vo.title}" /></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${vo.writer}
					<input type="hidden" name="writer" value="${vo.writer}" /></td>
					<th>작성 날짜</th>
					<td>${vo.writeDate.substring(0,10)}
					<input type="hidden" name="writeDate" value="${vo.writeDate}" /></td>
				</tr>
				<tr>
					<td colspan="4">${vo.content}
					<input type="hidden" name="content" value='${vo.content}' /></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align:center">
						<a href="#" onclick="CommuList_go(${vo.groupID})"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>&nbsp;
						<c:if test="${empID == vo.writer}">
							<input type="button" value="수정" onclick="modi_Community_go(${vo.community_no})" /> 
							<input type="button" value="삭제" onclick="delete_go(this.form)" /> 
						</c:if>
						<input type="hidden" name="cPage" value="${cPage}" />
						<input type="hidden" name="community_no" value="${vo.community_no}" />
						<input type="hidden" name="groupID" value="${vo.groupID}" /></td>
				</tr>
				</table>
					<br>
				<table>
				<tr>
					<th>댓글 달기</th>
					<td>
						<input type="hidden" id="re_content" name="re_content">
						<textarea rows="2" cols="60"></textarea>
						<a href="#" onclick="reply_insert(this.form)"><i class="fa fa-check" aria-hidden="true"></i></a>
					</td>
				</tr>
				<c:forEach items="${reply_list}" var="k" varStatus="i">
					<tr>
						<td>${k.content}</td>
						<td>${k.id}</td>
						<td>${k.reply_date.substring(0,10)}</td>
					</tr>
				</c:forEach>
				</table>
			</div>
	</form>

	
</body>
