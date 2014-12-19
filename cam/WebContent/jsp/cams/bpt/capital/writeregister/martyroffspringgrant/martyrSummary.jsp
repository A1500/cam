<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
	response.setHeader("Cache-Control",
			"no-store,no-cache,must-revalidate");
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	response.setHeader("Pragma", "no-cache");
%>
<html>
<head>
<title>老烈士(平反)子女生活补助金发放汇总</title>
<next:ScriptManager />
<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			 var organCode = '<%=BspUtil.getOrganCode()%>';
			 var struId='<%=BspUtil.getStruId()%>';
             var organType='<%=BspUtil.getOrganType()%>';
		</script>
<script type="text/javascript" src="../../common/comm.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="martyrSummary.js"></script>
</head>
<body>
<model:datasets>
	<!-- 数据导出Dataset -->
	<model:dataset id="DemobilizedIllExportDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" global="true" method="queryExportData">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalSummaryQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.capital.data.BptCapitalSummary">
			<model:field name="organName" type="string" />
		</model:record>
	</model:dataset>
	<!--发放资金状态标志-->
	<model:dataset id="dsGrantFlag" enumName="GRANT.FLAG" autoLoad="true"></model:dataset>
	<!-- 名册类别代码 -->
	<model:dataset id="dsRegType" enumName="CAPITAL.REGTYPE"
		autoLoad="true"></model:dataset>

</model:datasets>

<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 95%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>

				<td class="FieldLabel">所属机构:</td>
				<td class="FieldInput"><input type="text" id="domicileName"
					class="TextEditor" title="所属机构" onclick="help()" /> <input
					type="hidden" id="domicileCode" class="TextEditor" title="所属机构" /></td>
				<td class="FieldLabel">发放起止日期:</td>
				<td class="FieldInput"><input type="text" id="startYear"
					style="width: 80" title="所属年月" format="Y-m-d" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img
					src="../../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);">-- --<input type="text"
					id="endYear" class="TextEditor" title="所属年月" style="width: 80"
					format="Y-m-d" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img
					src="../../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"></td>

				<td class="FieldLabel">
				<button onclick="query()" id="search">查 询</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptcapitalsummaryGrid" clickToSelectedForChkSM="true"
	width="100%" stripeRows="true" height="100%" dataset="ds"
	notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="登记发放名册" iconCls="add" handler="insert"
			id="insert" />
		<next:ToolBarItem text="修改发放名册" iconCls="edit" handler="update"
			id="update" />
		<next:ToolBarItem text="删除发放名册" iconCls="remove" handler="del" id="delete"/>
		<next:ToolBarItem text="确认发放" iconCls="select" handler="grantConfirm" id="grantConfirm"/>
		<next:ToolBarItem text="查看变更明细" iconCls="detail" handler="changeDetail" id="changeDetail"/>
		<next:ToolBarItem text="查看发放明细" iconCls="view" handler="detail" id="detail"/>
		<next:ToolBarItem text="导出Excel" iconCls="chart" handler="expExcel" id="expExcel"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="registerId" header="名册ID" field="registerId" width="90" hidden="true">
		</next:Column>
		<next:Column id="registerName" header="名册名称" field="registerName" width="170">
		</next:Column>
		<next:Column id="registerType" header="名册类别" field="registerType" width="170" dataset="dsRegType" hidden="true">
		</next:Column>
		<next:Column id="organName" header="发放单位" field="organName" width="80">
		</next:Column>
		<next:Column id="respectiveYears" header="发放年度" field="respectiveYears" width="60" hidden="true">
		</next:Column>
		<next:Column id="startDate" header="开始月份" field="startDate" width="90"></next:Column>
		<next:Column id="endDate" header="结束月份" field="endDate" width="90"></next:Column>
		<next:Column id="grantDate" header="发放日期" field="grantDate" width="80"></next:Column>
		<next:Column id="grantMonSum" header="发放资金总额" field="grantMonSum" renderer="formatNum(this)" width="90" align="right">
		</next:Column>
		<next:Column id="grantFlag" header="发放状态" field="grantFlag" width="60" dataset="dsGrantFlag"></next:Column>
		<next:Column id="grantSureDate" header="发放确认日期" field="grantSureDate" width="80">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="grantConfirmWindow" title="确认发放" width="605"
	height="120" closeAction="hide" modal="true" resizable="true">
	<next:AnchorLayout>
		<next:Panel collapsible="true">
			<next:Html>
				<form id="grantConfirmForm" name="grantConfirmForm" method="post"
					dataset="ds" onsubmit="return false" class="L5form">
				<table border="0" width="98%">
					<tr>
						<td class="FieldLabel" nowrap="nowrap">确认日期:</td>
						<td class="FieldInput"><input type="text" id="grantSureDate"
							name="grantSureDate" field="grantSureDate"
							onclick="LoushangDate(this)" format="Y-m-d" maxlength="10"
							style="width: 80px" /><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap">对账单编号:</td>
						<td class="FieldInput"><input type="text" id="feedbackNumber"
							name="feedbackNumber" field="feedbackNumber" /><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap">发放资金总额:</td>
						<td class="FieldInput"><input type="text" id="grantMonSum"
							name="grantMonSum" field="grantMonSum" style="text-align: right" /><font
							color="red">*</font></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
	<next:Buttons>
		<next:ToolButton text="确认" handler="grantConfirmSave"></next:ToolButton>
		<next:ToolButton text="关闭" handler="grantConfirmClose"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
