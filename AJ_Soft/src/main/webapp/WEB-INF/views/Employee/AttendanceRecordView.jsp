<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="resources/fullcalendar/moment.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		
		
		
		

		$.contextMenu({
			selector : '.right-click-menu',
			callback : function(key, options) {
				//var m = "clicked: " + key;
				// window.console && console.log(m) || alert(m); 
				var id;
				if (key == 'edit') {
					//id = $(this).children("td.date").attr('id');
					id = $(this).attr('id');
					if(editSelected != null){
						// 이미 수정하던 element가 있었다면
						editCancel(editSelected);
						$("#editArBtn").remove();
					}
					editSelected = $(this);
					
					// id가 0이면 수정했을 때 insert필요하다
					// id가 0이 아니면 해당 아이디가 key값
					//alert(id);
					/* $(this).children("td[class!=date]").each(function(index){
						var tmpText = $(this).text().trim();
						if(tmpText != "-"){
							
							$(this).append("<input class='arEdit' type='text' value="+tmpText+">");
							$(this).parent().find("#go_modify").html("<i class='fa fa-check btn' aria-hidden='true'></i>");
						}else{
							
						}
					}); */
					startTime = getText($(this),"startTime");
					endTime = getText($(this),"endTime");
					ip = getText($(this),"ip");
					//workTime = getText($(this),"workTime");
					
					setInputText($(this),"startTime",startTime);
					setInputText($(this),"endTime", endTime);
					setInputText($(this),"ip",ip);
					//setInputText($(this),"workTime",workTime);
					var editBtn = "<i class='fa fa-check btn editArBtn' aria-hidden='true'></i>";
					$(this).find("#go_modify").html(editBtn);
					
				} else if (key == 'delete') {
					
				}
			},
			items : {
				"edit" : {
					name : "Edit",
					icon : "edit"
				},

				"delete" : {
					name : "Delete",
					icon : "delete"
				}

			}
		});
		
		
		$(document).on("click",".editArBtn",function(){
			alert("dd");
			
			/* var editID = $(this).parent().parent().attr('id');
			var startVal = $(this).find("input[class=startTime]").val();
			alert(startVal); */
			
			//$("#arView").load('goEditAR.do', {id:editID,startTime:}, function(){});
		});
	});
	
	
</script>
</head>
<body>
	<input type="hidden" id="receiveID">
	<table id="ar_table">
		<thead>
			<tr>
				<th>날짜</th>
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
			
</body>
</html>