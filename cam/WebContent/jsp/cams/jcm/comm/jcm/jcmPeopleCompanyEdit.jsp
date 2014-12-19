<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员工作单位信息（多条记录过程）编辑</title>
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
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleCompanyDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员工作单位信息（多条记录过程）</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">人员工作单位主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员工作单位主键" id="peopleCompanyId" field="peopleCompanyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员主键" id="peopleId" field="peopleId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位主键" id="companyId" field="companyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">部门：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="部门" id="peopleDepartment" field="peopleDepartment" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">职务：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="职务" id="companyDuty" field="companyDuty" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">职称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="职称" id="jobTitle" field="jobTitle" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">房间号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="房间号" id="roomsNum" field="roomsNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员编制性质：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员编制性质" id="establishment" field="establishment" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职时间：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="任职时间" id="dutyTime" field="dutyTime" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">岗位状态：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="岗位状态" id="jobStatus" field="jobStatus" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">手机：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="手机" id="molible" field="molible" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="联系电话" id="phone" field="phone" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">专业资格：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="专业资格" id="qualification" field="qualification" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">奖惩记录：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="奖惩记录" id="rpRecord" field="rpRecord" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更时间：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="变更时间" id="changeTime" field="changeTime" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职文号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="任职文号" id="dutyNum" field="dutyNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职状态：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="任职状态" id="dutyStatus" field="dutyStatus" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员所属部门：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员所属部门" id="dutySection" field="dutySection" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>