<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社区建设领导协调机制填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcCoordinateInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	userStatus="vcdcCoordinateInfoEdit.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="coordinateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcCoordinateInfoQueryCmd"  pageSize="1" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcCoordinateInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R17'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="YorNDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="coordinateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>领导协调机制</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" colspan="2">是否成立领导协调机制：</td>
			<td class="FieldInput" colspan="3"><select name = "是否成立领导协调机制"  id= "ifFound" field="ifFound" onchange="ifFoundChanges()"><option dataset ="YorNDataSet"></option> </select><font color="red">*</font> </td>
		</tr>
		<tr>
			<td class="FieldLabel"  rowspan="3" >详细信息：</td>
			<td class="FieldLabel"  >名称：</td>
			<td class="FieldInput" ><input type="text" name = "名称"  id="name" field="name" maxlength="30" /><font color="red">*</font></td>
			<td class="FieldLabel" >职责：</td>
			<td class="FieldInput" ><input type="text" name = "职责"  id="duty" field="duty" maxlength="30" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  >牵头部门：</td>
			<td class="FieldInput" ><input type="text" name = "牵头部门"  id="department" field="department" maxlength="30" /><font color="red">*</font></td>
			<td class="FieldLabel" >联系人姓名：</td>
			<td class="FieldInput" ><input type="text" name = "联系人姓名"  id="linkPeople" field="linkPeople" maxlength="30" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel"  >联系人电话(座机)：</td>
			<td class="FieldInput" ><input type="text" name = "联系人电话(座机)"  id="phone" field="phone" maxlength="30" /><font color="red">*</font></td>
			<td class="FieldLabel" >联系人职责：</td>
			<td class="FieldInput" ><input type="text" name = "联系人职责"  id="position" field="position" maxlength="30" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" >经费保障：</td>
			<td class="FieldLabel" >是否纳入财政预算：</td>
			<td class="FieldInput" ><select name = "是否纳入财政预算" id = "ifBudget" field="ifBudget" onchange=" ifBudgetChanges()"><option dataset ="YorNDataSet"></option> </select><font color="red">*</font></td>
			<td class="FieldLabel" >财政标准：</td>
			<td class="FieldInput" ><input type="text" name = "财政标准"  id="criterion" field="criterion" maxlength="30" />&nbsp; 元<font id = "red"  color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>