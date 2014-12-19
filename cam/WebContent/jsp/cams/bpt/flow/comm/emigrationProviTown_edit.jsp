<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>外省优抚人员抚恤关系迁入我省县级审核编辑</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<model:dataset id="BptApplyEmigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="queryById" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyEmigration"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel  width="100%" height="100%" id="approveTabPanel" autoScroll="true">
	 <next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="view" id="submitButton" text="提交" handler="createSend"/>
			<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" title="县级审核"   dataset="BptApplyEmigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		  <div id="TownVerify">
		  	<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">县级审核</td>
						<td class="FieldLabel" style="width:8%">审核人员</td>
						<td class="FieldInput"><input type="text" id="townAduitIncharge" name="townAduitIncharge" field="townAduitIncharge" /><font color="red">*</font></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput"><input type="text" id="townAduitApproveDate" name="townAduitApproveDate" field="townAduitApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审核意见</td>
						<td class="FieldInput" colspan="3"><textarea type="text" name="townAduitAdvice" field="townAduitAdvice" style="width:90%"></textarea></td>
					</tr>
			 </table>
		  </div>
		</table>
		</form>
   </next:Html>
</next:Panel>
<script type="text/javascript">
   var curDate=getCurDate();
	function init() {
		var organType = '<%=BspUtil.getOrganType()%>';
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		BptApplyEmigratDataSet.setParameter("APPLY_ID",'<%=request.getParameter("applyId")%>')

		BptApplyEmigratDataSet.load();
		BptApplyEmigratDataSet.on("load",func);
		L5.QuickTips.init();
		if(organType=='14'){//街道
			L5.getCmp("submitButton").hide();
		}
	}
	
	function func(BptApplyEmigratDataSet) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=request.getParameter("applyId")%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var data = BptApplyEmigratDataSet.get("townAduitApproveDate");
		var name = BptApplyEmigratDataSet.get("townAduitIncharge");
		if(name == null || name == "") {
			BptApplyEmigratDataSet.set("townAduitIncharge",currentUserName);
		}
		if(ifback){
			BptApplyEmigratDataSet.set("townAduitApproveDate",curDate);
		}else if(data == null || data == "") {
			BptApplyEmigratDataSet.set("townAduitApproveDate",curDate);
		}
	}
				//发起单个流程
	function createSend(){
		L5.getCmp("submitButton").setDisabled(true);
		window.returnValue="createSend";
		window.close();
	}
	function save() {
		var townAduitIncharge = document.getElementById("townAduitIncharge").value;
		if(townAduitIncharge == null || townAduitIncharge == "") {
			L5.Msg.alert("提示","审核人员不能为空！");
			return false;
		}
		var townAduitApproveDate = document.getElementById("townAduitApproveDate").value;
		if(townAduitApproveDate == null || townAduitApproveDate == "") {
			L5.Msg.alert("提示","审核时间不能为空！");
			return false;
		}
		if(townAduitApproveDate!=''&&!validateDateFormat(townAduitApproveDate)){
			L5.Msg.alert("提示","审核时间格式不正确！");
			return false;
		}
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		var BptApplyEmigratRecord = BptApplyEmigratDataSet.getCurrent();
		var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand"); 
		command.setParameter("record",BptApplyEmigratRecord);
		command.execute("updateApprove");	
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

function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}
//手动输入时间格式 
function changeDateStyle(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4) {
		obj.value = temp + '-';
	} else if (temp!=""&&temp.length==7) {
		obj.value = temp + '-';
	} 
}
</script>
</body>
</html>
