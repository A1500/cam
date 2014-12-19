<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>居民小组长、楼长信息编辑</title>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="cdcPeopleInfoHeadManEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var peopleId='<%=request.getParameter("peopleId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcPeopleInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleInfo"/>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 职务类型 -->
	<model:dataset id="dutyTypeDataSet" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<!-- 分管工作 -->
	<model:dataset id="jobDataSet" enumName="CDC.JOB.TYPE" autoLoad="true" global="true"/>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>
<next:Panel width="100%"  autoScroll="true" >
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcPeopleInfoDataSet" onsubmit="return false" class="L5form"  >
<fieldset >
	<legend>居民小组长、楼长信息</legend>
	<table width="99%">
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="姓名" id="name" field="name" maxlength="50" style="width:80%"/></td>
			<td class="FieldLabel" style="width:18%">身份证件号码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="身份证件号码" id="idCard" field="idCard" maxlength="18" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:36%"><select name="性别" id="sex" field="sex" style="width:80%"><option dataset = "sexDataSet"> </option> </select></td>
			<td class="FieldLabel" style="width:18%">出生日期：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="出生日期" id="birthday" field="birthday" onclick="LoushangDate(this)" format="Y-m-d" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><select  name="民族" id="nation" field="nation" style="width:35%"><option dataset = "NationDataset"> </option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文化程度：</td>
			<td class="FieldInput" style="width:36%"><select name="文化程度" id="eduCode" field="eduCode" style="width:80%"><option dataset = "educationDataSet"> </option> </select></td>
			<td class="FieldLabel" style="width:18%">政治面貌：</td>
			<td class="FieldInput" style="width:36%"><select name="政治面貌" id="politicalCode" field="politicalCode" style="width:80%"><option dataset = "politicalDataSet"> </option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><input type="text" name="家庭住址" id="address" field="address" maxlength="200" style="width:93%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="联系电话" id="tel" field="tel" maxlength="50" style="width:80%"/></td>
			<td class="FieldLabel" style="width:18%">邮政编码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="邮政编码" id="postCode" field="postCode" maxlength="6" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">个人简历：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><textarea rows="3" field ="resume" style="width:93%"></textarea> </td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><textarea rows="3" field ="note" style="width:93%"></textarea> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>