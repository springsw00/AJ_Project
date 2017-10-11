<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
</head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function addPictureWin() {
		window.open("addPicture.do", "사진업로드",
						"width=400, height=500, toolbar=no, menubar=no, scrollbars=yes, resizable=yes")
	}
	var path = "";
	function upload() {
		var form = $('#frm');

		//alert("aaa");
		var formData = new FormData(form);
		formData.append("fileObj", $("#imgFile")[0].files[0]);

		$.ajax({
			url : 'addPictureAjax.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'text',
			success : function(result) {
				alert("업로드 성공!!");
				$("#profile").val(result);
				$("#addPicResult").val("추가완료");
				
			}
		});
	}

	function modify_go(f) {
		f.action = "modify_ok.do"
		f.submit();
	}
	function delete_go(f) {
		f.action = "delete_ok.do"
		f.submit();
	} 
	

	$(function(){
		var dtmID = '${empvo.departmentID}';
		var position = '${empvo.position}';
		
		if(dtmID != ""){
			$("#dtmentID_${empvo.departmentID}").attr("selected","selected");
		}
		if(position != ""){
			$("#position_${empvo.position}").attr("selected","selected");
		}
	});
</script>

<style>
	#empModify-table th {
		width: 120px;
		text-align: right;
		border-right: 1px solid #aaa;
		padding-right: 10px;
	}
	
	#empModify-table td {
		margin: 0px;
		padding: 4px 0 4px 10px;
		border-spacing: 0px;
		text-align: left;
	}
	
	#empModify-table {
		width: 100%;
		
	}
</style>
</head>
<body>

	<form method="post" id="frm">
	<h3 class="align-center">사원 정보 수정</h3>
	<hr>
		<table id="empModify-table">
			<tbody>
				<tr>
				<!-- 	<c:set var="fnamePath" value="${empvo.profile}" />
					<c:set var="fname" value="${fn:split(fnamePath, '/')}" />
					<c:forEach var="s1" items="${fname }" varStatus="s">
						<c:if test="${s.count == 2}"><c:set var="realFname" value="${s1}" /></c:if>
					</c:forEach> -->
					<th>사진</th>
					<td><img src="resources\personImage/${empvo.profile}" width="150" height="175"/></td>
				</tr>
				<tr>
					<th>아이디 <i class="fa fa-check-square-o color-req" ></i></th>
					<td><input type="text" id="id" name="id" value="${empvo.id }">
						<a style="color: red" id="id_ajax"></a></td>
				</tr>

				<tr>
					<th>비밀번호 <i class="fa fa-check-square-o color-req" ></i></th>
					<td><input type="text" name="password"
						value="${empvo.password }"></td>
				</tr>

				<tr>
					<th>이름 <i class="fa fa-check-square-o color-req" ></i></th>
					<td><input type="text" name="name" value="${empvo.name }"></td>
				</tr>

				<tr>
					<th>이메일</th>
					<td><input type="text" name="email" value="${empvo.email }"></td>
				</tr>

				<tr>
					<th>주소</th>
					<td><input type="text" name="address"
						value="${empvo.address }"></td>
				</tr>

				<!-- ajax로 로딩 시 DB에 저장되어있는 Department정보 가져오도록 하자 -->

				<tr>
					<th>부서</th>

					<td><select id="dtmentID" name="departmentID">
							<option id="dtmentID_PRMT" value="PRMT">인사관리팀</option>
							<option id="dtmentID_PDEPT" value="PDEPT">전략기획팀</option>
							<option id="dtmentID_R_DT" value="R_DT">개발팀</option>
					</select></td>
				</tr>
				<tr>
					<th>직위</th>
					<td><select id="position" name="position">
							<option id="position_사원" value="사원">사원</option>
							<option id="position_팀장" value="팀장">팀장</option>
					</select></td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td><input type="text" name="cellPhone"
						value="${empvo.cellPhone }"></td>
				</tr>
				<tr>
					<th>내선번호</th>
					<td><input type="text" name="phone" value="${empvo.phone }"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="number" name="birth" value="${empvo.birth }"></td>
				</tr>
				<tr>
					<th>입사일자</th>
					<td><input type="text" name="hired_date"
						value="${empvo.hired_date.substring(0,10)}"></td>
				</tr>
				<tr>
					<th>프로필사진</th>
					<td><input type="text" disabled="disabled" value=""id="addPicResult"> 
						<input type="file" value="파일 선택"name="imgFile" id="imgFile"> <br> 
						<a href="javascript:upload();">등록</a>
						<!-- <input type="button" value="추가/삭제" onclick="addPictureWin()"> -->

						<input type="hidden" name="profile" id="profile" value=""></td>
				</tr>

			</tbody>

			<tfoot>
			</tfoot>
		</table>
		
		<hr>
		<div class="align-center">
			<input type="button" onclick="modify_go(this.form)"
						value="수정">
			<input type="button" onclick="delete_go(this.form)"
						value="삭제">
		</div>

	</form>

</body>
</html>