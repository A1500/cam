<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>供养对象信息表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samEditInGero.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var personId='<%=request.getParameter("personId")%>';
	var gerocomiumName='<%=request.getParameter("gerocomiumName")%>';
	<%
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
	%>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="samGeroKeptPersonDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson"/>
	</model:dataset>
	<!-- yes or no -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="nation" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 出院原因 -->
	<model:dataset id="reason" enumName="SAM_REASON"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="samGeroKeptPersonDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>供养对象入院信息表</legend>
	<table width="99%">
		<tr>
			<td class="FieldLabel" style="width:15%">敬老院：</td>
			<td class="FieldInput" style="width:18%">
			<input type="text" name="敬老院" id="gerocomiumName" disabled="disabled" maxlength="50" style="width:90%"/>
			<label type="text" name="敬老院ID" id="gerocomiumId" field="gerocomiumId" maxlength="50" style="display: none"/></td>
			
			<td class="FieldLabel" style="width:15%">姓名：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="姓名" id="personName" field="personName" maxlength="50" style="width:90%"/></td>
			
			<td class="FieldLabel" style="width:15%">性别：</td>
			<td class="FieldInput" style="width:18%"><select field="sex" disabled="disabled" style="width: 80%">
			<option dataset="sex"></option></select></td>
		</tr>
		
		<tr>
			<td class="FieldLabel" style="width:15%">身份证号：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="身份证号" id="idCard" field="idCard" maxlength="50" style="width:90%"/></td>
		
			<td class="FieldLabel" style="width:15%">出生日期：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="出生日期" id="birthday" field="birthday" maxlength="50" style="width:90%"/></td>
		
			<td class="FieldLabel" style="width:15%">民族：</td>
			<td class="FieldInput" style="width:18%"><select field="nation" disabled="disabled" style="width: 80%">
			<option dataset="nation"></option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">政治面貌：</td>
			<td class="FieldInput" style="width:18%"><select field="politicsStatus" disabled="disabled" style="width: 80%">
			<option dataset="DmZzmmDataSet" ></option> </select></td>
		
			<td class="FieldLabel" style="width:15%">家庭住址：</td>
			<td class="FieldInput" style="width:18%" colspan="3"><label type="text" name="家庭住址" id="familyAdd" field="familyAdd" maxlength="50"  style="width:90%"/></td>
		
			<!--  <td class="FieldLabel" style="width:15%">照片：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="照片" id="photoId" field="photoId" maxlength="50" style="width:90%"/></td>
			-->
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">是否已建健康档案：</td>
			<td class="FieldInput" style="width:18%"><select id="ifArchive" disabled="disabled" field="ifArchive" style="width:90%">
			<option  dataset="comm_yesorno"></option> </select></td>
		
			<td class="FieldLabel" style="width:15%">所在房间：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="所在房间" id="inRoom" field="inRoom" maxlength="50" style="width:90%"/></td>
		
			<td class="FieldLabel" style="width:15%">所用床位：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="所用床位" id="inBed" field="inBed" maxlength="50" style="width:90%"/></td>
		</tr>
		
		<tr>
			<td class="FieldLabel" style="width:15%">入院时间：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="入/出院时间" id="inoutDate" field="inoutDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" maxlength="50" style="width:90%"/></td>
		
			<td class="FieldLabel" style="width:15%">经办人：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="经办人" id="updatePerson" field="updatePerson" maxlength="50" style="width:90%"/></td>
		
			<td class="FieldLabel" style="width:15%"></td>
			<td class="FieldInput" style="width:18%"></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>