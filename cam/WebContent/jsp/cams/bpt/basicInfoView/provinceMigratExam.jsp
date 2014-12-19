<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>优抚人员省内迁移</title>
		<next:ScriptManager/>
	
		<script>
			applyId='<%=request.getParameter("applyId")%>'
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ProvinceMigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand"  method="query" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="ingoingName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 业务类型 --> 
	<model:dataset id="BptServiceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>


<next:Panel  title="审批信息" id="approveTabPanel" width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="ProvinceMigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="99%">
					<div>
				<table width="99%">
					<tr>
						<td class="FieldLabel" colspan="2" style="width:16%">业务类型</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="serviceType" field="serviceType" dataset="BptServiceTypeDataset"/></td>
						<td class="FieldLabel" style="width:16%">申请机构</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="applyOrganization" field="applyOrganization"/></td>
						<td class="FieldLabel" style="width:16%">抚恤金已发至月份</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="allowanceMonth" field="allowanceMonth"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" colspan="2">迁入地行政区划</td>
						<td class="FieldInput"><label type="text" name="ingoingName" field="ingoingName"/></td>
						<td class="FieldLabel">迁出地县级联系电话</td>
						<td class="FieldInput" colspan="3"><label type="text" name="outTownCheckPhone" field="outTownCheckPhone"/></td>
					</tr>
				</table>
			</div>
	   			</br>
	   		<div id="OutTownAduit">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="outTownAduitIncharge" field="outTownAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:16%">审核时间</td>
						<td class="FieldInput" colspan="3" style="width:48%"><label type="text" name="outTownAduitApproveDate" field="outTownAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="outTownAduitAdvice" field="outTownAduitAdvice" style="width:90%;"></label></td>
					</tr>
	   			</table>
	   		</div>
	   			</br>
	   		<div id="OutCityAduit" >
	   			<table width="99%">
	   				<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="outCityAduitIncharge" field="outCityAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:16%">审核时间</td>
						<td class="FieldInput" colspan="3"><label type="text" name="outCityAduitApproveDate" field="outCityAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="outCityAduitAdvice" field="outCityAduitAdvice" style="width:90%;"></label></td>
					</tr>
	   			</table>
	   		</div>
	   			</br>
	   		<div id="InTownAduit">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁入地县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="inTownAduitIncharge" field="inTownAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:16%">审核时间</td>
						<td class="FieldInput" colspan="3"><label type="text" name="inTownAduitApproveDate" field="inTownAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="inTownAduitAdvice" field="inTownAduitAdvice" style="width:90%;"></label></td>
					</tr>
	   			</table>
	   		</div>
				</br>
	   		<div id="InCityAduit">
	   			<table width="99%">
	   				<tr>
	   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁入地市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="inCityAduitIncharge" field="inCityAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:16%">审核时间</td>
						<td class="FieldInput" colspan="3"><label type="text" name="inCityAduitApproveDate" field="inCityAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="5"><label type="text" name="inCityAduitAdvice" field="inCityAduitAdvice" style="width:90%;"/></td>
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
<script type="text/javascript">
	function init() {
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		ProvinceMigratDataSet.setParameter("APPLY_ID",applyId);
		ProvinceMigratDataSet.load();
		L5.QuickTips.init(); 
	}
	function Pr(){
		return openDetail(applyId);
	}
	
	function openDetail(applyId){
		var url = L5.webPath+"/jsp/cams/bpt/flow/disability/assessdisability/disabilityCert_FlowAppHistory.jsp?applyId="+applyId;
		var width = screen.width-60;
		var height = 580;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
		if (win==null) {
			return;
		}
	}
	
	
</script>

</html>
