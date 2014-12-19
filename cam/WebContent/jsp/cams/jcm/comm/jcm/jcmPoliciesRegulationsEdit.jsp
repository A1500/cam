<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>政策法规表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPoliciesRegulations.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var prId='<%=request.getParameter("prId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPoliciesRegulationsDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPoliciesRegulationsQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPoliciesRegulations"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPoliciesRegulationsDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>政策法规表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="主键" id="prId" field="prId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位主键" id="companyId" field="companyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="文号" id="referenceNum" field="referenceNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">标题：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="标题" id="prTitle" field="prTitle" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">类别：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="类别" id="prType" field="prType" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">内容：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="内容" id="prContent" field="prContent" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="备注" id="prNote" field="prNote" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">政策法律生效日期：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="政策法律生效日期" id="prDate" field="prDate" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">创建时间：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="创建时间" id="prCreateTime" field="prCreateTime" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>