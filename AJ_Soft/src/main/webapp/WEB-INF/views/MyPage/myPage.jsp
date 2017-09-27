<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript">
	function modify_go(f) {
		f.action = "/myPage_modi.do";
		f.submit();
	}
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
		<h2>내 정보</h2>
			<table>
				<tr>
					<th>아이디</th>
					<td>${vo.id}
					<input type="hidden" name="id" value="${vo.id}"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>${vo.password}
					<input type="hidden" name="password" value="${vo.password}"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${vo.name}
					<input type="hidden" name="name" value="${vo.name}"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${vo.email}
					<input type="hidden" name="email" value="${vo.email}"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${vo.address}
					<input type="hidden" name="address" value="${vo.address}"></td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td>${vo.cellPhone}
					<input type="hidden" name="cellPhone" value="${vo.cellPhone}"></td>
				</tr>
				<tr>
					<th>내선번호</th>
					<td>${vo.phone}
					<input type="hidden" name="phone" value="${vo.phone}"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${vo.birth}
					<input type="hidden" name="birth" value="${vo.birth}"></td>
				</tr>
					<tr>
						<td colspan="2">
						<input type="button" value="수정" onclick="modify_go(this.form)">
						<input type="hidden" name="position" value="${vo.position}"> 
						<input type="hidden" name="profile" value="${vo.profile}"> 
						<input type="hidden" name="departmentID" value="${vo.departmentID}"> 
						<input type="hidden" name="hired_date" value="${vo.hired_date}"></td>
					</tr>
			</table>
		</div>
	</form>
</body>
</html>