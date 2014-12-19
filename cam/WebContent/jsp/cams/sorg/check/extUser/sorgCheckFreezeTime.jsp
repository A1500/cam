<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>社会组织年检冻结账号时间配置列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="sorgCheckFreezeTime.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.SorgCheckFreezeTimeQueryCmd" global="true" sortField="FREEZE_YEAR">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.SorgCheckFreezeTime"></model:record>
	</model:dataset>

	<model:dataset id="newDataset" cmd="com.inspur.cams.comm.extuser.cmd.SorgCheckFreezeTimeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.SorgCheckFreezeTime">
				<model:field name="freezeSorgType" type="string" rule="require" />
				<model:field name="freezeDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件</legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">社会组织类型</td>
								<td class="FieldInput">
									<select name="社会组织类型" id="freezeSorgType" blank="false">
										<option value ="">请选择...</option>
										<option value ="ST">社会团体</option>
										<option value ="MF">民办非企业</option>
										<option value ="JJ">基金会</option>
									</select></td>
								<td class="FieldLabel">冻结年份</td>
								<td class="FieldInput"><input type="text" id="freezeYear" title="冻结年份"  /></td>
								<td class="FieldButton"><button onclick="query()">查询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="comextuserGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="社会组织外网用户维护列表" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="新增" iconCls="add" handler="addFreeze"/>
		<next:ToolBarItem text="修改" iconCls="edit" handler="changeFreeze"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="deleteFreeze"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column   header="社会组织类型" field="freezeSorgType" width="90" renderer="detailHref">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column  header="冻结年份" field="freezeYear" width="250" >
			<next:TextField  />
		</next:Column>

		<next:Column  header="冻结日期" field="freezeDate" width="250" >
			<next:TextField allowBlank="false" />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>


<next:Window id="window" closeAction="hide" title="社会组织年检冻结账号时间配置" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="社会组织年检冻结账号时间配置"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="submit" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form style="width: 95%; height: 100%;" class="L5form" dataset="newDataset">
		<table  border="1" width="100%" >
			<tr >
				<td class="FieldLabel">社会组织类型</td>
				<td class="FieldInput">
					<select name="社会组织类型" field="freezeSorgType" blank="false">
						<option value ="">请选择...</option>
						<option value ="ST">社会团体</option>
						<option value ="MF">民办非企业</option>
						<option value ="JJ">基金会</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">冻结日期</td>
				<td class="FieldInput"><input type="text" field="freezeDate" format="Y-m-d" onclick="WdatePicker();" title="冻结日期"  /></td>
			</tr>
		</table>
	</form>
	</next:Html>
</next:Window>
</body>
</html>
