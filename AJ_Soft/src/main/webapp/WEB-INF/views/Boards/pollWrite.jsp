<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.width_100 {
	position: relative;
	width: 100%;
	height: auto;
}
/* #noticeTable thead tr, #noticeTable thead td{
		border: 1px solid #aaa;
	} */
.top_c_btn {
	position: absolute;
	margin: 0;
	right: 1px;
	_right: -1px;
	top: 2px;
	_top: 1px;
	font-size: 11px;
	font-weight: normal;
}

#list-div {
	list-style: none;
}
</style>

<script type="text/javascript">
	
</script>

</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board" class="use-scroll">
			<h2>설문조사 게시판</h2>
			<div class="width_100">
			
			

				<div>
					<table id="pollTable" class="width_100">
						<thead>
							<tr>
								<td>제목</td>
								<td colspan="3"><input type="text" name="title"></td>
							</tr>
							<tr>
								<td>투표기간</td>
								<td><input type="text" data-range="true"
									data-multiple-dates-separator=" - " data-language="en"
									class="datepicker-here" /></td>
							</tr>
						</thead>
					</table>
				</div>
				<div class="width_100">
					<h4>투표항목</h4>
					<span class="top_c_btn"> <a href="#"><img
							src="https://ssl.pstatic.net/static/poll/img/ico_add01.gif"
							width="14" height="14" alt="항목 추가"></a> <span
						style="margin-left: 3px;">항목 추가</span></span>
					<div id="list-div">
						<ul>
							<li>
								<table>
									<tbody>
										<tr>
											<td><input type="text" name="" readonly="readonly" title="투표항목번호" value="1"></td>
										</tr>
									</tbody>
								</table>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>