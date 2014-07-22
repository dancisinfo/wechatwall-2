<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="content-type" content="text/html; charset=gb2312">
<meta name="HandheldFriendly" content="true">
<meta name="apple-touch-fullscreen" content="yes" />
<title>����ϲ��</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.mobile-1.4.3.min.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet"
	media="only screen and (-webkit-min-device-pixel-ratio: 2)"
	type="text/css" href="css/highdpi.css" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery.mobile-1.4.3.min.js"></script>
<script type="text/javascript">
	$(function() {
		highdpi_init();

		$('.ui-radio label').css("text-align", "center").css("font-size",
				"12px").width("50px");
		$('label[for=radio-choice-1c]').width("74px");
		$('.ui-btn').css("font-size", "12px");

		$('#submitBtn').click(function() {
			$.ajax({
				url : '/invitationServlet.do',
				type : 'post'
			}).done(function(data) {
				$('.baseinfo').html(JSON.stringify(data));
			}).error(function() {
			});
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
</head>
<body>
	<div class="main">
		<div class="container">
			<img alt="" src="images/page1.jpg" class="replace-2x container" />
		</div>
		<div class="container">
			<img alt="" src="images/page2.jpg" class="replace-2x container" />
		</div>
		<div class="container page3">
			<div class="signInContainer">
				<input type="text" name="guestName" id="guestName"
					data-clear-btn="true" placeholder="���մ���" data-theme="b" />
				<fieldset data-role="controlgroup" data-theme="b"
					data-type="horizontal">
					<input type="radio" name="radio-choice-1" id="radio-choice-1a"
						value="1" checked="checked"> <label for="radio-choice-1a">�Լ���</label>
					<input type="radio" name="radio-choice-1" id="radio-choice-1b"
						value="2"> <label for="radio-choice-1b">������</label> <input
						type="radio" name="radio-choice-1" id="radio-choice-1c" value="0">
					<label for="radio-choice-1c">�˲�����</label>
				</fieldset>
				<textarea rows="2" name="remark" id="remark" class="remark"
					style="resize: none; overflow-y: auto; margin-bottom: 10px"
					placeholder="����ɶ��˵���𣿱���:��Ҫ�͵��������һ����������Ҫ����ֹһ��������" data-theme="b"></textarea>
				<input data-theme="b" value="ȷ�ϻ�ִ" type="button" data-icon="check"
					id="submitBtn">
			</div>
		</div>
	</div>
</body>
</html>