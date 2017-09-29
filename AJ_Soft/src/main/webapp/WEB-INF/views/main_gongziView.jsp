<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	#main-notice tr,#main-notice th {
		text-align: center;
		padding: 4px 10px;
		background-color: #F6F6F6;
	}
	#main-notice a{
		text-decoration: none;
		color: #000;
	}
	#main-notice{
		margin: auto;
		width: 100%;
	}
</style>
</head>
<body>
	<table id="main-notice">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성날짜</th>
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
	
</body>
</html>