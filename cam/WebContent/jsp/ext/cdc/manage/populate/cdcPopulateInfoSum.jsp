<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区人口状况汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcPopulateInfoSum.js"></script>
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
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPopulateInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPopulateInfo"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPopulateInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPopulateInfo"/>
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
			<model:param name="reportType" value='R01'/>
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
		<next:Column field="populateNum" header="人口总户数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="peopleNum" header="人口总数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="residePopulateNum" header="常住人口户数" width="8%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="residePeopleNum" header="常住人口数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="resideFemaleNum" header="常住人口女性人数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="registeNum" header="户籍人口数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="floatingNum" header="持居住证人口数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="outsideNum" header="流动人口数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="femaleNum" header="女性人口数" width="6%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="reportDate" header="填报日期" width="8%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="6%" editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="480" modal="true" closeAction="hide" autoScroll="true">
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
			<td class="FieldInput" style="width:27%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:13%">上报日期：</td>
			<td class="FieldInput" style="width:42%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>人口状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="5">人口状况</td>
			<td class="FieldLabel" style="width:13%">总户数：</td>
			<td class="FieldInput" style="width:14%"><label field="populateNum" renderer="reRender"/></td>
			<td class="FieldLabel" style="width:13%">总人口数：</td>
			<td class="FieldInput" style="width:14%"><label field="peopleNum" renderer="peRender" renderer="peRender"/></td>
			<td class="FieldLabel" style="width:13%">其中：女性</td>
			<td class="FieldInput" style="width:15%"><label field="femaleNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">常住人口户数：</td>
			<td class="FieldInput"><label field="residePopulateNum" renderer="reRender"/></td>
			<td class="FieldLabel">常住人口数：</td>
			<td class="FieldInput"><label field="residePeopleNum" renderer="peRender"/></td>
			<td class="FieldLabel">其中：女性</td>
			<td class="FieldInput"><label field="resideFemaleNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">户籍人口数：</td>
			<td class="FieldInput"><label field="registeNum" renderer="peRender"/></td>
			<td class="FieldLabel">持居住证人口数：</td>
			<td class="FieldInput"><label field="floatingNum" renderer="peRender"/></td>
			<td class="FieldLabel">流动人口数：</td>
			<td class="FieldInput"><label field="outsideNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">农业人口数：</td>
			<td class="FieldInput"><label field="farmingNum" renderer="peRender"/></td>
			<td class="FieldLabel">非农业人口数：</td>
			<td class="FieldInput" colspan="3"><label field="nonFarmingNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">18岁以下人数：</td>
			<td class="FieldInput"><label id="pipiEgihteenNum" field="pipiEgihteenNum" renderer="peRender" /></td>
			<td class="FieldLabel">60岁以上人数：</td>
			<td class="FieldInput" colspan="3" ><label id="pipiSixtyNum" field="pipiSixtyNum" renderer="peRender" /></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>人户情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:8%" >人在户在</td>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label field="pipiNum" renderer="peRender"/></td>
			<td class="FieldLabel" style="width:13%">其中：女性</td>
			<td class="FieldInput" style="width:14%" colspan="3"><label field="pipiFemaleNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" >人在户不在</td>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label field="pipoNum" renderer="peRender"/></td>
			<td class="FieldLabel" style="width:13%">其中：女性</td>
			<td class="FieldInput" style="width:14%" colspan="3"><label field="pipoFemaleNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" >户在人不在</td>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label field="popiNum" renderer="peRender"/></td>
			<td class="FieldLabel" style="width:13%">其中：女性</td>
			<td class="FieldInput" style="width:14%" colspan="3"><label field="popiFemaleNum" renderer="peRender"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>其他情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="1">党员情况</td>
			<td class="FieldLabel">党员数：</td>
			<td class="FieldInput" colspan="6"><label field="partyNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="4">社会保障情况</td>
			<td class="FieldLabel" style="width:13%">低保户数：</td>
			<td class="FieldInput" style="width:14%"><label field="lowestSafeguardNum" renderer="reRender"/></td>
			<td class="FieldLabel" style="width:13%">五保户数：</td>
			<td class="FieldInput" style="width:14%"><label field="fiveSafeguardNum" renderer="reRender"/></td>
			<td class="FieldLabel" style="width:13%">残疾人数：</td>
			<td class="FieldInput" style="width:15%"><label field="handicappedNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">三无人员数：</td>
			<td class="FieldInput"><label field="threeNoNum" renderer="peRender"/></td>
			<td class="FieldLabel">优抚对象人数：</td>
			<td class="FieldInput"><label field="preferentialNum" renderer="peRender"/></td>
			<td class="FieldLabel">失业人员数：</td>
			<td class="FieldInput"><label field="loseWorkNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">在社区交纳养老保险人数：</td>
			<td class="FieldInput"><label field="agedInsuranceNum" renderer="peRender"/></td>
			<td class="FieldLabel">离退休人数：</td>
			<td class="FieldInput" colspan="3"><label field="retireNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">返乡大学生人数：</td>
			<td class="FieldInput"><label field="backStudentNum" renderer="peRender"/></td>
			<td class="FieldLabel">未就业大学生人数：</td>
			<td class="FieldInput" colspan="3"><label field="nojobStudentNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="1">社会保障情况</td>
			<td class="FieldLabel">外籍人员人数：</td>
			<td class="FieldInput"><label field="foreignerNum" renderer="peRender"/></td>
			<td class="FieldLabel">归侨归眷人数：</td>
			<td class="FieldInput" colspan="3"><label field="backNum" renderer="peRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="1">特殊人群情况</td>
			<td class="FieldLabel">社区矫正对象人数：</td>
			<td class="FieldInput"><label field="correctNum" renderer="peRender"/></td>
			<td class="FieldLabel">禁毒对象人数：</td>
			<td class="FieldInput"><label field="drugNum" renderer="peRender"/></td>
			<td class="FieldLabel">反邪教重点对象人数：</td>
			<td class="FieldInput"><label field="heresyNum" renderer="peRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
</body>
</html>