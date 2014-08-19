<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="utf8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="content-type" content="text/html; charset=utf8">
<meta name="HandheldFriendly" content="true">
<meta name="apple-touch-fullscreen" content="yes" />
<title>婚礼喜帖</title>
<link href="css/invitation.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" media="only screen and (-webkit-min-device-pixel-ratio: 2)" type="text/css" href="css/highdpi.css" />
<script>
	var imgUrl = "http://59.46.100.104:8090/test/images/shareimg.jpg";
	var lineLink = "http://59.46.100.104:8090/test/invitation.jsp";
	var descContent = '徐寒李娇媚要结婚啦，特邀请您来参加我们的婚礼。为安排桌位请在喜帖最下面留下回执。';
	var shareTitle = '婚礼喜帖';
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

	// 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		// 发送给好友
		WeixinJSBridge.on('menu:share:appmessage', function(argv) {
			shareFriend();
		});

		// 分享到朋友圈
		WeixinJSBridge.on('menu:share:timeline', function(argv) {
			shareTimeline();
		});

		// 分享到微博
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
				ele.innerHTML = "多谢合作.";
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
				徐寒&李娇媚婚礼，敬备喜宴<br />2014.10.18 08:30
			</div>
		</div>
		<div class="mapbanner">
			<div class="map">
				<a href="http://api.map.baidu.com/geocoder?address=沈阳燕豪大酒店&output=html" target="_blank"> <img src="images/location@2x.jpg" class="replace-2x" /></a>
			</div>
			<div class="address">
				<a href="http://api.map.baidu.com/geocoder?address=沈阳燕豪大酒店&output=html" target="_blank">沈阳和平区长白东路18号燕豪大酒店</a>
			</div>
		</div>
		<div class="checkinbanner">
			<div class="title2">签到处</div>
		</div>
		<div class="checkincontainer">
			<div class="formcontainer" id="formcontainer">
				<form action="invitationServlet.do" target="submitFrame" name="form1" id="form1" method="post">
					<ul>
						<li><input type="text" id="guestName" name="guestName" placeholder="尊姓大名" class="guestname" /></li>
						<li class="attendanceli">
							<div class="attendcontainer">
								<label class="attendance"><input type="radio" name="attendance" value="0"><span>钱到</span></label> <label class="attendance"><input
									type="radio" name="attendance" value="1" checked="checked"><span>人到</span></label> <label class="attendance"><input type="radio"
									name="attendance" value="2"><span>带家属到</span></label>
							</div>
						</li>
						<li><textarea rows="2" cols="" id="remark" name='remark' placeholder="还有什么要说的吗？比如：我要和单身姑娘们一桌，或者，我是单身姑娘。"></textarea></li>
						<li><input type="button" id="submitBtn" class="submitbtn" value="确认回执" /></li>
					</ul>
				</form>
			</div>
		</div>
	</div>
	<iframe name="submitFrame" id="submitFrame" src="" hidden="true"></iframe>
</body>
</html>