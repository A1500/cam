
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>登记机关信息表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrm_organ_edit.js"></script>
	</head>
<body>
<model:datasets>
 	 <model:dataset id="bztypesDs" enumName="MRM.FORMATION.NATURE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="sslevelDs" enumName="MRM.LEVEL.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="monitorDs" enumName="MRM.MONITOR.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="validDs" enumName="MRM.VALIDFLAG" autoLoad="true" pageSize="-1"></model:dataset>
	 <!-- 等级 -->
	<model:dataset id="EvaluLevelDataset" enumName="MRM.EVALULEVEL.TYPE" autoLoad="true" global="true"></model:dataset>
	 
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
			<model:field name="forAreaCode"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel  title=""  width="100%" id="baseTabPanel">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="等级评定申报" handler="levelApply"/>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >登记机关代码</td>
				<td class="FieldInput"><label field="deptCode"></label>  </td>
				<td  class="FieldLabel" >名称</td>
				<td class="FieldInput"  colspan="3"> <label field="name" style="width: 408px"></label> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >地址</td>
				<td class="FieldInput" colspan="5"><input type="text" name="地址" field="deptAddress"  style="width: 670px"/>  <font color="red">*</font></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >邮编</td>
				<td class="FieldInput"><input type="text" name="邮编" field="deptPost"  />  <font color="red">*</font></td>
				<td  class="FieldLabel" >服务电话</td>
				<td class="FieldInput"><input type="text" name="服务电话" field="deptTel" /> <font color="red">*</font> </td>
				<td  class="FieldLabel" >传真电话</td>
				<td class="FieldInput"><input type="text" name="传真电话" field="deptFax" /> </td>
			</tr>
			<tr>	
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><input type="text" name="负责人" field="modifyId"  /> <font color="red">*</font></td>
				<td  class="FieldLabel" >手机</td>
				<td class="FieldInput"><input type="text" name="手机" field="complainTel"  /> <font color="red">*</font></td>
				<td  class="FieldLabel" >电子邮箱</td>
				<td class="FieldInput"><input type="text" name="电子邮箱" field="officeEmail"  /> <font color="red">*</font> </td>
			</tr>
			<tr>	
				<td  class="FieldLabel" >编制性质</td>
				<td class="FieldInput">
				 	<select  name="编制性质" field="types" >
						<option dataset="bztypesDs"></option>
					</select>
				  <font color="red">*</font> </td>
				   <td  class="FieldLabel" >工作经费：上年度拨付</td>
				<td class="FieldInput"><input type="text" name="辖区人口" field="lastYearBudget"   /> 万元 <font color="red">*</font></td>
				   <td  class="FieldLabel" >本年度拨付</td>
				<td class="FieldInput"><input type="text" name="辖区人口" field="thisYearBudget"  /> 万元 <font color="red">*</font></td>
				  </tr>
				  <tr>
				<td  class="FieldLabel" >级别</td>
				<td class="FieldInput">
					<select  name="级别" field="sslevel" >
						<option dataset="sslevelDs"></option>
					</select>
				 <font color="red">*</font></td>
				<td  class="FieldLabel" >成立日期</td>
				<td class="FieldInput" colspan="3">
				 <input type="text" id="creatDate" name="creatDate" field="creatDate" title="成立日期" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				 </td>
				
			</tr>
			
				<tr>
			    <td  class="FieldLabel" >辖区人口</td>
				<td class="FieldInput"><input type="text" name="辖区人口" field="deptNumRy"  /> <font color="red">*</font></td>
				
				<td  class="FieldLabel" >编委核定编制人数</td>
				<td class="FieldInput"><input type="text" name="编委核定编制人数" field="deptNumRdbz"  /> <font color="red">*</font></td>
				
				<td  class="FieldLabel" >实有人数</td>
				<td class="FieldInput"><input type="text" name="实有人数" field="deptNumSj"  /> <font color="red">*</font></td>
			
			</tr>
			
			<tr>
				<td  class="FieldLabel" >机构状态</td>
				<td class="FieldInput">
					<select  name="机构状态" field="validFlag" >
						<option dataset="validDs"></option>
					</select> <font color="red">*</font>
				 </td>
				<td  class="FieldLabel" >所属行政区</td>
				<td class="FieldInput">
				<label id="regionName" field="regionName" ></label> 
				<input type="hidden" name="regionCode" id="regionCode" field="regionCode"/> </td>
				
				<td  class="FieldLabel" >所属民政部门</td>
				<td class="FieldInput"><label id="deptOrgan" field="deptOrgan" ></label></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >当前级别</td>
				<td class="FieldInput" >
					<select name="skinValue" field="skinValue" >
						<option dataset="EvaluLevelDataset"></option>
					</select>
				</td>
	            <td  class="FieldLabel" >登记机关被撤销时间</td>
				<td class="FieldInput">
				 <input type="text" id="abolishDate" name="abolishDate" field="abolishDate" title="成立日期" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				 </td>
				<td  class="FieldLabel" >撤消后业务归属</td>
				<td class="FieldInput" ><input type="text" name="abolishYwgs" field="abolishYwgs"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >撤销原因</td>
				<td class="FieldInput" colspan="5"><textarea rows="4" cols="130" name="abolishReason" field="abolishReason"  ></textarea> </td>
				
			</tr>
	   		<tr>
				<td  class="FieldLabel" >部门外网网址</td>
				<td class="FieldInput" colspan="5"><input type="text" name="homeUrl" field="homeUrl"  style="width: 670px"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注</td>
				<td class="FieldInput" colspan="5"><textarea rows="4" cols="130" name="remark" field="remark" ></textarea> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
