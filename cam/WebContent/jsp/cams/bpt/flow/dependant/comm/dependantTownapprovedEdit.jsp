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
		<title>县级审核</title>
	</head>
	<next:ScriptManager/>
	<script type="text/javascript">
		var organType = '<%=BspUtil.getOrganType()%>';
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var currentDate = getCurDate();
		var peopleId ='<%=request.getParameter("peopleId")%>';
		var serviceType='<%=request.getParameter("serviceType")%>';
		function init() {
			var ds = L5.DatasetMgr.lookup("ds");
			ds.setParameter("apply_Id",'<%=request.getParameter("applyId")%>');
			ds.load();
			ds.on("load",setDefultValue);
			if(organType=='14'){//街道
				L5.getCmp("submitButton").hide();
			}
			document.getElementById("isApprove").options.remove(3);
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
				var ds = L5.DatasetMgr.lookup("ds");
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
				var countiesAduitIncharge = document.getElementById("countiesAduitIncharge").value;
					if(countiesAduitIncharge == null || countiesAduitIncharge == "") {
						L5.Msg.alert("提示","乡镇负责人不能为空！");
						return false;
					}
					
				var countiesAduitApproveDate = document.getElementById("countiesAduitApproveDate").value;
					if(countiesAduitApproveDate == null || countiesAduitApproveDate == "") {
						L5.Msg.alert("提示","乡镇审核日期不能为空！");
						return false;
					}
					if(countiesAduitApproveDate!=''&&!validateDateFormat(countiesAduitApproveDate)){
						L5.Msg.alert("提示","乡镇审核日期格式不正确！");
						return false;
					}
				var townAduitIncharge = document.getElementById("townAduitIncharge").value;
					if(townAduitIncharge == null || townAduitIncharge == "") {
						L5.Msg.alert("提示","县区负责人不能为空！");
						return false;
					}
					
				var townAduitApproveDate = document.getElementById("townAduitApproveDate").value;
					if(townAduitApproveDate == null || townAduitApproveDate == "") {
						L5.Msg.alert("提示","县区审核日期不能为空！");
						return false;
					}
					var isApprove = document.getElementById("isApprove").value;
					if(isApprove == null || isApprove == "") {
						L5.Msg.alert("提示","是否同意认定不能为空！");
						return false;
					}
					if(isApprove==0){
						var isSure = document.getElementById("isSure").value;
						if(isSure == null || isSure == "") {
							L5.Msg.alert("提示","是否享受待遇不能为空！");
							return false;
						}
					}
					
					if(townAduitApproveDate!=''&&!validateDateFormat(townAduitApproveDate)){
						L5.Msg.alert("提示","县区审核日期格式不正确！");
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
					ds.getAllChangedRecords()[0].set("serviceType",'<%=request.getParameter("serviceType")%>');
				    var records = ds.getAllChangedRecords();
					var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDependantCommand"); 
					command.setParameter("records",records);
					command.execute("saveDependant");	
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
			var trialName = ds.get("countiesAduitIncharge");
			var trialDate = ds.get("countiesAduitApproveDate");
			var reviewDate = ds.get("townAduitApproveDate");
			var reviewView = ds.get("townAduitIncharge");
			/*if(trialName == null || trialName == "") {
				ds.set("countiesAduitIncharge",currentUserName);
			}*/
			if(trialDate == null || trialDate == "") {
				ds.set("countiesAduitApproveDate",getCurDate());
			}
			if(reviewView == null || reviewView == "") {
				ds.set("townAduitIncharge",currentUserName);
			}
			if(reviewDate == null || reviewDate == "") {
				ds.set("townAduitApproveDate",getCurDate());
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
	function change(obj){
		if(obj.value=="1"){
			document.getElementById("ia1").style.display="none";
			document.getElementById("ia2").style.display="none";
			document.getElementById("ia3").style.display="";
			document.getElementById("ia4").style.display="";
		}else if(obj.value=="0"){
			document.getElementById("ia1").style.display="";
			document.getElementById("ia2").style.display="";
			document.getElementById("ia3").style.display="none";
			document.getElementById("ia4").style.display="none";
		}else{
			document.getElementById("ia1").style.display="none";
			document.getElementById("ia2").style.display="none";
			document.getElementById("ia3").style.display="";
			document.getElementById("ia4").style.display="";
		}
	}
			//发起单个流程
function createSend(){
	L5.getCmp("submitButton").setDisabled(true);
	window.returnValue="createSend";
	window.close();
}
		</script>
		<script type="text/javascript" src="../../../comm/bptComm.js"></script>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDependantQueryCommand" method="queryTownApproved">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDependant"></model:record>
	</model:dataset>
	<!--同意认定 -->
	<model:dataset id="isApproveEnum" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
	<!--是否享受待遇 -->
	<model:dataset id="isSureEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

 <next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
 <next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
					<next:ToolBarItem iconCls="view" id="submitButton"  text="审批" handler="createSend"/>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
					<next:ToolBarItem iconCls="view" text="添加到黑名单" handler="addBlackList" />
				</next:TopBar>	
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
				<tr>
					<td class="FieldLabel" rowspan="2" style="width: 15%">村（居）委会审核</td>
					<td class="FieldLabel" style="width: 10%">负责人</td>
					<td class="FieldInput"><input type="text" name="acceptIncharge" field="acceptIncharge" /><font color="red">*</font></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><input type="text"
						name="acceptDate" id="acceptDate"
						field="acceptDate" format="Y-m-d"
						style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);"> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">审查意见</td>
					<td class="FieldInput" colspan="3"><textarea type="text" id="acceptAdvice"
						name="acceptAdvice" field="acceptAdvice"
						style="width: 80%" rows="3"></textarea></td>
				</tr>
	   		<tr>
	   				<td class="FieldLabel" rowspan="2" style="width: 15%">乡（镇、街道）审核</td>
					<td  class="FieldLabel">负责人</td>
					<td class="FieldInput"><input type="text" name="countiesAduitIncharge" field="countiesAduitIncharge"  /><font color="red">*</font></td>
					<td  class="FieldLabel" >审核日期</td>
					<td class="FieldInput"><input type="text" name="countiesAduitApproveDate"id="countiesAduitApproveDate" field="countiesAduitApproveDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" 
						/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
						<font color="red">*</font>
					</td>	
			</tr>
	   		<tr>
	   				<td class="FieldLabel" >审核意见</td>
					<td class="FieldInput" colspan="3"><textarea type="text" name="countiesAduitAdvice" field="countiesAduitAdvice" style="width:80%" rows="4"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" rowspan="3" style="width: 15%">县（市、区）审批</td>
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><input type="text" name="townAduitIncharge" field="townAduitIncharge"  /> <font color="red">*</font></td>
			
				<td  class="FieldLabel" > 审批日期</td>
				<td class="FieldInput"><input type="text" name="townAduitApproveDate" id="townAduitApproveDate"field="townAduitApproveDate" format="Y-m-d" style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
				<font color="red">*</font>
				</td>
				</tr>
			<tr>
				<td  class="FieldLabel" >是否同意认定</td>
				<td class="FieldInput" id="is2">
					<select name="isApprove" id="isApprove" field="isApprove" onchange="change(this)">
						<option dataset="isApproveEnum"></option>
					</select><font color="red">*</font>
				</td>
				<td  class="FieldLabel" id="ia1" style="display:none">是否享受待遇</td>
				<td class="FieldInput" id="ia2" style="display:none">
					<select name="isSure" id="isSure" field="isSure" >
						<option dataset="isSureEnum"></option>
					</select><font color="red">*</font>
				</td>
				
				<td  class="FieldLabel" id="ia3" ></td>
				<td class="FieldInput" id="ia4"  ></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >审批意见</td>
				<td class="FieldInput" colspan="3"><textarea type="text" name="townAduitAdvice" field="townAduitAdvice" style="width:80%" rows="4"></textarea> </td>
			</tr>
			</table>
		</form>
   </next:Html>
 </next:Panel>
</body>
</html>
