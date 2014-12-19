<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
	var peopleId = '<%=request.getParameter("peopleId")%>';
	var applyId = '<%=request.getParameter("applyId")%>';
</script>
<html>
<head>
<title> 参战人员省内迁移信息查看</title>
<next:ScriptManager />
<script type="text/javascript" src="provinceMigrationUpdate.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 参战人员跨省迁出 -->
	<model:dataset id="emigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="queryWarUpdateRecord" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyEmigration">
			<model:field name="idCard" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="warTypeCode" type="string"/>
			<model:field name="forcesNo" type="string"/>
			<model:field name="position" type="string"/>
			<model:field name="asdpNo" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 参战类别 -->
	<model:dataset id="warTypeCodeDataset" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="emigratDataSet">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" style="width:15%">身份证号：</td>
				<td class="FieldInput" style="width:15%" nowrap="nowrap"><label type="text" name="idCard" field="idCard"/></td>
				<td class="FieldLabel" style="width:15%">姓名：</td>
				<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				<td class="FieldLabel" style="width:15%">性别：</td>
				<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
	   		</tr>
	   		<tr>
	   			<td class="FieldLabel">参战类别：</td>
				<td class="FieldInput"><label id="warTypeCode" name="warTypeCode" field="warTypeCode" dataset="warTypeCodeDataset"/></td>
				<td class="FieldLabel">原部队：</td>
				<td class="FieldInput"><label id="forcesNo" name="forcesNo" field="forcesNo" ></label></td>
				<td class="FieldLabel">职务：</td>
				<td class="FieldInput"><label id="position" name="position" field="position" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">退伍证号：</td>
				<td class="FieldInput" colspan="5"><label id="asdpNo" name="asdpNo" field="asdpNo"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局：</td>
				<td class="FieldInput" nowrap="nowrap"><label type="text" id="ingoingAddress" name="ingoingAddress" field="ingoingAddress"/></td>
				<td class="FieldLabel" nowrap="nowrap">抚恤金已发至：</td>
				<td class="FieldInput"><label type="text" id="allowanceMonth" name="allowanceMonth" field="allowanceMonth"/></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话：</td>
				<td class="FieldInput"><label type="text" name="townCheckPhone" field="townCheckPhone"/></td>
			</tr>
			<!-- 打印相关 -->
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/comm/print/e_migration_table1.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
			<input type="hidden" id="scaconfPath" value="migrationApp/migrationAppPrintDao"/>
			<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="55"/>
		</table>
		</form>
   </next:Html>
</next:Panel>	
</body>
<script type="text/javascript">
	function init(){
	var emigratDataSet = L5.DatasetMgr.lookup("emigratDataSet");
	emigratDataSet.setParameter("PEOPLE_ID",peopleId);
 	emigratDataSet.setParameter("APPLY_ID",applyId);
 	emigratDataSet.load(); 
	L5.QuickTips.init();
}
function print() {
		var url="../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
