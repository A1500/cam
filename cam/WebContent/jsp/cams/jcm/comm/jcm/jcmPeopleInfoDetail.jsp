<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员基本信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var peopleId='<%=request.getParameter("peopleId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleInfoDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员基本信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员照片ＩＤ：</td>
			<td class="FieldInput" style="width:36%"><label field="photoId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleSex"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">身份证号：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleCard"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">出生年月：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleBirthday"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">政治面貌：</td>
			<td class="FieldInput" style="width:36%"><label field="peoplePolitics"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleNation"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">学历：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleEdu"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">毕业院校：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleSchool"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleAdress"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">参加工作时间：</td>
			<td class="FieldInput" style="width:36%"><label field="jobStartTime"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>