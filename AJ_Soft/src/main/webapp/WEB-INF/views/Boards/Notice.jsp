<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	
	#importLev.importLev{
		background-color: rgba(255, 154, 25, 0.64);
	}
	#importLev{
		width: 350px;
	}
	
	#NoticList th {
		background-color: #CFD8DC;
	}
	
	#NoticList table {
		margin: auto;
		width: 100%;
		
		/* border: 1px solid #aaa;	 */
	}
	#NoticList table td {
		margin: 0px;
		padding: 0px;
		border-bottom: 1px solid #aaa;
		border-spacing: 0px;
	}
	#paging_Notic{
		text-align:center;
	}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$('li a').removeClass('menu_active');
	$('li[data-tab=tab5] a').addClass('menu_active');
});
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div id="NoticList">
				<h2>공지 게시판 </h2>
				<div class="float-right" style="font-size: 1em;">
					<c:if test="${empDeptID == 'PRMT' }">
						<a href="goNotice.do?cPage=${pvo.nowPage}"><i class="fa fa-pencil fa-2x" aria-hidden="true"></i></a>
					</c:if>
				</div>
				<table>
					<tr>
						<th width="40px">번호</th>
						<th>제목</th>
						<th width="100px">작성자</th>
						<th width="100px">작성날짜</th>
					</tr>
					<c:forEach items="${list}" var="k" varStatus="i">
						<tr>
							<td class="align-center">${pvo.totalRecord-((pvo.nowPage-1)*pvo.numPerPage+i.index)}</td>
							<c:set var="impLev" value="${k.importanceLevel}" />
							<c:if test="${impLev == '1' }">
							<td id="importLev" class="importLev"></c:if>
							<c:if test="${impLev == '0' }">
							<td id="importLev"></c:if>
							<a href="goNotice_view.do?cPage=${pvo.nowPage}&notice_no=${k.notice_no}">${k.title}</a>
							</td>
							<td>${k.writer}</td>
							<td>${k.writeDate.substring(0,10)}</td>
						</tr>
					</c:forEach>
					<tfoot>
						<tr id="paging_Notic">
							<td colspan="4">
								<!-- 이전  -->
								 <c:if test="${pvo.beginPage > pvo.pagePerBlock}">
									<a href="Notice_go.do?cPage=${pvo.beginPage - pvo.pagePerBlock}"><<</a>
									&nbsp;
								</c:if> 
								<!-- 페이지번호 --> 
								<c:forEach var="k" begin="${pvo.beginPage}" end="${pvo.endPage}">
									<c:choose>
										<c:when test="${k == pvo.nowPage }">
											${k}
										</c:when>
										<c:otherwise>
											<a href="Notice_go.do?cPage=${k}"> ${k} </a>
										</c:otherwise>
									</c:choose>
								</c:forEach> 
								<!-- 이후 --> 
								<c:if test="${pvo.endPage < pvo.totalPage}">&nbsp;
								<a href="Notice_go.do?cPage=${pvo.beginPage + pvo.pagePerBlock }">>></a>
								</c:if>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</form>


</body>
</html>