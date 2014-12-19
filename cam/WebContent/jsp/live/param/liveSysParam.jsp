<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>消息平台系统参数配置</title>
<next:ScriptManager/>
<script type="text/javascript" src="liveSysParam.js"></script>
<model:datasets>
	<model:dataset id="parmStat" enumName="PARM.STAT" autoLoad="true"></model:dataset>
	<model:dataset id="sysParamDs" cmd="org.loushang.live.param.cmd.LiveParmsQueryCommand" method="queryParams" autoLoad="true" global="true" pageSize="10">
		<model:record fromBean="org.loushang.live.param.dao.LiveParamsView"></model:record>
		<model:params>
			<model:param name="parmLevel" value="S"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="msgTypeDs" cmd="org.loushang.live.engine.view.MessageQueryCmd" method="queryDeliveryMode" autoLoad="true">
		<model:record>
			<model:field name="text" mapping="deliveryName" type="string"/>
			<model:field name="value" mapping="deliveryMode" type="string"/>	
		</model:record>
	</model:dataset>
</model:datasets>

</head>
<body>
<next:Panel frame="false" width="100%" height="75">
<next:Html>
	<form onsubmit="return false;" name="paramQueryForm" class="L5form">
		<fieldset class="GroupBox">
		<legend>系统参数查询</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel">
					<label>参数代码</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="sysParmCode" name="sysParmCode" style="width: 150px"/>
				</td>
				<td class="FieldLabel">
					<label>参数描述</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="sysParmName" name="sysParmName" style="width: 150px"/>
				</td>				
				<td class="FieldLabel" colspan="2" style="text-align: center;">
					<button onclick="querySysParam()">查询</button>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
</next:Html>
</next:Panel>
<next:EditGridPanel dataset="sysParamDs" id="sysParamGrid" name="paramGrid" width="100%" height="300">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="add" text="新增" handler="sysWndShow"/>
		<next:ToolBarItem  iconCls="save" text="保存" handler="saveSysParam"/>
		<next:ToolBarItem  iconCls="undo" text="撤销" handler="undoSysParam"/>				
		<next:ToolBarItem  iconCls="remove" text="删除" handler="delSysParam"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column field="parmId"  header="id" hidden="true"/>
		<next:Column field="parmCode"  header="代码" width="150" sortable="true">
			<next:TextField allowBlank="true"></next:TextField>
		</next:Column>
		<next:Column field="parmName"  header="描述" width="200">
			<next:TextField allowBlank="true"></next:TextField>
		</next:Column>
		<next:Column field="parmLevel"  header="参数级别" width="100" hidden="true">
			<next:TextField allowBlank="true"></next:TextField>
		</next:Column>
		<next:Column field="parmValue" header="值" width="350">
			<next:TextField allowBlank="true"></next:TextField>
		</next:Column>
		<next:Column field="stat" header="使用状态">
			<next:ComboBox dataset="parmStat" triggerAction="all" valueField="value" displayField="text"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="sysParamDs"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="paramWnd" title="系统参数配置" closeAction="hide" closable="true" resizable="false" width="450">
<next:Html>
	<form onsubmit="return false;" name="paramForm" class="L5form">
		<fieldset style="width: 100%;">
		<legend>系统参数配置</legend>
		<table width="100%">
			<tr height="20px">
				<td class="FieldLabel">
					<label>参数代码</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="parmCode" name="parmCode" style="width: 150px"/>
					<span style="color:red;">*除中文,全角,"#","'",与"="</span>
				</td>
			</tr>
			<tr height="20px">
				<td class="FieldLabel">
					<label>参数描述</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="parmName" name="parmName" style="width: 150px"/>
					<span style="color:red;">* 参数的作用说明</span>
				</td>				
			</tr>
			<tr height="20px">
				<td class="FieldLabel">
					<label>参数值</label>：
				</td>
				<td class="FieldInput">
					<input type="text" id="parmValue" name="parmValue" style="width: 150px"/>
					<span style="color:red;">*</span>
				</td>				
			</tr>
			<!--<tr height="20px">
				<td class="FieldLabel">
					<label>消息类别</label>：
				</td>
				<td class="FieldInput">
					<select id="deliveryMode">
						<option dataset="msgTypeDs"></option>
					</select>
					<span style="color:red;">为空表示全部类型</span>
				</td>				
			</tr>
			-->
			<tr height="20px" align="center">
				<td class="FiledButton" colspan="2">
					<button onclick="addParam()">确定</button>
					&nbsp;&nbsp;&nbsp;
					<button onclick="resetParamForm()">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
	</form>
</next:Html>
</next:Window>

<script type="text/javascript">

</script>
</body>
</html>