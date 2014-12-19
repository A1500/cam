<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@ page import="java.util.HashMap" %>
<html>
	<head>
		<title>优抚_申请_伤残申请_审批编辑</title>
		<next:ScriptManager/>
				<script>
				var applyId='<%=request.getParameter("applyId")%>';
				</script>
					</head>
<body>
<model:datasets>
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryApplyInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability"></model:record>
	</model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="ServiceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="审批信息" height="100%" width="100%" id="approveTabPanel" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="DisabilityApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0"  width="99%">
				<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><label  name="townAduitIncharge" field="townAduitIncharge" readonly="readonly" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label   name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"  /> </td>
					</tr>
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
							<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;"  name="townFlag"  dataset="ApplyContent" field="townFlag" >
									</label>
								</td>
								<td class="FieldInput">
									<div id="TownVerifyPass" style="display:none">伤残性质：
										<label dataset="DisabilityCaseDataset" name="townAduitDisabilityNature" field="townAduitDisabilityNature">
										</label> 
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label  dataset="DisabilityLevelDataset" name="townAduitDisabilityLevel" field="townAduitDisabilityLevel">
										</label> 
									</div>
									<div id="TownVerifyEnd" disabled="disabled" style="display:none">
										是否上报：
										<label name="townReport" id="townReport"  dataset="ReportFlagEnum" field="townReport" >
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="townAduitAdvice" field="townAduitAdvice"></label>  
								</td>
							</tr>
						</table>
						</td>
						</tr>
						</table>
			</div>
				<br>
			<div id="CityVerify">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" nowrap="nowrap">市级审核</td>
			   			<td class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="cityAduitIncharge" field="cityAduitIncharge"/></td>
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="cityAduitApproveDate" field="cityAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="cityFlag" 
									 id="CityVerifyFlag" field="cityFlag" dataset="ApplyContent">
									</label>
								</td>
								<td class="FieldInput">
									<div id="CityVerifyPass" style="display:none">伤残性质： 
										<label dataset="DisabilityCaseDataset" name="cityAduitDisabilityNature"  field="cityAduitDisabilityNature">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label dataset="DisabilityLevelDataset" name="cityAduitDisabilityLevel"   field="cityAduitDisabilityLevel">
										</label>	
									</div>
									<div id="CityVerifyEnd"  style="display:none">
										是否上报：
										<label name="cityReport" id="cityReport" dataset="ReportFlagEnum" field="cityReport" >
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="cityAduitAdvice" field="cityAduitAdvice"></label>
								</td>
							</tr>
						</table>
						 </td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceAccept">
				<table width="99%">
					<tr>
						<td class="FieldLabel" rowspan="5" nowrap="nowrap">省级审批</td>			   			
			   			<td class="FieldLabel" nowrap="nowrap">受理人员</td>
						<td class="FieldInput" style="width:30%"><label name="provinceCheckPeopleId" field="provinceCheckPeopleId"/></td>
						
						<td class="FieldLabel" style="width:20%">受理时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceCheckDate" field="provinceCheckDate"/></td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">负伤时间</td>
						<td class="FieldInput" style="width:30%"><label name="disabilityDate" field="disabilityDate" ></label> </td>
						<td  class="FieldLabel" nowrap="nowrap">负伤地点</td>
						<td class="FieldInput" style="width:30%"><label   name="disabilityAdd" field="disabilityAdd" ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">负伤部位</td>
						<td class="FieldInput" style="width:30%"><label  name="disabilityBody" field="disabilityBody" ></label> </td>
						<td  class="FieldLabel" nowrap="nowrap">负伤原因</td>
						<td class="FieldInput" style="width:30%"><label  name="disabilityReason" field="disabilityReason" ></label> </td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput"> 
									<label style="width:90px;"  name="proCheckFlag"  dataset="ApplyContent"
									id="ProvinceAcceptFlag" field="proCheckFlag" >
									</label>
								</td>
								<td class="FieldInput">
									<div id="ProvinceAcceptPass" style="display:none">伤残性质：
										<label name="provinceCheckDisNature" dataset="DisabilityCaseDataset"  field="provinceCheckDisNature">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label name="provinceCheckDisLevel" dataset="DisabilityLevelDataset" field="provinceLevel">
										</label>
									</div>
									<div id="ProvinceAcceptEnd"  style="display:none">
										是否上报：
										<label name="proCheckReport" dataset="ReportFlagEnum" id="proCheckReport" field="proCheckReport" >
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceCheckAdvice" field="provinceCheckAdvice"></label> 
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
			
<br>
				<div>
					<table>
						<tr border="0"  width="98%">
							<td class="FieldInput"><lable id = "PrHistory" name="PrHistory"><a href="javaScript:Pr()">审批历史记录</a></lable></td>
						</tr>
					</table>
				</div>
		</table>
		</form>
   </next:Html>
</next:Panel>

</body>
<script>
function init() {
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
	DisabilityApproveDataset.load();
	L5.QuickTips.init(); 
}
function Pr(){
		return openDetail(applyId);
	}
	
	function openDetail(applyId){
		var url = L5.webPath+"/jsp/cams/bpt/flow/disability/assessdisability/disabilityAppHistory.jsp?applyId="+applyId;
		var width = screen.width-60;
		var height = 580;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
		if (win==null) {
			return;
		}
	}
</script>
</html>
