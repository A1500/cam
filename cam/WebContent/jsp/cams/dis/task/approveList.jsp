<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>待办任务列表</title>
<next:ScriptManager />
<script type="text/javascript" src="approveList.js"></script>
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
	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand"
		method="queryBatchDetail" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>

	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE"
		autoLoad="true" global="true">
	</model:dataset>
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

				<td class="FieldLabel">填报单位:</td>
				<td class="FieldInput"><input type="text"
					id="requiredOrganName" class="TextEditor" title="所属行政区划"
					style="width: 200" /> <input type="hidden" id="requiredOrganCode"
					class="TextEditor" title="所属行政区划" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>
				<td class="FieldLabel">救助类型:</td>
				<td class="FieldInput"><select type="text" id="reliefType"
					class="TextEditor" title="RELIEF_TYPE" />
					<option dataset="ReliefTypeDataset"></option>
				</select></td>
				<td class="FieldLabel">填报状态:</td>
				<td class="FieldInput"><select type="text" id="fillState"
					class="TextEditor" title="fillState" />
					<option value="">请选择....</option>
					<option value="2">填报完成</option>
					<option value="3">已审批</option>
				</select></td>
				<td class="FieldLabel">
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
		<next:ToolBarItem text="待办任务列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="办理" iconCls="edit" handler="deal" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column header="年度" field="YEAR" width="50">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="批次名称" field="BATCH_NAME" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="救助类型" field="RELIEF_TYPE"
			dataset="ReliefTypeDataset" width="165">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column header="填报单位" field="REQUIRED_ORGAN_NAME" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="填报状态" field="FILL_STATE" dataset="fillstateDs"
			width="100">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="填报人" field="FILL_PEOPLE" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="填报时间" field="FILL_TIME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="batchDetailds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
