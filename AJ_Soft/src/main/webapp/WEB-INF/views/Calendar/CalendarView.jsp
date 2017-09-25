<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/fullcalendar/fullcalendar.css" />
<link rel="stylesheet" href="/resources/css/avgrund.css" />

<script type="text/javascript" src="/resources/fullcalendar/jquery.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/moment.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="/resources/fullcalendar/ko.js"></script>
<script type="text/javascript" src="/resources/js/jquery.avgrund.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.modal {
	display: none;
}
</style>

<script type="text/javascript">

	
	$(function(){
		$('#calendar').fullCalendar({
		       // put your options and callbacks here
		       locale: 'ko',
		       dayClick: function(date, jsEvent, view){
		    	   viewModal(date);
		       }
		});
		
		function viewModal(date){
			$("#modal-eventInsert").avgrund();
			alert(date.format());
		}
			
	});
</script>

</head>
<body>
	<form id="main_form">
	<jsp:include page="../layout.jsp" />
		<div id="main_board" class="use-scroll">
			<div id='calendar'></div>
			<div id="modal-eventInsert" class="modal">
				<a id="pick_date">test</a>
			</div>
		</div>
	</form>
</body>
</html>