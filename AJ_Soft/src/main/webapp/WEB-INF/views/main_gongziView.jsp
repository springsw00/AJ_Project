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
		color: #000;
	}
	table{
		margin: auto;
		width: 700px;
	}
</style>
</head>
<body>
	<table>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성날짜</td>
		</tr>
		<c:forEach items="${vo}" var="k" begin="0" varStatus="status" end="4" >
			<tr>
				<td>${status.count}</td>
				<td><a
					href="goNotice_view.do?cPage=${pvo.nowPage}&notice_no=${k.notice_no}">${k.title}</a>
				</td>
				<td>${k.writer}</td>
				<td>${k.writeDate.substring(0,10)}</td>
			</tr>
		</c:forEach>
	</table>
	<h2><a href="Notice_go.do">+</a></h2>
</body>
</html>