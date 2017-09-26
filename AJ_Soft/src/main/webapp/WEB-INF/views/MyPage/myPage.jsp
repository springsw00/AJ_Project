<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function modigy_go(f) {
		f.action = "/myPage_modi.do";
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
					<th>아이디</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>${vo.writer}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${vo.writeDate.substring(0,10)}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>내선번호</th>
					<td>${vo.title}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${vo.title}</td>
				</tr>
					<tr>
						<td colspan="2">
						<input type="button" value="수정" onclick="modify_go(this.form)" /> 
					</tr>
			</table>
		</div>
	</form>
</body>
</html>