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

 function list_go(f) {
	 f.action ="go_community.do";
	 f.submit();
 }
</script>
</head>
<body>
	<form>
			<div id="Community_detail">
				<table>
				<tr>
					<th>제목</th>
					<td>${vo.title}
					<input type="hidden" name="title" value="${vo.title}" /></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${vo.writer}
					<input type="hidden" name="writer" value="${vo.writer}" /></td>
				</tr>
				<tr>
					<th>작성 날짜</th>
					<td>${vo.writeDate.substring(0,10)}
					<input type="hidden" name="writeDate" value="${vo.writeDate}" /></td>
				</tr>
				<tr>
					<td colspan="2">${vo.content}
					<input type="hidden" name="content" value='${vo.content}' /></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<input type="button" value="목록" onclick="list_go(this.form)" />
						<c:if test="${empID == vo.writer}">
							<input type="button" value="수정" onclick="modify_go(this.form)" /> 
							<input type="button" value="삭제" onclick="delete_go(this.form)" />
						</c:if>
						<input type="hidden" name="cPage" value="${cPage}" />
						<input type="hidden" name="community_no" value="${vo.community_no}" /></td>
				</tr>
				</table>
			</div>
	</form>

	
</body>
</html>