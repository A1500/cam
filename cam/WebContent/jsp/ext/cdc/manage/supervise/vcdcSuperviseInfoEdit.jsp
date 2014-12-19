<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村民主监督情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcSuperviseInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="superviseDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
	</model:dataset>
	<model:dataset id="superviseInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseInfo"/>
	</model:dataset>
	<model:dataset id="reviewDs" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReviewInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="TimeDataset" enumName="CDC.PUBLISH_CYC" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="typeDataset" enumName="CDC.REVIEW_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="resultDataset" enumName="CDC.REVIEW_RESULT" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="mannerDataset" enumName="CDC.MANNER" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="superviseDataSet" onsubmit="return false" class="L5form">
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
</form>
<form id="form1" method="post" dataset="superviseInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>民主监督情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">村务公开程序</td>
			<td class="FieldLabel" style="width:15%">是否经村委会提出公开方案：</td>
			<td class="FieldInput" style="width:15%"><select name = "是否经村委会提出公开方案"  id="ifPublish" field ="ifPublish"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel" style="width:15%">是否经村务监督委员会<br>审查、补充、完善：</td>
			<td class="FieldInput" style="width:15%"><select name = "是否经村务监督委员会审查、补充、完善"  id="ifAudit" field ="ifAudit"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel" style="width:15%">是否经村党组织和村委会<br>联席会议讨论确定：</td>
			<td class="FieldInput" style="width:15%"><select name = "是否经村党组织和村委会联席会议讨论确定"  id="ifDiscuss" field ="ifDiscuss"><option dataset="YorN"></option></select> <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="2">公开内容</td>
			<td class="FieldLabel">党务公开：</td>
			<td class="FieldInput"><select name="党务公开" id="partCyc" field ="partCyc"><option dataset="TimeDataset"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">政务公开：</td>
			<td class="FieldInput"><select name="政务公开" id="govCyc" field ="govCyc"><option dataset="TimeDataset"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
		<tr>
			<td class="FieldLabel">事务公开：</td>
			<td class="FieldInput"><select name="事务公开" id="affairCyc" field ="affairCyc"><option dataset="TimeDataset"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">财务公开：</td>
			<td class="FieldInput"><select name="财务公开" id="financeCyc" field ="financeCyc"><option dataset="TimeDataset"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="2">公开形式</td>
			<td class="FieldLabel">公开栏：</td>
			<td class="FieldInput"><select name="公开栏" id="formPlacard" field ="formPlacard"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">网络：</td>
			<td class="FieldInput"><select name="网络" id="formWeb" field ="formWeb"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">民主听证会：</td>
			<td class="FieldInput"><select name="民主听证会" id="formMeeting" field ="formMeeting"><option dataset="YorN"></option></select> <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">明白纸：</td>
			<td class="FieldInput"><select name="明白纸" id="formPaper" field ="formPaper"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">其他：</td>
			<td class="FieldInput"><select name="其他" id="formOther" field ="formOther"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="reviewDs" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="被评议人员姓名" width="200" sortable="false"/>
		<next:Column field="peopleType" header="类型" dataset ="typeDataset" width="100" sortable="false"/>
		<next:Column field="reviewDate" header="民主评议时间" width="90" sortable="false"/>
		<next:Column field="manner" header="评议方式" width="90" sortable="false" dataset="mannerDataset"/>
		<next:Column field="meetingShouldNum" header="应到人数" width="90" sortable="false"/>
		<next:Column field="meetingRealNum" header="实到人数" width="90" sortable="false"/>
		<next:Column field="excellentNum" header="优秀票数" width="90" sortable="false"/>
		<next:Column field="competentNum" header="称职票数" width="90" sortable="false"/>
		<next:Column field="uncompetentNum" header="不称职票数" width="90" sortable="false"/>
		<next:Column field="result" header="评议结果" dataset ="resultDataset" width="100" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reviewDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>

<next:Window id="cmWin" title="民主评议" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWin"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="reviewDs" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">类型：</td>
			<td class="FieldInput"><select id="peopleType" field="peopleType"><option dataset="typeDataset"/></select><font color="red">*</font></td>
			<td class="FieldLabel">被评议人员姓名：</td>
			<td class="FieldInput"><input type="text" name="被评议人员姓名" id="name" field="name" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">民主评议时间：</td>
			<td class="FieldInput"><input type="text" name="民主评议时间" id="reviewDate" field="reviewDate" onclick="LoushangDate(this)" format="Y-m-d" style="width:80%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">评议方式：</td>
			<td class="FieldInput"><select id="manner" field="manner"><option dataset="mannerDataset"/></select><font color="red">*</font></td>
			<td class="FieldLabel">应到人数：</td>
			<td class="FieldInput"><input type="text" name="应到人数" id="meetingShouldNum" field="meetingShouldNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">实到人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="实到人数" id="meetingRealNum" field="meetingRealNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:14%">优秀票数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="优秀票数" id="excellentNum" field="excellentNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">称职票数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="称职票数" id="competentNum" field="competentNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:22%">不称职票数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="不称职票数" id="uncompetentNum" field="uncompetentNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">评议结果：</td>
			<td class="FieldInput" colspan="5"><select id="result" field="result"><option dataset="resultDataset"/></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
