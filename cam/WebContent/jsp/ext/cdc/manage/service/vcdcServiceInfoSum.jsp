<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区服务汇总</title>
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
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceReport"/>
		<model:params>
			<model:param name="REPORT_TYPE" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R07'/>
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
		<next:RowNumberColumn />
		<next:RadioBoxColumn />
		<next:Column field="organName" header="单位名称"  sortable="false" renderer="statusRender"/>
		<next:Column field="communityNum" header="社区数量" sortable="false" align="right"/>
		<next:Column field="serviceNum" header="开展服务社区数"  sortable="false" align="right"/>
		<next:Column field="onceNum" header="一站式服务大厅数" sortable="false" align="right"/>
		<next:Column field="publicNum" header="服务项目数" sortable="false" align="right"/>
		<next:Column field="publicLocaleNum" header="现场办理项目数"  sortable="false" align="right"/>
		<next:Column field="publicSupplyNum" header="全程代理项目数" sortable="false" align="right"/>
		<next:Column field="publicOtherNum" header="其他项目数" sortable="false" align="right"/>
		<next:Column field="publicMorgNum" header="主管单位总数" sortable="false" align="right"/>
		<next:Column field="publicPeopleNum" header="服务人员数"  sortable="false" align="right"/>
		<next:Column field="publicDayNum" header="全天项目数"  sortable="false" align="right"/>
		<next:Column field="publicNotdayNum" header="非全天项目数"  sortable="false" align="right"/>
		<next:Column field="facilitateNum" header="项目数" sortable="false" align="right"/>
		<next:Column field="facilitateMorgNum" header="主管单位数" sortable="false" align="right"/>
		<next:Column field="facilitatePeopleNum" header="服务人员"  sortable="false" align="right"/>
		<next:Column field="facilitateArea" header="服务场所总面积" sortable="false" align="right"/>
		<next:Column field="facilitateArea" header="服务场所平均面积"  sortable="false" align="right"/>
		<next:Column field="facilitateDayNum" header="24小时服务项目数" sortable="false" align="right"/>
		<next:Column field="voluntNum" header="总数"  sortable="false" align="right"/>
		<next:Column field="voluntNum" header="平均个数"  sortable="false" align="right"/>
		<next:Column field="voluntYearNum" header="当年成立数量" sortable="false" align="right"/>
		<next:Column field="voluntChildNum" header="针对儿童个数" sortable="false" align="right"/>
		<next:Column field="voluntOldNum" header="针对老年人个数"  sortable="false" align="right"/>
		<next:Column field="voluntHandiNum" header="针对残疾人个数" sortable="false" align="right"/>
		<next:Column field="voluntDiffNum" header="针对困难群众个数"  sortable="false" align="right"/>
		<next:Column field="voluntOtherNum" header="针对其他个数"  sortable="false" align="right"/>
		<next:Column field="volunteerNum" header="总人数"  sortable="false" align="right"/>
		<next:Column field="volunteerNum" header="平均人数"  sortable="false" align="right"/>
		<next:Column field="regNum" header="注册人数"  sortable="false" align="right"/>
		<next:Column field="regNum" header="平均注册人数"  sortable="false" align="right"/>
		<next:Column field="reportDate" header="填报日期" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态"  editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期"  sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'公共服务',start:4,colspan:10},{header:'便民利民服务',start:14,colspan:6},{header:'志愿者服务',start:20,colspan:12}]
        			  ,[{header:'服务方式',start:7,colspan:3},{header:'服务时间',start:12,colspan:2},{header:'志愿者组织',start:20,colspan:8},{header:'志愿者组织',start:28,colspan:4}]
        			  ]
    		})
	</next:ExtendConfig>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
<next:Panel>
<next:Html>
<form id="form2" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:38%">填报单位：</td>
			<td class="FieldInput" style="width:16%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:31%">社区数量：</td>
			<td class="FieldInput" style="width:28%"><label id="communityNum" field="communityNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">填报日期：</td>
			<td class="FieldInput"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel">上报日期：</td>
			<td class="FieldInput"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区服务状况</legend>
	<table width="100%">
			<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="5">公共服务</td>
			<td class="FieldLabel" style="width:10%" colspan="2">开展服务社区数：</td>
			<td class="FieldInput" style="width:8%"><label field="serviceNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:6%" rowspan="3">服务方式：</td>
			<td class="FieldLabel" style="width:10%">现场办理项目数：</td>
			<td class="FieldInput" style="width:8%"><label field="publicLocaleNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">一站式服务大厅数：</td>
			<td class="FieldInput"><label field="onceNum" renderer="gRender"/></td>
			<td class="FieldLabel">全程代理项目数：</td>
			<td class="FieldInput"><label field="publicSupplyNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">服务项目数：</td>
			<td class="FieldInput"><label field="publicNum" renderer="gRender"/></td>
			<td class="FieldLabel">其他项目数：</td>
			<td class="FieldInput"><label field="publicOtherNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">主管单位总数：</td>
			<td class="FieldInput"><label field="publicMorgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:6%" rowspan="2">服务时间：</td>
			<td class="FieldLabel">全天项目数：</td>
			<td class="FieldInput"><label field="publicDayNum" renderer="gRender"/></td>
		</tr>
			<tr>
			<td class="FieldLabel" colspan="2">服务人员数：</td>
			<td class="FieldInput"><label field="publicPeopleNum" renderer="pRender"/></td>
			<td class="FieldLabel">非全天项目数：</td>
			<td class="FieldInput"><label field="publicNotdayNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="3">便民利民服务</td>
			<td class="FieldLabel" style="width:13%" colspan="2">项目数：</td>
			<td class="FieldInput" style="width:8%"><label field="facilitateNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">服务场所总面积：</td>
			<td class="FieldInput" style="width:8%"><label field="facilitateArea" renderer="aRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">主管单位数：</td>
			<td class="FieldInput" style="width:8%"><label field="facilitateMorgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">24小时服务项目数：</td>
			<td class="FieldInput" style="width:8%"><label field="facilitateDayNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">服务人员：</td>
			<td class="FieldInput" style="width:14%" colspan="4"><label field="facilitatePeopleNum" renderer="pRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="5">志愿者服务</td>
			<td class="FieldLabel" style="width:7%" rowspan="4">志愿者组织：</td>
			<td class="FieldLabel" style="width:7%">总数：</td>
			<td class="FieldInput" style="width:8%"><label field="voluntNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">当年成立数量：</td>
			<td class="FieldInput" style="width:8%"><label field="voluntYearNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对儿童个数：</td>
			<td class="FieldInput" style="width:8%"><label field="voluntChildNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%"colspan="2">针对残疾人个数：</td>
			<td class="FieldInput" style="width:8%"><label field="voluntHandiNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对老年人个数：</td>
			<td class="FieldInput" style="width:8%"><label field="voluntOldNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">针对困难群众个数：</td>
			<td class="FieldInput" style="width:8%"><label field="voluntDiffNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对其他个数：</td>
			<td class="FieldInput" colspan="4"><label field="voluntOtherNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:6%" >志愿者：</td>
			<td class="FieldLabel" style="width:7%">总人数：</td>
			<td class="FieldInput" style="width:8%"><label field="volunteerNum" renderer="pRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">注册人数：</td>
			<td class="FieldInput" style="width:8%"><label field="regNum" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
</body>
</html>