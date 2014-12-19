<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
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
	<table style="position: relative;left: 20px;top: 10px;width: 90%;padding: 30px;" >
		<tr>
			<td >
				<fieldset id="cdcFieldset"><legend><b>
				通知通告回复信息</b></legend>
				<table width="90%" border="0">
					<tr>
						<th align="center" width="10%">地区</th>
						<th align="center" width="10%">回复人</th>
						<th align="center" width="10%">回复时间</th>
						<th align="center" width="10%">附件</th>
						<th align="center" width="10%">备注</th>
					</tr>
					<tr>
						<td align="center"><a href="#" onclick="showList_xian()"> 济南</a></td>
						<td align="center">济南安置办管理员</td>
						<td align="center">2012年8月21日</td>
						<td align="center"><a href="#">附件</a></td>
						<td align="center"></td>
					</tr>
					<tr>
						<td align="center"><a href="#" onclick="showList_xian1()">青岛</a></td>
						<td align="center">青岛安置办管理员</td>
						<td align="center">2012年8月21日</td>
						<td align="center"><a href="#">附件</a></td>
						<td align="center"></td>
					</tr>
					<tr>
						<td align="center"><a href="#">淄博</a></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">枣庄</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">东营</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">烟台</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
					<tr>
						<td align="center">潍坊</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">济宁</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">泰安</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">威海</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">日照</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">莱芜</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">临沂</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">德州</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">聊城</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">滨州</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
					</tr>
						<tr>
						<td align="center">菏泽</td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
						<td align="center"></td>
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
		function showList_xian(){
			var url = "jsp/cams/prs/notification/list_xian.jsp";
			L5.forward(url, null, null);
		}
		function showList_xian1(){
			var url = "jsp/cams/prs/notification/list_xian1.jsp";
			L5.forward(url, null, null);
		}
	</script>
</html>
