<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organCodeSub = organCode.substr(0,6);
   var struId = '<%=BspUtil.getStruId()%>';
   var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<html>
<head>
<title>决定书修改</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
		</script>
<script type="text/javascript" src="testDecisionLetterUpdate.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 决定书dataset -->
	<model:dataset id="decisionLetterDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptDecisionLetterQueryCommand" method="queryDecisionLetter" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptDecisionLetter">
			<model:field name="domicile" type="string" />
			<model:field name="name" type="string" />
		</model:record>
	</model:dataset>
	<!-- 不符合情形 -->
	<model:dataset id="noFitDataset" enumName="WAR.NOFIT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 依据条款 -->
	<model:dataset id="foundationDataset" enumName="WAR.FOUNDATION.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true" >
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print" text="打印" handler="print" />
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="decisionLetterDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%">
	   		<tr>
				<td class="FieldLabel" >姓名：</td>
				<td class="FieldInput"  width="30%"><label  name="name" field="name" title="姓名"  readonly="readonly"/></td>
				<td class="FieldLabel">业务类型：</td>
				<td class="FieldInput" width="30%">参试退役军人身份认定 </td>
			</tr>
			<tr>
				<td class="FieldLabel" >不符合情形：</td>
				<td class="FieldInput" colspan="3">
				<textarea rows="2" cols="150" id="noFit" name="noFit" field="noFit" title="不符合情形"  style="width: 80%"></textarea>
				<font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" >依据：</td>
				<td class="FieldInput"  colspan="3">
				<textarea rows="2"  id="foundation" name="foundation" field="foundation" title="依据法规" style="width: 80%"></textarea>
				<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" >出具时间：</td>
				<td class="FieldInput"><input type="text" format="Y-m-d" style="width: 100px;" maxlength="10" name="decisionDate" field="decisionDate" title="出具时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
				<td class="FieldLabel" >出具单位：</td>
				<td class="FieldInput"  >
				<label  id="domicile" name="domicile" class="TextEditor" field="domicile" title="决定书出具单位"  />
				</td>
			</tr>
		</table>
		
		<!-- 打印相关 -->
		<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/tested/table/testDecisionLetter.doc"/>
		<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
		<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
		<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
		<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
		<input type="hidden" id="method" value="queryDecisionLetter"/>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
