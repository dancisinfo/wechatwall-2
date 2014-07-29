<?xml version="1.0" encoding="gbk" ?>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>΢��ǽ</title>
<script src="js/jquery.min.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : 'wallServlet.do?get=all',
			type : 'post',
			async : false
		}).done(function(data) {
			var msgs = analyzeData(data);
			$(msgs).prependTo(".messagelist");
		});

		function getNewMessages() {
			$.ajax({
				url : 'wallServlet.do?get=new',
				type : 'post'
			}).done(function(data) {
				var msgs = analyzeData(data);
				$(msgs).prependTo(".messagelist");
				setTimeout(getNewMessages, 5000);
			});
		}

		function analyzeData(data) {
			var items = [];
			data = JSON.parse(data);
			var messages = data.messages;
			var token = data.token;
			for (var i = 0; i < messages.length; i++) {
				var msg = messages[i];
				var sb = "<li class='messageitem'>";
				sb += "<div class='who'>";
				sb += "<img class='avatar' src='" + msg.headimg + "&token=" + token + "'/>";
				sb += "</div><div class='what'>";
				sb += "<span class='name'>" + msg.nick_name + ":</span>";
				if (msg.type == 1) {
					sb += "<span class='text'>" + msg.content + "</span>";
				} else {
					// TODO �����ͼƬ����������Ū���ʵ���С
					sb += "<img class='photo' src='" + msg.content + "&token=" + token + "'/>";
				}
				sb += "</div></li>";
				items.push(sb);
			}
			return items.join("");
		}

		getNewMessages();
	});
</script>
</head>
<body class="wallbody">
	<div class="wallcontainer">
		<div class="left">
			<img class="qrcode" src="images/qrcode.jpg" /> <span class="qrtip"><br />΢��ɨ��ά��<br />���ں�����<span
				class="account">xhjm1018</span><br />��ע��������Ϣ��ǽ </span>
		</div>
		<div class="main">
			<ul class="messagelist">
				<li class="messageitem">��ӭɧ��</li>
			</ul>
		</div>
	</div>
</body>
</html>
