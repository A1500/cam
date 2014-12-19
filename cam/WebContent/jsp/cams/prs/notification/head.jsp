<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title></title>
<next:ScriptManager/>
<style type="text/css">
		a {text-decoration:none;color: #03c;}
		a:visited {text-decoration:none; color: #03c;}
	</style>
<html>
	<head>
	</head>
	<body >
	<next:Panel width="100%" border="0" height="100%">
	<next:Html>
	<table style="position: relative;left: 20px;top: 10px;width: 80%;padding: 30px;" >
		<tr>
			<td >
				<fieldset id="cdcFieldset"  border="0" ><legend><b>
				通知通告</b></legend>
				<table width="100%" border="0">
					<tr>
						<th width="10%">标题</th>
						<th width="10%">发布单位</th>
						<th width="10%">下发到</th>
						<th width="10%">内容</th>
						<th width="10%">发布时间</th>
						<th width="10%">回复情况</th>
					</tr>
					<tr>
						<td align="center">临时通知3</td>
						<td align="center">省民政厅</td>
						<td align="center">区县</td>
						<td align="center">测试系统通知...</td>
						<td align="center">2012年8月21日</td>
						<td align="center"><a href="#" onclick="showList_shi1()">查看回复情况</a></td>
					</tr>
					<tr>
						<td align="center">临时通知2</td>
						<td align="center">济南市民政局安置办</td>
						<td align="center">区县</td>
						<td align="center">测试系统通知...</td>
						<td align="center">2012年8月20日</td>
						<td align="center"><a href="#" onclick="showList_xian()">查看回复情况</a></td>
					</tr>
					<tr>
						<td align="center">临时通知1</td>
						<td align="center">省民政厅</td>
						<td align="center">地市</td>
						<td align="center">测试系统通知...</td>
						<td align="center">2012年8月19日</td>
						<td align="center"><a href="#" onclick="showList_shi()">查看回复情况</a></td>
					</tr>
				</table>
				</fieldset>
				</td>
		</tr>
	</table>
	</next:Html>
	</next:Panel>
	</body>
	<script type="text/javascript" >
		function showList_shi(){
			var width = screen.width-60;
			var height = 580;
			var url = "list_shi.jsp";
			var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
			if (win==null) {
				return;
			}
		}
		function showList_shi1(){
			var width = screen.width-60;
			var height = 580;
			var url = "list_shi1.jsp";
			var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
			if (win==null) {
				return;
			}
		}
		//background="../../../public/images/main_bg.gif"
		function showList_xian(){
			var width = screen.width-60;
			var height = 580;
			var url = "list_xian.jsp";
			var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
			if (win==null) {
				return;
			}
		}
	</script>
</html>
