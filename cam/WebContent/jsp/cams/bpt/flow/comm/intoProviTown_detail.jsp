<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>外省优抚人员抚恤关系迁入我省县级审核查看</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<!-- 外省优抚人员抚恤关系迁入DataSet -->
	<model:dataset id="BptIntoproviDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand"  method="queryApplyInfo"   global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyIntoprovince"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel  width="100%" height="100%" id="approveTabPanel" autoScroll="true">
	 
	<next:Html>
		<form id="editForm"   dataset="BptIntoproviDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		  <div id="TownVerify">
		  	<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" style="width:8%">县级审核</td>
						<td class="FieldLabel" style="width:8%">审核人员</td>
						<td class="FieldInput"><label    name="townAduitIncharge" field="townAduitIncharge"  /></td>
						<td class="FieldLabel">审核时间</td>
						<td class="FieldInput"><label    name="townAduitApproveDate" field="townAduitApproveDate" /></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">审核意见</td>
						<td class="FieldInput" colspan="3"><label    name="townAduitAdvice" field="townAduitAdvice" style="width:90%"></label></td>
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
		BptIntoproviDataset.setParameter("APPLY_ID",'<%=request.getParameter("applyId")%>');  
		BptIntoproviDataset.load();
		L5.QuickTips.init(); 
	}
</script>
</body>
</html>
