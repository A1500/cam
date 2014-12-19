<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
	var applyId = '<%=request.getParameter("applyId")%>';
	var peopleId = '<%=request.getParameter("peopleId")%>';
</script>
<html>
<head>
<title> 修改年满60周岁农村籍退役士兵定补关系跨省迁出</title>
<next:ScriptManager />
<script type="text/javascript" src="sEmigrationUpdate.js"></script>
<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	 
	<!-- 人员抚恤关系跨省迁出 -->
	<model:dataset id="martyEmigratDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="querySoldierInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyEmigration">
			<model:field name="idCard" type="string"/>
			<model:field name="name" type="string" />
			<model:field name="sex" type="string"/>
			<model:field name="ingoingCode" type="string"/>
		</model:record>
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	 
	 <!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
	 
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="martyEmigratDataset">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" style="width:15%">身份证号：</td>
				<td class="FieldInput" style="width:15%"><label type="text" name="idCard" field="idCard" style="width:135" />
				</td>
				<td class="FieldLabel" style="width:15%">姓名：</td>
				<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				<td class="FieldLabel" style="width:15%">性别：</td>
				<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
	   		</tr>
	   		<tr>
	   		    <td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label name="conscriptDate" field="conscriptDate" format="Y-m-d" title="入伍时间"/></td>
	   		    <td class="FieldLabel" nowrap>退役时间：</td>
				<td class="FieldInput"><label name="decruitmentDate" field="decruitmentDate" format="Y-m-d"  title="退役时间"/></td>
				<td class="FieldLabel" nowrap>退役证件号：</td>
				<td class="FieldInput"><label name="retiredNo" field="retiredNo" title="退役证件号"/></td>
			</tr>
			<tr>
		        <td class="FieldLabel" nowrap>服役部队名称(番号)：</td>
				<td class="FieldInput"><label name="forcesName" field="forcesName" title="服役部队名称(番号)"/><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>服役部队代号：</td>
				<td class="FieldInput" colspan="3"><label name="forcesNo" field="forcesNo" title="服役部队代号"/><font color="red">*</font></td>
		    </tr>
	   		<tr>
	   		    <td  class="FieldLabel" nowrap>服义务兵(开始时间)：</td>
				<td class="FieldInput"><label name="soldierStartDate" field="soldierStartDate" format="Y-m-d"style="width: 100px;"   title="服义务兵开始时间" /></td>
				<td  class="FieldLabel" nowrap>服义务兵(结束时间)：</td>
				<td class="FieldInput"><label name="soldierEndDate" field="soldierEndDate" format="Y-m-d"style="width: 100px;" maxlength="10"  title="服义务兵结束时间" /></td>
	   		    <td  class="FieldLabel" nowrap>所服义务兵役折算年限：</td>
				<td class="FieldInput"><label id="soldierYears" name="soldierYears" field="soldierYears" title="所服义务兵役折算年限"/> </td>
	   		</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局：</td>
				<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
										<input type="text" id="ingoingAddress" name="ingoingAddress" field="ingoingAddress" onclick="getCodeAndName()"/>
										<font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">残疾抚恤金已发至：</td>
				<td class="FieldInput"><input type="text" id="allowanceMonth"  format="Y-12" style="width: 100px;" maxlength="10" name="allowanceMonth" field="allowanceMonth" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话：</td>
				<td class="FieldInput"><input type="text" name="townCheckPhone" field="townCheckPhone" /></td>
			</tr>
			<!-- 打印相关 -->
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/comm/print/e_migration_table1.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
			<input type="hidden" id="scaconfPath" value="migrationApp/migrationAppPrintDao"/>
			<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="84"/>
		</table>
		</form>
   </next:Html>
</next:Panel>	
<script type="text/javascript">
	
function print() {
		var url="../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</body>
</html>
