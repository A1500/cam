<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
<script type="text/javascript">
   var applyId = '<%=request.getParameter("applyId")%>';
   var commitFlag = '<%=request.getParameter("commitFlag")%>';
   var serviceType = '<%=request.getParameter("serviceType")%>';
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
					<next:ToolBarItem id="createSend" iconCls="view"  text="提交" handler="createSend"/>
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
						<td class="FieldInput" style="width:30%"><input type="text" name="townAduitApproveDate"  style="width: 100px;" format="Y-m-d" maxlength="10" field="townAduitApproveDate"   onpropertychange="changeDateStyle(this)"   /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
					</tr>
			   	   <tr id="publicity">
			   			<td  class="FieldLabel" >公示结果</td>
						<td class="FieldInput" colspan="3"><textarea name="townAduitBulletinResult" field="townAduitBulletinResult" id="townAduitBulletinResult" style="width:80%" rows="2"></textarea>
						<font color="red">*</font>
						 </td>
			   		</tr>
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审核意见：
								</td>
								<!--<td class="FieldInput">
									
					
									 <select style="width:90px;" name="townFlag" id="townFlag" field="townFlag" onchange="changeDiv(this.value)">
										<option dataset="ApplyContent"></option>
									</select> 
									
								</td>-->
								
								<td class="FieldInput">
									<input type="hidden" style="width:90px;" name="townFlag" id="townFlag" field="townFlag" value='0'></label>
									<div id="pass" >伤残性质：
										<select name="townAduitDisabilityNature" field="townAduitDisabilityNature">
											<option dataset="DisabilityCaseDataset"></option>
										</select> 
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<select  name="townAduitDisabilityLevel" field="townAduitDisabilityLevel">
											<option dataset="DisabilityLevelDataset"></option>
										</select> 
									</div>
									<!-- <div id="end" style="display:none">
										是否上报：
										<select name="townReport" id="townReport" field="townReport" >
											<option dataset="ReportFlagEnum"></option>
										</select>
									</div> -->
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea  name="townAduitAdvice" field="townAduitAdvice" style="width:80%" rows="2"></textarea> </td>
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
		if(commitFlag=="0"){
			document.getElementById("createSend").style.visibility = "hidden";
		}
		if(serviceType=='14'){
			document.getElementById("publicity").style.display="none";
		}
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
		DisabilityApproveDataset.load();
		DisabilityApproveDataset.on("load",func);
		if(organType=='14'){//街道
				L5.getCmp("createSend").hide();
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
	
	function func_Close() {
		window.close();
	}
	
	function save(){
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
		
		var isValidate = DisabilityApproveDataset.isValidate();
		if(isValidate != true){
			L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
			return false;
		}
		var townAduitApproveDate = DisabilityApproveRecord.get("townAduitApproveDate");
		if(townAduitApproveDate!=''&&!validateDateFormat(townAduitApproveDate)){
			L5.Msg.alert('提示',"校验未通过,不能保存!时间格式不正确");
			return false;
		}
		if(serviceType!='14'){
			var townAduitBulletinResult = DisabilityApproveRecord.get("townAduitBulletinResult");
			if(townAduitBulletinResult == null || townAduitBulletinResult == "") {
				L5.Msg.alert('提示',"公示结果不能为空");
				return false;
			}
		}
		DisabilityApproveRecord.set("townFlag",0);
		var townFlag = DisabilityApproveRecord.get("townFlag");
		if(townFlag == null || townFlag == "") {
			L5.Msg.alert('提示',"审批意见不能为空");
			return false;
		}
		if(townFlag == 0) {
			var townAduitDisabilityNature = DisabilityApproveRecord.get("townAduitDisabilityNature");
			if(townAduitDisabilityNature=='' || townAduitDisabilityNature == null){
				L5.Msg.alert('提示',"伤残性质不能为空");
				return false;
			}
			
			var townAduitDisabilityLevel = DisabilityApproveRecord.get("townAduitDisabilityLevel");
			if(townAduitDisabilityLevel=='' || townAduitDisabilityLevel == null){
				L5.Msg.alert('提示',"申报等级不能为空");
				return false;
			}
		} else {
			var townReport = DisabilityApproveRecord.get("townReport");
			if(townReport == "" || townReport == null) {
				L5.Msg.alert('提示',"是否上报不能为空");
				return false;
			}
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
			DisabilityApproveDataset.set("townReport","")
		} else if(value == 0) {
			pass.style.display="";
			end.style.display="none";
			DisabilityApproveDataset.set("townReport","")
		} else if(value == 1) {
			pass.style.display="none";
			end.style.display="";
			var townReport = DisabilityApproveDataset.get("townReport");
			if(townReport == null || townReport == "" ) {
				DisabilityApproveDataset.set("townReport","0");
			}
		} else if(value == 2) {
			pass.style.display="none";
			end.style.display="none";
			DisabilityApproveDataset.set("townReport","")
		}
	}
		//发起单个流程
function createSend(){
	L5.getCmp("createSend").setDisabled(true);
	window.returnValue="createSend";
	window.close();
	
}
</script>
</html>
