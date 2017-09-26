<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/fullcalendar/fullcalendar.css" />
<link rel="stylesheet" href="/resources/css/avgrund.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.8.2/jquery.modal.min.css" />

<script type="text/javascript" src="/resources/fullcalendar/jquery.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/moment.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/ko.js"></script>
<script type="text/javascript" src="/resources/js/jquery.avgrund.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.8.2/jquery.modal.min.js"></script>

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