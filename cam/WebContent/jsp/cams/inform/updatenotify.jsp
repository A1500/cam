<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>查看通知明细</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="updatenotify.js"></script>
	<script>
		var queryid='<%=request.getParameter("queryid")%>';
		var page='<%=request.getParameter("page")%>';
	</script>
</head>
<style type="text/css">
	.labelClass{
		width: 300px;
		white-space:nowrap;
	}
	.inputClass{
		background:#F6F9FF;
		border:0px;
		white-space:nowrap;
	}
</style>
<body>
<model:datasets>
	<model:dataset id="organ" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" global="true">
		<model:record fromBean="puborgan.dao.PubOrganDao">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
	<model:dataset id="informType" enumName="Inform.Type" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="availableDate" enumName="Available.Date" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:TabPanel name="tabpanel-div" deferredRender="false" height="590" activeTab="0"  title="发件箱">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="发布" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="click_back"></next:ToolBarItem>
	</next:TopBar>
	<next:Tabs>
		<next:Panel title="基本信息" collapsible="false">
			<next:Html>
			<form id="form_content" method="post" onsubmit="return false">
				<table id="table1" border=1 width="100%">
					<tr>
						<td class="FieldLabel">标题：</td>
						<td><input type="text" id="title" size="92" maxlength="38" value=""></td>
					</tr>
					<tr>
						<td class="FieldLabel">通知类型：</td>
						<td><select name="informtype"  id="informtype">
							<option dataset="informType"></option>
						</select></td>
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
					<tr>
					<td class="FieldLabel">已上传附件：</td>
						<td>
						<div id="filename"></div>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">新上传附件</td>
						<td>
							<input   type=button   value="添加"   onclick="add_row()" style="CURSOR: hand">
		         		    &nbsp;<span id="span"></span>
		         		    <table id="table2">	</table>
	           			</td>
           			</tr>
           			<tr>
						<td class="FieldLabel">发送人：</td>
						<td><input type="text" id="sendmanid" size="92" maxlength="38" value="" class="inputClass" readonly="true"></td>
					</tr>
					<tr>
						<td class="FieldLabel">发送单位：</td>
						<td>
							<input type="hidden" id="sendman" value="">
							<input type="text" id="sendmanname" size="92" maxlength="38" value="" class="inputClass" readonly="true">
						</td>
					</tr>
           			<input type="hidden" id="receiveman" name="receiveman">
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