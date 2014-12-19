<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String peopleId=request.getParameter("peopleId");
	String familyId=request.getParameter("familyId");	
	String applyId=request.getParameter("applyId");
	%>
<html>
	<head>
		<title>在乡复员军人审批表</title>
	</head>
	<next:ScriptManager/>
	<script type="text/javascript" src="../../../comm/bptComm.js"></script>
	<script type="text/javascript">
		var organType = '<%=BspUtil.getOrganType()%>';
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var currentDate = getCurDate();
		function init() {
						var ds = L5.DatasetMgr.lookup("ds");
							ds.setParameter("apply_Id",'<%=request.getParameter("applyId")%>');
							ds.load();
					ds.on("load",setDefultValue);
				if(organType=='14'){//街道
					L5.getCmp("submitButton").hide();
				}
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
		function save(){
				var townFlag = document.getElementById("townFlag").value;
				if(townFlag == null || townFlag == "") {
					L5.Msg.alert("提示","审批意见不能为空！");
					return false;
				}
				if(townFlag=='1'){
					var townReport = document.getElementById("townReport").value;
					if(townReport == null || townReport == "") {
						L5.Msg.alert("提示","是否上报不能为空！");
						return false;
					}
				}
				
				var trialName = document.getElementById("trialName").value;
					if(trialName == null || trialName == "") {
						L5.Msg.alert("提示","审核人员不能为空！");
						return false;
					}
				var applyDate = document.getElementById("applyDate").value;
					if(applyDate!=''&&!validateDateFormat(applyDate)){
						L5.Msg.alert("提示","申请日期格式不正确！");
						return false;
					}	
				var trialDate = document.getElementById("trialDate").value;
					if(trialDate == null || trialDate == "") {
						L5.Msg.alert("提示","初审日期不能为空！");
						return false;
					}
					if(trialDate!=''&&!validateDateFormat(trialDate)){
						L5.Msg.alert("提示","初审日期格式不正确！");
						return false;
					}
				var reviewView = document.getElementById("reviewView").value;
					if(reviewView == null || reviewView == "") {
						L5.Msg.alert("提示","审核人员不能为空！");
						return false;
					}
					
				var reviewDate = document.getElementById("reviewDate").value;
					if(reviewDate == null || reviewDate == "") {
						L5.Msg.alert("提示","复审日期不能为空！");
						return false;
					}
					if(reviewDate!=''&&!validateDateFormat(reviewDate)){
						L5.Msg.alert("提示","复审日期格式不正确！");
						return false;
					}
					var ds = L5.DatasetMgr.lookup("ds");
					var records = ds.getAllChangedRecords();
					if(records.length<1){
						L5.Msg.alert('提示','没有需要保存的数据!');
						return false;
					}
					//校验
					var valid = ds.isValidate();
					if(valid != true){
						L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
						return false;
					}	
				    var records = ds.getCurrent();
					var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand"); 
					command.setParameter("records",records);
					command.execute("save");	
					if (!command.error) {
						L5.Msg.alert('提示',"保存成功!");
					
					}else{
						L5.Msg.alert('提示',"保存时出现错误！"+command.error);
					}
			}
			function func_Close(){
				window.close();
			}
	function	setDefultValue(ds){
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
			var trialDate = ds.get("trialDate");
			var trialName = ds.get("trialName");
			var reviewDate = ds.get("reviewDate");
			var reviewView = ds.get("reviewView");
			/*if(trialName == null || trialName == "") {
				ds.set("trialName",currentUserName);
			}*/
			if(trialDate == null || trialDate == "") {
				ds.set("trialDate",getCurDate());
			}
			if(reviewView == null || reviewView == "") {
				ds.set("reviewView",currentUserName);
			}
			if(reviewDate == null || reviewDate == "") {
				ds.set("reviewDate",getCurDate());
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
		var isReport1 = document.getElementById("isReport1");
		var isReport2 = document.getElementById("isReport2");
		var applyc = document.getElementById("applyc");
		ds = L5.DatasetMgr.lookup("ds");
		if(value == null || value == "") {
			isReport1.style.display="none";
			isReport2.style.display="none";
			ds.set("townReport","");
			applyc.width="82%";
		} else if(value == 0) {
			isReport1.style.display="none";
			isReport2.style.display="none";
			ds.set("townReport","");
			applyc.width="82%";
		} else if(value == 1) {
			isReport1.style.display="";
			isReport2.style.display="";
			applyc.width="22%";
			var townReport = ds.get("townReport");
			if(townReport==null||townReport=="") {
				ds.set("townReport","0");
			}
		} else if(value == 2) {
			isReport1.style.display="none";
			isReport2.style.display="none";
			ds.set("townReport","");
			applyc.width="82%";
		} 
	}
				//发起单个流程
function createSend(){
	L5.getCmp("submitButton").setDisabled(true);
	window.returnValue="createSend";
	window.close();
}
		</script>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.DemobilizedflowQueryCommand" method="query3">
		<model:record fromBean="com.inspur.cams.bpt.base.data.Demobilizedflow"></model:record>
	</model:dataset>
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

 <next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
 <next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
					<next:ToolBarItem iconCls="view" id="submitButton" text="提交" handler="createSend"/>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>	
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<div id="counties">
			<table border="1"  width="100%" >	
			<tr>
				<td  class="FieldLabel" >申请时间</td>
				<td class="FieldInput" colspan="4">
				<input type="text" name="applyDate" id="applyDate" field="applyDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
				</td>
			</tr>
	   		<tr>	
	   		<td class="FieldLabel" rowspan="2" style="width:10%;">乡镇（街道）初审</td>
			<td class="FieldLabel" style="width:8%;">初审意见</td>
			<td class="FieldInput" colspan="3"><textarea type="text" name="townViews" field="townViews" style="width:80%" rows="4"></textarea> </td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><input type="text" name="trialName" field="trialName"  /> <font color="red">*</font></td>
				<td  class="FieldLabel" >初审日期</td>
				<td class="FieldInput"><input type="text" name="trialDate"id="trialDate" field="trialDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel"  rowspan="2" style="width:10%;">县级审核</td>
				<td class="FieldInput" colspan="4">
					<table width="100%">
						<tr align="left">
							<td class="FieldLabel" >审核意见：</td>
							<td class="FieldInput" width="82%" id="applyc" >
								<select  name="townFlag" id="townFlag" field="townFlag" onchange="changeDiv(this.value)">
									<option dataset="ApplyContent"></option>
								</select><font color="red">*</font>
							</td>
							<td width="17%" id="isReport1"  class="FieldLabel" style="display:none">是否上报：</td>
							<td class="FieldInput" id="isReport2" style="display:none">
								<select name="townReport" id="townReport" field="townReport" >
									<option dataset="ReportFlagEnum"></option>
								</select><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td colspan="5"><textarea type="text" name="countiesViews" field="countiesViews" style="width:80%" rows="4"></textarea></td>
						</tr>
					</table>
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><input type="text" name="reviewView" field="reviewView"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >复审日期</td>
				<td class="FieldInput"><input type="text" name="reviewDate" id="reviewDate"field="reviewDate" format="Y-m-d" style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
			</tr>
			</table>
			</div>
			</table>
		</form>
   </next:Html>
 </next:Panel>
</body>
</html>
