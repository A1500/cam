<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>年检审批页面</title>
		<%
			String taskCode = (String)request.getParameter("taskCode");
			String flag = (String)request.getParameter("flag");
			String organId = BspUtil.getCorpOrganId();
			String deptId = BspUtil.getDeptOrganId();
			String empId = BspUtil.getEmpOrganId();
			String date = DateUtil.getTime();
			String empName = BspUtil.getEmpOrgan().getOrganName();
		%>
		<next:ScriptManager/>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=request.getParameter("taskCode")%>';
			var flag='<%=request.getParameter("flag")%>';
			var id='<%=IdHelp.getUUID32() %>';
			function init(){
				somCheckDataSet.load();
				flowDs.load();
				flowDs.on('load',function(){
					if(flowDs.getCount()==0){
						flowDs.newRecord({'id':id,'acceptOpinionId':'1'});
					}
				});
			}
			//弹出打印证书窗口
			function check(){
				var win=L5.getCmp("forCheck");
				win.show();
				if(somCheckDataSet.getCount()==1){
					var batchYear = parseInt(somCheckDataSet.get("batchYear"))-1;
					var fillPeopleId = somCheckDataSet.get("fillPeopleId");
					var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
					command.setParameter("batchYear", ""+batchYear);
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
			function forCheckClose(){
				var flowDsValidate = flowDs.isValidate();
				//if(flowDsValidate != true){
				//	L5.Msg.alert("提示",flowDsValidate);
				//	return false;
				//}	
				var somCheckDataSetValidate = somCheckDataSet.isValidate();
				if(somCheckDataSetValidate != true){
					L5.Msg.alert("提示",somCheckDataSetValidate);
					return false;
				}	
				var flowDsRecord=flowDs.getCurrent();
				var somCheckRecord= somCheckDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheckflow.cmd.SomCheckFlowCommand");
				flowDsRecord.set("acceptOrganId",'<%=organId%>');
				flowDsRecord.set("acceptDeptId",'<%=deptId%>');
				flowDsRecord.set("acceptPeopleId",'<%=empId%>');
				flowDsRecord.set("acceptDate",'<%=date%>');
				flowDsRecord.set("acceptPeopleName",'<%=empName%>');
				flowDsRecord.set("acceptOpinionId","1");
				command.setParameter("record", flowDsRecord);
				command.setParameter("somCheckRecord", somCheckRecord);
				command.setParameter("taskCode", taskCode);
				command.setParameter("status", "5");
				command.execute("save");
				if (!command.error) {
					L5.Msg.alert("提示","提交成功！",function(){
						var win=L5.getCmp("forCheck");
						win.hide();
					});		
				}else{
					L5.Msg.alert('提示',"提交时出现错误！"+command.error);
				}
			}
			function checkClose(){
				var win=L5.getCmp("forCheck");
				win.hide();
			}
			
			function returnList(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/group/manage/somgroupcheckaccept_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="checkResult" type="string" rule="require" />
		</model:record>
		<model:params>
			<model:param name="TASK_CODE" value='<%= taskCode%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="flowDs" cmd="com.inspur.cams.sorg.check.somcheckflow.cmd.SomCheckFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheckflow.data.SomCheckFlow">
			<model:field name="acceptOpinionId" type="string" rule="require" />
		</model:record>
		<model:params>
			<model:param name="TASK_CODE" value='<%= taskCode%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<iframe id="frame" marginwidth=0 marginheight=0 width=100% height=93% src="../detail/groupCheckDetail1.jsp?taskCode=<%= taskCode%>&flag=<%= flag%>" frameborder=0></iframe>
<div id="floatBottom" style="height:7%">
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="审核" style="height:25px;width:80px;position:absolute;margin-left:30%;"  onclick="check();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:60%;" onclick="returnList();"/>
</div>
<next:Window id="forCheck" closeAction="hide" title="填写审核意见" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="审核意见"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="提交" iconCls="detail" handler="forCheckClose"></next:ToolBarItem>
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
		<form method="post" onsubmit="return false" class="L5form" dataset="somCheckDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>预审意见：</label></td>
					<td class="FieldInput" colspan="5">
					<select id="checkResult" field="checkResult" title="年检结果" name='"预审意见"' style="width:150px" default="0">
						<option dataset="checkResultSelect"></option>
					</select><span style="color:red">*</span>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>预审结果描述：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"预审结果描述"' field="checkResultDesc" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
