<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区服务汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcServiceInfoSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceModeQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceMode"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceModeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceMode"/>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
		<model:params>
		<model:param name="type" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R20'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="sumButton" iconCls="save" text="汇总" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
</next:TopBar>
<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">汇总情况</legend>
		<form id="form1" method="post" dataset="sumDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">填报单位：</td>
					<td class="FieldInput" style="width:36%"><label field="organName"/></td>
					<td class="FieldLabel" style="width:16%">填报日期：</td>
					<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate" onchange="getData()"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</fieldset>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="detailDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		
		<next:Column field="publicContent" header="公共服务内容" width="10%" sortable="false" align="right"/>
		<next:Column field="publicPeopleNum" header="公共服务人数" width="10%" sortable="false" align="right"/>
		
		<next:Column field="voluntContent" header="志愿服务内容" width="10%" sortable="false" align="right"/>
		<next:Column field="voluntPeopleNum" header="志愿服务人数" width="10%" sortable="false" align="right"/>
		
		
		<next:Column field="commerceName" header="商业服务名称" width="10%" sortable="false" align="right"/>
		<next:Column field="commerceContent" header="商业服务内容" width="10%" sortable="false" align="right"/>
		<next:Column field="commerceAddress" header="商业服务地址" width="10%" sortable="false" align="right"/>
		
		<next:Column field="ifService" header="是否提供全程代办代理服务" width="10%" sortable="false" align="right"/>
		<next:Column field="servicePhone" header="社区电话服务热线" width="10%" sortable="false" align="right"/>
		<next:Column field="serviceWeb" header="社区网络服务平台" width="10%" sortable="false" align="right"/>
		
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="450">
		<next:Html>
			<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
			<fieldset id="cdcFieldset">
			<legend>填报情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">填报单位：</td>
						<td class="FieldInput" colspan="3"><label field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:18%">填报日期：</td>
						<td class="FieldInput" style="width:35%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
						<td class="FieldLabel" style="width:15%">上报日期：</td>
						<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="cdcFieldset">
			<legend>社区服务</legend>
				<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="2">公共服务</td>
			<td class="FieldLabel" style="width:18%">公共服务内容：</td>
			<td class="FieldInput" style="width:36%"><label id="publicContent" field="publicContent"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%" >公共服务人数：</td>
			<td class="FieldInput" style="width:30%"><label id="publicPeopleNum" field="publicPeopleNum"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="2">志愿服务</td>
			<td class="FieldLabel" style="width:18%">志愿服务内容：</td>
			<td class="FieldInput" style="width:36%"><label id="voluntContent" field="voluntContent"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >志愿服务人数：</td>
			<td class="FieldInput" style="width:36%"><label id="voluntPeopleNum" field="voluntPeopleNum"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="3">商业服务</td>
			<td class="FieldLabel" style="width:18%">商业服务名称：</td>
			<td class="FieldInput" style="width:36%"><label id="commerceName" field="commerceName"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >商业服务内容：</td>
			<td class="FieldInput" style="width:36%"><label id="commerceContent" field="commerceContent"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >商业服务地址：</td>
			<td class="FieldInput" style="width:36%"><label id="commerceAddress" field="commerceAddress"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="3">服务方式</td>
			<td class="FieldLabel" style="width:18%">是否提供全程代办代理服务：</td>
			<td class="FieldInput" style="width:36%"><label id="ifService" field="ifService" dataset ="YorN" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >社区电话服务热线：</td>
			<td class="FieldInput" style="width:36%"><label id="servicePhone" field="servicePhone"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >社区网络服务平台：</td>
			<td class="FieldInput" style="width:36%"><label id="serviceWeb" field="serviceWeb"  /></td>
		</tr>
	</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>