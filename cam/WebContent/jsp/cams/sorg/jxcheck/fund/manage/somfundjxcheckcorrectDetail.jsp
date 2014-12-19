<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>年检核对页面</title>
		<%
			String taskCode = (String)request.getParameter("taskCode");
			String organId = BspUtil.getCorpOrganId();
			String deptId = BspUtil.getDeptOrganId();
			String empId = BspUtil.getEmpOrganId();
			String date = DateUtil.getDay();
			String empName = BspUtil.getEmpOrgan().getOrganName();
		%>
		<next:ScriptManager/>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=request.getParameter("taskCode")%>';
			var id='<%=IdHelp.getUUID32() %>';
			function init(){
				somCheckDataSet.load();
			}
			//弹出打印证书窗口
			function check(){
				var win=L5.getCmp("forCheck");
				win.show();
				if(somCheckDataSet.getCount()==1){
					var checkYear = parseInt(somCheckDataSet.get("checkYear"))-1;
					var fillPeopleId = somCheckDataSet.get("fillPeopleId");
					var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
					command.setParameter("checkYear", ""+checkYear);
					command.setParameter("fillPeopleId", fillPeopleId);
					command.execute("queryLastYearCheckResult");
					var value = command.getReturn("lastYearCheckResult");
					var ary = value.split(";");
					document.getElementById("lastYearCheckResult").innerHTML=ary[0];
					if(ary.length==2){
						document.getElementById("lastYearCheckResultDesc").value=ary[1];
					}
				}
			}
			function correctPass(){
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("status", "3");
				command.execute("updateStatus");
				if (!command.error) {
					L5.Msg.alert("提示","校对通过成功！",function(){
						returnList();
					});		
				}else{
					L5.Msg.alert('提示',"校对通过时出现错误！"+command.error);
				}
			}
			
			function correctNotPass(){
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("correctNotReason",document.getElementById("correctNotReason").value);
				command.setParameter("status", "4");
				command.execute("updateStatus");
				if (!command.error) {
					L5.Msg.alert("提示","校对不通过成功！",function(){
						returnList();
					});		
				}else{
					L5.Msg.alert('提示',"校对不通过时出现错误！"+command.error);
				}
			}
			function checkClose(){
				var win=L5.getCmp("forCheck");
				win.hide();
			}
			function returnList(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/fund/manage/somfundjxcheckcorrect_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck">
			<model:field name="checkResult" type="string" rule="require" />
		</model:record>
		<model:params>
			<model:param name="TASK_CODE" value='<%= taskCode%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<iframe id="frame" marginwidth=0 marginheight=0 width=100% height=93% src="../detail/fundJXCheckDetail1.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<div id="floatBottom" style="height:7%">
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="校对" style="height:25px;width:80px;position:absolute;margin-left:30%;"  onclick="check();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:60%;" onclick="returnList();"/>
</div>
<next:Window id="forCheck" closeAction="hide" title="年检校对" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="校对处理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="校对通过" iconCls="edit" handler="correctPass"/>
		<next:ToolBarItem text="校对不通过" iconCls="edit" handler="correctNotPass"/>
		<next:ToolBarItem text="关闭窗口" iconCls="detail" handler="checkClose"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>去年年检结果：</label></td>
					<td class="FieldInput" colspan="5"><label id="lastYearCheckResult"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>去年年检结果描述：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"去年年检结果描述"' id="lastYearCheckResultDesc" style="width:98%" readonly="readonly"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>校对不通过原因描述：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"校对不通过原因描述"' id="correctNotReason" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
