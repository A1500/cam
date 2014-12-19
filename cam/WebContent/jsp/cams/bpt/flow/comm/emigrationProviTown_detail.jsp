<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
	<head>
		<title>外省优抚人员抚恤关系迁入我省县级审核编辑</title>
		<next:ScriptManager/>
		<script type="text/javascript"src = "../../comm/bptComm.jsp"></script>
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
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>
	<next:Html>
		<form id="editForm" title="县级审核"  dataset="BptApplyEmigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		  <div id="TownVerify">
		  	<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">县级审核</td>
						<td class="FieldLabel" style="width:8%">审核人员</td>
						<td class="FieldInput"><label type="text" id="townAduitIncharge" name="townAduitIncharge" field="townAduitIncharge" /><font color="red">*</font></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput"><label type="text" id="townAduitApproveDate" name="townAduitApproveDate" field="townAduitApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审核意见</td>
						<td class="FieldInput" colspan="3"><label type="text" name="townAduitAdvice" field="townAduitAdvice" style="width:90%"/></td>
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
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		BptApplyEmigratDataSet.setParameter("APPLY_ID",'<%=request.getParameter("applyId")%>')

		BptApplyEmigratDataSet.load();
	//	BptApplyEmigratDataSet.on("load",func);
		L5.QuickTips.init();
	}
	
	function func(BptApplyEmigratDataSet) {
		
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var data = BptApplyEmigratDataSet.get("townAduitApproveDate");
		var name = BptApplyEmigratDataSet.get("townAduitIncharge");
		if(name == null || name == "") {
			BptApplyEmigratDataSet.set("townAduitIncharge",currentUserName);
		}
		if(data == null || data == "") {
			BptApplyEmigratDataSet.set("townAduitApproveDate",curDate);
		}
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

</script>
</body>
</html>
