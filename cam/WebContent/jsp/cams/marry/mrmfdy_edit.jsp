
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>辅导员编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmfdy_edit.js"></script>
			<script type="text/javascript" src="../bpt/comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmFdyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmFdy">
			<model:field name="workbegintime"/> 
			<model:field name="workendtime"/>
		</model:record>
		
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
    <!-- 职务 -->
	<model:dataset id="zwDataset" enumName="MRM.ZW.TYPE" autoLoad="true" global="true"></model:dataset>
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
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="辅导员信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="delete"  text="关闭" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		<input type="hidden" id="organId" name="organId" field="organId"/>
			<input type="hidden" id="fdyId" name="fdyId" field="fdyId"/> 
	   	
	   		<tr>
				<td  class="FieldLabel" >姓名</td>
				<td class="FieldInput"><input type="text" name="name" field="name"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >性别</td>
				<td class="FieldInput">
				<select name="xb" id="xb" field="xb"><option dataset="SexDataset"/></select><font color="red">*</font> 
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >出生日期</td>
				<td class="FieldInput">
				<input type="text" name="nl" field="nl" format="Y-m-d"  /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
				<td  class="FieldLabel" >学历</td>
				<td class="FieldInput">
				<select name="hyzk" id="hyzk" field="hyzk"><option dataset="EducationDataset"/></select></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >专业</td>
				<td class="FieldInput">
		    	<select name="zy" id="zy" field="zy"><option dataset="zyDataset"/></select></td>
					<td  class="FieldLabel" >职称</td>
		    	<td class="FieldInput"><input type="text" name="zc" field="zc"  /></td>	
			</tr>
			<tr>
				<td  class="FieldLabel" >政治面貌：</td>
				<td class="FieldInput">
				<select id="politics" name="political" field="political" >
					<option  dataset="PoliticalDataset" />
				</select>
				</td>
					<td  class="FieldLabel" >职务：</td>
				<td class="FieldInput">
					<select name="zw" field="zw" >
					<option dataset="zwDataset" />
				</select>
				 </td>
				 </tr>
			<tr>
				<td  class="FieldLabel" >专业资格证</td>
				<td class="FieldInput">
			<select name="zyzgz" id="zyzgz" field="zyzgz"><option dataset="zyzgzDataset"/></select></td>
			
				<td  class="FieldLabel" >工作单位</td>
				<td class="FieldInput">
				<input type="text" name="organwork" field="organwork"  /></td>	
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >人员来源</td>
				<td class="FieldInput" colspan="3">
				<select name="ryly" id="ryly" field="ryly" onchange="otherCase(this.value)"><option dataset="RylyDataset"/></select></td>
			</tr>
			<tr id="otherCase" style="display:none">
			<td  class="FieldLabel">其他情况</td>
			<td class="FieldInput"  colspan="3"><input type="text" name="qtqk" field="qtqk"  style="width:700px"/> <font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >辅导安排</td>
				<td class="FieldInput" colspan="3">
			                                    	<textarea rows="2" cols="130" name="bz" field="bz" ></textarea> 
				 </td>
			</tr>
				<tr>
				<td  class="FieldLabel" >工作开始时间</td>
				<td class="FieldInput">
				<input type="text" name="workbegintime" field="workbegintime" format="Y-m-d"  /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
				<td  class="FieldLabel" >工作结束时间</td>
				<td class="FieldInput">
				<input type="text" name="workendtime" field="workendtime" format="Y-m-d"  /><img  src="../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
			</tr>		
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
