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
	
</style>
<div id="ContactView">
	<table>
		<thead>
			<tr>
				<th width="60px">이름</th>
				<th>직급</th>
				<th>휴대폰</th>
				<th>이메일</th>
				<th>회사</th>
				<th>회사전화</th>
				<th>그룹</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!empty cListDept}">
					<c:forEach items="${cListDept}" var="k">
				<tr>
					<td>${k.NAME }</td>
					<td>${k.POSITION }</td>
					<td>${k.CELLPHONE }</td>
					<td>${k.EMAIL }</td>
					<td>AJ-SOFT</td>
					<td>${k.PHONE }</td>
					<td>${k.DEPARTMENTNAME }</td>
				</tr>
					</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
