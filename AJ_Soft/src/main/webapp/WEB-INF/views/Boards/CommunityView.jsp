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
 function detailCommunity(cPage, community_no){
	 //alert(cPage+","+ community_no);
	$("#Community_detail").load("detailCommu.do?cPage="+cPage+"&community_no="+community_no);

	$("#Community_list").addClass("display-none");
 };

</script>
</head>
<body>
	<form>
		<div>
			<div id="Community_list" >
				<table>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성날짜</td>
					</tr>
					<c:forEach items="${list}" var="k" varStatus="i">
						 <c:if test="${k.groupID == groupID}">
							<tr>
								<td>${pvo.totalRecord-((pvo.nowPage-1)*pvo.numPerPage+i.index)}</td>
								<td id="importLev">
								<a href="#" onclick="detailCommunity(${pvo.nowPage}, ${k.community_no})">${k.title}</a>
								</td>
								<td>${k.writer}</td>
								<td>${k.writeDate.substring(0,10)}</td>
							</tr>
						</c:if>
					</c:forEach>
					<tfoot>
						<tr>
							<td colspan="3">
								<!-- 이전  -->
								 <c:if test="${pvo.beginPage > pvo.pagePerBlock}">
									<a href="list_community.do?cPage=${pvo.beginPage - pvo.pagePerBlock}"><<</a>
									&nbsp;
								</c:if> 
								<!-- 페이지번호 --> 
								<c:forEach var="k" begin="${pvo.beginPage}" end="${pvo.endPage}">
									<c:choose>
										<c:when test="${k == pvo.nowPage }">
											${k}
										</c:when>
										<c:otherwise>
											<a href="list_community.do?cPage=${k}"> ${k} </a>
										</c:otherwise>
									</c:choose>
								</c:forEach> 
								<!-- 이후 --> 
								<c:if test="${pvo.endPage < pvo.totalPage}">&nbsp;
								<a href="list_community.do?cPage=${pvo.beginPage + pvo.pagePerBlock }">>></a>
								</c:if>
							</td>
							<td>
								<a href=".do?cPage=${pvo.nowPage}">추가하기</a>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div id="Community_detail">
			</div>
		</div>
	</form>

	
</body>
</html>