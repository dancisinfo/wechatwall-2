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
	var lineLink = "http://59.46.100.104:8090/test/wi.jsp";
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

	};
</script>
</head>
<body>
	<div class="invitationmain">
		<div class="banner1">
			<div class="title1">Come and Enjoy</div>
			<div class="subtitle1">
				XX和XX婚礼，敬备喜宴<br />2014.10.18
			</div>
		</div>
	</div>
</body>
</html>