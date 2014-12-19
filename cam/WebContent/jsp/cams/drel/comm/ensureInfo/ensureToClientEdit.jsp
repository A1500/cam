<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>核查业务反馈表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ensureToClient.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var ensureId='<%=request.getParameter("ensureId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ensureToClientDataSet" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.ensureInfo.data.EnsureToClient"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="ensureToClientDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>核查业务反馈表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">业务主键：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="业务主键" id="ensureId" field="ensureId" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">历史信息主键：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="历史信息主键" id="historyInfoId" field="historyInfoId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">委托业务：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="委托业务" id="applyId" field="applyId" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">核查业务：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="核查业务" id="commissionId" field="commissionId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">接收单位主键：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="接收单位主键" id="acceptUnitId" field="acceptUnitId" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">接收单位：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="接收单位" id="acceptUnit" field="acceptUnit" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">所属行政区划代码：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="所属行政区划代码" id="areaCode" field="areaCode" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">所属行政区划名称：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="所属行政区划名称" id="areaName" field="areaName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">户主姓名：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="户主姓名" id="familyName" field="familyName" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">户主身份证号：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="户主身份证号" id="familyIdCard" field="familyIdCard" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">核查单位主键：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="核查单位主键" id="ensureUnitId" field="ensureUnitId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">核查单位：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="核查单位" id="ensureUnit" field="ensureUnit" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">核查收入：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="核查收入" id="ensureIncome" field="ensureIncome" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">核查支出：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="核查支出" id="ensureExpend" field="ensureExpend" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">核查财产：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="核查财产" id="ensureProperty" field="ensureProperty" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">反馈时间：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="反馈时间" id="feedbackTime" field="feedbackTime" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">反馈结果：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="反馈结果" id="feedbackResult" field="feedbackResult" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">查看标示：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="查看标示" id="readStatus" field="readStatus" maxlength="50" style="width:90%"/></td>
			<td class="FieldLabel" style="width:18%">导入导出标识：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="导入导出标识" id="inOutStatus" field="inOutStatus" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">当前标识：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="当前标识" id="currentStatus" field="currentStatus" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>