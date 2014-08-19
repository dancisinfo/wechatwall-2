<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="content-type" content="text/html; charset=gbk">
<meta name="HandheldFriendly" content="true">
<meta name="apple-touch-fullscreen" content="yes" />
<title>����ϲ��</title>
<link href="css/invitation.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" media="only screen and (-webkit-min-device-pixel-ratio: 2)" type="text/css" href="css/highdpi.css" />
<script>
	var imgUrl = "http://59.46.100.104:8090/test/images/shareimg.jpg";
	var lineLink = "http://59.46.100.104:8090/test/invitation.jsp";
	var descContent = '�캮���Ҫ������������������μ����ǵĻ���Ϊ������λ����ϲ�����������»�ִ��';
	var shareTitle = '����ϲ��';
	var appid = '';

	function shareFriend() {
		WeixinJSBridge.invoke('sendAppMessage', {
			"appid" : appid,
			"img_url" : imgUrl,
			"img_width" : "200",
			"img_height" : "200",
			"link" : lineLink,
			"desc" : descContent,
			"title" : shareTitle
		}, function(res) {
		});
	}

	function shareTimeline() {
		WeixinJSBridge.invoke('shareTimeline', {
			"img_url" : imgUrl,
			"img_width" : "200",
			"img_height" : "200",
			"link" : lineLink,
			"desc" : descContent,
			"title" : shareTitle
		}, function(res) {
		});
	}

	function shareWeibo() {
		WeixinJSBridge.invoke('shareWeibo', {
			"content" : descContent,
			"url" : lineLink,
		}, function(res) {
		});
	}

	// ��΢���������������ڲ���ʼ����ᴥ��WeixinJSBridgeReady�¼���
	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		// ���͸�����
		WeixinJSBridge.on('menu:share:appmessage', function(argv) {
			shareFriend();
		});

		// ��������Ȧ
		WeixinJSBridge.on('menu:share:timeline', function(argv) {
			shareTimeline();
		});

		// ����΢��
		WeixinJSBridge.on('menu:share:weibo', function(argv) {
			shareWeibo();
		});
	}, false);
</script>
<script type="text/javascript">
	var submiting = false;
	window.onload = function() {
		function highdpi_init() {
			var els = document.getElementsByClassName("replace-2x");
			for (var i = 0; i < els.length; i++) {
				els[i].src = els[i].src.replace(".jpg", "@2x.jpg");
			}
		}

		// highdpi_init();

		document.getElementById("submitBtn").onclick = function() {
			if (submiting) {
				return;
			}
			var ele = document.getElementById("guestName");
			if (ele.value == "") {
				ele.focus();
				ele.style.border = "1px solid red";
				return;
			}
			ele.style.border = "";
			submiting = true;
			document.getElementById("form1").submit();
		};

		document.getElementById("submitFrame").onload = function() {
			var ele = document.getElementById("formcontainer");
			if (this.contentDocument.body.innerHTML) {
				ele.style.paddingTop = "100px";
				ele.style.fontSize = "0.75em";
				ele.innerHTML = "��л����.";
			}
		}
	};
</script>
</head>
<body>
	<div class="invitationmain">
		<div class="titlebanner">
			<div class="title1">Come and Enjoy</div>
			<div class="subtitle1">
				�캮&��Ļ��񣬾���ϲ��<br />2014.10.18 08:30
			</div>
		</div>
		<div class="mapbanner">
			<div class="map">
				<a href="http://api.map.baidu.com/geocoder?address=���������Ƶ�&output=html" target="_blank"> <img src="images/location@2x.jpg" class="replace-2x" /></a>
			</div>
			<div class="address">
				<a href="http://api.map.baidu.com/geocoder?address=���������Ƶ�&output=html" target="_blank">������ƽ�����׶�·18�������Ƶ�</a>
			</div>
		</div>
		<div class="checkinbanner">
			<div class="title2">ǩ����</div>
		</div>
		<div class="checkincontainer">
			<div class="formcontainer" id="formcontainer">
				<form action="invitationServlet.do" target="submitFrame" name="form1" id="form1" method="post">
					<ul>
						<li><input type="text" id="guestName" name="guestName" placeholder="���մ���" class="guestname" /></li>
						<li class="attendanceli">
							<div class="attendcontainer">
								<label class="attendance"><input type="radio" name="attendance" value="0"><span>Ǯ��</span></label> <label class="attendance"><input
									type="radio" name="attendance" value="1" checked="checked"><span>�˵�</span></label> <label class="attendance"><input type="radio"
									name="attendance" value="2"><span>��������</span></label>
							</div>
						</li>
						<li><textarea rows="2" cols="" id="remark" name='remark' placeholder="����ʲôҪ˵���𣿱��磺��Ҫ�͵��������һ�������ߣ����ǵ�����"></textarea></li>
						<li><input type="button" id="submitBtn" class="submitbtn" value="ȷ�ϻ�ִ" /></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
	<iframe name="submitFrame" id="submitFrame" src="" hidden="true"></iframe>
</body>
</html>