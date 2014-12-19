<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>伤残人员省内迁移</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
		<script type="text/javascript">
			var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
			var applyId='<%= request.getParameter("applyId")%>';
			var organType = '<%=BspUtil.getOrganType()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ProvinceMigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="outTownAduitIncharge" type="string" rule="require"/>
			<model:field name="ingoingName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>


<next:Panel   id="approveTabPanel" width="100%" height="100%" autoScroll="true">
	<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
					<next:ToolBarItem iconCls="view" id="submitButton"  text="提交" handler="createSend"/>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>
	<next:Html>
		<form id="editForm" title="县级审核" dataset="ProvinceMigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
   			<table width="99%">
   				<tr>
   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地县级审核</td>
					<td class="FieldLabel" style="width:8%">负责人</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="outTownAduitIncharge" field="outTownAduitIncharge"  /><font color="red">*</font></td>
					<td class="FieldLabel" style="width:16%">审核时间</td>
					<td class="FieldInput" colspan="3" style="width:48%"><input id="outTownAduitApproveDate" type="text" name="outTownAduitApproveDate"   format="Y-m-d" style="width: 100px;" maxlength="10" field="outTownAduitApproveDate"   onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				</tr>
		   		<tr>
					<td class="FieldLabel">意见</td>
					<td class="FieldInput" colspan="5"><textarea type="text" id="outTownAduitAdvice" name="outTownAduitAdvice" field="outTownAduitAdvice" style="width:90%;"></textarea></td>
				</tr>
   			</table>
		</form>
   </next:Html>
</next:Panel>

	
</body>
<script type="text/javascript">
	var updateUrl;
	var url;
	var first = true;
	function init() {
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		
		ProvinceMigratDataSet.setParameter("APPLY_ID",applyId);
		ProvinceMigratDataSet.load();
		ProvinceMigratDataSet.on("load",func);
		L5.QuickTips.init();
		if(organType=='14'){//街道
			L5.getCmp("submitButton").hide();
		}
		
	}
	function func(ProvinceMigratDataSet) {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",applyId);
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var data = ProvinceMigratDataSet.get("outTownAduitApproveDate");
		var name = ProvinceMigratDataSet.get("outTownAduitIncharge");
		if(name == null || name == "") {
			ProvinceMigratDataSet.set("outTownAduitIncharge",currentUserName);
		}
		if(ifback){
			ProvinceMigratDataSet.set("outTownAduitApproveDate",getCurDate());
		}else if(data == null || data == "") {
			ProvinceMigratDataSet.set("outTownAduitApproveDate",getCurDate());
		}
	}
				//发起单个流程
	function createSend(){
		L5.getCmp("submitButton").setDisabled(true);
		window.returnValue="createSend";
		window.close();
	}
	function save(){
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		var ProvinceMigratRecord = ProvinceMigratDataSet.getCurrent();
		//校验
		var date= document.getElementById("outTownAduitApproveDate").value;
		var advice= document.getElementById("outTownAduitAdvice").value;
		var valid = ProvinceMigratDataSet.isValidate();
		if(date==""){
			L5.Msg.alert('提示',"审批时间不能为空!");
			return false;
		}
		//if(advice==""){
		//	L5.Msg.alert('提示',"意见不能为空!");
		//	return false;
		//}
		if(date!=''&&!validateDateFormat(date)){
		L5.Msg.alert("提示","审批时间格式不正确！");
		return false;
	}
		if(valid != true){
			L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
			return false;
		}	
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
		command.setParameter("record",ProvinceMigratRecord);
		command.execute("update");	
		if (!command.error) {
			ifsave = true;
			L5.Msg.alert('提示',"保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
function func_Close() {
		window.close();
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

</html>
