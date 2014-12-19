<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新建通知</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="addnotify.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="informType" enumName="Inform.Type" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="availableDate" enumName="Available.Date" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:TabPanel name="tabpanel-div" deferredRender="false" height="590" activeTab="0"  title="发件箱">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="发布" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>

	</next:TopBar>
	<next:Tabs>
		<next:Panel title="基本信息" collapsible="false">
			<next:Html>
			<form id="form_content" method="post" onsubmit="return false" class="L5form">
				<table id="table1" border=1 width="100%">
					<tr>
						<td class="FieldLabel">标题：</td>
						<td ><input type="text" id="title" size="1000" maxlength="10000" value="" width="100000" style="width: 300px">
							 <input id="informtype" name="informtype" value="bulletin" type="hidden">
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">接收单位：</td>
						<td>

						<textarea id="NAME" name="receivemanview"	rows="5" cols="92" readonly="readonly">
				  		 </textarea>

						<input type="button" name="selectdept" value="选择部门" onclick="selectUser()" style="CURSOR: hand">
						<input type="hidden"  id="CODE" class="TextEditor"/>

						</td>
					</tr>
					<tr style="display:none">
						<td class="FieldLabel">有效时限：</td>
						<td><select name="validdaynum"  id="validdaynum" >
							<option dataset="availableDate" ></option>
						</select></td>
					</tr>
					<tr><td class="FieldLabel">附件</td>
					<td>
					<input   type=button   value="添加"   onclick="add_row()" style="CURSOR: hand">
         		    &nbsp;<span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
				</table>

				</form>
			</next:Html>
		</next:Panel>
		<next:Panel id="content" title="正文" closable="false">
				<next:Html>
					<div id="htmledit" />
				</next:Html>
		</next:Panel>
	</next:Tabs>

</next:TabPanel>
</body>
</html>
