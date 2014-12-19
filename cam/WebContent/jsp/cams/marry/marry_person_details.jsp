<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<next:ScriptManager />
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<title>婚姻登记人员明细信息</title>
	<script>
		var idField='<%= request.getParameter("dataBean") %>';
		var method='<%= request.getParameter("method") %>';
	</script>
	<script type="text/javascript" src="marry_person_details.js"></script>
	<style>
	.styleOne {
		font-size: 13px;
	}
	.styleLabel {
		font-size: 13px;
	}
	</style>
</head>
<body>
<model:datasets>
	<!--	性别字典		-->
	<model:dataset id="xbDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	人员性质字典		-->
	<model:dataset id="ryxzDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	
	<!--	登记机关字典	-->
	<model:dataset id="djjgDs" cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true" pageSize="-1"
		sortField="deptCode" method="getCacheDept">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept">
			<model:field name="value" mapping="deptCode" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	身份类别字典		-->
	<model:dataset id="sflbDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	国籍字典		-->
	<model:dataset id="gjDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	证件类型字典		-->
	<model:dataset id="zjlxDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	民族字典		-->
	<model:dataset id="mzDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	婚姻状况字典		-->
	<model:dataset id="hyzkDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	职业字典		-->
	<model:dataset id="zyDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	文化程度字典		-->
	<model:dataset id="whcdDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	<!--	婚姻登记人员信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.person.cmd.MarrypersonCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.person.data.Marryperson"></model:record>
	</model:dataset>

</model:datasets>
<next:ViewPort>
<next:Panel id="myPanel" autoWidth="true" height="100%" title="婚姻登记人员明细信息"
	autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="打印" handler="print" />
		<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
		<next:ToolBarItem symbol=""></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="HydjForm" method="post" dataset="ds"
			onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="0" width="99%" height="98%">
			  <tr>
		        <td class="FieldLabel" style="width: 20%">登记员编号：</td>
		        <td class="FieldInput" style="width: 30%"><span field="code" class="styleOne" /></td>
		        <td class="FieldLabel" style="width: 20%">姓名：</td>
		        <td class="FieldInput" style="width: 30%"><span field="name" class="styleOne" /></td>
			  </tr> 
			  <tr>
		        <td class="FieldLabel">性别：</td>
		        <td class="FieldInput"><label field="sex" class="styleOne" dataset="xbDs"/></td>
		        <td class="FieldLabel">出生日期：</td>
		        <td class="FieldInput"><span field="birthDate" class="styleOne" /></td>
			  </tr> 
			  <tr>
		        <td class="FieldLabel">身份证号：</td>
		        <td class="FieldInput"><span field="cardNo" class="styleOne" /></td>
		        <td class="FieldLabel">籍贯：</td>
		        <td class="FieldInput"><span field="nativePlace" class="styleOne" /></td>
			  </tr> 
			  <tr>
		        <td class="FieldLabel">民族：</td>
		        <td class="FieldInput"><span field="nation" class="styleOne" /></td>
		        <td class="FieldLabel">政治面貌：</td>
		        <td class="FieldInput"><span field="politics" class="styleOne" /></td>
			  </tr> 
			  <tr>
		        <td class="FieldLabel">入党入团时间：</td>
		        <td class="FieldInput"><span field="partyDate" class="styleOne" /></td>
		        <td class="FieldLabel">学历：</td>
		        <td class="FieldInput"><span field="culture" class="styleOne" /></td>
			  </tr> 
			  <tr>
		        <td class="FieldLabel">学位：</td>
		        <td class="FieldInput"><span field="degree" class="styleOne" /></td>
		        <td class="FieldLabel">专业：</td>
		        <td class="FieldInput"><span field="specialty" class="styleOne"/></td>
			  </tr>  
			  <tr>
		        <td class="FieldLabel">毕业院校：</td>
		        <td class="FieldInput"><span field="college" class="styleOne" /></td>
		        <td class="FieldLabel">毕业时间：</td>
		        <td class="FieldInput"><span field="graduateDate" class="styleOne" /></td>
			  </tr>  
			  <tr>
		        <td class="FieldLabel">婚姻状况：</td>
		        <td class="FieldInput"><span field="marry" class="styleOne" /></td>
		        <td class="FieldLabel">职称：</td>
		        <td class="FieldInput"><span field="technical" class="styleOne" /></td>
			  </tr>   
			  <tr>
		        <td class="FieldLabel">职务：</td>
		        <td class="FieldInput"><span field="duty" class="styleOne" /></td>
		        <td class="FieldLabel">工作证号：</td>
		        <td class="FieldInput"><span field="workNo" class="styleOne" /></td>
			  </tr>   
			  <tr>
		        <td class="FieldLabel">办公电话：</td>
		        <td class="FieldInput"><span field="officeTel" class="styleOne" /></td>
		        <td class="FieldLabel">手机：</td>
		        <td class="FieldInput"><span field="mobile" class="styleOne" /></td>
			  </tr>   
			  <tr>
		        <td class="FieldLabel">参加工作时间：</td>
		        <td class="FieldInput"><span field="workDate" class="styleOne" /></td>
		        <td class="FieldLabel">所属部门：</td>
		        <td class="FieldInput"><label field="deptCode" class="styleOne" dataset="djjgDs" /></td>
			  </tr>    
			  <tr>
		        <td class="FieldLabel">人员性质：</td>
		        <td class="FieldInput"><label field="kind" class="styleOne" dataset="ryxzDs"/></td>
		        <td class="FieldLabel">人员状态：</td>
		        <td class="FieldInput"><label field="validFlag" class="styleOne" dataset="ryztDs"/></td>
			  </tr>    
			  <tr>
		        <td class="FieldLabel">从事婚姻工作开始时间：</td>
		        <td class="FieldInput"><span field="marryStartDate" class="styleOne" /></td>
		        <td class="FieldLabel">从事婚姻工作结束时间：</td>
		        <td class="FieldInput"><span field="marryEndDate" class="styleOne" /></td>
			  </tr>     
			  <tr>
		        <td class="FieldLabel">家庭地址：</td>
		        <td class="FieldInput" colspan="3"><span field="address" class="styleOne" /></td>  
		      </tr>     
			  <tr>
		        <td class="FieldLabel">备注：</td>
		        <td class="FieldInput" colspan="3"><span field="remark" class="styleOne" /></td>
			  </tr> 
			</table>
		</form>
	</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>
