<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
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
	<script type="text/javascript">
		function init() {
						var ds = L5.DatasetMgr.lookup("ds");
							ds.setParameter("apply_Id",'<%=request.getParameter("applyId")%>');
							ds.load();
							ds.on("load",function(){
								var townReport = ds.get("townReport");
								var isReport1 = document.getElementById("isReport1");
								var isReport2 = document.getElementById("isReport2");
								var applyc = document.getElementById("applyc");
								if(townReport == null||townReport == "") {
									isReport1.style.display="none";
									isReport2.style.display="none";
									applyc.width="82%";
								} else  {
									isReport1.style.display="";
									isReport2.style.display="";
									applyc.width="20%";
								}
							});
					}
		function save(){
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
				    var records = ds.getAllChangedRecords();
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
 <next:Panel height="100%" width="100%" autoScroll="true" id="peopleTabPanel">
 	<next:Html>
 	<form id="editForm" dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%">
			<div id="counties">
			<table border="1" width="100%">	
			<tr>
				<td class="FieldLabel" >申请时间</td>
				<td class="FieldInput" colspan="4">
					<label name="applyDate" id="applyDate" field="applyDate"/>
				</td>
			</tr>
	   		<tr>	
	   		<td class="FieldLabel" rowspan="2" style="width:10%;">乡镇（街道）初审</td>
			<td class="FieldLabel" style="width:8%;">初审意见</td>
			<td class="FieldInput" colspan="3"><label name="townViews" field="townViews"></label></td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><label name="trialName" field="trialName"  /></td>
				<td  class="FieldLabel" >初审日期</td>
				<td class="FieldInput"><label name="trialDate"id="trialDate" field="trialDate"/></td>
			</tr>
			<tr>
				<td  class="FieldLabel"  rowspan="2" style="width:10%;">县级审核</td>
				<td class="FieldInput" colspan="4">
					<table width="100%">
						<tr align="left">
							<td class="FieldLabel" >审核意见：</td>
							<td class="FieldInput" width="82%" id="applyc" >
								<label  name="townFlag" id="townFlag" field="townFlag" dataset="ApplyContent"></label>
							</td>
							<td width="17%" id="isReport1"  class="FieldLabel" style="display:none">是否上报：</td>
							<td class="FieldInput" id="isReport2" style="display:none">
								<label name="townReport" id="townReport" field="townReport"  dataset="ReportFlagEnum"></label>
							</td>
						</tr>
						<tr>
							<td colspan="5"><label name="countiesViews" field="countiesViews"></label></td>
						</tr>
					</table>
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><label name="reviewView" field="reviewView"/></td>
				<td  class="FieldLabel" >复审日期</td>
				<td class="FieldInput"><label name="reviewDate" id="reviewDate" field="reviewDate"/></td>
			</tr>
			</table>
			</div>
			</table>
		</form>
   </next:Html>
 </next:Panel>
</body>
</html>
