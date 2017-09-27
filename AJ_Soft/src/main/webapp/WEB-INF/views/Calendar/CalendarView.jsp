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

	
	$(function(){
		$('#calendar').fullCalendar({
		       // put your options and callbacks here
		       locale: 'ko',
		       dayClick: function(date, jsEvent, view){
		    	   $("#modal_startDate").val(date.format());
		    	  /*  $(this).avgrund({
		    		   template: $(".avgrund-popup")
		    	   }); */
		    	   //$('.popup-a').click();
		    	   $("#modal-eventInsert").modal();
		       },
		       eventClick: function(calEvent, jsEvent, view) {

		           /* alert('Event: ' + calEvent.title);
		           alert('Event - id: ' + calEvent.id);
		           alert('Event - content: ' + calEvent.description); */
		           
		           /* alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
		           alert('View: ' + view.name); */

		           // change the border color just for fun
		           $(this).css('border-color', 'red');

		       },
				
		eventSources: [
			'/getCalData.do',

	        // your event source
	        /* {
	            events: {
	            	url: '/getCalData.do',
	            	success : function(){
	            		alert("su");
	            	},
	            	error : function(){
	            		alert("error");
	            	}
	            	
	            	
	            }/* [ // put the array in the `events` property
	                {
	            		id: '11',
	                    title  : 'event1',
	                    start  : '2017-09-05',
	                    description : '중요한날'
	                },
	                {
	                	id: '22',
	                    title  : 'event2',
	                    start  : '2017-09-05',
	                    end    : '2017-09-07'
	                }
	            ] */,
	            /* color: 'black',     // an option! */
	       // } */

	        // any other event sources...

	    ],
	    eventRender: function(event, element) {
	    	element.click(function(){
	    		 alert('Event: ' + event.title);
		           alert('Event - id: ' + event.id);
		           alert('Event - content: ' + event.description);
	    	});
	    	
	    }
		});
		
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
		/* $.ajax({
			url: 'go_AddSchedule.do',
			type: 'GET',
			data : {
				title : $('#title').val(),
				target : $('#target').val(),
				startDate : $('#startDate').val(),
				endDate : $('#endDate').val(),
				content: $("#content").val(),
				color : $("#selectedColor").val()
						
			},
			success : function(){
				$.modal.close();
			}
			
		}); */
		
		$('#startDate').val($('#modal_startDate').val());
		$('#endDate').val($('#modal_endDate').val());
		$('#title').val($('#modal_title').val());
		$('#target').val($('#modal_target').val());
		$('#content').val($('#modal_content').val());
		$('#category').val("My");
		
		
		
		$("#main_form").attr("action",'go_AddSchedule.do');
		$("#main_form").submit(); 
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
			
			<div id="modal-eventInsert" class="modal">
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
				<a href="#" onclick="go_AddSchedule()">일정추가</a>
			</div>
			<!-- <a class="popup-a" href="#modal-eventInsert" rel="modal:open"></a> -->
		</div>
	</form>

	
</body>
</html>