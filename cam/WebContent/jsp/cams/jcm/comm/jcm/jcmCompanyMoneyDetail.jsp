<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>工作经费信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyMoney.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var companyMoneyId='<%=request.getParameter("companyMoneyId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyMoneyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyMoneyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyMoney"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmCompanyMoneyDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>工作经费信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">工作经费主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyMoneyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">工作经费类别：</td>
			<td class="FieldInput" style="width:36%"><label field="moneyType"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">工作经费金额：</td>
			<td class="FieldInput" style="width:36%"><label field="moneyCost"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldInput" style="width:36%"><label field="note"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>