<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>

<html>
	<head>
		<title>优抚抚恤关系跨省迁出审批表</title>
		<next:ScriptManager/>
		<script>
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType='<%=request.getParameter("serviceType")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="BptApplyEmigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="queryById" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyEmigration"></model:record>
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
 

<next:Panel  title="审批表" id="approveTabPanel" width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="BptApplyEmigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" width="99%">
		   		<div>
			  <table width="99%">
		   		<tr>
						<td class="FieldLabel" colspan="2" style="width:16%">业务类型</td>
						<td class="FieldInput" style="width:16%" nowrap="nowrap"><label type="text" name="serviceType" field="serviceType" dataset="BptServiceTypeDataset"/></td>
						<td class="FieldLabel" style="width:16%">申请机构</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="applyOrganization" field="applyOrganization"/></td>
						<td class="FieldLabel" style="width:16%">抚恤金已发至月份</td>
						<td class="FieldInput" style="width:16%"><label type="text" name="allowanceMonth" field="allowanceMonth"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" colspan="2" style="width:16%">迁入地民政局：</td>
					<td class="FieldInput" colspan="5"><label name="ingoingAddress" field="ingoingAddress"/></td>
				</tr>
			  </table>
		   </div>
				<br/>
			<div id="TownAduit">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">县级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput" ><label name="townAduitIncharge" field="townAduitIncharge"/></td>
						<td class="FieldLabel" style="width:8%">审核时间</td>
						<td class="FieldInput" colspan="3"><label name="townAduitApproveDate" field="townAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><label name="townAduitAdvice" rows="3" field="townAduitAdvice" ></label></td>
					</tr>
				</table>
			</div>
				<br/>
			<div id="CityAduit" >
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">市级审核</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label name="cityAduitIncharge" field="cityAduitIncharge"/></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput" colspan="3"><label name="cityAduitApproveDate" field="cityAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><label name="cityAduitAdvice" field="cityAduitAdvice" rows="3"/></td>
					</tr>
				</table>
			</div>
				<br/>
			<div id="ProvinceApprove" >
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">省级审批</td>
						<td class="FieldLabel" style="width:8%">负责人</td>
						<td class="FieldInput"><label name="provinceIncharge" field="provinceIncharge"/></td>
						<td class="FieldLabel">审批时间</td>
						<td class="FieldInput" colspan="3"><label name="provinceApproveDate" field="provinceApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" style="width:8%">意见</td>
						<td class="FieldInput" colspan="5"><label name="provinceAdvice" field="provinceAdvice" rows="3"/></td>
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

	


<script type="text/javascript"><!--
	function init() {
		var BptApplyEmigratDataSet = L5.DatasetMgr.lookup("BptApplyEmigratDataSet");
		BptApplyEmigratDataSet.setParameter("APPLY_ID",applyId);
		BptApplyEmigratDataSet.load();
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
--></script>

</body>
</html>
