<%@ page language="java" contentType="text/html; charset=utf-8"pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<!-- 证书明细表 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupCert.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somCertDataset"></model:dataset>
</model:datasets>
<next:Panel title="证书信息明细">
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel"><label>社会组织名称:</label></td>
				<td class="FieldInput"><input type="text" /><font color="red">*</font></td>
				<td class="FieldLabel"><label>登记证号:</label></td>
				<td class="FieldInput"><input type="text" /><font color="red">*</font></td>
				<td class="FieldLabel"><label>证书类别:</label></td>
				<td class="FieldInput"><select field="">
					<option></option>
				</select></td>

			</tr>
			<tr>
				<td class="FieldLabel"><label>发证机关:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>证书有效期起:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>证书有效期止:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证人:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>发证日期:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>发证原因代码:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>登记管理机关名称:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>领取人:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>领取日期:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>制证人:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>制政时间:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>上缴标志:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>收缴人:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>上缴日期:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
				<td class="FieldLabel"><label>证书状态:</label></td>
				<td class="FieldInput"><input type="text" field="" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因:</label></td>
				<td class="FieldInput"colspan="5"><textarea rows="3" field=""
						cols="160" style="height: 50px; overflow-y: visible"></textarea></td>
			</tr>
			

		</table>
		</form>
	</next:Html>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
</next:Panel>




</body>
</html>