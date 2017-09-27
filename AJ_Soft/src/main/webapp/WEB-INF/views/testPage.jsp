<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/resources/css/jquery.fastColorPicker.css" />
<link rel="stylesheet" href="/resources/css/colorPick.min.css" />

<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="/resources/fullcalendar/jquery.min.js"></script>
<style type="text/css">

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

</head>
<body>
<div id='my-color-select' class='fast-color-picker'></div>
<div class="colorPickSelector"></div>

	<script src="/resources/js/colorPick.min.js"></script>
	<script>
		$(".colorPickSelector").colorPick({
			'initialColor' : '#27ae60',
			'onColorSelected' : function() {
				console.log("The user has selected the color: " + this.color)
				this.element.css({
					'backgroundColor' : this.color,
					'color' : this.color
				});
			}
		});
	</script>

	<!-- <script type="text/javascript" src="/resources/js/jquery.fastColorPicker.js"></script>
<script type="text/javascript">
var colorArray=['#3f51b5','#ffffff','#ffa500','#696969','#4d3900','#005737','#4169e1','#b399ff','#a4c639'];
var picker=$('#my-color-select').fastColorPicker(colorArray,{
	btn:{
		width:100,
		height:32,
		// border:'false'
	},
	item:{
		width:30,
		height:30,
		// hover:false
	}
});
</script> -->
</body>
</html>