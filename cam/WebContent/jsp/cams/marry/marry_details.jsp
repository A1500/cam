<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<next:ScriptManager />
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<title>婚姻明细信息</title>
	<style>
	.styleOne {
		font-size: 13px;
	}
	.styleLabel {
		font-size: 13px;
	}
	@media print {
		.noprint {
			display: none
		}
	}
	</style>
	<script>
		var certNumMan='<%= request.getParameter("certNumMan") %>';
		var certNumWoman='<%= request.getParameter("certNumWoman") %>';
		var idField='<%= request.getParameter("dataBean") %>';
		var method='<%= request.getParameter("method") %>';
	</script>
	<script type="text/javascript" src="common.js"></script>
	<script type="text/javascript" src="marry_details.js"></script>
</head>
<body>
<model:datasets>
	<!--	补发原因字典		-->
	<model:dataset id="bfyyDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
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
	
	<!--	业务类别字典		-->
	<model:dataset id="ywlbDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	
	<!--	男方全部信息	-->
	<model:dataset id="manAllDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1" sortField="opDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<!--	女方全部信息	-->
	<model:dataset id="womanAllDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1" sortField="opDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
		<!--	男方全部信息-二次-->
	<model:dataset id="manAllDs2"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1" sortField="opDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<!--	女方全部信息-二次	-->
	<model:dataset id="womanAllDs2"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1" sortField="opDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	
	<!--	男方婚史、补发结婚证、补发离婚证、补发婚姻证明、撤销婚姻信息	-->
	<model:dataset id="manIABDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="manICADs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="manICBDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="manICDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="manIDDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	
	<!--	女方婚史、补发结婚证、补发离婚证、补发婚姻证明、撤销婚姻信息	-->
	<model:dataset id="womanIABDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="womanICADs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="womanICBDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="womanICDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	<model:dataset id="womanIDDs"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>
	
	<!--	婚姻登记信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>

</model:datasets>
<next:ViewPort>
	<next:TabPanel id="tabpanel" name="tabpanel-div">
		<next:Tabs>
			<next:Panel autoWidth="true" height="98%" title="婚姻登记双方明细信息"
				autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="打印" handler="print"/>
					<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
					<next:ToolBarItem symbol=""></next:ToolBarItem>
					<next:ToolBarItem symbol="-"></next:ToolBarItem>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
				</next:TopBar>
				<next:Html>
					<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" id="WebBrowser" width="0"></OBJECT> 
					<form id="HydjForm" method="post" dataset="ds"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="99%" height="98%">
					  <tr>
					    <td colspan="2" height="20" class="FieldLabel" valign="middle">
						登记字号为：<span field="certNo" class="styleOne" />
						</td>
					  </tr>
					  <tr>
					    <td height="20" class="FieldInput" align="center">男方信息</td>
					    <td class="FieldInput" align="center">女方信息</td>
					  </tr> 
					  <tr>
					    <td width="50%" valign="top" height="100%" >
					    <table width="100%" height="100%" border="1" bordercolor="red">
					      <tr>
					        <td class="FieldLabel">姓名：</td>
					        <td class="FieldInput"><span field="nameMan" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">身份类别：</td>
					        <td class="FieldInput"><label field="idTypeMan" class="styleOne" dataset="sflbDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">国籍：</td>
					        <td class="FieldInput"><label field="nationMan" class="styleOne" dataset="gjDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">证件类型：</td>
					        <td class="FieldInput"><label field="certTypeMan" class="styleOne" dataset="zjlxDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">证件号码：</td>
					        <td class="FieldInput"><span field="certNumMan" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">出生日期：</td>
					        <td class="FieldInput"><span field="birthMan" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">民族：</td>
					        <td class="FieldInput"><label field="folkMan" class="styleOne" dataset="mzDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">婚姻状况：</td>
					        <td class="FieldInput"><label field="marryStatusMan" class="styleOne" dataset="hyzkDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">职业：</td>
					        <td class="FieldInput"><label field="jobMan" class="styleOne" dataset="zyDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">文化程度：</td>
					        <td class="FieldInput"><label field="degreeMan" class="styleOne" dataset="whcdDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">常住户口所在地：</td>
					        <td class="FieldInput"><span field="regDetailMan" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">提供证件材料：</td>
					        <td class="FieldInput"><span field="certProofMan" class="styleOne" /></td>
					      </tr>
					    </table></td>
					    <td width="50%" valign="top" height="100%"><table width="100%" height="100%" border="1">
					      <tr>
					        <td class="FieldLabel">姓名：</td>
					        <td class="FieldInput"><span field="nameWoman" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">身份类别：</td>
					        <td class="FieldInput"><label field="idTypeWoman" class="styleOne" dataset="sflbDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">国籍：</td>
					        <td class="FieldInput"><label field="nationWoman" class="styleOne" dataset="gjDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">证件类型：</td>
					        <td class="FieldInput"><label field="certTypeWoman" class="styleOne" dataset="zjlxDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">证件号码：</td>
					        <td class="FieldInput"><span field="certNumWoman" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">出生日期：</td>
					        <td class="FieldInput"><span field="birthWoman" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">民族：</td>
					        <td class="FieldInput"><label field="folkWoman" class="styleOne" dataset="mzDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">婚姻状况：</td>
					        <td class="FieldInput"><label field="marryStatusWoman" class="styleOne" dataset="hyzkDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">职业：</td>
					        <td class="FieldInput"><label field="jobWoman" class="styleOne" dataset="zyDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">文化程度：</td>
					        <td class="FieldInput"><label field="degreeWoman" class="styleOne" dataset="whcdDs"/></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">常住户口所在地：</td>
					        <td class="FieldInput"><span field="regDetailWoman" class="styleOne" /></td>
					      </tr>
					      <tr>
					        <td class="FieldLabel">提供证件材料：</td>
					        <td class="FieldInput"><span field="certProofWoman" class="styleOne" /></td>
					      </tr>
					    </table></td>
					  </tr>
					  <tr>
					    <td colspan="2" height="200">
							<table width="100%" height="100%" border="1">
								<tr>
								  <td class="FieldLabel">审查意见：</td>
								  <td class="FieldInput"><span field="checkData" class="styleOne" /></td>
								  <td class="FieldLabel">登记日期：</td>
								  <td class="FieldInput"><span field="opDate" class="styleOne" /></td>
								</tr>
								<tr>
								  <td class="FieldLabel">印制号（男）：</td>
								  <td class="FieldInput"><span field="printNumMan" class="styleOne" /></td>
								  <td class="FieldLabel">印制号（女）：</td>
								  <td class="FieldInput"><span field="printNumWoman" class="styleOne" /></td>
								</tr>
								<tr>
								  <td class="FieldLabel">登记员：</td>
								  <td class="FieldInput"><span field="operator" class="styleOne" /></td>
								  <td class="FieldLabel">归档页数：</td>
								  <td class="FieldInput"><span field="docPageNum" class="styleOne" /></td>
								</tr>
								<tr>
								  <td class="FieldLabel">证书备注：</td>
								  <td class="FieldInput" colspan="3"><span field="remark" class="styleOne" /></td>
								</tr>
								<tr>
								  <td class="FieldLabel">其他备注：</td>
								  <td class="FieldInput" colspan="3"><span field="printRemark" class="styleOne" /></td>
								</tr>
								
							</table>
					    </td>
					  </tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			
			
			<next:Panel width="100%" height="100%" title="男方婚姻记录"
				autoScroll="true" disabled="true">
				<next:TabPanel id="tabpanelM" name="tabpanel-div">
					<next:Tabs>
						<next:Panel width="100%" height="100%" title="男方婚史信息"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printManIAB"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="manIABDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">婚史信息：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
										      <tr>
										        <td class="FieldInput" colspan="4"><label field="opType" class="styleOne" dataset="ywlbDs"/></td>
										      </tr>
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameWoman" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeWoman" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationWoman" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeWoman" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkWoman" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusWoman" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobWoman" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeWoman" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="男方补发结婚登记历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printManICA"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="manICADs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">补发结婚登记历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameWoman" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeWoman" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationWoman" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeWoman" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkWoman" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusWoman" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobWoman" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeWoman" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">补发原因：</td>
										        <td class="FieldInput" colspan="3"><label field="redoReason" class="styleOne" dataset="bfyyDs"/></td>
										      </tr> 
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="男方补发离婚登记历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printManICB"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="manICBDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">补发离婚登记历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameWoman" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeWoman" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationWoman" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeWoman" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkWoman" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusWoman" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobWoman" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeWoman" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">补发原因：</td>
										        <td class="FieldInput" colspan="3"><label field="redoReason" class="styleOne" dataset="bfyyDs"/></td>
										      </tr> 
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="男方补办婚姻登记历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printManIC"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="manICDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">补办婚姻登记历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameWoman" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeWoman" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationWoman" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeWoman" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkWoman" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusWoman" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobWoman" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeWoman" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="男方撤销婚姻历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printManID"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="manIDDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">撤销婚姻历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameWoman" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeWoman" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationWoman" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeWoman" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkWoman" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusWoman" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobWoman" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeWoman" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailWoman" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">撤销依据：</td>
										        <td class="FieldInput" colspan="3"><label field="cancelProof" class="styleOne"/></td>
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
			</next:Panel>
			<next:Panel width="100%" height="100%" title="女方婚姻记录"
				autoScroll="true" disabled="true">
				<next:TabPanel id="tabpanelW" name="tabpanel-div">
					<next:Tabs>
						<next:Panel width="100%" height="100%" title="女方婚史信息"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printWomanIAB"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="womanIABDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">婚史信息：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
										      <tr>
										        <td class="FieldInput" colspan="4"><label field="opType" class="styleOne" dataset="ywlbDs"/></td>
										      </tr>
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameMan" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeMan" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationMan" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeMan" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkMan" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusMan" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobMan" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeMan" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailMan" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="女方补发结婚登记历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printWomanICA"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="womanICADs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">补发结婚登记历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameMan" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeMan" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationMan" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeMan" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkMan" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusMan" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobMan" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeMan" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailMan" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">补发原因：</td>
										        <td class="FieldInput" colspan="3"><label field="redoReason" class="styleOne" dataset="bfyyDs"/></td>
										      </tr> 
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="女方补发离婚登记历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printWomanICB"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="womanICBDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">补发离婚登记历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameMan" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeMan" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationMan" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeMan" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkMan" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusMan" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobMan" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeMan" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailMan" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">补发原因：</td>
										        <td class="FieldInput" colspan="3"><label field="redoReason" class="styleOne" dataset="bfyyDs"/></td>
										      </tr> 
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="女方补办婚姻登记历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printWomanIC"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="womanICDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">补办婚姻登记历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameMan" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeMan" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationMan" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeMan" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkMan" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusMan" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobMan" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeMan" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailMan" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										  </table>
									     </td>
									    </tr>
									</table>
								</td></tr>
								</table>
							</next:Html>
						</next:Panel>
						
						<next:Panel width="100%" height="100%" title="女方撤销婚姻历史"
							autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="打印" handler="printWomanID"/>
								<next:ToolBarItem iconCls="undo" text="关闭" handler="returnClick" />
								<next:ToolBarItem symbol=""></next:ToolBarItem>
								<next:ToolBarItem symbol="-"></next:ToolBarItem>
								<next:ToolBarItem symbol=""></next:ToolBarItem>
							</next:TopBar>
							<next:Html>
								<table border="0" width="99%" height="100%" class="L5form">
								<tr><td height="100%">
									<table dataset="womanIDDs" border="0" width="100%" height="98%">
									  <tr>
									  	<td class="FieldInput" colspan="4">撤销婚姻历史：</td>
								      </tr>
									  <tr repeat="true">
									  	<td valign="top">
										  <table border="0" width="100%">
											  <tr>
										        <td class="FieldLabel" style="width: 216px;">姓名：</td>
										        <td class="FieldInput"><span field="nameMan" class="styleOne" /></td>
										        <td class="FieldLabel" style="width: 216px;">身份类别：</td>
										        <td class="FieldInput" style="width: 21%"><label field="idTypeMan" class="styleOne" dataset="sflbDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">国籍：</td>
										        <td class="FieldInput"><label field="nationMan" class="styleOne" dataset="gjDs"/></td>
										        <td class="FieldLabel">出生日期：</td>
										        <td class="FieldInput"><span field="birthMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">证件类型：</td>
										        <td class="FieldInput"><label field="certTypeMan" class="styleOne" dataset="zjlxDs"/></td>
										        <td class="FieldLabel">证件号码：</td>
										        <td class="FieldInput"><span field="certNumMan" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">民族：</td>
										        <td class="FieldInput"><label field="folkMan" class="styleOne" dataset="mzDs"/></td>
										        <td class="FieldLabel">婚姻状况：</td>
										        <td class="FieldInput"><label field="marryStatusMan" class="styleOne" dataset="hyzkDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">职业：</td>
										        <td class="FieldInput"><label field="jobMan" class="styleOne" dataset="zyDs"/></td>
										        <td class="FieldLabel">文化程度：</td>
										        <td class="FieldInput"><label field="degreeMan" class="styleOne" dataset="whcdDs"/></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">常住户口所在地：</td>
										        <td class="FieldInput" colspan="3"><span field="regDetailMan" class="styleOne" /></td>
										      </tr>
										      <tr>
												<td class="FieldLabel">登记日期：</td>
												<td class="FieldInput"><span field="opDate" class="styleOne" /></td>
												<td class="FieldLabel">登记机关：</td>
												<td class="FieldInput"><span field="deptName" class="styleOne" /></td>
										      </tr>
										      <tr>
										        <td class="FieldLabel">撤销依据：</td>
										        <td class="FieldInput" colspan="3"><label field="cancelProof" class="styleOne"/></td>
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
			</next:Panel>
			
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
</body>
</html>
