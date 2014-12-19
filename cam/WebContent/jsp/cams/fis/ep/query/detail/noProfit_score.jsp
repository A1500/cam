<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>公益性公墓打分情况</title>
<next:ScriptManager />
<script>
		var idField='<%=request.getParameter("dataBean")%>';
</script>
<script type="text/javascript" src="noProfit_score.js"></script>
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
									<td class="FieldButton" colspan="3" >检查项目</td>
									<td class="FieldButton" width="5%">分值</td>
									<td class="FieldButton" >得分</td>
									<td class="FieldButton" width="25%">扣分或加分原因</td>
								</tr>
								<tr>
									<td class="FieldLabel" rowspan="7" width="20%" style="text-align:left">在服务场所公开展示内容
									(15分)</td>
									<td class="FieldLabel" width="30%" colspan="2" style="text-align:left">县级民政部门批准建设文件</td>
									<td class="FieldLabel" style="text-align: center" width="15%">2</td>
									<td class="FieldInput" ><label type="text"
										name="县级民政部门批准建设文件得分" field="businesscertificateScore"
										id="businesscertificateScore" onchange="checkNum(this.id)"  style="text-align:right"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput" width="35%"><textarea disabled="disabled"   onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="县级民政部门批准建设文件扣分加分原因" style="width: 400px"  
										field="businesscertificateReason"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">本公益性公墓管理章程</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="本公益性公墓管理章程得分" field="businesslicenseScore"
										id="businesslicenseScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" 
										name="本公益性公墓管理章程原因" style="width: 400px" disabled="disabled" 
										field="businesslicenseReason"></textarea></td>
								</tr> 
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">安葬（安放）墓穴（格位）的条件和程序</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="安葬（安放）墓穴（格位）的条件和程序得分" field="purchasegravesScore"
										id="purchasegravesScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="安葬（安放）墓穴（格位）的条件和程序原因" style="width: 400px"  disabled="disabled" 
										field="purchasegravesReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">收费项目、收费标准、收费依据等价格公示内容</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="收费项目、收费标准、收费依据等价格公示内容得分" field="feeScore" id="feeScore"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="收费项目、收费标准、收费依据等价格公示内容原因" style="width: 400px"  disabled="disabled" 
										field="feeReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">服务承诺</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><label type="text" name="服务承诺得分"  style="text-align:right"
										field="pledgeScore" id="pledgeScore"
										onchange="checkNum(this.id)" maxlength="5" style="width: 50px" /> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="服务承诺原因" 
										style="width: 400px" field="pledgeReason" disabled="disabled" ></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">工作人员职责及照片、编号</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="工作人员职责及照片、编号得分" field="staffresponsibilitiesScore"
										id="staffresponsibilitiesScore" style="width: 50px"
										onchange="checkNum(this.id)" maxlength="5" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="工作人员职责及照片、编号原因" style="width: 400px" 
										field="staffresponsibilitiesReason" disabled="disabled" ></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">服务时间、地点、电话和监督电话</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="服务时间、地点、电话和监督电话得分" field="officeTimeScore"
										id="officeTimeScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="服务时间、地点、电话和监督电话原因" style="width: 400px" 
										field="officeTimeReason" disabled="disabled" ></textarea></td>

								</tr>
								<tr>
									<td rowspan="6" class="FieldLabel" style="text-align:left">墓穴(格位)档案管理(16分)</td>
									<td class="FieldLabel" colspan="2" style="text-align:left">使用全省统一的卷盒和卷袋</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="使用全省统一的卷盒和卷袋得分" field="boxesandbagsScore"
										id="boxesandbagsScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="使用全省统一的卷盒和卷袋原因" style="width: 400px"  disabled="disabled" 
										field="boxesandbagsReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有死亡证明或火化证明的复印件</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="有死亡证明或火化证明的复印件得分" field="deathcertificateScore"
										id="deathcertificateScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有死亡证明或火化证明的复印件原因" style="width: 400px" disabled="disabled" 
										field="deathcertificateReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有骨灰安放（葬）协议、补充签订的协议</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="有骨灰安放（葬）协议、补充签订的协议得分" field="propergraveScore"
										id="propergraveScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有骨灰安放（葬）协议、补充签订的协议原因" style="width: 400px" disabled="disabled" 
										field="propergraveReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有丧事承办人签名的骨灰安放（葬）处理表</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="有丧事承办人签名的骨灰安放（葬）处理表得分" field="ashescontractScore"
										id="ashescontractScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有丧事承办人签名的骨灰安放（葬）处理表原因" style="width: 400px" disabled="disabled" 
										field="ashescontractReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有丧事承办人的有效身份证件复印件</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="有丧事承办人的有效身份证件复印件得分" field="contractoridScore"
										id="contractoridScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有丧事承办人的有效身份证件复印件原因" style="width: 400px" disabled="disabled" 
										field="contractoridReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有其他应当归档的材料</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="有其他应当归档的材料得分" field="othermaterialsScore"
										id="othermaterialsScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有其他应当归档的材料原因" style="width: 400px" disabled="disabled" 
										field="othermaterialsReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="3" class="FieldLabel" style="text-align:left">墓穴建设(16分)</td>
									<td class="FieldLabel" style="text-align:left" style="width: 30%">墓穴面积或墓碑高度超过规定标准20%以下的个数</td>
									<td class="FieldLabel"><label type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数"
									field="tombstoneTwentyNum" style="text-align:right" id="tombstoneTwentyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="墓穴面积或墓碑高度超过规定标准20%以下的个数得分" field="tombstoneTwentyScore"
										id="tombstoneTwentyScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴面积或墓碑高度超过规定标准20%以下的个数原因" style="width: 400px" disabled="disabled" 
										field="tombstoneTwentyReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准20%至50%的个数</td>
									<td class="FieldLabel"><label type="text" name="墓穴面积或墓碑高度超过规定标准20%至50%的个数"
									field="tombstoneFiftyNum" style="text-align:right" id="tombstoneFiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><label type="text"
										name="墓穴面积或墓碑高度超过规定标准20%至50%的个数得分" field="tombstoneFiftyScore"
										id="tombstoneFiftyScore" onchange="checkNum(this.id)"  style="text-align:right"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴面积或墓碑高度超过规定标准20%至50%的个数原因" style="width: 400px" disabled="disabled" 
										field="tombstoneFiftyReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准50%以上的个数</td>
									<td class="FieldLabel"><label type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数"
									field="tombstoneoverfiftyNum" style="text-align:right" id="tombstoneoverfiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">8</td>
									<td class="FieldInput"><label type="text"
										name="墓穴面积或墓碑高度超过规定标准50%以上的个数得分"  style="text-align:right"
										field="tombstoneoverfiftyScore" id="tombstoneoverfiftyScore"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴面积或墓碑高度超过规定标准50%以上的个数原因" style="width: 400px" disabled="disabled" 
										field="tombstoneoverfiftyReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="7" class="FieldLabel" style="text-align:left">墓区管理(30分)</td>
									<td class="FieldLabel" colspan="2" style="text-align:left">道路畅通，安全防护措施到位</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"
										name="道路畅通，安全防护措施到位得分" field="roadsafetyScore"
										id="roadsafetyScore" onchange="checkNum(this.id)"  style="text-align:right"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="道路畅通，安全防护措施到位原因" style="width: 400px" disabled="disabled" 
										field="roadsafetyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有文明祭奠举措，无封建迷信活动</td>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="有文明祭奠举措，无封建迷信活动得分" field="civilizationMemorialScore"
										id="civilizationMemorialScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有文明祭奠举措，无封建迷信活动原因" style="width: 400px" disabled="disabled" 
										field="civilizationMemorialReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分"
										field="fireMemorialScore" id="fireMemorialScore"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" disabled="disabled" 
										name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批原因"
										style="width: 400px" field="fireMemorialReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例</td>
									<td class="FieldLabel"><label type="text" style="text-align:right" name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例"
									field="ecologyNum" id="ecologyNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><label type="text"  style="text-align:right"
										name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分" field="ecologyScore"
										id="ecologyScore" onchange="checkNum(this.id)" style="width: 50px"
										maxlength="5" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例原因" style="width: 400px" disabled="disabled" 
										field="ecologyReason" ></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿化覆盖率</td>
									<td class="FieldLabel"><label type="text" name="绿化覆盖率"  style="text-align:right"
									field="greenCoverageNum" id="greenCoverageNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><label type="text" name="绿化覆盖率得分"  style="text-align:right"
										field="greenCoverageScore" id="greenCoverageScore" style="width: 50px"
										onchange="checkNum(this.id)" maxlength="5" /> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿化覆盖率原因"
										style="width: 400px" field="greenCoverageReason" disabled="disabled"  ></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿地面积和占总面积的比例</td>
									<td class="FieldLabel"><label type="text" name="绿地面积和占总面积的比例" style="text-align:right"
									field="greenareaRatioNum" id="greenareaRatioNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><label type="text"
										name="绿地面积和占总面积的比例得分" field="greenareaRatioScore"
										id="greenareaRatioScore" onchange="checkNum(this.id)" style="text-align:right"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="绿地面积和占总面积的比例原因" style="width: 400px" disabled="disabled" 
										field="greenareaRatioReason" ></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><label type="text"
										name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分" style="text-align:right"
										field="burialTombScore" id="burialTombScore"
										onchange="checkNum(this.id)" maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）原因" style="width: 400px" disabled="disabled" 
										field="burialTombReason" ></textarea> </td>

								</tr>
								<tr>
									<td rowspan="8" class="FieldLabel" style="text-align:left">公墓管理(23分)</td>
									<td class="FieldLabel" colspan="2" style="text-align:left">墓区建设地点和规模与申报材料相符</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><label type="text"
										name="墓区建设地点和规模与申报材料相符得分" field="burialConformScore" style="text-align:right"
										id="burialConformScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓区建设地点和规模与申报材料相符原因" style="width: 400px" disabled="disabled" 
										field="burialConformReason" ></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">无违法出租或买卖墓穴（格位）现象</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"
										name="无违法出租或买卖墓穴（格位）现象得分" field="nooffenseScore" style="text-align:right"
										id="nooffenseScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="无违法出租或买卖墓穴（格位）现象原因" style="width: 400px" disabled="disabled" 
										field="nooffenseReason" ></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><label type="text"
										name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分" style="text-align:right"
										field="acceptanceComplianceScore"
										id="acceptanceComplianceScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定原因" style="width: 400px" disabled="disabled" 
										field="acceptanceComplianceReason" ></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">公墓更名符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"
										name="公墓更名符合《山东省公墓管理办法》规定得分" field="changeComplianceScore" style="text-align:right"
										id="changeComplianceScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="公墓更名符合《山东省公墓管理办法》规定原因" style="width: 400px" disabled="disabled" 
										field="changeComplianceReason" ></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">墓区管理机构的组建与申报报告相符</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"
										name="墓区管理机构的组建与申报报告相符得分" field="agenciesScore" style="text-align:right"
										id="agenciesScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓区管理机构的组建与申报报告相符原因" style="width: 400px" disabled="disabled" 
										field="agenciesReason" ></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">工作人员参加省或设区的市人民政府民政部门组织的业务培训</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><label type="text"
										name="工作人员参加省或设区的市人民政府民政部门组织的业务培训得分" style="text-align:right"
										field="businessTrainingScore" id="businessTrainingScore"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="工作人员参加省或设区的市人民政府民政部门组织的业务培训原因" style="width: 400px" disabled="disabled" 
										field="businessTrainingReason" ></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">公墓管理的各项规章制度健全</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"
										name="公墓管理的各项规章制度健全得分" field="systemSoundScore"
										id="systemSoundScore" onchange="checkNum(this.id)" style="text-align:right"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="公墓管理的各项规章制度健全原因" style="width: 400px" disabled="disabled" 
										field="systemSoundReason" ></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有高峰应急预案</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><label type="text"
										name="有高峰应急预案得分" field="contingencyPlansScore" style="text-align:right"
										id="contingencyPlansScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有高峰应急预案原因" style="width: 400px" disabled="disabled" 
										field="contingencyPlansReason" ></textarea> </td>
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

