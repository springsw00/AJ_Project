<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 
#notice-vtable {
	margin: auto;
	width: 100%;
	
}

#notice-vtable tr {
	padding: 4px 10px;
	background-color: #F6F6F6;
}

#notice-vtable th {
	text-align:left;
	padding: 4px 10px;
	margin-right: 20px;
    width: 100px;
} */
#notice-vtable th {
	background-color: #CFD8DC;
	width: 120px;
}

#notice-vtable {
	width: 90%;
	margin: auto;

	/* border: 1px solid #aaa;	 */
}

#notice-vtable td {
	margin: 0px;
	padding: 0px;
	border-bottom: 1px solid #aaa;
	border-spacing: 0px;
}
</style>
<script type="text/javascript">
	function list_go(f) {
		f.action = "Notice_go.do";
		f.submit();
	}
	function delete_go(f) {
		f.action = "delete_go.do";
		f.submit();
	}
	function modify_go(f) {
		f.action = "goNoti_modi.do";
		f.submit();
	}
	function main_go(f) {
		history.back(-1);
	}
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<h2>공지 게시판</h2>
			<table id="notice-vtable">
				<thead>
					<tr>
						<th>제목</th>
						<td colspan="3">${vo.title}<input type="hidden" name="title"
							value="${vo.title}" /></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${vo.writer}<input type="hidden" name="writer"
							value="${vo.writer}" /></td>
						<th>작성 날짜</th>
						<td>${vo.writeDate.substring(0,10)}<input type="hidden"
							name="writeDate" value="${vo.writeDate}" /></td>
					</tr>
				</thead>
				<tr>
					<td colspan="4"><div>${vo.content}
							<input type="hidden" name="content" value='${vo.content}' />
						</div></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center">
						<c:if test="${cPage == ''}">
							<input type="button" value="뒤로" onclick="main_go(this.form)" />
						</c:if> 
						<c:if test="${cPage != ''}">
							<input type="button" value="목록" onclick="list_go(this.form)" />
						</c:if> 
						<c:if test="${empDeptID == 'PRMT'}">
							<input type="button" value="수정" onclick="modify_go(this.form)" >
							<input type="button" value="삭제" onclick="delete_go(this.form)" >
							<input type="hidden" name="cPage" value="${cPage}" >
							<input type="hidden" name="importanceLevel"
								value="${vo.importanceLevel}" >
							<input type="hidden" name="notice_no" value="${vo.notice_no}" >
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>