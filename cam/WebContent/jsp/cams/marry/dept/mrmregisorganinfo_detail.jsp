
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>登记机关信息表明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmregisorganinfo_detail.js"></script>
		<script type="text/javascript">
			var idField='<%=request.getParameter("dataBean")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo"></model:record>
	</model:dataset>
	
		 
	<!--	机构类型字典		-->
	<model:dataset id="jglxDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	机构性质字典		-->
	<model:dataset id="jgxzDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	 <model:dataset id="bztypesDs" enumName="MRM.FORMATION.NATURE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="sslevelDs" enumName="MRM.LEVEL.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="monitorDs" enumName="MRM.MONITOR.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="areaNameDs" enumName="MRM.AREA.NAME" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="resourceNameDs" enumName="MRM.RESOURCE.NAME" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="validDs" enumName="MRM.VALIDFLAG" autoLoad="true" pageSize="-1"></model:dataset>
	  <model:dataset id="wsyydjDs" enumName="MRM.WSYYDJ.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	<!--	行政区划信息	-->
	<model:dataset id="xzqhDs"
		cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
	 
</model:datasets>

<next:Panel  title="登记机关信息表" width="100%" height="100%" autoHeight="true" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="returnBack"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0" width="100%" height="100%">
				  <tr>
			        <td class="FieldLabel" style="width: 20%">机构代码：</td>
			        <td class="FieldInput" style="width: 30%"><span field="deptCode" class="styleOne" /></td>
			        <td class="FieldLabel" style="width: 20%">名称：</td>
			        <td class="FieldInput" style="width: 30%"><span field="name" class="styleOne" /></td>
				  </tr> 
				  <tr>
			        <td class="FieldLabel">编制性质</td>
			        <td class="FieldInput"><label id="types" name="types" field="types" dataset="bztypesDs" /></td>
			        <td class="FieldLabel">机构状态：</td>
			        <td class="FieldInput"><label field="validFlag" class="validFlag" dataset="validDs"/></td>
				  </tr> 
				   <tr>
			        <td class="FieldLabel">上年度工作经费：</td>
			        <td class="FieldInput"><span field="lastYearBudget" class="styleOne" />万元</td>
			       <td class="FieldLabel">本年度工作经费：</td>
			        <td class="FieldInput"><span field="lastYearBudget" class="styleOne" />万元</td>
				  </tr>  
				  <tr>
			        <td class="FieldLabel">机构类型：</td>
			        <td class="FieldInput"><label field="validFlag" class="validFlag" dataset="validDs"/></td>
			        <td class="FieldLabel">电子邮箱：</td>
			        <td class="FieldInput"><span field="officeEmail" class="styleOne" /></td>
			        
				  </tr> 
				  <tr>
			        <td class="FieldLabel">实有人数：</td>
			        <td class="FieldInput"><span field="deptNumSj" class="styleOne" /></td>
			       <td class="FieldLabel">传真电话：</td>
			        <td class="FieldInput"><span field="deptFax" class="styleOne" /></td>
				  </tr>  
				  <tr>
			        <td class="FieldLabel">负责人：</td>
			        <td class="FieldInput"><span field="deptLeador" class="styleOne" /></td>
			        <td class="FieldLabel">咨询电话：</td>
			        <td class="FieldInput"><span field="deptTel" class="styleOne" /></td>
				  </tr>   
				 
	   		<tr>
	   			<td  class="FieldLabel" >辖区人口</td>
				<td class="FieldInput"><label field="deptNumRy" /> </td>
				<td  class="FieldLabel" >编制人数</td>
				<td class="FieldInput"><label field="deptNumRdbz" /> </td>
			</tr>
	   		<tr>
			 <td class="FieldLabel">所属行政区：</td>
			        <td class="FieldInput"><label field="regionCode" class="styleOne" dataset="xzqhDs"/></td>
				<td  class="FieldLabel" >所属民政部门</td>
				<td class="FieldInput"><label field="deptOrgan" /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >分管局长姓名</td>
				<td class="FieldInput"><label field="jzname" /> </td>
				<td  class="FieldLabel" >分管局长电话</td>
				<td class="FieldInput"><label field="jzdh" /> </td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >分管局长手机</td>
				<td class="FieldInput"><label field="jzsj" /> </td>
				<td  class="FieldLabel" >撤消后业务归属</td>
				<td class="FieldInput" ><label field="abolishYwgs" /> </td>
			</tr>
			 <tr>
				<td  class="FieldLabel" >撤销原因</td>
				<td class="FieldInput" colspan="3"><label field="abolishReason" /> </td>
			</tr>
			   
			       <tr>
			        <td class="FieldLabel">内网首页Url：</td>
			        <td class="FieldInput"  colspan="3"><span field="homeUrl" class="styleOne" /></td>
				  </tr>       
				  <tr>
			        <td class="FieldLabel">备注：</td>
			        <td class="FieldInput" colspan="3"><span field="remark" class="styleOne" /></td>
				  </tr> 			
				</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
