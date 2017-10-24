<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
	
	#CommuView, #CommuView a{
		color: black;
	}
	#CommuView th {
		background-color: #CFD8DC;
	}
	
	#CommuView table {
		width: 100%;
		
		/* border: 1px solid #aaa;	 */
	}
	#CommuView table td {
		margin: 0px;
		padding: 0px;
		border-bottom: 1px solid #aaa;
		border-spacing: 0px;
	}
	#paging_commu, .commuView_num{
		text-align:center;
	}
</style>
<script type="text/javascript">
</script>
<body>
		<div id="CommuView">
			<h3> ${groupName}</h3>
				<div class="float-right" style="font-size: 1em;">
					<a href="#" onclick="addCommunity_go(${pvo.nowPage},${groupID})"><i class="fa fa-pencil fa-2x" aria-hidden="true"></i></a>
				</div>
				<table>
					<tr>
						<th width="50px">번호</th>
						<th>제목</th>
						<th width="130px">작성자</th>
						<th width="130px">작성날짜</th>
					</tr>
					<c:forEach items="${list}" var="k" varStatus="i">
						<tr>
							<td class="commuView_num">${pvo.totalRecord-((pvo.nowPage-1)*pvo.numPerPage+i.index)}</td>
							<!-- <td>${k.community_no}</td> -->
							<td id="importLev">
							<a href="#" onclick="detailCommunity(${pvo.nowPage}, ${k.community_no}, ${groupID})">${k.title}</a>
							</td>
							<td>${k.writer}</td>
							<td>${k.writeDate.substring(0,10)}</td>
						</tr>
					</c:forEach>
					<tfoot>
						<tr id="paging_commu">
							<td colspan="4">
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
						</tr>
					</tfoot>
				</table>
			</div>
		</div>

	
</body>
