<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	tr {
		text-align: center;
		padding: 4px 10px;
		background-color: #F6F6F6;
	}
	a{
		text-decoration: none;
	}
	table{
		margin: auto;
		width: 700px;
	}
</style>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div>
				<h2>공지 게시판</h2>
				<table>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성날짜</td>
					</tr>
					<c:forEach items="${list}" var="k" varStatus="i">
						<tr>
							<td>${pvo.totalRecord-((pvo.nowPage-1)*pvo.numPerPage+i.index)}</td>
							<td><a href="goNotice_view.do?cPage=${pvo.nowPage}&notice_no=${k.notice_no}">${k.title}</a>
							</td>
							<td>${k.writer}</td>
							<td>${k.writeDate.substring(0,10)}</td>
						</tr>
					</c:forEach>
					<tfoot>
						<tr>
							<td colspan="3">
								<!-- 이전  -->
								 <c:if test="${pvo.beginPage > pvo.pagePerBlock}">
									<a href="/Notice_go.do?cPage=${pvo.beginPage - pvo.pagePerBlock}"><<</a>
									&nbsp;
								</c:if> 
								<!-- 페이지번호 --> 
								<c:forEach var="k" begin="${pvo.beginPage}" end="${pvo.endPage}">
									<c:choose>
										<c:when test="${k == pvo.nowPage }">
											${k}
										</c:when>
										<c:otherwise>
											<a href="/Notice_go.do?cPage=${k}"> ${k} </a>
										</c:otherwise>
									</c:choose>
								</c:forEach> 
								<!-- 이후 --> 
								<c:if test="${pvo.endPage < pvo.totalPage}">&nbsp;
								<a href="/Notice_go.do?cPage=${pvo.beginPage + pvo.pagePerBlock }">>></a>
								</c:if>
							</td>
							<td>
								<c:if test="${empDeptID == 'PRMT' }">
									<a href="goNotice.do?cPage=${pvo.nowPage}">공지추가하기</a>
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