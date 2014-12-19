<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主监督汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcSuperviseInfoSum.js"></script>
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
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
			<model:params>
			<model:param name="REPORT_TYPE" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getChengShiUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
			<model:param name="organType" value='C'/>
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
					<td class="FieldLabel" style="width:10%">填报单位：</td>
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
		<next:RowNumberColumn width="45"/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		<next:Column field="discussNum" header="财务公开" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="publishNum" header="居务公开" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="auditNum" header="政府公开" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="placardNum" header="公开栏" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="meetingNum" header="触摸屏" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="webNum" header="计算机网络" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="paperNum" header="明白纸" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="otherNum" header="其他" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="partYear" header="居委会成员接受评议次数" width="15%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="govYear" header="村务聘用人员受评议次数" width="15%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="affairYear" header="连续两次被评议为不称职数" width="15%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="financeYear" header="人数" width="10%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="financeMonth" header="居民会议推选产生人数" width="15%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="financeImm" header="居民代表会议产生人数" width="15%" sortable="false" align="center" summaryType="sum"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:2,colspan:1},{header:'居务公开',start:3,colspan:14},{header:'民主评议',start:17,colspan:3},{header:'监督委员会',start:20,colspan:3},{header:'',start:23,colspan:3}]
        			  ,
        			  [{header:'',start:2,colspan:1},{header:'居务公开程序',start:3,colspan:2},{header:'公开时间',start:5,colspan:4},{header:'公开内容',start:9,colspan:3},{header:'公开形式',start:12,colspan:5},{header:'',start:17,colspan:3},{header:'',start:20,colspan:3},{header:'',start:23,colspan:3}]]
    		})
	</next:ExtendConfig>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="300" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="430">
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
						<td class="FieldLabel" style="width:10%">填报日期：</td>
						<td class="FieldInput" style="width:35%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
						<td class="FieldLabel" style="width:15%">上报日期：</td>
						<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="cdcFieldset">
		<legend>民主监督情况</legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%" colspan="2">财务公开数：</td>
			<td class="FieldInput" style="width:10%"><label field="discussNum" renderer="cRender" /></td>
			<td class="FieldLabel" style="width:10%">居务公开数：</td>
			<td class="FieldInput" style="width:10%"><label field="publishNum" renderer="cRender" /></td>
			<td class="FieldLabel" style="width:10%">政府公开数：</td>
			<td class="FieldInput" style="width:10%"><label field="auditNum" renderer="cRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%" rowspan="2">公开形式</td>
			<td class="FieldLabel" style="width:10%" >公开栏数：</td>
			<td class="FieldInput" style="width:10%"><label field="placardNum" renderer="gRender" /></td>
			<td class="FieldLabel" style="width:10%">触摸屏数：</td>
			<td class="FieldInput" style="width:10%"><label field="meetingNum" renderer="gRender" /></td>
			<td class="FieldLabel" style="width:10%">计算机网络数：</td>
			<td class="FieldInput" style="width:10%"><label field="webNum" renderer="gRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">明白纸数：</td>
			<td class="FieldInput" style="width:10%"><label field="paperNum" renderer="zRender"/></td>
			<td class="FieldLabel" style="width:10%">其他数：</td>
			<td class="FieldInput" style="width:10%"><label field="otherNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%"></td>
			<td class="FieldInput" style="width:10%"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%" colspan="2">居委会成员接受评议次数：</td>
			<td class="FieldInput" style="width:10%"><label field="partYear" renderer="cRender" /></td>
			<td class="FieldLabel" style="width:10%">居委会聘用人员受评人数：</td>
			<td class="FieldInput" style="width:10%"><label field="govYear" renderer="pRender" /></td>
			<td class="FieldLabel" style="width:10%">连续两次被评议为不称职人数：</td>
			<td class="FieldInput" style="width:10%"><label field="affairYear" renderer="pRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%" colspan="2">居务监督委员会人数：</td>
			<td class="FieldInput" style="width:10%"><label field="financeYear" renderer="pRender" /></td>
			<td class="FieldLabel" style="width:10%">居务监督委员会经居民会议推选产生人数：</td>
			<td class="FieldInput" style="width:10%"><label field="financeMonth" renderer="pRender" /></td>
			<td class="FieldLabel" style="width:10%">居务监督委员会经居民会代表会议产生人数：</td>
			<td class="FieldInput" style="width:10%"><label field="financeImm" renderer="pRender" /></td>
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