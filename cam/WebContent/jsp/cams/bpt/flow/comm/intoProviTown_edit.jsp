<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>外省优抚人员抚恤关系迁入我省县级审核编辑</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 外省优抚人员抚恤关系迁入DataSet -->
	<model:dataset id="BptIntoproviDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand"  method="queryApplyInfo"   global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyIntoprovince"></model:record>
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
		<form id="editForm"   dataset="BptIntoproviDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
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
	function init() {
		var organType = '<%=BspUtil.getOrganType()%>';
		var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
		BptIntoproviDataset.setParameter("APPLY_ID",'<%=request.getParameter("applyId")%>')
		BptIntoproviDataset.load();
		BptIntoproviDataset.on("load",func);
		L5.QuickTips.init();
		if(organType=='14'){//街道
			L5.getCmp("submitButton").hide();
		}
	}
	
	function func(BptIntoproviDataset) {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=request.getParameter("applyId")%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var data = BptIntoproviDataset.get("townAduitApproveDate");
		var name = BptIntoproviDataset.get("townAduitIncharge");
		if(name == null || name == "") {
			BptIntoproviDataset.set("townAduitIncharge",currentUserName);
		}
		if(ifback){
			BptIntoproviDataset.set("townAduitApproveDate",getCurDate());
		}else if(data == null || data == "") {
			BptIntoproviDataset.set("townAduitApproveDate",getCurDate());
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
		
	
		var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
		var BptIntoproviRecord=BptIntoproviDataset.getCurrent();
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
		command.setParameter("record", BptIntoproviRecord);
		command.execute("update");
		if (!command.error) {
			BptIntoproviDataset.commitChanges();
			L5.Msg.alert('提示',"数据保存成功!");
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
</script>
</body>
</html>
