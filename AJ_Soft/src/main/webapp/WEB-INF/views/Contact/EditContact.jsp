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
	$(function(){
		$('#addgrouptoggle').hide();
		
		$('#groupSelect').change(function(){
			if($('#groupSelect option:selected').attr('id') == 'addGroup'){
				$('#addgrouptoggle').toggle(300);
			}else{
				$('#addgrouptoggle').hide();
			}
		});
		$('#addGroupbtn').click(function(){
			var gName = $('#addgroupname').val();
			if(gName !=''){
				$('#groupSelect').append('<option selected>'+gName+'</option>')
				$('#addgroupname').val('');
				$('#addgrouptoggle').hide();
			}
		});
		
		
		$("#formAdd").click(function(){
			if($('input[name=name]').val()==''){
				$('input[name=name]').focus();
				return;
			}
			
			$('input[class=chk]').each(function(){
				if($(this).val()==''){
					$(this).val(null);
				}
			});
			
			if($('#groupSelect').val()=='그룹추가'){
				$('#groupSelect').focus();
				return;
			}
			
			//$('#AddContactForm').action = '/go_AddContact.do';
			$('#AddContactForm').submit();
		});
	});

</script>
<div id="AddContactView" class="align-center">
<form id="AddContactForm" action="go_editContact.do">
	<h3>연락처 수정</h3>
	<hr>
	<input type="hidden" name="contactList_No" value="${vo.contactList_No}">
	<table>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="${vo.name }"></td>
		</tr>
		<tr>
			<th>휴대폰</th>
			<td><input type="text" name="cellPhone" class="chk" value="${vo.cellPhone }"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" class="chk" value="${vo.email }"></td>
		</tr>
		<tr>
			<th>회사</th>
			<td><input type="text" name="companyName" class="chk" value="${vo.companyName }"></td>
		</tr>
		<tr>
			<th>회사전화</th>
			<td><input type="text" name="phone" class="chk" value="${vo.phone }"></td>
		</tr>
		<tr>
			<th>소속부서</th>
			<td><input type="text" name="departmentID" class="chk" value="${vo.departmentID }"></td>
		</tr>
		<tr>
			<th>그룹</th>
			<td id="group-td">
				<select id="groupSelect" name="contact_group" class="left">
					<option id="default">그룹미지정</option>
					<c:if test="${!empty gList }">
						<c:forEach items="${gList }" var="k">
							<c:choose>
								<c:when test="${vo.contact_group == k.contact_group }">
								
									<option selected>${k.contact_group }</option>
								</c:when>
								
								<c:otherwise>
									<option>${k.contact_group }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
					<option id="addGroup">그룹추가</option>
				</select>
				<div class="left indent1" id="addgrouptoggle">
					<input type="text" id="addgroupname" size="10"><a id="addGroupbtn" class="btn">+</a>
				</div>
			</td>
		</tr>
		<tr>
			<th>기타메모</th>
			<td><textarea rows="2" cols="40" name="etc"  class="chk">${vo.etc }</textarea></td>
		</tr>
	</table>
	<hr>
	<a class="btn" id="formAdd"> 수정 </a>
</form>
</div>
