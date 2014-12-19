<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员基础信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="cdcBaseinfoPeople.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var peopleId='<%=request.getParameter("peopleId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcBaseinfoPeopleDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcBaseinfoPeople"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcBaseinfoPeopleDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员基础信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">人员ID：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="人员ID" id="peopleId" field="peopleId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭ID：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="家庭ID" id="familyId" field="familyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">户主关系代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="户主关系代码" id="relationshipType" field="relationshipType" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">所属区、街道：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="所属区、街道" id="domicileCode" field="domicileCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">居住社区：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="居住社区" id="domicileName" field="domicileName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="姓名" id="name" field="name" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">身份证件号码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="身份证件号码" id="idCard" field="idCard" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="性别" id="sex" field="sex" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">出生日期：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="出生日期" id="birthday" field="birthday" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="民族" id="nation" field="nation" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文化程度代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="文化程度代码" id="eduCode" field="eduCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">政治面貌代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="政治面貌代码" id="politicalCode" field="politicalCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="联系电话" id="tel" field="tel" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">住址：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="住址" id="address" field="address" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">邮政编码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="邮政编码" id="postCode" field="postCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">工作单位：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="工作单位" id="workUnit" field="workUnit" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">优抚对象类型：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="优抚对象类型" id="bptType" field="bptType" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">伤残类型：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="伤残类型" id="disabilityFlag" field="disabilityFlag" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">失业标志：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="失业标志" id="unemployedFlag" field="unemployedFlag" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">贫困人员：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="贫困人员" id="povertyType" field="povertyType" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">孤儿标识：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="孤儿标识" id="orphanFlag" field="orphanFlag" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">妇女标识：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="妇女标识" id="womanFlag" field="womanFlag" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">农民工标志：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="农民工标志" id="peasantFlag" field="peasantFlag" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">子女上学问题：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="子女上学问题" id="childrenEducation" field="childrenEducation" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">照片ID：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="照片ID" id="photoId" field="photoId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="备注" id="note" field="note" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>