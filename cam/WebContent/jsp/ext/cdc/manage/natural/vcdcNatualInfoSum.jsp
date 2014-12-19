<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区自然状况汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcNatualInfoSum.js"></script>
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
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcNatureReportQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNatureReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcNatureReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNatureReport"/>
		<model:params>
			<model:param name="REPORT_TYPE"  value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R02'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
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
		<next:Column field="organName" header="单位名称" width="10%" sortable="false" renderer="statusRender"/>
		<next:Column field="communityNum" header="社区数量" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="villageNum" header="自然村总数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="villageNum" header="自然村平均数" width="8%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="groupNum" header="村民小组总数" width="8%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="groupNum" header="村民小组平均数" width="9%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="totalArea" header="辖区总面积(平方公里)" width="11%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="totalArea" header="辖区平均面积(平方公里)" width="13%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="ploughArea" header="耕地总面积(亩)" width="9%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="ploughArea" header="耕地平均面积(亩)" width="9%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="houseArea" header="宅基地总面积(亩)" width="9%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="houseArea" header="宅基地平均面积(亩)" width="10%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="collectNum" header="集中型个数" width="7%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="disperseNum" header="分散型个数" width="7%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="mountainNum" header="山区型个数" width="7%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="helfMountainNum" header="丘陵型个数" width="7%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="campagnaNum" header="平原型个数" width="7%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="6%" editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="8%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="360" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel>
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
			<legend>社区自然状况</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">社区数：</td>
					<td class="FieldInput" style="width:18%"><label field ="communityNum"   maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:18%">自然村总数：</td>
					<td class="FieldInput" style="width:18%"><label field ="villageNum"   maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:18%">自然村平均数：</td>
					<td class="FieldInput" style="width:18%" renderer="avgRender"><label field ="villageNum" maxlength="30" style="width:90%" renderer="gRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:16%">村民小组总数：</td>
					<td class="FieldInput" style="width:16%"><label field ="groupNum"   maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:16%">辖区总面积：</td>
					<td class="FieldInput" style="width:16%"><label field ="totalArea"   maxlength="30" style="width:90%" renderer="aRender" /></td>
					<td class="FieldLabel" style="width:18%">耕地总面积：</td>
					<td class="FieldInput" style="width:18%"><label field ="ploughArea"   maxlength="30" style="width:90%" renderer="mRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:16%">村民小组平均数：</td>
					<td class="FieldInput" style="width:16%" renderer="avgRender"><label field ="groupNum"   maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:16%">辖区平均面积：</td>
					<td class="FieldInput" style="width:16%" renderer="avgRender"><label field ="totalArea"   maxlength="30" style="width:90%" renderer="aRender" /></td>
					<td class="FieldLabel" style="width:18%">耕地平均面积：</td>
					<td class="FieldInput" style="width:18%" renderer="avgRender"><label  field ="ploughArea"   maxlength="30" style="width:90%" renderer="mRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:16%">宅基地总面积：</td>
					<td class="FieldInput" style="width:16%"><label  field ="houseArea"   maxlength="30" style="width:90%" renderer="mRender" /></td>
					<td class="FieldLabel" style="width:16%" >宅基地平均面积：</td>
					<td class="FieldInput" style="width:16%" colspan="3"><label id="houseArea" field ="houseArea"  maxlength="30" style="width:90%" renderer="mRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:16%">集中型个数：</td>
					<td class="FieldInput" style="width:16%"><label   field ="collectNum" maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:16%">分散型个数：</td>
					<td class="FieldInput" style="width:16%" colspan="3"><label   field ="disperseNum" maxlength="30" style="width:90%" renderer="gRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:16%">山区型个数：</td>
					<td class="FieldInput" style="width:16%"><label  field ="mountainNum" maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:16%">丘陵型个数：</td>
					<td class="FieldInput" style="width:16%" renderer="avgRender"><label  field ="helfMountainNum" maxlength="30" style="width:90%" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:16%">平原型个数：</td>
					<td class="FieldInput" style="width:16%"><label  field ="campagnaNum" maxlength="30" style="width:90%" renderer="gRender" /></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
<next:Window id="rejectWin" title="驳回原因" resizable="false" width="400" height="200" modal="true" closeAction="hide" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
	<fieldset>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:30%">驳回原因：</td>
			<td class="FieldInput" style="width:70%" ><textArea style="height:110;width:100%" id="reason"></textArea></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
<next:Buttons>
		<next:ToolButton text="确定" handler="confirmReject"></next:ToolButton>
		<next:ToolButton text="取消" handler="closeWin"></next:ToolButton>
</next:Buttons>
</next:Window>
</body>
</html>