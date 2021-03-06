<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.contextMenu.css"
	rel="stylesheet" type="text/css" />
<script
	src="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.contextMenu.js"
	type="text/javascript"></script>
<script
	src="https://swisnl.github.io/jQuery-contextMenu/dist/jquery.ui.position.min.js"
	type="text/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.float_left_menu {
	padding: 10px 10px 0 10px;
	margin: 0px;
	float: left;
	border: 1px solid #aaa;
	width: 150px;
	height: inherit;	
	border-radius: 5px;
}
.float_left {
	padding: 10px 0px 0 0px;
	margin: 0 0 0 10px;
	float: left;
	border: 1px solid #aaa;
	width: 710px;
	height: inherit;
	border-radius: 5px;	
}
#arView{
	width: 100%;
	height: inherit;
}
#ar_table {
	width: 100%;
}
#ar_table th {
	height: 30px;
	background-color: #E8C77A
}
.display-none{
	display: none;
}
.arEditNow {
	width: 100px;
}


.font-bold{
	font-weight: bold;
}
</style>
<script type="text/javascript">
	$(function(){
		
		$('li a').removeClass('menu_active');
		$('li[data-tab=tab1] a').addClass('menu_active');
		
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
		
		$("#arView").load('goARView2.do');
		
		$(".inDept").click(function(){
			//alert($(this).attr("id"));
			
			$("#arView").load('goARView2.do', {id:$(this).attr("id")}, function(){});
			$("#date_select_div_dept").addClass("display-none");
			$("#date_select_div_my").removeClass("display-none");
		});
		
		$('#findAR-input').keyup(function(){
			var chkRadio = $(':radio[name="find-radio"]:checked').val();
			//alert(chkRadio);
		});
		
		var editSelected =null;
		
		$.contextMenu({
			selector : '.right-click-menu',
			callback : function(key, options) {
				//var m = "clicked: " + key;
				// window.console && console.log(m) || alert(m); 
				var id;
				
				id = $(this).attr('id');
				if (key == 'edit') {
					//id = $(this).children("td.date").attr('id');
					
					if(editSelected != null){
						// 이미 수정하던 element가 있었다면
						editCancel(editSelected);
						$("#editArBtn").remove();
					}
					editSelected = $(this);
					
					// id가 0이면 수정했을 때 insert필요하다
					// id가 0이 아니면 해당 아이디가 key값
					//alert(id);
					
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
					var searchID = $("#searchID").val();
					if(id == 0){
						return;
					}
					//alert("id>>>"+id);
					$("#arView").load('goDeleteAR.do', {arNO:id,id:searchID}, function(){
						alert("삭제완료!");						
					});
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
		
		function getText(parent, cName){
			return parent.children("td[class="+cName+"]").text().trim();
		}
		function setInputText(parent, cName, textVal){
			var element = parent.children("td[class="+cName+"]");
			element.empty();
			element.append("<input class='arEditNow'  type='text' value="+textVal+">");
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
			var selectedDate = $(this).parent().siblings(".date").text();
			//alert($("#searchID").val());
			/* $(".arEditNow").each(function(){
				transVal+=$(this).val()+"/";
				//alert($(this).val());
			}); */
			
			$.ajax({
				type:'POST',
				url : 'goEditAR.do',
				data:{
					startTime : $(".arEditNow:eq(0)").val(),
					endTime : $(".arEditNow:eq(1)").val(),
					ip : $(".arEditNow:eq(2)").val(),
					ar_No : $(this).parent().parent().attr('id'),
					id: $("#searchID").val(),
					ar_Date: selectedDate
				},
				dataType: 'text',
				success : function(data){
					$("#arView").load('goARView2.do', {id:$("#searchID").val(), searchResult:'searchResult'}, function(){});
				},
				error: function(){
					alert("수정실패");
				}
			}); 
			
			/* var editID = $(this).parent().parent().attr('id');
			var startVal = $(this).find("input[class=startTime]").val();
			alert(startVal); */
			
			//$("#arView").load('goEditAR.do', {id:editID,startTime:}, function(){});
		});
		
	});
	
	function showMyAR(){
		$("#arView").load('goARView2.do');
		$("#date_select_div_dept").addClass("display-none");
		$("#date_select_div_my").removeClass("display-none");
	}
	
	function showDeptAR(){
		$("#arView").load('goDeptARView.do',function(responseTxt, statusTxt, xhr){
			if(statusTxt == "success")
	            //alert(responseTxt);
	        if(statusTxt == "error")
	            alert("Error: " + xhr.status + ": " + xhr.statusText);
		});
		$("#date_select_div_dept").removeClass("display-none");
		$("#date_select_div_my").addClass("display-none");
		
		
	}
	function searchDeptAR(){
		/* $("#arView").load('goDeptARView.do',function(responseTxt, statusTxt, xhr){
			if(statusTxt == "success")
	            //alert(responseTxt);
	        if(statusTxt == "error")
	            alert("Error: " + xhr.status + ": " + xhr.statusText);
		});
		$("#date_select_div_dept").removeClass("display-none");
		$("#date_select_div_my").addClass("display-none"); */
		
		
	}
	
	function showSelectdate(){		
		//alert($("#y_opt").val()+'/'+$("#m_opt").val());
		var id = $("#searchID").val();
		if(id != null){
			$("#arView").load('goARView2.do', {year:$("#y_opt").val(), month:$("#m_opt").val(), id:id, searchResult:'searchResult'}, function(){});
		}else{
			$("#arView").load('goARView2.do', {year:$("#y_opt").val(), month:$("#m_opt").val(), id:$("#receiveID").val()}, function(){});
		}
	}
	
	function showSelectdateDept(){
		//alert($("#input-date").val());
		$("#arView").load('goDeptARView.do', {inputdate:$("#input-date").val()}, function(){});
	}
	
	function go_findAR(frm){
		
		var findKey = $("#findAR-input").val();
		var chkRadio = $(':radio[name="find-radio"]:checked').val();
		// 검색어는 2글자 이상!
		if(findKey.length <= 2){
			alert("2글자 이상 검색가능");
			return;
		}else{
			if(chkRadio == 'name' ){
				
			}else{	// id로 검색하는 경우
				$("#arView").load('goARView2.do', {id:findKey, searchResult:'searchResult'}, function(){});
			}			
		}
	}
	
</script>
</head>
<body>

	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
			
				<%-- <ul id="ar-ul">
					<li class="font-bold btn" onclick="showMyAR()"> 내 근태 현황</li>
					<c:if test="${!empty deptSuper }">
					<li class="font-bold btn" onclick="showDeptAR()">부서 근태 현황</li>
						<ul>
							<c:forEach var="k" items="${empList}">
							<li  id="${k.id}" class="btn inDept"> &nbsp;&nbsp;&nbsp; - ${k.name}</li>
							</c:forEach>
						</ul>
					</c:if>
				</ul>
						<input type="hidden" name="" id="selectedID">
				 --%>
			
				<a href="#" onclick="showMyAR()" class="font-bold">내 근태 현황</a>
				<hr>
				<c:if test="${!empty deptSuper }">
					<a href="#" onclick="showDeptAR()" class="font-bold">부서 근태 현황</a>
					<br>	
					<c:forEach var="k" items="${empList}">
						&nbsp;&nbsp;&nbsp;<a href="#" class="inDept" id="${k.id}"> - ${k.name}</a><br>										
					</c:forEach>
					<input type="hidden" name="" id="selectedID">
					<hr>
				</c:if>
				<c:if test="${empDeptID == 'PRMT' }">
				<!-- 인사관리팀이면 보여줄 페이지 -->
					<a href="#" onclick="searchDeptAR()">근태 검색</a>
					<input id="findAR-input" name="findAR" type="text" size="12" class="autoCompleteID"/><a
					onclick="go_findAR($(this).closest('form')[0])"> <img alt="find" src="resources/Image/find_person.png" width="15px" height="15px" class="btn"> </a>
					<br>
					<input type="radio" name="find-radio" value="id" checked="checked"> ID
					<!-- <input type="radio" name="find-radio" value="name" > NAME -->
				</c:if>
			</div>
			<div class="float_left use-scroll" >
				<%-- <div class="left">${searchID}</div>
			
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
					</select> 월
					<input type="button" onclick="showSelectdate()" value="이동">
				</div> --%>
				
				<div class="align-center display-none" id="date_select_div_dept">
					<input type="date" name="date" id="input-date">
					<input type="button" onclick="showSelectdateDept()" value="이동">
				</div>
				<div id="arView">
				
				</div>
			</div>
			
		</div>
	</form>
</body>
</html>