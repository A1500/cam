<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>上传附件</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="bptuploadfile.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="uploadds" cmd="com.inspur.cams.bpt.bptuploadfile.cmd.BptUploadfileQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptuploadfile.dao.BptUploadfile"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Html>
		<form id="form_content"   dataset="uploadds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
					<tr>
						<td class="FieldLabel">附件标题：</td>
						<td class="FieldInput"><input type="text" id="fileName"   size="92" maxlength="38" name="fileName" ></td>
						<td class="FieldLabel">附件类型：</td>
						<td class="FieldInput"><input type="text" id="fileType"   name="fileType"></td>
					</tr>
					<tr>
						<td class="FieldLabel" >附件描述</td>
						<td class="FieldInput" colspan="3"><textarea
								id="fileMess" name="fileMess"  cols="122%" rows="3" ></textarea></td>
						</tr>
					<tr><td class="FieldLabel">附件上传：</td>
					<td colspan="5" class="FieldInput">
					<input   type=button   value="添加"   onclick="add_row()" style="CURSOR: hand">
         		    &nbsp;<span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
