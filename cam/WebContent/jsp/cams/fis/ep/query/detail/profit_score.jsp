<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>经营性公墓年检打分情况</title>
<next:ScriptManager />
<script type="text/javascript" src="profit_score.js"></script>
<script type="text/javascript">
	var idField = '<%=request.getParameter("dataBean")%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.CemeInspectionQueryCmd"
		method="queryScore" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckScore">
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel height="100%" width="100%" autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" method="post" dataset="ds"
					onsubmit="return false" class="L5form">
				<fieldset><legend>公墓年检标准(满分：100)</legend>
				<table width="100%">

								<tr>
									<td class="FieldButton" colspan="3">检查项目</td>
									<td class="FieldButton" width="5%">分值</td>
									<td class="FieldButton" >得分</td>
									<td class="FieldButton" width="25%">扣分或加分原因</td>
								</tr>
								<tr>
									<td class="FieldLabel" rowspan="8" width="20%" style="text-align:left">在销售服务场所公开展示内容
									(10分)</td>
									<td class="FieldLabel" width="30%" style="text-align:left"  colspan="2">《经营性公墓合格证》</td>
									<td class="FieldLabel" style="text-align: center" width="15%">1</td>
									<td class="FieldInput"  ><label type="text"
										name="经营性合格证得分" field="businesscertificateScore" style="text-align:right"
										id="businesscertificateScore"    style="width: 50px" 
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput" width="35%"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="经营性合格证原因" style="width: 400px"
										field="businesscertificateReason" maxlength="50" disabled="disabled"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">营业执照</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" style="text-align:right"
										name="营业执照得分" field="businesslicenseScore"
										id="businesslicenseScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="营业执照原因" style="width: 400px"
										field="businesslicenseReason" maxlength="50" disabled="disabled"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">税务登记证</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="税务登记证得分" style="text-align:right"
										field="taxcertificateScore" id="taxcertificateScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="税务登记证原因"
										style="width: 400px" field="taxcertificateReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">收费项目、收费标准、收费依据等价格公示内容</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><label type="text" name="收费得分" style="text-align:right"
										field="feeScore" id="feeScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="收费原因"
										style="width: 400px" field="feeReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">购置墓穴（格位）的条件和程序</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text"
										name="购置墓穴/安葬程序得分" field="purchasegravesScore" style="text-align:right"
										id="purchasegravesScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="购置墓穴/安葬程序原因" style="width: 400px"
										field="purchasegravesReason" maxlength="50" disabled="disabled"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">服务承诺</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><label type="text" name="服务承诺得分" style="text-align:right"
										field="pledgeScore" id="pledgeScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="服务承诺原因"
										style="width: 400px" field="pledgeReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">工作人员职责及照片、编号</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="工作人员职责及照片、编号得分" style="text-align:right"
										field="staffresponsibilitiesScore"
										id="staffresponsibilitiesScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="工作人员职责原因"
										style="width: 400px" field="staffresponsibilitiesReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">办公时间、服务电话和监督电话</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text"
										name="办公时间、服务电话、监督电话得分" field="officeTimeScore" style="text-align:right"
										id="officeTimeScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="办公时间、服务电话、监督电话原因" style="width: 400px"
										field="officeTimeReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td rowspan="4" class="FieldLabel" style="text-align:left">墓穴(格位)销售管理(5分)</td>
									<td class="FieldLabel" style="text-align:left"  colspan="2">使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》得分"
										field="provincialdocumentsScore" id="provincialdocumentsScore"  style="width: 50px" style="text-align:right"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="全省统一证原因"
										style="width: 400px" field="provincialdocumentsReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">物价部门核定收费标准</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="物价部门收费标准得分" style="text-align:right"
										field="departmentchargesScore" id="departmentchargesScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="物价部门收费标准原因" style="width: 400px"
										field="departmentchargesReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">无违法出租或买卖墓穴（格位）现象</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><label type="text" name="无违法出租或买卖墓穴（格位）现象得分" style="text-align:right"
										field="nooffenseScore" id="nooffenseScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="无违法出租原因"
										style="width: 400px" field="nooffenseReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">对超过20年的墓穴能够妥善处理</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" style="text-align:right"
										name="对超过20年的墓穴能够妥善处理得分" field="propergraveScore"
										id="propergraveScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴妥善处理原因" style="width: 400px"
										field="propergraveReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="7" class="FieldLabel" style="text-align:left">墓穴(格位)销售档案管理(7分)</td>
									<td class="FieldLabel" style="text-align:left"  colspan="2">使用全省统一的卷盒和卷袋</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="使用全省统一的卷盒和卷袋得分" style="text-align:right"
										field="boxesandbagsScore" id="boxesandbagsScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="统一卷盒原因"
										style="width: 400px" field="boxesandbagsReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有死亡证明或火化证明的复印件</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="有死亡证明或火化证明的复印件得分" style="text-align:right"
										field="deathcertificateScore" id="deathcertificateScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="死亡证明复印件原因"
										style="width: 400px" field="deathcertificateReason" maxlength="50" disabled="disabled"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有骨灰安放(葬)合同</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text"
										name="骨灰安放合同得分" field="ashescontractScore" style="text-align:right"
										id="ashescontractScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="骨灰安放合同原因" style="width: 400px"
										field="ashescontractReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有丧事承办人签名的骨灰安放(葬)处理表、业务流程单等</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="有丧事承办人签名的骨灰安放（葬）处理表、业务流程单等得分"
										field="contractorssignatureScore" style="text-align:right"
										id="contractorssignatureScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="承办人签名原因"
										style="width: 400px" field="contractorssignatureReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有丧事承办人的有效身份证件复印件</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="有丧事承办人的有效身份证件复印件得分" style="text-align:right"
										field="contractoridScore" id="contractoridScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="承办人身份证原因"
										style="width: 400px" field="contractoridReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有补充签订的合同或者协议</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="有补充签订的合同或者协议得分" style="text-align:right"
										field="addcontractScore" id="addcontractScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="补充合同协议原因"
										style="width: 400px" field="addcontractReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有其他应当归档的材料</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="有其他应当归档的材料得分" style="text-align:right"
										field="othermaterialsScore" id="othermaterialsScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="其他材料原因"
										style="width: 400px" field="othermaterialsReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="3" class="FieldLabel" style="text-align:left">墓穴建设(9分)</td>
									<td class="FieldLabel" style="text-align:left" style="width: 30%">墓穴面积或墓碑高度超过规定标准20%以下的个数</td>
									<td class="FieldLabel"><label type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数" style="text-align:right"
									field="tombstoneTwentyNum" id="tombstoneTwentyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><label type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数得分" style="text-align:right"
										field="tombstoneTwentyScore" id="tombstoneTwentyScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓碑20%以下原因"
										style="width: 400px" field="tombstoneTwentyReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准20%至50%的个数</td>
									<td class="FieldLabel"><label type="text" name="墓穴面积或墓碑高度超过规定标准20%至50%的个数" style="text-align:right"
									field="tombstoneFiftyNum" id="tombstoneFiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><label type="text"
										name="墓穴面积或墓碑高度超过规定标准20%至50%的个数得分" style="text-align:right" field="tombstoneFiftyScore"  style="width: 50px"
										id="tombstoneFiftyScore" 
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓碑20%到50%原因" style="width: 400px"
										field="tombstoneFiftyReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准50%以上的个数</td>
									<td class="FieldLabel"><label type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数" style="text-align:right"
									field="tombstoneoverfiftyNum" id="tombstoneoverfiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput" ><label type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数得分" style="text-align:right" field="tombstoneoverfiftyScore"
										id="tombstoneoverfiftyScore"  maxlength="5"  style="width: 50px"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓碑50%以上原因"
										style="width: 400px" field="tombstoneoverfiftyReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="10" class="FieldLabel" style="text-align:left">墓区管理(30分)</td>
									<td class="FieldLabel" style="text-align:left">营业室面积(㎡)</td>
									<td class="FieldLabel"><label type="text" name="营业室面积(㎡)" style="text-align:right"
									field="operatingareaNum" id="operatingareaNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="营业室面积得分" style="text-align:right"
										field="operatingareaScore" id="operatingareaScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="营业室面积原因"
										style="width: 400px" field="operatingareaReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">档案室面积(㎡)</td>
									<td class="FieldLabel"><label type="text" name="档案室面积(㎡)" style="text-align:right"
									field="archivesareaNum" id="archivesareaNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="档案室面积得分" style="text-align:right"
										field="archivesareaScore" id="archivesareaScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="档案室面积原因"
										style="width: 400px" field="archivesareaReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">办公室面积(㎡)</td>
									<td class="FieldLabel"><label type="text" name="办公室面积(㎡)" style="text-align:right"
									field="officeareaNum" id="officeareaNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" name="办公室面积得分" style="text-align:right"
										field="officeareaScore" id="officeareaScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="办公室面积原因"
										style="width: 400px" field="officeareaReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">道路、供水、供电畅通，安全防护措施到位</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><label type="text" name="道路、供水、供电畅通，安全防护措施到位得分" style="text-align:right"
										field="roadsafetyScore" id="roadsafetyScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="道路供水原因"
										style="width: 400px" field="roadsafetyReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">有文明祭奠举措，无封建迷信活动</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><label type="text" name="有文明祭奠举措，无封建迷信活动得分" style="text-align:right"
										field="civilizationMemorialScore"  style="width: 50px"
										id="civilizationMemorialScore" 
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="文明祭奠原因"
										style="width: 400px" field="civilizationMemorialReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><label type="text" style="text-align:right" name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分"
										field="fireMemorialScore" id="fireMemorialScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="明火祭奠原因"
										style="width: 400px" field="fireMemorialReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left">生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例</td>
									<td class="FieldLabel"><label type="text" name="生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例" style="text-align:right"
									field="ecologyNum" id="ecologyNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><label type="text" name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分"
										field="ecologyScore" id="ecologyScore" style="text-align:right"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="生态原因"
										style="width: 400px" field="ecologyReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿化覆盖率</td>
									<td class="FieldLabel"><label type="text" name="绿化覆盖率" style="text-align:right"
									field="greenCoverageNum" id="greenCoverageNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><label type="text" name="绿化覆盖率得分" style="text-align:right"
										field="greenCoverageScore" id="greenCoverageScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿化率原因"
										style="width: 400px" field="greenCoverageReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿地面积和占总面积的比例</td>
									<td class="FieldLabel"><label type="text" name="绿地面积和占总面积的比例" style="text-align:right"
									field="greenareaRatioNum" id="greenareaRatioNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><label type="text" name="绿地面积和占总面积的比例得分" style="text-align:right"
										field="greenareaRatioScore" id="greenareaRatioScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿地面积比率原因"
										style="width: 400px" field="greenareaRatioReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" style="text-align:right" name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分"
										field="burialTombScore" id="burialTombScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="标准安葬墓穴原因"
										style="width: 400px" field="burialTombReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="9" class="FieldLabel" style="text-align:left">公墓管理(39分)</td>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">墓区建设地点和规模与申报材料相符</td>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><label type="text" name="墓区建设地点和规模与申报材料相符得分" style="text-align:right"
										field="burialConformScore" id="burialConformScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓区相符原因"
										style="width: 400px" field="burialConformReason" maxlength="50" disabled="disabled"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><label type="text" style="text-align:right" name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分"
										field="acceptanceComplianceScore"  style="width: 50px"
										id="acceptanceComplianceScore" 
										maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="手续符合规定原因"
										style="width: 400px" field="acceptanceComplianceReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">公墓更名、变更法人代表，改变性质或改变合作（合资）单位符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><label type="text" style="text-align:right"
										name="公墓更名、变更法人代表，改变性质或改变合作（合资）单位符合《山东省公墓管理办法》规定得分" field="changeComplianceScore"
										id="changeComplianceScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="改变符合规定/公墓更名符合规定原因" style="width: 400px"
										field="changeComplianceReason" maxlength="50" disabled="disabled"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证
									</td>
									<td class="FieldLabel" style="text-align: center">7</td>
									<td class="FieldInput" ><label type="text" style="text-align:right" name="公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证得分"
										field="paymentCertificateScore" id="paymentCertificateScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)" /></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="有交款凭证原因"
										style="width: 400px" field="paymentCertificateReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">墓区管理机构的组建与申报报告相符</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput" ><label type="text" style="text-align:right"
										name="墓区管理机构的组建与申报报告相符得分" field="agenciesScore" id="agenciesScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="管理机构组建相符原因" style="width: 400px" field="agenciesReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">工作人员参加省或设区的市人民政府民政部门组织的业务培训</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><label type="text" style="text-align:right" name="工作人员参加省或设区的市人民政府民政部门组织的业务培训得分"
										field="businessTrainingScore" id="businessTrainingScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="业务培训原因"
										style="width: 400px" field="businessTrainingReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">公墓管理的各项规章制度健全</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"  ><label type="text" name="公墓管理的各项规章制度健全得分"
										field="systemSoundScore" id="systemSoundScore" style="text-align:right"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="规章制度健全原因"
										style="width: 400px" field="systemSoundReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有高峰应急预案</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"  ><label type="text" name="有高峰应急预案得分" style="text-align:right"
										field="contingencyPlansScore" id="contingencyPlansScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="应急预案原因"
										style="width: 400px" field="contingencyPlansReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">实行信息化管理，使用省厅研制的软件信息系统</td>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><label type="text" name="实行信息化管理，使用省厅研制的软件信息系统得分" style="text-align:right"
										field="informationScore" id="informationScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="信息化原因"
										style="width: 400px" field="informationReason" maxlength="50" disabled="disabled"></textarea> </td>
								</tr>
							</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>

	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>

