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
<title>婚礼喜帖</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.mobile-1.4.3.min.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="css/flexslider.css" type="text/css">
<link rel="stylesheet"
	media="only screen and (-webkit-min-device-pixel-ratio: 2)"
	type="text/css" href="css/highdpi.css" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery.mobile-1.4.3.min.js"></script>
<script src="js/jquery.flexslider-min.js"></script>
<script src="js/imagesloaded.pkgd.min.js"></script>
<script src="js/dialog-min.js"></script>
<script type="text/javascript">
	$(function() {
		$('.ui-radio label').css("text-align", "center").css("font-size",
				"12px").width("58px");
		$('.ui-btn').css("font-size", "12px");

		$('#form1').submit(function(event) {
			event.preventDefault();
			if ($.trim($('#gusetName').text()).length == 0) {
				var d = dialog({
					content : '签个名呗',
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
				if (data) {

				} else {

				}
			}).error(function() {
			});
		});

		$('#musicBox').trigger('play');

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
					<input type="text" name="guestName" id="guestName"
						data-clear-btn="true" placeholder="尊姓大名" data-theme="b" />
					<fieldset data-role="controlgroup" data-theme="b"
						data-type="horizontal">
						<input type="radio" name="radio-choice-1" id="radio-choice-1a"
							value="0"> <label for="radio-choice-1a">钱到</label> <input
							type="radio" name="radio-choice-1" id="radio-choice-1b" value="1"
							checked="checked"> <label for="radio-choice-1b">人到</label>
						<input type="radio" name="radio-choice-1" id="radio-choice-1c"
							value="2"> <label for="radio-choice-1c">带家属到</label>
					</fieldset>
					<textarea rows="2" name="remark" id="remark" class="remark"
						style="resize: none; overflow-y: auto; margin-bottom: 10px"
						placeholder="还有啥想说的吗？比如:我要和单身姑娘们一桌，或者:我要带不止一个家属，亦或:给我准备一个大号的红包，小的不够装。"
						data-theme="b"></textarea>
					<input data-theme="b" value="确认回执" type="submit" data-icon="check"
						id="submitBtn">
				</form>
			</div>
		</div>
	</div>
	<div class="player">
		<audio tabindex="0" id="musicBox" autoplay="autoplay" loop="loop"
			controls="controls" src="music/weddingmarch.mp3"></audio>
	</div>
</body>
</html>