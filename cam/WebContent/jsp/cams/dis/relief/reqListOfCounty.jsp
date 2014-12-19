<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救助需求分析</title>
<next:ScriptManager />
<script type="text/javascript" src="reqListOfCounty.js"></script>
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
	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		method="queryBatchDetail" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--灾害类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<!--填报状态-->
	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE"
		autoLoad="true" global="true">
	</model:dataset>
	<!--发放单位-->
	<model:dataset id="grantTypeDataset" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放方式-->
	<model:dataset id="allocationTypeDataset"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>
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
			</tr>
			<tr>
				<td class="FieldLabel">填报状态:</td>
				<td class="FieldInput"><select id="fillState"
					class="TextEditor" title="fillState" />
					<option value="" selected="selected">请选择……</option>
					<option value="2">已上报</option>
					<option value="3">已提交</option>
					<option value="5">复核上报</option>
					<option value="6">复核提交</option>
				</select></td>
				<td class="FieldLabel" colspan="2">
				<button onclick="query()">查 询</button>
				&nbsp;&nbsp;
				<button onclick="resetClick()">重置</button>
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
	dataset="batchDetailds">
	<next:TopBar>
		<next:ToolBarItem text="救助需求分析列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="分析" iconCls="edit" handler="sumReq" />
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

		<next:Column header="填报单位" field="REQUIRED_ORGAN_NAME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="填报状态" field="FILL_STATE" width="80" renderer="fillStateRenderer">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="填报时间" field="FILL_TIME" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="batchDetailds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
