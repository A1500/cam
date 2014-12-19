<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员工作单位信息（多条记录过程）明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleCompany.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var peopleCompanyId='<%=request.getParameter("peopleCompanyId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleCompanyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleCompanyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleCompany"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleCompanyDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员工作单位信息（多条记录过程）</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">人员工作单位主键：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleCompanyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员主键：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">部门：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleDepartment"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">职务：</td>
			<td class="FieldInput" style="width:36%"><label field="companyDuty"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">职称：</td>
			<td class="FieldInput" style="width:36%"><label field="jobTitle"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">房间号：</td>
			<td class="FieldInput" style="width:36%"><label field="roomsNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员编制性质：</td>
			<td class="FieldInput" style="width:36%"><label field="establishment"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职时间：</td>
			<td class="FieldInput" style="width:36%"><label field="dutyTime"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">岗位状态：</td>
			<td class="FieldInput" style="width:36%"><label field="jobStatus"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">手机：</td>
			<td class="FieldInput" style="width:36%"><label field="molible"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><label field="phone"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">专业资格：</td>
			<td class="FieldInput" style="width:36%"><label field="qualification"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">奖惩记录：</td>
			<td class="FieldInput" style="width:36%"><label field="rpRecord"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更时间：</td>
			<td class="FieldInput" style="width:36%"><label field="changeTime"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职文号：</td>
			<td class="FieldInput" style="width:36%"><label field="dutyNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职状态：</td>
			<td class="FieldInput" style="width:36%"><label field="dutyStatus"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员所属部门：</td>
			<td class="FieldInput" style="width:36%"><label field="dutySection"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>