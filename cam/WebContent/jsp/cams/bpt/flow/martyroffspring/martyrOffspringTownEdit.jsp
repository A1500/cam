<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>部分烈士（错杀被平反人员）子女受理县级审核</title>
</head>
<next:ScriptManager />
<script type="text/javascript">
		var applyId = '<%=request.getParameter("applyId")%>';
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var currentDate = getCurDate();
		var organType = '<%=BspUtil.getOrganType()%>';
		var peopleId ='<%=request.getParameter("peopleId")%>';
		var serviceType='<%=request.getParameter("serviceType")%>';
		function init(){
			var ds = L5.DatasetMgr.lookup("ds");
			ds.setParameter("APPLY_ID",applyId);
			ds.load();
			ds.on("load",function(){
				var acceptDate = ds.get("acceptDate");
				if(acceptDate == null || acceptDate == "") {
					ds.set("acceptDate",currentDate);
				}
				var checkDate = ds.get("checkDate");
				if(checkDate == null || checkDate == "") {
					ds.set("checkDate",currentDate);
				}
				var auditDate = ds.get("auditDate");
				if(auditDate == null || auditDate == "") {
					ds.set("auditDate",currentDate);
				}
				var auditIncharge = ds.get("auditIncharge");
				if(auditIncharge == null || auditIncharge == "") {
					ds.set("auditIncharge",currentUserName);
				}
			});
			if(organType=='14'){//街道
				L5.getCmp("submitButton").hide();
			}
			document.getElementById("agreeFlag").options.remove(3);
		}
		function validateDateFormat(date) {
			if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
				return false;
				}
			var r = date.match(/\d{1,4}/g);
			if (r == null) {
				return false;
			};
			var d = new Date(r[0], r[1] - 1, r[2]);
			return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d.getDate() == r[2]);
		}
		function getTimes(item) {
			LoushangDate(item.previousSibling);
		}
		//获得当前日期 
	function getCurDate(){
		var date=new Date();
		var year=""+date.getFullYear();
		var month=date.getMonth()+1;
		if(month<10){month="0"+month;}
		var day = date.getDate();
		if(day<10){day = "0"+day;}
		return year+"-"+month+"-"+day;
	}	
		</script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyMartyrOffspringQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring"></model:record>
	</model:dataset>
	<!--同意认定 -->
	<model:dataset id="isAgreeEnum" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel height="100%" width="100%" autoScroll="true" id="peopleTabPanel">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem iconCls="view" id="submitButton" text="审批" handler="createSend"/>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		<next:ToolBarItem iconCls="view" text="添加到黑名单" handler="addBlackList" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
			<table border="1" width="99%">
				<tr>
					<td class="FieldLabel" rowspan="2" style="width: 15%">村（居）委会审核</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><input type="text" name="acceptIncharge" field="acceptIncharge" /><font color="red">*</font></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><input type="text"
						name="acceptDate" id="acceptDate"
						field="acceptDate" format="Y-m-d"
						style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);"> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">审查意见</td>
					<td class="FieldInput" colspan="3"><textarea type="text" id="acceptAdvice"
						name="acceptAdvice" field="acceptAdvice"
						style="width: 80%" rows="3"></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">乡（镇、街道）审核</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><input type="text" id="checkIncharge"
						name="checkIncharge" field="checkIncharge" /><font
						color="red">*</font></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><input type="text"
						name="checkDate" id="checkDate"
						field="checkDate" format="Y-m-d"
						style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);"> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><textarea type="text" id="checkAdvice"
						name="checkAdvice" field="checkAdvice"
						style="width: 80%" rows="3"></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="3">县（市、区）审批</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><input type="text" id="auditIncharge"
						name="auditIncharge" field="auditIncharge" /> <font
						color="red">*</font></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><input type="text"
						name="auditDate" id="auditDate"
						field="auditDate" format="Y-m-d" style="width: 100px;"
						maxlength="10" onpropertychange="changeDateStyle(this)" /><img
						src="../../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);"> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">是否同意</td>
					<td class="FieldInput" colspan="3"><select name="agreeFlag"
						id="agreeFlag" field="agreeFlag">
						<option dataset="isAgreeEnum"></option>
					</select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><textarea type="text" id="auditAdvice"
						name="auditAdvice" field="auditAdvice" style="width: 80%"
						rows="3"></textarea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
</body>
<script type="text/javascript">
			function save(){
				var record = ds.getCurrent();
				
				var acceptIncharge = record.get("acceptIncharge");
				if(acceptIncharge == null || acceptIncharge == "") {
					L5.Msg.alert("提示","村（居）委会负责人不能为空！");
					return false;
				}
				var acceptDate = record.get("acceptDate");
				if(acceptDate == null || acceptDate == "") {
					L5.Msg.alert("提示","村（居）委会审核日期不能为空！");
					return false;
				}
				var checkIncharge = record.get("checkIncharge");
				if(checkIncharge == null || checkIncharge == "") {
					L5.Msg.alert("提示","乡（镇、街道）负责人不能为空！");
					return false;
				}
				var checkDate = record.get("checkDate");
				if(checkDate == null || checkDate == "") {
					L5.Msg.alert("提示","乡（镇、街道）审核日期不能为空！");
					return false;
				}
			    var auditIncharge = record.get("auditIncharge");
				if(auditIncharge == null || auditIncharge == "") {
					L5.Msg.alert("提示","县（市、区）负责人不能为空！");
					return false;
				}
				var auditDate = record.get("auditDate");
				if(auditDate == null || auditDate == "") {
					L5.Msg.alert("提示","县（市、区）审核日期不能为空！");
					return false;
				}
				var agreeFlag = record.get("agreeFlag");
				if(agreeFlag == null || agreeFlag == "") {
					L5.Msg.alert("提示","是否同意不能为空！");
					return false;
				}
				
				var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyMartyrOffspringCommand"); 
				command.setParameter("record",record);
				command.execute("update");	
				if (!command.error) {
					L5.Msg.alert('提示',"保存成功!");
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
					
				}
			}
						//发起单个流程
			function createSend(){
				L5.getCmp("submitButton").setDisabled(true);
				var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyMartyrOffspringCommand");
				command.setParameter("applyId", applyId);
				command.execute("getSaveFlag");
				var saveFlag =command.getReturn("saveFlag");
				if(saveFlag=="1"){
					command.execute("applySubmit");
					if (!command.error) {
						L5.Msg.alert('提示','认定成功！');
						L5.getCmp("submitButton").setDisabled(false);
						window.returnValue = "yes";
						window.close();
					}else{
						L5.getCmp("submitButton").setDisabled(false);
						L5.Msg.alert('提示',"认定时出现错误！"+command.error);
					}
				}else{
					L5.getCmp("submitButton").setDisabled(false);
					L5.Msg.alert('提示','必须县级审核之后才能提交！');
					return false;
				}
			}
			
			function func_Close(){
				window.close();
			}
</script>
</html>
