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
<script type="text/javascript" src="/resources/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/ko.js"></script>
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
					setData(event);
					
					$("#modal_section").html('<a href="#" onclick="go_editSchedule()">수정</a> <a href="#" onclick="go_deleteSchedule()">일정삭제</a>');
					
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
		
	}
	
	function setData(event){
		$("#modal_startDate").val(event.start.format());
		$("#modal_endDate").val(event.end.format());
		$("#modal_title").val(event.title);
		$("#modal_content").val(event.description);
		$("#modal_target").val(event.target);
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
	
	
	
	function go_AddSchedule(){
		
		$('#startDate').val($('#modal_startDate').val());
		$('#endDate').val($('#modal_endDate').val());
		$('#title').val($('#modal_title').val());
		$('#target').val($('#modal_target').val());
		$('#content').val($('#modal_content').val());
		$('#category').val("My");
		
		$("#main_form").attr("action",'go_AddSchedule.do');
		$("#main_form").submit(); 
	}
	
	function go_editSchedule(){
		
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
			
			<div id="modal-event" class="modal">
				<ul class="input-ul">
					<li><a id="pick_date">일정추가</a><br>
				시작일: <input type="text" id="modal_startDate" class='datepicker-here' data-language='en' data-date-format="yyyy-mm-dd">~ 
				종료일: <input type='text' id="modal_endDate" class='datepicker-here' data-language='en' data-date-format="yyyy-mm-dd" /></li>
					<li>제목
				<input type="text" name="title" id="modal_title"></li>
					<li>공유대상
				<input type="text" name="target" id="modal_target"></li>
					<li>색상
						<div class="colorPickSelector"></div>
					</li>
					<li>설명
				<input type="text" id="modal_content"></li>
				</ul>
				<hr>
				<section class="align-center" id="modal_section">
				
				</section>
			</div>
			<!-- <div id="modal-eventView" class="modal">
				<ul class="input-ul">
					<li><a id="pick_date">일정보기</a><br>
				시작일: <input type="text" id="startDate_view" class='datepicker-here' data-language='en' data-date-format="yyyy-mm-dd" >~ 
				종료일: <input type='text' id="endDate_view" class='datepicker-here' data-language='en' data-date-format="yyyy-mm-dd" /></li>
					<li>제목
				<input type="text" name="title" id="title_view"></li>
					<li>공유대상
				<input type="text" name="target" id="targer_view"></li>
					<li>색상
						<div class="colorPickSelector"></div>
					</li>
					<li>설명
				<input type="text" id="content_view"></li>
				</ul>
				<hr>
				<section class="align-center" >
				<a href="#" onclick="go_editSchedule()">수정</a> <a href="#" onclick="go_deleteSchedule()">일정삭제</a>
				</section>
			</div> -->
			<!-- <a class="popup-a" href="#modal-eventInsert" rel="modal:open"></a> -->
		</div>
	</form>

	
</body>
</html>