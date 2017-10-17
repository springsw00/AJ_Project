<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>
<style type="text/css">
	tr {
		padding: 4px 10px;
		background-color: #F6F6F6;
	}
	a{
		text-decoration: none;
		color: #000;
	}
	table{
		margin: auto;
		width: 650px;
	}
	#importLev{
		width: 350px;
	}
	tfoot{
		text-align: center;
	}
	.display-none{
		display: none;
	}
	th {
		text-align:left;
		padding: 4px 10px;
		margin-right: 20px;
	    width: 150px;
	}
</style>
<script type="text/javascript">
	$(function(){
		var CKEDITOR_BASEPATH = 'resources/ckeditor/';
		CKEDITOR.replace( 'editor' );
	});
	function modi_Community(f){
		f.action="modi_Community.do";
		f.submit();
	}
	
	$(function(){
		$("#modiBtn").click(function(){
			
			var editor_data = CKEDITOR.instances.editor.getData();
			$('#content').val(editor_data);
			
			$("#commuModi_form").attr('action', "modi_Community.do");
			$("#commuModi_form").submit();
			
			
		});
		
	});
</script>
<body>
	<form id="commuModi_form">
			<div id="Community_detail"><br>
				<table>
				<tr>
					<th>제목</th>
					<td>
					<input type="text" name="title" value="${vo.title}" /></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="hidden" id="content" name="content">
						<textarea rows="20" cols="80" name="editor" id="editor">
						${vo.content}
						</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<a id="modiBtn" href="#">수정 완료</a>
						<input type="hidden" name="cPage" value="${cPage}" />
						<input type="hidden" name="community_no" value="${vo.community_no}" />
						<input type="hidden" name="writer" value="${vo.writer}" />
						<input type="hidden" name="groupID" value="${vo.groupID}" />
					</td>
				</tr>
				</table>
			</div>
	</form>

	
</body>
