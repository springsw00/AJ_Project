<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<style>
	#ContactView th {
		background-color: #CFD8DC;
	}
	
	#ContactView table {
		width: 100%;
		
		/* border: 1px solid #aaa;	 */
	}
	#ContactView table td {
		margin: 0px;
		padding: 0px;
		border-bottom: 1px solid #aaa;
		border-spacing: 0px;
	}
</style>
<div id="ContactView">
	<table>
		<thead>
			<tr>
				<th>이름</th>
				<th>휴대폰</th>
				<th>이메일</th>
				<th>회사</th>
				<th>소속부서</th>
				<th>회사전화</th>
				<th>기타메모</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!empty cList}">
					<c:forEach items="${cList}" var="k">
				<tr>
					<td>${k.name }</td>
					<td>${k.cellPhone }</td>
					<td>${k.email }</td>
					<td>${k.companyName }</td>
					<td>${k.phone }</td>
					<td>${k.departmentID }</td>
					<td>${k.etc }</td>

				</tr>
					</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
