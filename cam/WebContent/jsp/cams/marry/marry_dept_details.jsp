<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<next:ScriptManager />
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<title>婚姻登记机构明细信息</title>
	<script>
		var code='<%= request.getParameter("code") %>';
		var idField='<%= request.getParameter("dataBean") %>';
		var method='<%= request.getParameter("method") %>';
	</script>
	<script type="text/javascript" src="marry_dept_details.js"></script>
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
	<!--	行政区划信息	-->
	<model:dataset id="xzqhDs"
		cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
	<!--	婚姻登记人员信息	-->
	<model:dataset id="personDs"
		cmd="com.inspur.cams.marry.person.cmd.MarrypersonCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.person.data.Marryperson"></model:record>
	</model:dataset>
	<!--	婚姻登记机关信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept"></model:record>
	</model:dataset>

</model:datasets>
<next:ViewPort>
<next:TabPanel id="tabpanel" name="tabpanel-div">
<next:Tabs>
	<next:Panel id="myPanel" autoWidth="true" height="100%" autoScroll="true" title="婚姻登记机关信息">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="打印" handler="print"/>
			<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form id="HydjForm" method="post" dataset="ds"
				onsubmit="return false" style="padding: 0px;" class="L5form">
				<table border="0" width="100%" height="100%">
				  <tr>
			        <td class="FieldLabel" style="width: 20%">机构统一编号：</td>
			        <td class="FieldInput" style="width: 30%"><span field="deptCode" class="styleOne" /></td>
			        <td class="FieldLabel" style="width: 20%">名称：</td>
			        <td class="FieldInput" style="width: 30%"><span field="name" class="styleOne" /></td>
				  </tr> 
				  <tr>
			        <td class="FieldLabel">所属行政区：</td>
			        <td class="FieldInput"><label field="regionCode" class="styleOne" dataset="xzqhDs"/></td>
			        <td class="FieldLabel">全宗号：</td>
			        <td class="FieldInput"><span field="docCode" class="styleOne" /></td>
				  </tr> 
				  <tr>
			        <td class="FieldLabel">机构类型：</td>
			        <td class="FieldInput"><label field="adminType" class="styleOne" dataset="jglxDs"/></td>
			        <td class="FieldLabel">机构性质：</td>
			        <td class="FieldInput"><label field="type" class="styleOne" dataset="jgxzDs"/></td>
				  </tr> 
				  <tr>
			        <td class="FieldLabel">经费形式：</td>
			        <td class="FieldInput"><span field="feeType" class="styleOne" /></td>
			        <td class="FieldLabel">业务办理模式：</td>
			        <td class="FieldInput"><label field="opMode" class="styleOne" dataset="ywmsDs"/></td>
				  </tr> 
				  <tr>
			        <td class="FieldLabel">创建日期：</td>
			        <td class="FieldInput"><span field="creatDate" class="styleOne" /></td>
			        <td class="FieldLabel">撤销日期：</td>
			        <td class="FieldInput"><span field="abolishDate" class="styleOne" /></td>
				  </tr> 
				  <tr>
			        <td class="FieldLabel">办公室对外邮箱：</td>
			        <td class="FieldInput"><span field="officeEmail" class="styleOne" /></td>
			        <td class="FieldLabel">乘车路线：</td>
			        <td class="FieldInput"><span field="deptRoute" class="styleOne" /></td>
				  </tr>  
				  <tr>
			        <td class="FieldLabel">实际人数：</td>
			        <td class="FieldInput"><span field="deptNumSj" class="styleOne" /></td>
			        <td class="FieldLabel">办公面积：</td>
			        <td class="FieldInput"><span field="officeArea" class="styleOne" /></td>
				  </tr>  
				  <tr>
			        <td class="FieldLabel">领导：</td>
			        <td class="FieldInput"><span field="deptLeador" class="styleOne" /></td>
			        <td class="FieldLabel">咨询电话：</td>
			        <td class="FieldInput"><span field="deptTel" class="styleOne" /></td>
				  </tr>   
				  <tr>
			        <td class="FieldLabel">传真：</td>
			        <td class="FieldInput"><span field="deptFax" class="styleOne" /></td>
			        <td class="FieldLabel">投诉电话：</td>
			        <td class="FieldInput"><span field="complainTel" class="styleOne" /></td>
				  </tr>   
				  <tr>
			        <td class="FieldLabel">内网首页Url：</td>
			        <td class="FieldInput"><span field="homeUrl" class="styleOne" /></td>
			        <td class="FieldLabel">台账部门编码：</td>
			        <td class="FieldInput"><span field="deptCodeDesk" class="styleOne" /></td>
				  </tr>   
				  <tr>
			        <td class="FieldLabel">描述：</td>
			        <td class="FieldInput"><span field="descript" class="styleOne"/></td>
			        <td class="FieldLabel">机构状态：</td>
			        <td class="FieldInput"><label field="validFlag" class="styleOne" dataset="jgztDs"/></td>
				  </tr>    
				  <tr>
			        <td class="FieldLabel">地址：</td>
			        <td class="FieldInput" colspan="3"><span field="deptAddress" class="styleOne" /></td>  
			      </tr>     
				  <tr>
			        <td class="FieldLabel">备注：</td>
			        <td class="FieldInput" colspan="3"><span field="remark" class="styleOne" /></td>
				  </tr> 
				</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:Panel id="subPanel" width="100%" height="100%" autoScroll="true" title="下属婚姻登记人员">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="打印" handler="printPerson"/>
			<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<table border="0" width="99%" height="100%" class="L5form">
				<tr><td height="100%">
					<table dataset="personDs" border="0" width="100%" height="98%">
					  <tr repeat="true">
					  	<td valign="top">
						  <table border="0" width="100%">
							  <tr>
						        <td class="FieldLabel" style="width: 216px;">登记员编号：</td>
						        <td class="FieldInput"><span field="code" class="styleOne" /></td>
						        <td class="FieldLabel" style="width: 216px;">姓名：</td>
						        <td class="FieldInput" style="width: 21%"><span field="name" class="styleOne" /></td>
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
						        <td class="FieldInput"><label field="validFlag" class="styleOne" dataset="jgztDs"/></td>
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
					     </td>
					    </tr>
					</table>
				</td></tr>
			</table>
		</next:Html>
	</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
</html>
