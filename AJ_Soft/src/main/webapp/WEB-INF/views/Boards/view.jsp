<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div {
	text-align: center;
}

table {
	margin: auto;
	width: 700px;
}

tr {
	text-align: center;
	padding: 4px 10px;
}

th {
	text-align: center;
	padding: 4px 10px;
	background-color: #F6F6F6;
}
</style>
<script type="text/javascript">
	function list_go(f) {
		f.action = "/Notice_go.do";
		f.submit();
	}
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<table>
				<tr>
					<th>제목</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${vo.writer}</td>
				</tr>
				<tr>
					<th>작성 날짜</th>
					<td>${vo.writeDate.substring(0,10)}</td>
				</tr>
				<tr>
					<td colspan="2">${vo.content}</td>
				</tr>
				<c:if test="${empDeptID == 'PRMT' }">
					<tr>
						<td colspan="2"><input type="button" value="수정" onclick="modify_go(this.form)" /> 
							<input type="button" value="삭제" onclick="delete_go(this.form)" /> 
							<input	type="button" value="목록" onclick="list_go(this.form)" /> 
							<input type="hidden" name="cPage" value="${cPage}" /></td>
					</tr>
				</c:if>
			</table>
		</div>
	</form>
</body>
</html>