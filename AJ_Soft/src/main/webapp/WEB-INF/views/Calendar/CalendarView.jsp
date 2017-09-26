<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/fullcalendar/fullcalendar.css" />
<!-- <link rel="stylesheet" href="/resources/css/avgrund.css" /> -->
<link rel="stylesheet" href="/resources/css/jquery.modal.css" />

<script type="text/javascript" src="/resources/fullcalendar/jquery.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/moment.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/ko.js"></script>
<!-- <script type="text/javascript" src="/resources/js/jquery.avgrund.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.8.2/jquery.modal.min.js"></script> -->
<script type="text/javascript" src="/resources/js/jquery.modal.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.modal, .popup-a {
	display: none;
}
</style>

<script type="text/javascript">

	
	$(function(){
		$('#calendar').fullCalendar({
		       // put your options and callbacks here
		       locale: 'ko',
		       dayClick: function(date, jsEvent, view){
		    	   $("#sDate").val(date.format());
		    	  /*  $(this).avgrund({
		    		   template: $(".avgrund-popup")
		    	   }); */
		    	   //$('.popup-a').click();
		    	   $("#modal-eventInsert").modal();
		       },
		       eventClick: function(calEvent, jsEvent, view) {

		           alert('Event: ' + calEvent.title);
		           alert('Event - id: ' + calEvent.id);
		           alert('Event - content: ' + calEvent.description);
		           
		           /* alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
		           alert('View: ' + view.name); */

		           // change the border color just for fun
		           $(this).css('border-color', 'red');

		       },
				
		eventSources: [

	        // your event source
	        {
	            events: [ // put the array in the `events` property
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
	            ],
	            /* color: 'black',     // an option! */
	        }

	        // any other event sources...

	    ],
	    eventRender: function(event, element) {
	    	element.attr('description', event.description);
	    	
	    }
		});
	});
</script>

</head>
<body>
	<form id="main_form">
	<jsp:include page="../layout.jsp" />
		<div id="main_board" class="use-scroll">
			<div id='calendar'></div>
			<div id="modal-eventInsert" class="modal">
				<a id="pick_date">일정추가</a>
				<input type="text" id="sDate" name="startDate">
			</div>
			
			<!-- <a class="popup-a" href="#modal-eventInsert" rel="modal:open"></a> -->
		</div>
	</form>
</body>
</html>