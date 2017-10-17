<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
}

.float_left {
	padding: 10px 0px 0 0px;
	margin: 0 0 0 10px;
	float: left;
	border: 1px solid #aaa;
	width: 710px;
	height: inherit;
}

#contactList {
	height: inherit;
	width: 100%;
}

#contact-ul,#contact-ul ul {
	list-style: none;
	padding: 0;
}

#contact-ul li {
	margin-left: 2px;
	margin-top: 10px;
	margin-bottom: 10px;
}
#contact-ul li li {
	margin-left: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
}

.font-bold{
	font-weight: bold;
}
</style>
<script type="text/javascript">
	$(function() {
		$('li a').removeClass('menu_active');
		$('li[data-tab=tab2] a').addClass('menu_active');
		
		
		$(".goDeptContact").click(function() {
			var deptId = $(this).attr("id");
			$('#contactList').empty();
			$('#contactList').load('getContactDept.do?deptId=' + deptId);
		});
		$("#addContact").click(function() {
			$('#contactList').empty();
			$('#contactList').load('go_addContactView.do');
		});

		$(".go_cListView").click(function() {
			$('#contactList').empty();
			var gName = $(this).attr("id");
			$('#contactList').load('getContactMy.do?gName=' + gName);

		});

	});

	$(function() {
		$.contextMenu({
			selector : '.right-click-menu',
			callback : function(key, options) {
				//var m = "clicked: " + key;
				// window.console && console.log(m) || alert(m); 
				var id = $(this).attr('id');
				if (key == 'edit') {
					$('#contactList').load("go_editContact.do?id=" + id);
					//location.replace("go_editContacte.do?id="+id);
				} else if (key == 'delete') {
					//alert($(this).attr('id'));
					deleteContact(id, $(this));
					$(this).remove();
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

		function deleteContact(id, item) {
			var result = "";

			$.ajax({
				url : 'deleteContact.do',
				type : 'POST',
				data : {
					id : id
				},
				dataType : 'text',
				success : function(data) {
					result = data;
				},
				error : function() {
					alert('there was an error while delete contact!');
					result = false;
				}
			});
			return result;
		}

	});
</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">

				<ul id="contact-ul">

					<li class="font-bold"><i class="fa fa-address-book-o" aria-hidden="true"></i> 개인 주소록</li>
					<li>
						<ul>
							<c:if test="${!empty cList }">
								<c:forEach items="${cList }" var="k">
									<li class="btn go_cListView" id="${k.contact_group}"><i
										class="fa fa-address-card-o" aria-hidden="true"></i>
										${k.contact_group}</li>
								</c:forEach>
							</c:if>
							<li class="t-grey btn" id="addContact">&nbsp;&nbsp;<i
								class="fa fa-plus-square-o" aria-hidden="true"></i> 연락처 추가
							</li>
						</ul>
					</li>
					<!-- 팀별로 공유될 주소록 -->
					<!-- 사내 팀 목록 -->
					<li class="font-bold"><i class="fa fa-address-book" aria-hidden="true"></i> 사내 주소록</li>
					<li>
						<ul>
							<c:if test="${!empty deptList  }">
								<c:forEach items="${deptList }" var="l">
									<li id="${l.departmentID }" class="goDeptContact btn"><i
										class="fa fa-address-card" aria-hidden="true"></i>
										${l.departmentName }</li>
								</c:forEach>
							</c:if>
						</ul>
					</li>
				</ul>
			</div>

			<div class="float_left use-scroll">
				<div id="contactList"></div>
			</div>

		</div>
	</form>
</body>
</html>