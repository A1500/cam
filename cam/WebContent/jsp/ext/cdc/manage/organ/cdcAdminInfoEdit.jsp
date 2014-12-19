<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市社区管理与共建填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcAdminInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="adminReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganReportQueryCmd" pageSize="-1" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganReport"/>
	</model:dataset>
	<model:dataset id="adminInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganInfoQueryCmd" pageSize="-1" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R09'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.CORP_TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="提取数据" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="adminReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>管理与共建状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="4">管理与共建状况</td>
			<td class="FieldLabel" style="width:13%">驻区单位总数：</td>
			<td class="FieldInput" style="width:14%"><label field="organNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:13%">当年进驻单位数：</td>
			<td class="FieldInput" style="width:14%"><label field="organYearNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:13%">政府机关类个数：</td>
			<td class="FieldInput" style="width:15%"><label field="kindOneNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">事业单位类个数：</td>
			<td class="FieldInput"><label field="kindTwoNum" renderer="gRender"/></td>
			<td class="FieldLabel">企业单位类个数：</td>
			<td class="FieldInput"><label field="kindThreeNum" renderer="gRender"/></td>
			<td class="FieldLabel">其他单位类个数：</td>
			<td class="FieldInput"><label field="kindFourNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">主管部门数量：</td>
			<td class="FieldInput"><label field="morgNum" renderer="gRender"/></td>
			<td class="FieldLabel">职工总人数：</td>
			<td class="FieldInput"><label field="memberNum" renderer="pRender"/></td>
			<td class="FieldLabel">占地面积：</td>
			<td class="FieldInput"><label field="officialArea" renderer="aRender"/></td>
		</tr>
	</table>
</form>
</next:Html>
</next:Panel>
</body>
</html>