<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
	<head>
		<title>年检审批页面</title>
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
		<script type="text/javascript" src="../../js/float.js"></script>
		<script language="javascript">
			var taskCode='<%=request.getParameter("taskCode")%>';
			//弹出打印证书窗口
			function check(){
				var win=L5.getCmp("forCheck");
				win.show();
			}
			function checkHis(){
				flowHisDs.reload();
				flowHisDs.on('load',function(){
					if(flowHisDs.getCount()==0){
						flowHisDs.newRecord();
					}
				});
				var win=L5.getCmp("forCheckHis");
				win.show();
			}
			function forCheckClose(){
				var flowDsValidate = flowDs.isValidate();
				if(flowDsValidate != true){
					L5.Msg.alert("提示",flowDsValidate);
					return false;
				}	
				var somCheckDataSetValidate = somCheckDataSet.isValidate();
				if(somCheckDataSetValidate != true){
					L5.Msg.alert("提示",somCheckDataSetValidate);
					return false;
				}	
				var flowDsRecord=flowDs.getCurrent();
				var somCheckRecord= somCheckDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheckflow.cmd.SomJxCheckFlowCommand");
				flowDsRecord.set("checkOrganId",'<%=organId%>');
				flowDsRecord.set("checkDeptId",'<%=deptId%>');
				flowDsRecord.set("checkPeopleId",'<%=empId%>');
				flowDsRecord.set("checkDate",'<%=date%>');
				flowDsRecord.set("checkPeopleName",'<%=empName%>');
				command.setParameter("record", flowDsRecord);
				command.setParameter("somCheckRecord", somCheckRecord);
				command.setParameter("taskCode", taskCode);
				command.setParameter("status", "6");
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
			function forCheckHisClose(){
				var win=L5.getCmp("forCheckHis");
				win.hide();
			}
			function checkClose(){
				var win=L5.getCmp("forCheck");
				win.hide();
			}
			function init(){
				flowDs.load();
				somCheckDataSet.load();
				flowDs.on('load',function(){
					if(flowDs.getCount()==0){
						flowDs.newRecord({'checkOpinionId':'1'});
					}
				});
				flowHisDs.load();
				flowHisDs.on('load',function(){
					if(flowHisDs.getCount()==0){
						flowHisDs.newRecord();
					}
				});
			}
			function backFlow(){
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("status", "3");
				command.execute("updateStatus");
				if (!command.error) {
					L5.Msg.alert("提示","退回承办人审核成功！",function(){
						var win=L5.getCmp("forCheck");
						win.hide();
					});		
				}else{
					L5.Msg.alert('提示',"退回承办人审核时出现错误！"+command.error);
				}
			}
			function returnList(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/manage/somgroupjxcheckcheck_list.jsp';
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
	<model:dataset id="flowDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckflow.cmd.SomJxCheckFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.SomJxCheckFlow">
			<model:field name="acceptOpinionId" type="string" rule="require" />
			<model:field name="checkOpinionId" type="string" rule="require" />
		</model:record>
		<model:params>
			<model:param name="TASK_CODE" value='<%= taskCode%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="flowHisDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckflow.cmd.SomJxCheckFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckflow.dao.SomJxCheckFlow"></model:record>
		<model:params>
			<model:param name="TASK_CODE" value='<%= taskCode%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<iframe id="frame" marginwidth=0 marginheight=0 width=100% height=93% src="../detail/groupJXCheckDetail1.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<div id="floatBottom" style="height:7%">
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="审核" style="height:25px;width:80px;position:absolute;margin-left:20%;"  onclick="check();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="查看审核意见" style="height:25px;width:80px;position:absolute;margin-left:40%;" onclick="checkHis();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:60%;" onclick="returnList();"/>
</div>
<next:Window id="forCheck" closeAction="hide" title="填写审核意见" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="审核意见"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="提交到局长审核" iconCls="detail" handler="forCheckClose"></next:ToolBarItem>
		<next:ToolBarItem text="退回到承办人审核" iconCls="detail" handler="backFlow"></next:ToolBarItem>
		<next:ToolBarItem text="关闭窗口" iconCls="detail" handler="checkClose"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somCheckDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>年检结果：</label></td>
					<td class="FieldInput" colspan="5">
					<select field="checkResult" title="年检结果" name='"年检结果"' style="width:150px" default="0">
						<option dataset="checkResultSelect"></option>
					</select><span style="color:red">*</span>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>年检结果描述：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"年检结果描述"' field="checkResultDesc" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<form method="post" onsubmit="return false" class="L5form" dataset="flowDs">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>处理意见：</label></td>
					<td class="FieldInput" colspan="5">
					<select field="checkOpinionId" title="处理意见" name='"处理意见"' style="width:150px" default="0">
						<option dataset="opinionSelect"></option>
					</select><span style="color:red">*</span>
					</td>
					
				</tr>
				<tr>
					<td class="FieldLabel"><label>处理补充意见：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='"处理补充意见"' field="checkOpinion" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="forCheckHis" closeAction="hide" title="查看审核意见" width="700"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="审核意见"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭窗口" iconCls="detail" handler="forCheckHisClose"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="flowHisDs">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:17%">承办人意见：</td>
					<td class="FieldInput" style="width:17%">
						<label field="acceptOpinionId" name='承办人意见' style="width:90%" dataset="opinionSelect"/>
					</td>
					<td class="FieldLabel" style="width:17%">承办人：</td>
					<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%"/>
					</td>
					<td class="FieldLabel" style="width:17%">承办时间：</td>
					<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptDate" style="width:90%" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">承办补充意见：</td>
					<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">审核意见：</td>
					<td class="FieldInput" style="width:17%">
						<label type="text"  field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="opinionSelect" />
					</td>
					<td class="FieldLabel" style="width:17%">审核人：</td>
					<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%"/>
					</td>
					<td class="FieldLabel" style="width:17%">审核时间：</td>
					<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkDate" style="width:90%" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">审核补充意见：</td>
					<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">审批意见：</td>
					<td class="FieldInput" style="width:17%">
						<label type="text"  field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="opinionSelect"  />
					</td>
					<td class="FieldLabel" style="width:17%">审批人：</td>
					<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='审批人' style="width:90%"/>
					</td>
					<td class="FieldLabel" style="width:17%">审批时间：</td>
					<td class="FieldInput" style="width:17%"><label type="text" name='审批时间' field="auditDate" style="width:90%" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">审批补充意见：</td>
					<td class="FieldInput" colspan="5"><textarea rows="3" name='审批补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
