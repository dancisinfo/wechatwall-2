<?xml version="1.0" encoding="gbk" ?>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>微信墙</title>
<script src="js/jquery.min.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var items = [];
	$(function() {
		function getNewMessages() {
			$
					.ajax({
						url : 'wallServlet.do?get=new',
						type : 'post'
					})
					.done(
							function(data) {
								data = JSON.parse(data);
								for (var i = 0; i < data.length; i++) {
									msg = data[i];
									if (msg.type == 1) {
										items
												.push("<li class='messageitem'><img src='"+msg.headimg+"'/>"
														+ msg.nick_name
														+ "说:"
														+ msg.content + "</li>");
									}
								}
								$('.messagelist').html(items.join(""));
								setTimeout(getNewMessages, 5000);
							}).error(function() {
					});
		}

		getNewMessages();
	});
</script>
</head>
<body>
	<div class="container">
		<div class="left"></div>
		<div class="main">
			<ul class="messagelist">
			</ul>
		</div>
	</div>
</body>
</html>