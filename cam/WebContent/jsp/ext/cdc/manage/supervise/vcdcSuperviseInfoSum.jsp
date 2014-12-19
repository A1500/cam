<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主监督汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcSuperviseInfoSum.js"></script>
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
			<model:param name="REPORT_TYPE" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
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
		<next:RowNumberColumn width="45"/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		<next:Column field="publishNum" header="经村委会提出<br>公开方案个数" width="10%" sortable="false" align="center"/>
		<next:Column field="noPublishNum" header="未经村委会提出<br>公开方案个数" width="10%" sortable="false" align="center"/>
		<next:Column field="auditNum" header="经村务监督委员会<br>审查、补充、完善个数" width="10%" sortable="false" align="center"/>
		<next:Column field="noAuditNum" header="未经村务监督委员会<br>审查、补充、完善个数" width="10%" sortable="false" align="center"/>
		<next:Column field="discussNum" header="经村党组织和村委会<br>联席会议讨论确定个数" width="10%" editable="false" sortable="true" align="center"/>
		<next:Column field="noDiscussNum" header="未经村党组织和村委会<br>联席会议讨论确定个数" width="10%" editable="false" sortable="false" align="center"/>
		<next:Column field="partYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="partSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="partMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="partImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="govYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="govSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="govMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="govImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="affairYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="affairSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="affairMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="affairImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="financeYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="financeSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="financeMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="financeImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="placardNum" header="公开栏" width="15%" sortable="false" align="center"/>
		<next:Column field="webNum" header="网络" width="15%" sortable="false" align="center"/>
		<next:Column field="meetingNum" header="民主听证会" width="15%" sortable="false" align="center"/>
		<next:Column field="paperNum" header="明白纸" width="10%" sortable="false" align="center"/>
		<next:Column field="otherNum" header="其他" width="15%" sortable="false" align="center"/>
		<next:Column field="mbNum" header="被评议人数" width="15%" sortable="false" align="center"/>
		<next:Column field="mbExcellentNum" header="优秀人数" width="15%" sortable="false" align="center"/>
		<next:Column field="mbCompetentNum" header="称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="mbUncompetentNum" header="不称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emNum" header="被评议人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emExcellentNum" header="优秀人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emCompetentNum" header="称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emUncompetentNum" header="不称职人数" width="15%" sortable="false" align="center"/>
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
        			  [{header:'',start:2,colspan:1},{header:'村务公开程序',start:3,colspan:6},{header:'公开内容',start:9,colspan:16},{header:'公开形式',start:25,colspan:5},{header:'民主评议',start:30,colspan:8},{header:'',start:38,colspan:3}],
        			  [{header:'',start:2,colspan:1},{header:'',start:3,colspan:6},{header:'党务公开',start:9,colspan:4},{header:'政务公开',start:13,colspan:4},{header:'事务公开',start:17,colspan:4},{header:'财务公开',start:21,colspan:4},{header:'',start:25,colspan:5},{header:'村民委员会成员',start:30,colspan:4},{header:'由村集体承担误工补贴人员',start:34,colspan:4},{header:'',start:38,colspan:3}]
        			  ]
    		})
	</next:ExtendConfig>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="300" modal="true" closeAction="hide" autoScroll="true">
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
			<legend>民主监督情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:20%" rowspan="3" colspan="2">村务公开程序</td>
						<td class="FieldLabel" style="width:25%">经村委会提出公开方案：</td>
						<td class="FieldInput" style="width:15%"><label field ="publishNum" renderer="cRender" /></td>
						<td class="FieldLabel" style="width:25%">未经村委会提出公开方案：</td>
						<td class="FieldInput" style="width:15%"><label field ="noPublishNum" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">经村务监督委员会<br>审查、补充、完善：</td>
						<td class="FieldInput"><label field ="auditNum" renderer="cRender" /></td>
						<td class="FieldLabel">未经村务监督委员会<br>审查、补充、完善：</td>
						<td class="FieldInput"><label field ="noAuditNum" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">经村党组织和村委会<br>联席会议讨论确定：</td>
						<td class="FieldInput"><label field ="discussNum" renderer="cRender" /></td>
						<td class="FieldLabel">未经村党组织和村委会<br>联席会议讨论确定：</td>
						<td class="FieldInput"><label field ="noDiscussNum" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="8">公开内容</td>
						<td class="FieldLabel" rowspan="2">党务公开：</td>
						<td class="FieldLabel">年度：</td>
						<td class="FieldInput"><label field ="partYear" renderer="cRender" /></td>
						<td class="FieldLabel">季度：</td>
						<td class="FieldInput"><label field ="partSeason" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">月度：</td>
						<td class="FieldInput"><label field ="partMonth" renderer="cRender" /></td>
						<td class="FieldLabel">即时：</td>
						<td class="FieldInput"><label field ="partImm" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2">政务公开：</td>
						<td class="FieldLabel">年度：</td>
						<td class="FieldInput"><label field ="govYear" renderer="cRender" /></td>
						<td class="FieldLabel">季度：</td>
						<td class="FieldInput"><label field ="govSeason" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">月度：</td>
						<td class="FieldInput"><label field ="govMonth" renderer="cRender" /></td>
						<td class="FieldLabel">即时：</td>
						<td class="FieldInput"><label field ="govImm" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2">事务公开：</td>
						<td class="FieldLabel">年度：</td>
						<td class="FieldInput"><label field ="affairYear" renderer="cRender" /></td>
						<td class="FieldLabel">季度：</td>
						<td class="FieldInput"><label field ="affairSeason" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">月度：</td>
						<td class="FieldInput"><label field ="affairMonth" renderer="cRender" /></td>
						<td class="FieldLabel">即时：</td>
						<td class="FieldInput"><label field ="affairImm" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2">财务公开：</td>
						<td class="FieldLabel">年度：</td>
						<td class="FieldInput"><label field ="financeYear" renderer="cRender" /></td>
						<td class="FieldLabel">季度：</td>
						<td class="FieldInput"><label field ="financeSeason" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">月度：</td>
						<td class="FieldInput"><label field ="financeMonth" renderer="cRender" /></td>
						<td class="FieldLabel">即时：</td>
						<td class="FieldInput"><label field ="financeImm" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="3" colspan="2">公开形式</td>
						<td class="FieldLabel">公开栏：</td>
						<td class="FieldInput"><label field ="placardNum" renderer="cRender" /></td>
						<td class="FieldLabel">网络：</td>
						<td class="FieldInput"><label field ="webNum" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">民主听证会：</td>
						<td class="FieldInput"><label field ="meetingNum" renderer="cRender" /></td>
						<td class="FieldLabel">明白纸：</td>
						<td class="FieldInput"><label field ="paperNum" renderer="cRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">其他：</td>
						<td class="FieldInput"><label field ="otherNum" renderer="cRender" /></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="4">民主评议</td>
						<td class="FieldLabel" rowspan="2">村民委员会成员：</td>
						<td class="FieldLabel">评议人数：</td>
						<td class="FieldInput"><label field ="mbNum" renderer="pRender" /></td>
						<td class="FieldLabel">优秀人数：</td>
						<td class="FieldInput"><label field ="mbExcellentNum" renderer="pRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">称职人数：</td>
						<td class="FieldInput"><label field ="mbCompetentNum" renderer="pRender" /></td>
						<td class="FieldLabel">不称职人数</td>
						<td class="FieldInput"><label field ="mbUncompetentNum" renderer="pRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2">由村集体承担<br>误工补贴人员：</td>
						<td class="FieldLabel">评议人数：</td>
						<td class="FieldInput"><label field ="emNum" renderer="pRender" /></td>
						<td class="FieldLabel">优秀人数：</td>
						<td class="FieldInput"><label field ="emExcellentNum" renderer="pRender" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">称职人数：</td>
						<td class="FieldInput"><label field ="emCompetentNum" renderer="pRender" /></td>
						<td class="FieldLabel">不称职人数</td>
						<td class="FieldInput"><label field ="emUncompetentNum" renderer="pRender" /></td>
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