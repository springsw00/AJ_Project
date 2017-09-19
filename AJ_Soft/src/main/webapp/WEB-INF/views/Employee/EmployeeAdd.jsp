<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.js"></script>
</head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function goSubmit(f){
		
		$(":input").each(function(index){
			if($(this).attr("name") == "imgFile"){
				return;
			}
			
			if($(this).val() != ""){
				//alert($(this).attr("name"));
			}else if($(this).val() == ""){
				// 빈칸일 경우 null값 넣어준다.
				$(this).val('null');
			}
			//alert(index);
		});
			f.action = "addEmployee.do";
			f.submit();
	}


	function addPictureWin() {
		window.open("addPicture.do", "사진업로드", "width=400, height=500, toolbar=no, menubar=no, scrollbars=yes, resizable=yes")
	}
	var path = "";
	function upload() {
		var form = $('#frm');

		alert("aaa");
		var formData = new FormData(form);
		formData.append("fileObj", $("#imgFile")[0].files[0]);

		$.ajax({
			url : 'addPictureAjax.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType:'text',
			success : function(result) {
				//alert(result);
				alert("업로드 성공!!");
				$("#profile").val(result);
				$("#addPicResult").val("추가완료");
			}
		});
	}
		
	
		
	
</script>
</head>
<body>
	<form method="post" id="frm">

		<table>
			<tbody>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"></td>
				</tr>

				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="password"></td>
				</tr>

				<tr>
					<td>이름</td>
					<td><input type="text" name="name" ></td>
				</tr>

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value=""></td>
				</tr>
				
				<tr>
					<td>주소</td>
					<td><input type="text" name="address" value=""></td>
				</tr>
				
				<!-- ajax로 로딩 시 DB에 저장되어있는 Department정보 가져오도록 하자 -->
		 		 
				<tr>
					<td>부서</td>
					<td>
						 <select
						name="departmentID" >
							<option>test</option>
					</select>
					</td>
				</tr>
				<tr>
					<td>직위</td>
					<td><select name="position">
							<option>팀장</option>
							<option>사원</option>
					</select></td>
				</tr>
				<tr>
					<td>휴대폰번호</td>
					<td><input type="text" placeholder="000-0000-0000 형식으로 입력"
						name="cellPhone" value=""></td>
				</tr>
				<tr>
					<td>내선번호</td>
					<td><input type="text" placeholder="00-000-0000형식으로 입력"
						name="phone" value=""></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="number" placeholder="주민등록번호앞 여섯자리"
						name="birth" value="000000"></td>
				</tr>
				<tr>
					<td>프로필사진</td>
					<td><input type="text" disabled="disabled" value=""
						id="addPicResult"> 
						
						<input type="file" value="파일 선택" name="imgFile" id="imgFile">
			<br> <a href="javascript:upload();">등록</a>
						
						<!-- <input type="button" value="추가/삭제" onclick="addPictureWin()"> -->
						
						<input
						type="hidden" name="profile" id="profile" value=""></td>
				</tr>
				  
			</tbody>

			<tfoot>
				<tr>
					<td colspan="2">
						<input type="button" onclick="goSubmit(this.form)" value="추가">
						<!-- <a href="#" onclick="">추가</a> -->
						<!-- <input type="submit" value="추가"> -->
					</td>
				</tr>
			</tfoot>
		</table>

	</form>

</body>
</html>