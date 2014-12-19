<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<title>赡（抚、扶）养义务人员信息</title>

<next:ScriptManager/>
<script type="text/javascript" src="supportInfo.js"></script>
<script type="text/javascript">
		<%
		String method=request.getParameter("method");//新增还是修改
		String supportId=request.getParameter("supportId");//业务主键
		String familyId=request.getParameter("familyId");//业务主键
		String disabled="";
		if("UPDATE".equals(method)){
			 disabled="disabled";
		}
		
		%>
		var method='<%=method%>' ;
		var supportId='<%=supportId%>';
		var familyId='<%=familyId%>' ;
</script>
</head>
<body>
<model:datasets>
	<!-- 赡（抚、扶）养义务人员信息 -->
	<!-- 赡养人信息 -->
	<model:dataset id="lowSupportDataset" cmd="com.inspur.cams.drel.application.cityLow.cmd.SamLowSupportPeopleQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople"></model:record>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="assistanceTypeCode" value='01'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况 -->
	<model:dataset id="employmentDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	

</model:datasets>
<next:Panel title="赡养(抚养、义务)人情况" width="850"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmSupport"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeSupport"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset="lowSupportDataset">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名</td>
				<td class="FieldInput" style="width: 35%"><input type='text' field="supportName" title="姓名" id="supportName"/> <font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">身份证号</td>
				<td class="FieldInput" style="width: 35%">
				<input type='text' id="supportCardNo" field="supportCardNo" title="身份证号" maxlength="18"  style="width:80%" onblur="checkCardNo(this)"/> <font color="red">*</font></td>
						
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">与户主关系</td>
				<td class="FieldInput" style="width: 35%">
				<select title="与户主的关系" name="releationType" field="releationType" id="releationType" >
					<option dataset="relationshipTypeDataset"></option>
				</select>
				<font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 15%">家庭人口数</td>
				<td class="FieldInput" style="width: 35%">
				<input type='text' id="supportFamilyNum" field="supportFamilyNum" 
				onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false" 
				 title="赡养人家庭人口数" onchange="getave()" /><font color="red">*</font></td>
				
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">职业状况</td>
				<td class="FieldInput" style="width: 35%">
				<select name="employmentCode" title="职业状况"  field="occupationCondition" <%=disabled %>>
					<option dataset="employmentDataset"></option>
				</select>
				<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 35%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">月总收入（元）</td>
				<td class="FieldInput" style="width: 35%">
				<input type='text'field="monthIncome" id="monthIncome" title="月总收入（元）" 
				onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false" 
				onchange="getave() " /><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%">月人均收入（元）</td>
				<td class="FieldInput" style="width: 35%"><input type='text'field="monthAveIncome" id="monthAveIncome" readonly="readonly" title="月人均收入（元）" /><font color="red">*</font></td>
			</tr>
				
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
