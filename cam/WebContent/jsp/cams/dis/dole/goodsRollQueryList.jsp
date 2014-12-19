<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>发放明细查询</title>
<next:ScriptManager />
<script type="text/javascript" src="goodsRollQueryList.js"></script>
<script language="javascript">
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
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
		</script>
</head>
<body>
<model:datasets>
<!--批次明细-->
	<model:dataset id="reliefDoleds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		method="queryReliefDole" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!--灾害类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放单位-->
	<model:dataset id="grantTypeDataset" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放方式-->
	<model:dataset id="yesornoDataset"
		enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">单位名称:</td>
				<td class="FieldInput"><input type="text"
					id="requiredOrganName" class="TextEditor" title="所属行政区划"
					style="width: 200" /> <input type="hidden" id="requiredOrganCode"
					class="TextEditor" title="所属行政区划" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>
				<td class="FieldLabel">救助类型:</td>
				<td class="FieldInput"><select type="text" id="reliefType"
					class="TextEditor" title="RELIEF_TYPE" style="width: 160"/>
					<option dataset="ReliefTypeDataset"></option>
				</select></td>
				<td class="FieldLabel">
				<button onclick="query()">查 询</button>
				&nbsp;&nbsp;
				<button onclick="resetClick()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid" width="100%"
	stripeRows="true" clickToSelectedForChkSM="true" height="100%"
	dataset="reliefDoleds">
	<next:TopBar>
		<next:ToolBarItem text="物资发放明细列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detailReq" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="年度" field="YEAR" width="50">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="批次名称" field="BATCH_NAME" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="救助类型" field="RELIEF_TYPE"
			dataset="ReliefTypeDataset" width="155">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="发放单位" field="GRANT_TYPE"
			dataset="grantTypeDataset" width="70">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="填报单位" field="REQUIRED_ORGAN_NAME" width="140">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="填报状态" field="FILL_STATE" width="80"
			dataset="ReliefinfoWorkflowState">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="物资发放数/总发放数(次)" field="DOLE_NUMS" width="140"
			align="right" renderer="doleNumsRenderer">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reliefDoleds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
