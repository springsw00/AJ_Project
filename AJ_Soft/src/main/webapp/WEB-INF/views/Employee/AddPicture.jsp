<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
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
				path = result;
				alert("업로드 성공!!");
			}
		});
	}
	
	function wClose(){
		window.opener.document.getElementById("addPicResult").value = '사진추가완료';
		window.opener.document.getElementById("profile").value= path;
	}
</script>


</head>
<body>
	<form method="post" enctype="multipart/form-data" id="frm">
		<div>
			<input type="file" value="파일 선택" name="imgFile" id="imgFile">
			<br> <a href="javascript:upload();">등록</a> <br> 
			<a href="javascript:window.close();">닫기</a>
		</div>
	</form>

</body>
</html>