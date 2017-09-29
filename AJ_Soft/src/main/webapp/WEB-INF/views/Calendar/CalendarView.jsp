<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/fullcalendar/fullcalendar.css" />
<link rel="stylesheet" href="/resources/css/jquery.modal.css" />
<link rel="stylesheet" href="/resources/css/colorPick.min.css?ver=0" />


<script type="text/javascript" src="/resources/fullcalendar/jquery.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/moment.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/fullcalendar.min.js" charset="euc-kr"></script>
<script type="text/javascript" src="/resources/fullcalendar/locale-all.js"></script>
<script type="text/javascript" src="/resources/js/jquery.modal.min.js"></script>


<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.modal, .popup-a {
	display: none;
}

.input-ul {
	list-style: none;
}


.colorPickSelector {
  border-radius: 5px;
  width: 30px;
  height: 30px;
  cursor: pointer;
  -webkit-transition: all linear .2s;
  -moz-transition: all linear .2s;
  -ms-transition: all linear .2s;
  -o-transition: all linear .2s;
  transition: all linear .2s;
}
.colorPickSelector:hover { transform: scale(1.1); }

#modal-event table{
	width: 100%;
}

#modal-event table th{
	width: 100px;
	text-align: right;
	padding-right: 10px;
}

.text-input {
	width: 100%;
	box-sizing: border-box;
    -webkit-box-sizing:border-box;
    -moz-box-sizing: border-box;
}


</style>

<script type="text/javascript">


	$(function() {
		function clone(obj) {
			if (null == obj || "object" != typeof obj)
				return obj;
			var copy = obj.constructor();
			for ( var attr in obj) {
				if (obj.hasOwnProperty(attr))
					copy[attr] = obj[attr];
			}
			return copy;
		}

		
	$('#calendar').fullCalendar({
			// put your options and callbacks here

			locale : 'ko',
			dayClick : function(date, jsEvent, view) {
				clearModalData();
				$("#modal_startDate").val(date.format());
				
				$("#modal_section").html('<a href="#" onclick="go_AddSchedule()">일정추가</a>');
				
				$("#modal-event").modal();
			},
			eventClick : function(calEvent, jsEvent, view) {
			},
			  /* eventSources : [

			{
				url : '/getCalData.do',
				type: 'POST',
				success : function(data) {
					$(data).each(function() {
						var endDate = new Date(this.end);
						endDate.setDate(endDate.getDate() + 1);
						this.end = endDate;
					});
				}

			}
			// any other event sources...

			],   */
			eventRender : function(event, element) {
				
				element.each(function(){
					//alert(event.newColor);
					$(this).css('background-color',event.newColor);
				});

				element.click(function() {
					// 모달 div에 값 설정
					setDataToModal(event);
					
					$(".colorPickSelector").colorPick({
						'initialColor' : $(this).css('background-color'),
					});
					
					$("#modal_section").html('<a href="#" onclick="go_editSchedule('+event.id+')">수정</a> <a href="#" onclick="go_deleteSchedule('+event.id+')">일정삭제</a>');
					
					// 모달창 띄우자
					$("#modal-event").modal();
				});

			},
			forceRerenderToDisplay : true,
			viewRender : function(view, element){
				var date = $("#calendar").fullCalendar('getDate');
				
			  	getData(date.format("YYYY-MM"));
			}


		});
	
	function clearModalData(){
		$("#modal_startDate").val("");
		$("#modal_endDate").val("");
		$("#modal_title").val("");
		$("#modal_content").val("");
		$("#modal_target").val("");
		$("#modal_location").val("");
	}
	
	function setDataToModal(event){
		$("#modal_startDate").val(event.start.format());
		
		var endDate = moment(event.end).subtract(1,'days').format('YYYY-MM-DD');
		$("#modal_endDate").val(endDate);
		$("#modal_title").val(event.title);
		$("#modal_content").val(event.description);
		$("#modal_target").val(event.target);
		$("#modal_location").val(event.location);
	}
	
	function getData(date){
		
		$.ajax({
			url : '/getCalData.do',
			type: 'POST',
			data : {
				inputdate : date
			},
			dataType :'json',
			success : function(data) {
				$(data).each(function() {
					var endDate = new Date(this.end);
					endDate.setDate(endDate.getDate() + 1);
					this.end = endDate;
				});
				
				$('#calendar').fullCalendar( 'removeEventSources' );
				$('#calendar').fullCalendar('addEventSource',data);
			},
			error: function() {
                alert('there was an error while fetching events!');
            }
		});
	}
	
	
		
	});
</script>
<script src="/resources/js/colorPick.min.js"></script>
	<script>
	$(function(){
		$(".colorPickSelector").colorPick({
			'initialColor' : '#27ae60',
			'onColorSelected' : function() {
				console.log("The user has selected the color: " + this.color);
				$('#color').val(this.color);
				this.element.css({
					'backgroundColor' : this.color,
					'color' : this.color,
				});
			}
		});
	});
	
	function setDataForSubmit(){
		$('#startDate').val($('#modal_startDate').val());
		$('#endDate').val($('#modal_endDate').val());
		$('#title').val($('#modal_title').val());
		$('#target').val($('#modal_target').val());
		$('#content').val($('#modal_content').val());
		$('#location').val($('#modal_locatin').val());
		$('#category').val("My");
	}
	
	
	
	function go_AddSchedule(){
		
		setDataForSubmit();
		
		var date = $("#calendar").fullCalendar('getDate').format("YYYY-MM");
		//alert(date);
		$("#main_form").attr("action",'go_AddSchedule.do?date='+date);
		$("#main_form").submit(); 
	}
	
	function go_editSchedule(id){
		//alert(id);
		
		var date = $("#calendar").fullCalendar('getDate').format("YYYY-MM");
		
		setDataForSubmit();
		$("#schedule_id").val(id);
		$("#date").val(date);
		
		
		$("#main_form").attr("action",'go_EditSchedule.do');
		$("#main_form").submit();  
	}
	
	function go_deleteSchedule(id){
		location.replace("go_deleteSchedule.do?id="+id);
		//$("#main_form").attr("action",'go_EditSchedule.do');
		//$("#main_form").submit();  
	}
</script>

</head>
<body>
	<form id="main_form" method="get">
	<jsp:include page="../layout.jsp" />
	
		<div id="main_board" class="use-scroll">
			<div id='calendar'></div>
			<input type="hidden" id="startDate" name="startDate">
			<input type="hidden" id="endDate" name="endDate">
			<input type="hidden" id="title" name="title">
			<input type="hidden" id="target" name="target">
			<input type="hidden" id="content" name="content">
			<input type="hidden" id="color" name="color">
			<input type="hidden" id="category" name="category">
			<input type="hidden" id="location" name="location">
			<input type="hidden" id="schedule_id" name="id">
			<input type="hidden" id="date" name="date">
			
			<div id="modal-event" class="modal">
				<table>
					<thead>
						<tr>
							<td colspan="2">
							<input type="text" name="title" id="modal_title" placeholder="일정 제목" class="text-input" style="font-size: 1.5em;">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" id="modal_startDate" class='datepicker-here' data-language='en' data-date-format="yyyy-mm-dd">~ 
								<input type='text' id="modal_endDate" class='datepicker-here' data-language='en' 
										data-date-format="yyyy-mm-dd" placeholder="종료일 설정"/>
							</td>
						</tr>
					</thead>
					<tr>
						<th>위치</th>
						<td><input type="text" name="location" id="modal_location" class="text-input"></td>
					</tr>
					<tr>
					<tr>
						<th>공유대상</th>
						<td><input type="text" name="target" id="modal_target" class="text-input"></td>
					</tr>
					<tr>
						<th>색상</th>
						<td><div class="colorPickSelector"></div></td>
					</tr>
					<tr>
						<th>설명</th>
						<td><textarea rows="3" id="modal_content" class="text-input"></textarea></td>
					</tr>
				</table>
				<hr>
				<section class="align-center" id="modal_section">
				</section>
			</div>
		</div>
	</form>

	
</body>
</html>