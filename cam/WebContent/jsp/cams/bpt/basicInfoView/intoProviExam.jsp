<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
 
<html>
	<head>
		<title>外省优抚人员抚恤关系迁入我省明细</title>
		<next:ScriptManager/>
				<script>var applyId='<%=request.getParameter("applyId")%>'</script>
	</head>
<body>
<model:datasets>
	<!-- 外省优抚人员抚恤关系迁入DataSet -->
	<model:dataset id="BptIntoproviDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand" method="query" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyIntoprovince"></model:record>
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



<next:Panel  title="审批信息" width="100%" height="100%" id="approveTabPanel" autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="BptIntoproviDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
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
						<td class="FieldLabel" colspan="2" style="width:16%">由何地迁入：</td>
						<td class="FieldInput"><label name="ingoingAddress" field="ingoingAddress"/></td>
						<td class="FieldLabel">迁入原因</td>
						<td class="FieldInput" colspan="5"><label name="ingoingReason" field="ingoingReason"/></td>
					</tr>
		  	</table>
		  </div>
		  	<br/>
		  <div id="TownVerify">
		  	<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2">县级审核</td>
						<td class="FieldLabel" >审核人员</td>
						<td class="FieldInput" style="width:30%"><label    name="townAduitIncharge" field="townAduitIncharge" readonly="readonly"/></td>
						<td class="FieldLabel" style="width:20%">审核时间</td>
						<td class="FieldInput" style="width:30%"><label   name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审核意见</td>
						<td class="FieldInput" colspan="3"><label    name="townAduitAdvice" field="townAduitAdvice" style="width:90%"></label></td>
					</tr>
			 </table>
		  </div>
			<br/>
		  <div id="CityVerify" >
		  	<table width="99%">
		   		<tr>
		   			<td class="FieldLabel" rowspan="2">市级审核</td>
					<td class="FieldLabel" >审核人员</td>
					<td class="FieldInput" style="width:30%"><label   validateName="审核人员" name="cityAduitIncharge" field="cityAduitIncharge" /></td>
					<td class="FieldLabel" style="width:20%">审核时间</td>
					<td class="FieldInput" style="width:30%"><label  validateName="审核时间" name="cityAduitApproveDate" field="cityAduitApproveDate"/></td>
				</tr>
		   		<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><label   name="cityAduitAdvice" field="cityAduitAdvice" style="width:90%"></label></td>
				</tr>
			</table>
		  </div>
		  	<br/>
			<div id="ProvinceApprove" >
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2">省级审批</td>
						<td class="FieldLabel"  >审批人员</td>
						<td class="FieldInput" style="width:30%"><label  validateName="审批人员" name="provinceIncharge" field="provinceIncharge" /></td>
					
						<td class="FieldLabel" style="width:20%">审批时间</td>
						<td class="FieldInput" style="width:30%"><label  validateName="审批时间" name="provinceApproveDate" field="provinceApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审批意见</td>
						<td class="FieldInput" colspan="3"><label   name="provinceAdvice" field="provinceAdvice" style="width:90%"></label></td>
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




<script type="text/javascript">
	function init() {
		var BptIntoproviDataset = L5.DatasetMgr.lookup("BptIntoproviDataset");
		BptIntoproviDataset.setParameter("APPLY_ID",applyId);
		BptIntoproviDataset.load();
		L5.QuickTips.init(); 
	}
		function Pr(){
		return openDetail(applyId);
	}
	
	function openDetail(applyId){
		var url = L5.webPath+"/jsp/cams/bpt/flow/comm/intoProAppHistory.jsp?applyId="+applyId;
		var width = screen.width-60;
		var height = 580;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
		if (win==null) {
			return;
		}
	}
</script>	
	