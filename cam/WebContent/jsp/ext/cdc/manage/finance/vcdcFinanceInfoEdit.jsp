<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村经济基本情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcFinanceInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var userStatus = "vcdcFinanceInfoEdit.jsp";
	
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFinanceInfoQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFinanceInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R19'/>
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
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
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
<legend>经济基本情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">年度：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><input type="text" name = "年度"  id="yearly" field="yearly" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">生产总值：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "生产总值"  id="gdpMon" field="gdpMon" maxlength="30" />&nbsp;万元<font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">农业产值：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "农业产值"  id="agricultureMon" field="agricultureMon" maxlength="30" />&nbsp;万元<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人均收入：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "人均收入"  id="personMon" field="personMon" maxlength="30" />&nbsp;元<font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">财政收入：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "财政收入"  id="financeMon" field="financeMon" maxlength="30" />&nbsp;万元<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>