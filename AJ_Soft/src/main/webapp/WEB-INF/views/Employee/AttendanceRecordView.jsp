<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<script type="text/javascript" src="resources/fullcalendar/moment.min.js"></script>
<style type="text/css">


#ar_table {
	width: 100%;
	
}
#ar_table th {
	height: 30px;
	
}
.border-btm{
	border-bottom: 1px solid #aaa;
}

.arEdit{
	width: 100%;
}

</style>
<script type="text/javascript">
	$(function(){
		var id = '${id}';
		var year = '${year}';
		var month = '${month}';
		var startTime, endTime, ip, workTime;
		var editSelected;
		
		///
		// 올해 이번달 기본선택
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		
		$("#y_opt").val(year).prop("selected", true);
		$("#m_opt").val(month).prop("selected", true);
		
		function getLastDay(year, month){
			var date = new Date(year, month, 0);
			return date.getDate();
		}
		/////////////////////////////////////////////
		
		
		if(id != ""){
			//alert(id);
			$("#receiveID").val(id);
		}
		
		if(year != "" && month != ""){
			//alert(year + "/" + month);
			$("#y_opt_${year}").attr("selected","selected");
		}
		
		var firstDay = '20${arList[0].ar_Date}';
		var weekChk = moment(firstDay).day();
		$(".dlist").each(function(index){
			if((weekChk +index)%7 == 0 || (weekChk +index)%7 == 6){
				$(this).css('color','red');
			}
			if((weekChk +index)%7 == 0){
				$(this).children().css('border-bottom','1px solid #aaa');
			}
		});
		
		function getText(parent, cName){
			return parent.children("td[class="+cName+"]").text().trim();
		}
		function setInputText(parent, cName, textVal){
			var element = parent.children("td[class="+cName+"]");
			element.empty();
			element.append("<input class='arEdit "+cName+"'  type='text' value="+textVal+">");
		}
		function editCancel(tr){
			tr.find("#go_modify").empty();
			tr.children("td[class=startTime]").empty();
			tr.children("td[class=startTime]").append(startTime);
			tr.children("td[class=endTime]").empty();
			tr.children("td[class=endTime]").append(endTime);
			tr.children("td[class=ip]").empty();
			tr.children("td[class=ip]").append(ip);
			//tr.children("td[class=workTime]").empty();
			//tr.children("td[class=workTime]").append(workTime);
		}
		
		
		
		
		$(document).on("click",".editArBtn",function(){
			alert("dd");
			
			/* var editID = $(this).parent().parent().attr('id');
			var startVal = $(this).find("input[class=startTime]").val();
			alert(startVal); */
			
			//$("#arView").load('goEditAR.do', {id:editID,startTime:}, function(){});
		});
	});
	
	
</script>
	<input type="hidden" id="receiveID">
	
	<c:if test="${!empty searchID }">
		<div class="left">검색 ID :: ${searchID}
			<input type="hidden" id="searchID" value="${searchID}">
		</div>
	</c:if>

	<div class="float-right align-center" id="date_select_div_my">
		<!-- <input type="text" class="datepicker-here" data-language='en'
						data-min-view="months" data-view="months"
						data-date-format="yyyy/mm" />  -->
		<select name="year" id="y_opt">
			<option id="y_opt_2016" value="2016">2016</option>
			<option id="y_opt_2017" value="2017">2017</option>
		</select> 년 <select name="month" id="m_opt">
			<c:forEach begin="1" end="12" var="k">
				<option id="m_opt_${k}">${k }</option>
			</c:forEach>
		</select> 월 <input type="button" onclick="showSelectdate()" value="이동">
	</div>


	<table id="ar_table">
		<thead>
			<tr>
				<th width="100px">날짜</th>
				<th>출근</th>
				<th>퇴근</th>
				<th>IP</th>
				<th>근무시간</th>
			</tr>
		</thead>
		<tbody>
			
			<c:forEach var="vo" items="${arList }" varStatus="i">
			
			<c:choose>
				<c:when test="${(empDeptID == 'PRMT') && (searchResult == 'true')}">
					<tr class="dlist right-click-menu" id="${vo.ar_No}">
				</c:when>
				<c:otherwise>
					<tr class="dlist" >
				</c:otherwise>
			</c:choose>
					<td class="date" >20${vo.ar_Date }</td>
					<td class="startTime">
						<c:choose>
							<c:when test="${empty vo.startTime }">-</c:when>
							<c:otherwise> ${vo.startTime }</c:otherwise>
						</c:choose>
					</td>
					<td class="endTime">
						<c:choose>
								<c:when test="${empty vo.endTime }">-</c:when>
								<c:otherwise> ${vo.endTime }</c:otherwise>
						</c:choose>
					</td>
					<td class="ip">
						<c:choose>
								<c:when test="${empty vo.ip }">-</c:when>
								<c:otherwise> ${vo.ip }</c:otherwise>
						</c:choose>
					</td>
					<td class="workTime">
						<c:choose>
								<c:when test="${empty vo.workTime }">-</c:when>
								<c:otherwise> ${vo.workTime }</c:otherwise>
						</c:choose>
					</td>
					<td id="go_modify" width="10px" style="color: black">
							
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot></tfoot>
	</table>
			
