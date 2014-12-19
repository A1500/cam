<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>救助任务补录（县级）</title>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var organType = '<%=BspUtil.getOrganType()%>';
	var nowYear = '<%=DateUtil.getYear()%>';
</script>
<script type="text/javascript" src="batch_list.js"></script>
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
		</script>
</head>
<body>
<model:datasets>
	<!--批次-->
	<model:dataset id="batchds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		global="true" pageSize="10" sortField="CREATE_TIME DESC,BATCH_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
			<model:field type="string" name="areaName" />
		</model:record>
	</model:dataset>
	<!--救灾类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放单位-->
	<model:dataset id="grantTypeDataset" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放方式-->
	<model:dataset id="allocationTypeDataset"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0">
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
				<td class="FieldLabel">批次名称:</td>
				<td class="FieldInput"><input type="text" id="batchName"
					class="TextEditor" title="批次名称" /></td>
				<td class="FieldLabel">年度:</td>
				<td class="FieldInput"><input type="text" id="year" name="year"
					title="年度" value="2014" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">救助类型:</td>
				<td class="FieldInput"><select type="text" id="reliefType"
					class="TextEditor" title="救助类型" style="width: 200" />
					<option dataset="ReliefTypeDataset"></option>
				</select></td>
				<td class="FieldLabel">发放单位:</td>
				<td class="FieldInput"><select type="text" id="grantType"
					class="TextEditor" title="发放单位" />
					<option dataset="grantTypeDataset"></option>
				</select></td>
				<td class="FieldLabel">发放方式:</td>
				<td class="FieldInput"><select type="text" id="allocationType"
					class="TextEditor" title="发放方式" />
					<option dataset="allocationTypeDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="6">
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
	dataset="batchds">
	<next:TopBar>
		<next:ToolBarItem text="救助任务信息列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="删除" iconCls="delete" handler="del" />
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="年度" field="year" width="50">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="批次名称" field="batchName" width="155" renderer="batchRenderer">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="救助类型" field="reliefType"
			dataset="ReliefTypeDataset" width="165">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="发放单位" field="grantType"
			dataset="grantTypeDataset" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="发放方式" field="allocationType"
			dataset="allocationTypeDataset" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column header="所需填报单位名称" field="areaName" width="400">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="创建人" field="createPerson" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="创建时间" field="createTime" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="batchds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
