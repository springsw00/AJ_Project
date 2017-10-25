<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>메세지함</title>

<style type="text/css">
body {
	margin: 0px;
}

#tabbed_box {
	margin: 0px auto 0px auto;
	width: 300px;
	height: 100%;
}

.tabbed_area {
	border: 1px solid #494e52;
	background-color: #636d76;
	padding: 8px;
	margin: 0px;
	height: 100%
}

ul.tabs {
	margin: 0px;
	padding: 0px;
}

ul.tabs li {
	list-style: none;
	display: inline;
}

ul.tabs li a {
	background-color: #464c54;
	color: #ffebb5;
	padding: 8px 14px 8px 14px;
	text-decoration: none;
	font-size: 9px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	text-transform: uppercase;
	border: 1px solid #464c54;
}

ul.tabs li a:hover {
	background-color: #2f343a;
	border-color: #2f343a;
}

ul.tabs li a.active {
	background-color: #ffffff;
	color: #282e32;
	border: 1px solid #464c54;
	border-bottom: 1px solid #ffffff;
}

.tab_content {
	background-color: #ffffff;
	padding: 10px;
	border: 1px solid #464c54;
}

#content_2, #content_3 {
	display: none;
}

ul.tabs {
	margin: 0px;
	padding: 0px;
	margin-top: 5px;
	margin-bottom: 6px;
}

.tab_content ul {
	margin: 0px;
	padding: 0px 20px 0px 20px;
}

.tab_content ul li {
	list-style: none;
	border-bottom: 1px solid #d6dde0;
	padding-top: 15px;
	padding-bottom: 15px;
	font-size: 13px;
}

.tab_content ul li a {
	text-decoration: none;
	color: #3e4346;
}

.tab_content ul li a small {
	color: #8b959c;
	font-size: 9px;
	text-transform: uppercase;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	position: relative;
	left: 4px;
	top: 0px;
}

/* textarea */
.wrap {
	width: 100%;
	height: 300px;
	position: relative;
	display: inline-block;
}

.wrap textarea {
	width: 100%;
	resize: none;
	line-height: 1.6em;
	height: 100%;
	box-sizing: border-box;
    -webkit-box-sizing:border-box;
    -moz-box-sizing: border-box;
}

.wrap span {
	position: absolute;
	bottom: 5px;
	right: 5px;
}

#counter {
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
}

#msgWrite-div table {
	width: 100%;
}

.tab_content small {
	float: right;
}

.msg-unRead {
	font-weight: bold;
}

	

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		var websocket;
		connectSocket();

		
		// When a link is clicked
		$("a.tab").click(function() {

			// switch all tabs off
			$(".active").removeClass("active");

			// switch this tab on
			$(this).addClass("active");

			// slide all elements with the class 'content' up
			$(".tab_content").hide();

			// Now figure out what the 'title' attribute value is and find the element with that id.  Then slide that down.
			var content_show = $(this).attr("title");
			$("#" + content_show).show();

			$('#content').keyup(function(e) {
				var maxlength = 300;
				var content = $(this).val();
				if(content.length > maxlength){
					alert("글자 수 초과");
					content = content.substr(0,maxlength);
					$(this).val(content);
				}
				
				//$(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
				$('#counter').html(content.length + '/'+maxlength);
			});
			$('#content').keyup();
		});
		
		$("#msgSendBtn").click(function(){
			
			var f = $("#msgSendForm");
			
			f.submit();
			
			sendMsg(f.find('[name=receiveID]').val());
			
			
			alert("전송완료");
		});
		
		$(".msg-append").click(function(){
			var t = $(this);
			
			/* class msg-unRead 제거 */
			t.removeClass("msg-unRead");
			
			var viewEle = $(this).next();
			if(viewEle.is(":visible")){
				viewEle.slideUp();
			}
			else{
				$(".hidden-item").slideUp();
				if(t.next().html().trim() != ""){
					viewEle.slideDown();
				}else{
					viewEle.slideDown(function() {
						if (t.attr('title') == 'receive') {
							showMsg(t.attr("id"), t, 'receive');
						} else {
							showMsg(t.attr("id"), t, 'send');
						}
					});
					
				}
			}
		});

		$(".hidden-item").hide();
		
		function connectSocket(){
			var loc = window.location;
			websocket = new WebSocket("ws://"+loc.host+"/"+loc.pathname.split('/')[1]+"/msgCount");
			websocket.onopen = function(evt){
			}; 
		}
		
	
		function sendMsg(receiveID) {
			//웹소캣

			// var loc = window.location;
			//websocket = new WebSocket("ws://"+loc.host+"/"+loc.pathname.split('/')[1]+"/msgCount");
			//websocket.onopen = function(evt){
			websocket.send(receiveID);
			//};  

			/* websocket.onmessage = function(evt) {
				onMessage(evt);
			}; */
			/* websocket.onerror = function(evt) {
				onError(evt);
			}; */
		}

		function onError(evt) {
			alert("error");
		}
		function showMsg(msgNo, t, type) {
					//alert(msgNo);
				$.ajax({
					url : "getMessage.do",
					data : {
						msgNo : msgNo,
						type : type
					},
					dataType : 'json',
					success : function(data) {
						//t.next().empty();

						t.next().append("<table></table>");
						var table = t.next().find('table');
						if (type == 'receive') {
							table.append("<tr><th>보낸사람</th><td>"
									+ data.senderID + "</td></tr>");
						} else {
							table.append("<tr><th>받을사람</th><td>"
									+ data.receiveID + "</td></tr>");
						}
						table.append("<tr><th>날짜</th><td>" + data.msgDate
								+ "</td></tr>");
						table.append("<tr><td colspan='2'><pre>"
								+ data.content + "</pre></td></tr>");

						// 안읽은 메세지 개수 새로표시
						sendMsg("${empID}");
					}
				});
			}

		});
</script>
</head>
<body>
<div id="tabbed_box_1" class="tabbed_box">
    <div class="tabbed_area">
        <ul class="tabs">
            <li><a href="#" title="content_1" class="tab active">Receive</a></li>
            <li><a href="#" title="content_2" class="tab" >Send</a></li>
            <li><a href="#" title="content_3" class="tab">Write</a></li>
        </ul>
         
         <!-- 수신함 -->
        <div id="content_1" class="tab_content">
            <ul>
            	<c:if test="${!empty msgList}">
	            	<c:forEach items="${msgList }" var="k">
	            		<c:choose>
	            			<c:when test="${k.readChk ==0 }">	<!-- 안읽은메세지 일 경우 -->
			            		<li id="${k.message_no}" class="msg-append msg-unRead" title="receive">
	            			</c:when>
	            			<c:otherwise>
			            		<li id="${k.message_no}" class="msg-append" title="receive">
	            			</c:otherwise>
	            		</c:choose>
	            		
	            		
	            		<a href="#"> 
	            			<c:choose>
	            				<c:when test="${fn:length(k.content) > 13}">
		            				<c:out value="${fn:substring(k.content, 0, 13) }..." />
	            				</c:when>
	            				<c:otherwise>
				            		${k.content } 
	            				</c:otherwise>
	            			</c:choose>
	            			<small>${k.senderID }&nbsp;|&nbsp;${fn:substring(k.msgDate,0,10) }</small>
	            		</a>
	            		</li>
	            		<li class="hidden-item">
	            		</li>
	            	</c:forEach>
            	</c:if>
                <c:if test="${empty msgList}">
                	<li><a href=""> 수신한 메세지가 없습니다. </a></li>
                </c:if>
            </ul>
        </div>
        <!-- 발신함 -->
        <div id="content_2" class="tab_content">
            <ul>
            	<c:if test="${!empty sendList}">
	            	<c:forEach items="${sendList }" var="k">
	            		<li id="${k.message_no }" class="msg-append" title="send"><a href="#"> 
	            			<c:choose>
	            				<c:when test="${fn:length(k.content) > 13}">
		            				<c:out value="${fn:substring(k.content, 0, 13) }..." />
	            				</c:when>
	            				<c:otherwise>
				            		${k.content } 
	            				</c:otherwise>
	            			</c:choose>
	            		<small>${k.receiveID }&nbsp;|&nbsp;${fn:substring(k.msgDate,0,10) }</small></a>
	            		</li>
	            		<li class="hidden-item">
	            		</li>
	            	</c:forEach>
            	</c:if>
            	<c:if test="${empty sendList}">
                	<li><a href=""> 보낸 메세지가 없습니다. </a></li>
                </c:if>
            </ul>
        </div>
        <!-- 쪽지보내기 -->
        <div id="content_3" class="tab_content">
            <div id="msgWrite-div">
            <form action="msgSend.do" method="post" id="msgSendForm">
            	<table>
            		<thead>
            			<tr>
            				<th>받을사람</th>
            				<td><input type="text" name="receiveID"></td>
            				<td><input type="button" value="전송" id="msgSendBtn"></td>
            			</tr>
            		</thead>
            		<tbody>
            			<tr>
            				<td colspan="3">
            					<div class="wrap">
            					<textarea name="content" id="content"></textarea>
            					<span id="counter">###</span>
            					</div>
            				</td>
            			</tr>
            		</tbody>
            		
            	</table>
            </form>
            </div>
        </div>
     
    </div>
 
</div>
</body>
</html>