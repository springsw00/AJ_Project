<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
	/* #commu_detailReply tr:hover {
		background-color: #BA9C9B;
	} */
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
 
 $(document).ready(function(){
	    $("#modiReply_go").click(function(){
	    	var contentEle = $(this).parent().siblings(".re_content");
	    	var con = contentEle.html();
	    	//var con = $("#re_content").val();
	    	alert(con);
	    	contentEle.empty();
	    	contentEle.append('<input type="text" name="modi_recontent" value="'+con+'">');
	        
	    	$("#check_img").removeClass("fa-pencil-square-o"); 
	    	$("#check_img").addClass("fa-check-circle-o"); 
	    	
	    	
	    });
	});
 
	 function deleteReply(reply_No) {
			var result = "";

			$.ajax({
				url : 'deleteReply.do',
				type : 'POST',
				data : {
					reply_No : reply_No
				},
				dataType : 'text',
				success : function(data) {
					result = data;
					
					$('#rep-'+reply_No).remove();
					//location.reload();
				},
				error : function() {
					alert('there was an error while delete Reply!');
					result = false;
				}
			});
			return result;
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
				<tr>
					<th>댓글 달기</th>
				</tr>
				<tr>
					<td colspan="4">
						<textarea rows="2" cols="80" name="re_content"></textarea>
						<a href="#" onclick="reply_insert(this.form)"><i class="fa fa-check" aria-hidden="true"></i></a>
					</td>
				</tr>
				</table>
					<br>
				<table id="commu_detailReply">
				<c:forEach items="${reply_list}" var="k" varStatus="i">
					<tr id="rep-${k.reply_No}">
					<c:choose>
						<c:when test="${k.id == empID}">
							<td class="re_content">${k.content}</td>
							<td width="20px">
								<a href="#" onclick="deleteReply(${k.reply_No})"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
							</td>
						</c:when>
						<c:otherwise>
							<td colspan="2" class="re_content">${k.content}</td>
						</c:otherwise>
					</c:choose>
						<td width="110px">${k.id}</td>
						<td width="110px">${k.reply_date.substring(0,10)}</td>
					</tr>
				</c:forEach>
				</table>
			</div>
	</form>

	
</body>
