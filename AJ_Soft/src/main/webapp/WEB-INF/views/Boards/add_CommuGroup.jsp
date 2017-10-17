<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<style>

	#AddContactView {
		margin-left: 0px;
		padding-left: 10px;
		width: 100%;
		height: 100%;
		box-sizing: border-box;
    	-webkit-box-sizing:border-box;
    	-moz-box-sizing: border-box;
		
	}
	#AddContactView th {
		text-align: left;
		width: 100px;
		border-right: 1px solid #aaa;
	}
	
	#AddContactView table {
		width: 70%;
		
		/* border: 1px solid #aaa;	 */
	}
	#AddContactView table td {
		margin: 0px;
		padding: 10px;
		border-spacing: 0px;
		text-align: left;
	}
</style>
<script type="text/javascript">

</script>
<div id="AddContactView" class="align-center">
<form id="AddContactForm" action="go_AddContact.do">
	<h3>커뮤니티 그룹 추가</h3>
	<hr>
	<table>
		<tr>
			<th>그룹 이름</th>
			<td><input type="text" name="groupName"></td>
		</tr>
		<tr>
			<th>그룹 멤버</th>
			<td><input type="text" name="memberID"></td>
		</tr>
	</table>
	<hr>
	<a class="btn" id="formAdd"> 추가 </a>
</form>
</div>
