
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>辅导员明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmfdy_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmFdyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmFdy"></model:record>
		<model:params>
			<model:param name="FDY_ID" value='<%=request.getParameter("fdyId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 学历 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 人员来源 -->
	<model:dataset id="RylyDataset" enumName="MRM.RYCODE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 专业 -->
	<model:dataset id="zyDataset" enumName="MRM.ZY.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 专业资格证 -->
	<model:dataset id="zyzgzDataset" enumName="MRM.ZYZGZ.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  title="辅导员信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete"  text="关闭" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		<input type="hidden" id="organId" name="organId" field="organId"/>
			<input type="hidden" id="fdyId" name="fdyId" field="fdyId"/> 
	   	
	   		<tr>
				<td  class="FieldLabel" >姓名</td>
				<td class="FieldInput"><label name="name" field="name"  /></td>
			
				<td  class="FieldLabel" >性别</td>
				<td class="FieldInput">
				<label name="xb" id="xb" field="xb"  dataset="SexDataset" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >出生日期</td>
				<td class="FieldInput">
				<label name="nl" field="nl" format="Y-m-d"  /> </td>
				<td  class="FieldLabel" >学历</td>
				<td class="FieldInput">
				<label name="hyzk" id="hyzk" field="hyzk"  dataset="EducationDataset" /></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >专业</td>
				<td class="FieldInput">
		    	<label name="zy" id="zy" field="zy" dataset="zyDataset" /></td>
					<td  class="FieldLabel" >职称</td>
		    	<td class="FieldInput"><label name="zc" field="zc"  /></td>	
			</tr>
			<tr>
				<td  class="FieldLabel" >专业资格证</td>
				<td class="FieldInput">
				<label name="zyzgz" id="zyzgz" field="zyzgz"  dataset="zyzgzDataset" /></td>
			
				<td  class="FieldLabel" >工作单位</td>
				<td class="FieldInput">
				<label name="organwork" field="organwork"  /></td>	
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >人员来源</td>
				<td class="FieldInput" colspan="3">
				<label name="ryly" id="ryly" field="ryly"  dataset="RylyDataset" /></td>
			</tr>
			<tr id="otherCase" style="display:none">
			<td  class="FieldLabel">其他情况</td>
			<td class="FieldInput"  colspan="3"><label name="qtqk" field="qtqk"  style="width:700px"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >辅导安排</td>
				<td class="FieldInput" colspan="3">
			         <label name="bz" field="bz" /> 
				 </td>
			</tr>
				<tr>
				<td  class="FieldLabel" >工作开始时间</td>
				<td class="FieldInput">
				<label name="workbegintime" field="workbegintime" format="Y-m-d"  /></td>
				<td  class="FieldLabel" >工作结束时间</td>
				<td class="FieldInput">
				<label name="workendtime" field="workendtime" format="Y-m-d"  /></td>
			</tr>		
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
