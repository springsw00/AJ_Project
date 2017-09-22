<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#noticeTable {
		width: 100%;
	}
	/* #noticeTable thead tr, #noticeTable thead td{
		border: 1px solid #aaa;
	} */
	
	#noticeTable #title{
		width: auto;
	}
	#noticeTable thead tr{
		line-height: 30px;
	}
	#noticeTable tbody tr{
		line-height: auto;
	}
</style>

<script type="text/javascript">
	var CKEDITOR_BASEPATH = '${pageContext.request.contextPath}/resources/ckeditor/';
	
	window.onload = function()
	{
		CKEDITOR.replace( 'editor' );
	};
	
	$(function(){
		$("#writeBtn").click(function(){
			
			
			var editor_data = CKEDITOR.instances.editor.getData();
			$('#content').val(editor_data);
			
			$("#main_form").attr('action', "/noticeWrite.do");
			$("#main_form").submit();
			
			
		});
		
	});
</script>

</head>
<body>
	<form id="main_form">
	<jsp:include page="../layout.jsp" />
		<div id="main_board" class="use-scroll">
			<h2>공지 게시판</h2>
			<table id="noticeTable">
				<thead>
					<tr>							
						<td>중요도</td>
						<td>
							<select name="importanceLevel">
								<option value="1">중요</option>
								<option value="0" selected="selected">보통</option>
							</select>
						</td>
						<td>글제목</td>
						<td><input type="text" id="title" name="title" size="80"></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4">
							<input type="hidden" id="content" name="content">
							<textarea rows="20" cols="80" name="editor" id="editor">
							</textarea>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="align-center">
							<a id="writeBtn" href="#" >글쓰기</a>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
</body>
</html>