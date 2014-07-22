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
<meta name="HandheldFriendly" content="True">
<meta name="apple-touch-fullscreen" content="YES" />
<title>婚礼喜帖</title>
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

		$('.ui-controlgroup-controls').css("margin", "5px 0");
		$('.ui-radio label').css("text-align", "center").css("font-size",
				"12px").width("58px");
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
					data-clear-btn="true" placeholder="尊姓大名" data-theme="b" />
				<fieldset data-role="controlgroup" data-theme="b"
					data-type="horizontal">
					<input type="radio" name="radio-choice-1" id="radio-choice-1a"
						value="1" checked="checked"> <label for="radio-choice-1a">自己来</label>
					<input type="radio" name="radio-choice-1" id="radio-choice-1b"
						value="2"> <label for="radio-choice-1b">带家属</label> <input
						type="radio" name="radio-choice-1" id="radio-choice-1c" value="0">
					<label for="radio-choice-1c">来不了</label>
				</fieldset>
				<textarea rows="2" name="remark" id="remark" class="remark"
					style="resize: none; overflow-y: auto"
					placeholder="还有啥想说的吗？比如:我要和单身姑娘们一桌，或者我要带不止一个家属。" data-theme="b"></textarea>
			</div>
		</div>
	</div>
</body>
</html>