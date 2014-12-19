<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
<script type="text/javascript">
   var applyId = '<%=request.getParameter("applyId")%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>伤残人员县级审核信息</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryApplyInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability">
			<model:field name="townAduitIncharge" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel height="100%" autoScroll="true" width="100%" id="typeInfo">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
					<next:ToolBarItem iconCls="view" id="submitButton"  text="提交" handler="createSend"/>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>
				<next:Html>
					<fieldset>
					<form id="editForm"   dataset="DisabilityApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
					<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><input type="text" name="townAduitIncharge" field="townAduitIncharge"  title="负责人"/><font color="red">*</font> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><input type="text" name="townAduitApproveDate"  style="width: 100px;" format="Y-m-d" maxlength="10" field="townAduitApproveDate"    onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td colspan="3">
									<textarea  name="townAduitAdvice" field="townAduitAdvice" style="width:80%" rows="2"></textarea> </td>
								</td>
							</tr>
						</table></td>
					</tr>
				</table>
			</div>
			</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>

<script type="text/javascript">
	function init() {
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
		DisabilityApproveDataset.load();
		DisabilityApproveDataset.on("load",func);
		L5.QuickTips.init();
		if(organType=='14'){//街道
			L5.getCmp("submitButton").hide();
	}
	}
	
	function func(DisabilityApproveDataset) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=request.getParameter("applyId")%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var data = DisabilityApproveDataset.get("townAduitApproveDate");
		var name = DisabilityApproveDataset.get("townAduitIncharge");
		if(name == null || name == "") {
			DisabilityApproveDataset.set("townAduitIncharge",currentUserName);
		}
		if(ifback){
			DisabilityApproveDataset.set("townAduitApproveDate",getCurDate());
		}else if(data == null || data == "") {
			DisabilityApproveDataset.set("townAduitApproveDate",getCurDate());
		}
	}
			//发起单个流程
function createSend(){
	L5.getCmp("submitButton").setDisabled(true);
	window.returnValue="createSend";
	window.close();
}
	function func_Close() {
		window.close();
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
	function save(){
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
		
		var isValidate = DisabilityApproveDataset.isValidate();
		if(isValidate != true){
			L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
			return false;
		}
		var townAduitIncharge = document.getElementById("townAduitIncharge").value;
		if(townAduitIncharge == null || townAduitIncharge == "") {
			L5.Msg.alert("提示","审核人员不能为空！");
			return false;
		}
					
		var townAduitApproveDate = document.getElementById("townAduitApproveDate").value;
		if(townAduitApproveDate == null || townAduitApproveDate == "") {
			L5.Msg.alert("提示","时间不能为空！");
			return false;
		}
		if(townAduitApproveDate!=''&&!validateDateFormat(townAduitApproveDate)){
			L5.Msg.alert("提示","时间格式不正确！");
			return false;
		}
		var townAduitApproveDate = document.getElementById("townAduitAdvice").value;
		if(townAduitApproveDate==null||townAduitApproveDate=="") {
			alert("审批意见不能为空！");
			return false ;
		}
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
		//command.setParameter("disabilityCaseCode",DisabilityApproveRecord.get("townAduitDisabilityNature"));
		//command.setParameter("disabilityLevelCode",DisabilityApproveRecord.get("townAduitDisabilityLevel"));
		command.setParameter("record", DisabilityApproveRecord);
		command.execute("update");
		if (!command.error) {
			DisabilityApproveDataset.commitChanges();
			L5.Msg.alert('提示',"数据保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
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


	function changeDiv(value) {
		var pass = document.getElementById("pass");
		var end = document.getElementById("end");
		if(value == null || value == "") {
			pass.style.display="none";
			end.style.display="none";
		} else if(value == 0) {
			pass.style.display="";
			end.style.display="none";
		} else if(value == 1) {
			pass.style.display="none";
			end.style.display="";
		} 
	}
</script>
</html>
