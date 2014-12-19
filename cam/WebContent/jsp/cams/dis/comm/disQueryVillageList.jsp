<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>查询所属行政村（社区）</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="disQueryVillageList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="villageds"
		cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand"
		global="true" pageSize="15" >
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity">
		</model:record>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetVillage" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 100%;height: 10%;" class="L5form">
				<table  border="1" width="100%" height="10%">
					<tr>
						<td class="FieldLabel">街镇:</td>
						<td class="FieldInput">
							<select id="dzZhenquery" onchange="getDzCun()" style="width=200px;">
								<option dataset="DmXzqhDataSetStreet"></option>
							</select>
						</td>	
					
						<td class="FieldLabel">村居:</td>
						<td class="FieldInput">
							<select id="dzCunquery"  style="width=200px;">
								<option dataset="DmXzqhDataSetVillage"></option>
							</select>
						</td>
						<td class="FieldLabel">
							<button onclick="query()">查 询</button>
							&nbsp;&nbsp;
							<button type="reset">重置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="dicctiyGrid" width="100%"
	stripeRows="true" clickToSelectedForChkSM="true"  height="95%"
	dataset="villageds">
	<next:TopBar>
		<next:ToolBarItem text="行政村信息列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="forExcel" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column header="行政村（社区）代码" field="id" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="行政村（社区）名称" field="fullName"  width="400">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="villageds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>