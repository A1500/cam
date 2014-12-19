<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员基本信息编辑</title>
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
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员基本信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="主键" id="peopleId" field="peopleId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位主键" id="companyId" field="companyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员照片ＩＤ：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员照片ＩＤ" id="photoId" field="photoId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="姓名" id="peopleName" field="peopleName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="性别" id="peopleSex" field="peopleSex" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">身份证号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="身份证号" id="peopleCard" field="peopleCard" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">出生年月：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="出生年月" id="peopleBirthday" field="peopleBirthday" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">政治面貌：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="政治面貌" id="peoplePolitics" field="peoplePolitics" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="民族" id="peopleNation" field="peopleNation" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">学历：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="学历" id="peopleEdu" field="peopleEdu" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">毕业院校：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="毕业院校" id="peopleSchool" field="peopleSchool" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="家庭住址" id="peopleAdress" field="peopleAdress" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">参加工作时间：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="参加工作时间" id="jobStartTime" field="jobStartTime" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>