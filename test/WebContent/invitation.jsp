<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="content-type" content="text/html; charset=gb2312">
<meta name="HandheldFriendly" content="true">
<meta name="apple-touch-fullscreen" content="yes" />
<title>����ϲ��</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.mobile-1.4.3.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/flexslider.css" type="text/css">
<link rel="stylesheet" media="only screen and (-webkit-min-device-pixel-ratio: 2)" type="text/css"
	href="css/highdpi.css" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery.mobile-1.4.3.min.js"></script>
<script src="js/jquery.flexslider-min.js"></script>
<script src="js/imagesloaded.pkgd.min.js"></script>
<script src="js/dialog-min.js"></script>
<script type="text/javascript">
	var submiting = false;
	$(function() {
		$('.ui-radio label').css("text-align", "center").css("font-size", "12px").width("58px");
		$('.ui-btn').css("font-size", "12px");

		$('#form1').submit(function(event) {
			submiting = true;
			$('#submitBtn').attr("disabled", "true");
			event.preventDefault();
			if ($.trim($('#guestName').val()).length == 0) {
				var d = dialog({
					content : 'ǩ������',
					quickClose : true
				});
				d.show(document.getElementById('guestName'));
				setTimeout(function() {
					d.close().remove();
				}, 2500);
				return;
			}

			$.ajax({
				url : 'invitationServlet.do',
				type : 'post',
				data : $(this).serialize()
			}).done(function(data) {
				submiting = false;
				$('#submitBtn').attr("disabled", "false");
				if (data) {
					$('.signInContainer').html("<div class='thanks'>��л������</div>");
				} else {

				}
			}).error(function() {
				submiting = false;
				$('#submitBtn').attr("disabled", "false");
			});
		});

		// $('#musicBox').trigger('play');

		imagesLoaded('img', function(instance) {
			$('.flexslider').flexslider({
				slideshowSpeed : 2000
			});
			highdpi_init();
		});
	});

	function highdpi_init() {
		if ($('.replace-2x').css('font-size') == "1px") {
			var els = $("img.replace-2x").get();
			for (var i = 0; i < els.length; i++) {
				var src = els[i].src;
				src = src.replace(".jpg", "@2x.jpg");
				els[i].src = src;
			}
		}
	}
</script>
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
</head>
<body>
	<div class="invitationmain">
		<div class="container">
			<img alt="" src="images/page1.jpg" class="replace-2x container" />
		</div>
		<div class="container">
			<img alt="" src="images/page2.jpg" class="replace-2x container" />
		</div>
		<div class="container page3">
			<div class="slidercontainer">
				<div class="flexslider">
					<ul class="slides">
						<li><img src="images/2007.jpg" class="replace-2x" /></li>
						<li><img src="images/2008.jpg" class="replace-2x" /></li>
						<li><img src="images/2009.jpg" class="replace-2x" /></li>
						<li><img src="images/2010.jpg" class="replace-2x" /></li>
						<li><img src="images/2011.jpg" class="replace-2x" /></li>
						<li><img src="images/2012.jpg" class="replace-2x" /></li>
						<li><img src="images/2013.jpg" class="replace-2x" /></li>
						<li><img src="images/2014.jpg" class="replace-2x" /></li>
					</ul>
				</div>
			</div>
			<div class="signInContainer">
				<form action="" id="form1" name="form1" method="post">
					<input type="text" name="guestName" id="guestName" data-clear-btn="true" placeholder="���մ���" data-theme="b" />
					<fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
						<input type="radio" name="radio-choice-1" id="radio-choice-1a" value="0"> <label for="radio-choice-1a">Ǯ��</label>
						<input type="radio" name="radio-choice-1" id="radio-choice-1b" value="1" checked="checked"> <label
							for="radio-choice-1b">�˵�</label> <input type="radio" name="radio-choice-1" id="radio-choice-1c" value="2">
						<label for="radio-choice-1c">��������</label>
					</fieldset>
					<textarea rows="2" name="remark" id="remark" class="remark"
						style="resize: none; overflow-y: auto; margin-bottom: 10px" placeholder="����ɶ��˵���𣿱���:��Ҫ�͵��������һ��������:���ǵ�����"
						data-theme="b"></textarea>
					<input data-theme="b" value="ȷ�ϻ�ִ" type="submit" data-icon="check" id="submitBtn">
				</form>
			</div>
		</div>
	</div>
</body>
</html>