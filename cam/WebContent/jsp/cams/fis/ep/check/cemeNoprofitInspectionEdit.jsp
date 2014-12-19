<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公益性公墓年检表单</title>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeNoprofitInspectionEdit.js"></script>
<script>
		var cemeId = '<%=request.getParameter("cemeId")%>';
		var wfId = '<%=request.getParameter("wfId")%>';
		var isEdit = '<%=request.getParameter("isEdit")%>';
		var endApplyId = '<%=request.getParameter("endApplyId")%>';
		var newWfId = '<%=IdHelp.getUUID32()%>';
		var newApplyId = '<%=IdHelp.getUUID32()%>';
		var newAuditId = '<%=IdHelp.getUUID32()%>';
		var newScoreId = '<%=IdHelp.getUUID32()%>';
		var newResultId = '<%=IdHelp.getUUID32()%>';
		var checkYear = '<%=request.getParameter("checkYear")%>';
		var checkNumber = '<%=request.getParameter("checkNum")%>';
		var orgCode ='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		var orgName ='<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
<!--公墓基本信息-->
	<model:dataset id="infoDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		global="true" method="queryForCemeInfo">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo">
		 <model:field name="directorMobile" type="string" rule="require" />
         <model:field name="totalArea" type="float" rule="require" />
         <model:field name="yearHoleNum" type="int" rule="require" />
         <model:field name="sinceHoleNum" type="int" rule="require" />
         <model:field name="yearSingleHole" type="int" rule="require" />
         <model:field name="yearDoubleHole" type="int" rule="require" />
         <model:field name="yearMoreHole" type="int" rule="require" />
         <model:field name="singleHole" type="int" rule="require" />
         <model:field name="doubleHole" type="int" rule="require" />
         <model:field name="moreHole" type="int" rule="require" />
         
         <model:field name="yearPeopleNum" type="int" rule="require" />
         <model:field name="sincePeopleNum" type="int" rule="require" />
         <model:field name="yearOutNum" type="int" rule="require" />
         <model:field name="outSingleHole" type="int" rule="require" />
         <model:field name="outDoubleHole" type="int" rule="require" />
         <model:field name="outMoreHole" type="int" rule="require" />
		</model:record>
	</model:dataset>
	
<!--公墓工作流信息-->
	<model:dataset id="wfDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckWfQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckWf">
		</model:record>
	</model:dataset>
	
<!--公墓年检结果信息-->
	<model:dataset id="resultDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckResult">
		</model:record>
	</model:dataset>
	
	<model:dataset id="scoreDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryScore" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckScore">
		 <model:field name="businesscertificateScore" type="int" rule="require" />
         <model:field name="businesslicenseScore" type="int" rule="require" />
         <model:field name="purchasegravesScore" type="int" rule="require" />
         <model:field name="feeScore" type="int" rule="require" />
         <model:field name="pledgeScore" type="int" rule="require" />
         <model:field name="staffresponsibilitiesScore" type="int" rule="require" />
         <model:field name="officeTimeScore" type="int" rule="require" />
         <model:field name="boxesandbagsScore" type="int" rule="require" />
         <model:field name="deathcertificateScore" type="int" rule="require" />
         <model:field name="propergraveScore" type="int" rule="require" />
         <model:field name="ashescontractScore" type="int" rule="require" />
         <model:field name="contractoridScore" type="int" rule="require" />
         <model:field name="othermaterialsScore" type="int" rule="require" />
         <model:field name="tombstoneTwentyScore" type="int" rule="require" />
         <model:field name="tombstoneFiftyScore" type="int" rule="require" />
         <model:field name="tombstoneoverfiftyScore" type="int" rule="require" />
         <model:field name="roadsafetyScore" type="int" rule="require" />
         <model:field name="civilizationMemorialScore" type="int" rule="require" />
         <model:field name="fireMemorialScore" type="int" rule="require" />
         <model:field name="ecologyScore" type="int" rule="require" />
         <model:field name="greenCoverageScore" type="int" rule="require" />
         <model:field name="greenareaRatioScore" type="int" rule="require" />
         <model:field name="burialTombScore" type="int" rule="require" />
         <model:field name="burialConformScore" type="int" rule="require" />
         <model:field name="nooffenseScore" type="int" rule="require" />
         <model:field name="acceptanceComplianceScore" type="int" rule="require" />
         <model:field name="changeComplianceScore" type="int" rule="require" />
         <model:field name="agenciesScore" type="int" rule="require" />
         <model:field name="businessTrainingScore" type="int" rule="require" />
         <model:field name="systemSoundScore" type="int" rule="require" />
         <model:field name="contingencyPlansScore" type="int" rule="require" />
         <model:field name="tombstoneTwentyNum" type="int" rule="require" />
         <model:field name="tombstoneFiftyNum" type="int" rule="require" />
         <model:field name="tombstoneoverfiftyNum" type="int" rule="require" />
         <model:field name="ecologyNum" type="float" rule="require" />
         <model:field name="greenCoverageNum" type="float" rule="require" />
         <model:field name="greenareaRatioNum" type="float" rule="require" />
		</model:record>
	</model:dataset>
	
	<model:dataset id="accessoriesDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryAccessories" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeAccessories">
		</model:record>
	</model:dataset>
	<!--政府部门批准文号-->
	<model:dataset id="govAppDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeGovApprovalCmd"
		global="true" autoLoad="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeGovApproval">
		</model:record>
		<model:params>
			<model:param name="CEME_ID" value='<%=request.getParameter("cemeId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="accessoriesItemDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryAccessoriesItem" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeAccessories"></model:record>
	</model:dataset>
	
	<model:dataset id="accessoriesType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CEME_ACCESSORIES_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<model:dataset id="auditDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryAudit" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit">
		</model:record>
	</model:dataset>

	<model:dataset id="gongmuxingzhiDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="jiliangdanweiDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="inspectionDataSet" enumName="FIS.CEME.RESULT"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel width="100%" height="100%">
			<next:TopBar>
				<next:ToolBarItem symbol="公益性公墓年检"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="export" text="上报" handler="reportClick" />
				<next:ToolBarItem iconCls="return" text="返回" handler="returnClick" />
			</next:TopBar>

			<next:TabPanel width="100%" height="100%" id="tab">
				<next:Tabs>
					<!-- 公墓基本信息 -->
					<next:Panel title="公墓信息" width="100%" height="100%" id="info"
						autoScroll="true">
						<next:Panel>
						<next:Html>
							<form id="InspectionForm" method="post" dataset="infoDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>公墓基本信息</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width: 20%">公墓名称</td>
									<td class="FieldInput"><label id="cemeName" name="公墓名称"
										field="cemeName" title="补录公墓的全称" style="width: 200px;" /></td>
									<td class="FieldLabel">主管单位</td>
									<td class="FieldInput"><label name="主管单位" id="manaLevel"
										field="manaLevel" readonly="readonly" /> <input type="text"
										id="manaLevelId" field="manaLevelId" style="display: none;" />
								</tr>
								<tr>
									<td class="FieldLabel">主办单位</td>
									<td class="FieldInput"><label name="主办单位"
										style="width: 200px;" field="organizer" />
									<td class="FieldLabel" style="width: 20%">公墓编号</td>
									<td class="FieldInput" style="width: 31%"><label
										id="cemeId" name="公墓编号" field="cemeId"
										title="省厅民政部门授予的组织编码，全省唯一\n请按主管单位的批准时间编写公墓顺序号" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓负责人</td>
									<td class="FieldInput"><input type="text" name="公墓负责人"
										field="legalPerson" maxlength="25" /></td>
									<td class="FieldLabel">公墓性质</td>
									<td class="FieldInput"><label title="公墓性质">公益性</label> <input
										type="hidden" name="prop" field="prop" title="公墓性质"></input></td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓负责人手机</td>
									<td class="FieldInput"><input type="text" name="公墓负责人手机"
										id="directorMobile" field="directorMobile" maxlength="16"
										onchange="checkNum(this.id)" /></td>
									<td class="FieldLabel">正式使用时间</td>
									<td class="FieldInput"><label name="正式使用时间"
										field="gestionTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 20%">公墓占地面积</td>
									<td class="FieldInput"><input type="text" name="公墓占地面积"
										style="text-align: right" field="totalArea" id="totalArea"
										onchange="checkAssMon(this.id)" maxlength="10" />亩 <!--&nbsp;&nbsp;<select name="公墓占地面积计量单位" id="totalAreaUnits"
										field="totalAreaUnits" style="width: 80px;">
										<option dataset="AreaUnitsDataSet"></option>
										</select>
									--></td>
									<td class="FieldLabel">资金来源</td>
									<td class="FieldInput"><input type="checkbox" name="资金来源"
										value="1" id="fundSources" field="fundSources"
										disabled="disabled"> <label>财政拨款</label> <input
										type="checkbox" name="资金来源" value="2" id="fundSources"
										field="fundSources" disabled="disabled"> <label>上级部门拨款</label>
									<input type="checkbox" name="资金来源" value="3" id="fundSources"
										field="fundSources" disabled="disabled"> <label>自筹</label>
									<br />
									<input type="checkbox" name="资金来源" value="4" id="fundSources"
										field="fundSources" disabled="disabled"> <label>福彩资助</label>
									<input type="checkbox" name="资金来源" value="5" id="fundSources"
										field="fundSources" disabled="disabled"> <label>其他</label></td>

								</tr>
								<tr>
									<td class="FieldLabel">所属行政区</td>
									<td class="FieldInput"><label name="所属行政区" id="areaLevel"
										field="areaLevel" /></td>
									<td class="FieldLabel">公墓所在位置</td>
									<td class="FieldInput"><label name="公墓所在位置"
										field="address" style="width: 300px" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">服务范围</td>
									<td class="FieldInput" colspan="5"><textarea rows="3"
										name='服务范围' field="serviceScope" style="width: 90%"
										readonly="readonly"></textarea></td>

								</tr>
							</table>
							</fieldset>
						
							</form>
						</next:Html>
						</next:Panel>
						<next:GridPanel title="政府部门批准文号" id="govAppGridPanel"
				name="govAppGridPanel" stripeRows="true" height="200" width="99%"
				dataset="govAppDs" notSelectFirstRow="true">
				<next:Columns>
					<next:Column id="cemeId" header="公墓ID" field="cemeId" width="160"
							sortable="false" editable="false" hidden="true">
							<next:TextField />
						</next:Column>
					<next:Column id="deptId" header="文号类型" field="deptId" width="160"
						sortable="false" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column id="deptNum" header="文号" field="deptNum" width="220"
						sortable="false">
						<next:TextField />
					</next:Column>
					<next:Column id="deptTime" header="批准时间" field="deptTime"
						width="110" sortable="false">
						<next:DateField allowBlank="false" format="Y-m-d" />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
						<next:PagingToolBar dataset="govAppDs" />
					</next:BottomBar>
				</next:GridPanel>
						<next:Panel>
						<next:Html>
							<form id="InspectionForm2" method="post" dataset="infoDataSet"
								onsubmit="return false" class="L5form">
						
							<fieldset><legend>公墓安葬信息</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width: 21%">本年安葬总人数:</td>
									<td class="FieldInput" colspan="3"><input type="text"
										name="本年安葬总人数" maxlength="10" field="yearPeopleNum"
										id="yearPeopleNum" onchange="checkNum(this.id)" style="text-align:right"/></td>
									<td class="FieldLabel" colspan="2" style="width: 21%">自使用至今安葬总人数:</td>
									<td class="FieldInput" style="width: 32%" colspan="3"><input
										type="text" name="自使用至今安葬总人数" maxlength="10"
										field="sincePeopleNum" id="sincePeopleNum"
										onchange="checkNum(this.id)" style="text-align:right"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年安葬墓穴数:</td>
									
									<td class="FieldLabel"  style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴安葬数(本年)" style="text-align:right"
										field="yearSingleHole" id="yearSingleHole" onblur="getNum()"
										onchange="checkNum(this.id)" maxlength="10" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput" ><input type="text" name="双穴安葬数(本年)" style="text-align:right" onblur="getNum()"
										field="yearDoubleHole" id="yearDoubleHole"
										onchange="checkNum(this.id)" maxlength="10" style="width: 80px" /></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴安葬数(本年)" style="text-align:right" onblur="getNum()"
										field="yearMoreHole" id="yearMoreHole"
										onchange="checkNum(this.id)" maxlength="10" style="width: 80px"/></td>
								    <td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="本年安葬墓穴数合计" style="text-align:right"
										field="yearHoleNum" id="yearHoleNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年迁出墓穴数:</td>
									
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴迁出数(本年)" style="text-align:right" onblur="getNum()"
										field="outSingleHole" id="outSingleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><input type="text" name="双穴迁出数(本年)" style="text-align:right" onblur="getNum()"
										field="outDoubleHole" id="outDoubleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴迁出数(本年)" style="text-align:right" onblur="getNum()"
										field="outMoreHole" id="outMoreHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
								    <td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="本年迁出墓穴数合计" style="text-align:right" 
										field="yearOutNum" id="yearOutNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px"/></td>
								</tr>  
								<tr>
									<td class="FieldLabel">自使用至今安葬穴数:</td>
									
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴安葬数(自使用至今)" style="text-align:right" onblur="getNum()"
										field="singleHole" id="singleHole"
										onchange="checkNum(this.id)" maxlength="10" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><input type="text" name="双穴安葬数(自使用至今)" style="text-align:right" onblur="getNum()"
										field="doubleHole" id="doubleHole"
										onchange="checkNum(this.id)" maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴安葬数(自使用至今)" style="text-align:right" onblur="getNum()"
										field="moreHole" id="moreHole" onchange="checkNum(this.id)"
										maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="自使用至今安葬穴位数合计" style="text-align:right"
										field="sinceHoleNum" id="sinceHoleNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px"/></td>
								</tr>

							</table>
							</fieldset>
							</form>
						</next:Html>
						</next:Panel>
						<next:Panel>
						
					</next:Panel>
					</next:Panel>
			
					<!-- 公墓年检标准 -->
					<next:Panel title="公墓年检标准" height="100%" width="100%"
						autoScroll="true">
						<next:Html>
							<form id="editForm" method="post" dataset="scoreDataSet"
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
									<td class="FieldInput" ><input type="text"
										name="县级民政部门批准建设文件得分" field="businesscertificateScore" style="text-align:right"
										id="businesscertificateScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput" width="35%"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="县级民政部门批准建设文件扣分加分原因" style="width: 400px"  
										field="businesscertificateReason" id="businesscertificateReason"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">本公益性公墓管理章程</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text"
										name="本公益性公墓管理章程得分" field="businesslicenseScore" style="text-align:right"
										id="businesslicenseScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" 
										name="本公益性公墓管理章程原因" style="width: 400px"
										field="businesslicenseReason" id="businesslicenseReason"></textarea></td>
								</tr> 
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">安葬(安放)墓穴(格位)的条件和程序</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput"><input type="text"
										name="安葬（安放）墓穴（格位）的条件和程序得分" field="purchasegravesScore"
										id="purchasegravesScore" onchange="checkNum(this.id)" style="text-align:right"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="安葬（安放）墓穴（格位）的条件和程序原因" style="width: 400px" 
										field="purchasegravesReason" id="purchasegravesReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">收费项目、收费标准、收费依据等价格公示内容</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text"
										name="收费项目、收费标准、收费依据等价格公示内容得分" field="feeScore" id="feeScore" style="text-align:right"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="收费项目、收费标准、收费依据等价格公示内容原因" style="width: 400px" 
										field="feeReason" id="feeReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">服务承诺</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><input type="text" name="服务承诺得分"
										field="pledgeScore" id="pledgeScore" style="text-align:right"
										onchange="checkNum(this.id)" maxlength="5" style="width: 50px" /> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="服务承诺原因" 
										style="width: 400px" field="pledgeReason" id="pledgeReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">工作人员职责及照片、编号</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="工作人员职责及照片、编号得分" field="staffresponsibilitiesScore"
										id="staffresponsibilitiesScore" style="width: 50px"
										onchange="checkNum(this.id)" maxlength="5" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="工作人员职责及照片、编号原因" style="width: 400px" 
										field="staffresponsibilitiesReason" id="staffresponsibilitiesReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">服务时间、地点、电话和监督电话</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="服务时间、地点、电话和监督电话得分" field="officeTimeScore"
										id="officeTimeScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="服务时间、地点、电话和监督电话原因" style="width: 400px" 
										field="officeTimeReason" id="officeTimeReason"></textarea></td>

								</tr>
								<tr>
									<td rowspan="6" class="FieldLabel" style="text-align:left">墓穴(格位)档案管理(16分)</td>
									<td class="FieldLabel" colspan="2" style="text-align:left">使用全省统一的卷盒和卷袋</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="使用全省统一的卷盒和卷袋得分" field="boxesandbagsScore"
										id="boxesandbagsScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="使用全省统一的卷盒和卷袋原因" style="width: 400px" 
										field="boxesandbagsReason" id="boxesandbagsReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有死亡证明或火化证明的复印件</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="有死亡证明或火化证明的复印件得分" field="deathcertificateScore"
										id="deathcertificateScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有死亡证明或火化证明的复印件原因" style="width: 400px" 
										field="deathcertificateReason" id="deathcertificateReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有骨灰安放(葬)协议、补充签订的协议</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="有骨灰安放（葬）协议、补充签订的协议得分" field="propergraveScore"
										id="propergraveScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有骨灰安放（葬）协议、补充签订的协议原因" style="width: 400px" 
										field="propergraveReason" id="propergraveReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有丧事承办人签名的骨灰安放(葬)处理表</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="有丧事承办人签名的骨灰安放（葬）处理表得分" field="ashescontractScore"
										id="ashescontractScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有丧事承办人签名的骨灰安放（葬）处理表原因" style="width: 400px" 
										field="ashescontractReason" id="ashescontractReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有丧事承办人的有效身份证件复印件</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="有丧事承办人的有效身份证件复印件得分" field="contractoridScore"
										id="contractoridScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有丧事承办人的有效身份证件复印件原因" style="width: 400px" 
										field="contractoridReason" id="contractoridReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有其他应当归档的材料</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="有其他应当归档的材料得分" field="othermaterialsScore"
										id="othermaterialsScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有其他应当归档的材料原因" style="width: 400px" 
										field="othermaterialsReason" id="othermaterialsReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="3" class="FieldLabel" style="text-align:left">墓穴建设(16分)</td>
									<td class="FieldLabel" style="text-align:left" style="width: 30%">墓穴面积或墓碑高度超过规定标准20%以下的个数</td>
									<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数" style="text-align:right"
									field="tombstoneTwentyNum" id="tombstoneTwentyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text"
										name="墓穴面积或墓碑高度超过规定标准20%以下的个数得分" field="tombstoneTwentyScore" style="text-align:right"
										id="tombstoneTwentyScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴面积或墓碑高度超过规定标准20%以下的个数原因" style="width: 400px" 
										field="tombstoneTwentyReason" id="tombstoneTwentyReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准20%至50%的个数</td>
									<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准20%至50%的个数" style="text-align:right"
									field="tombstoneFiftyNum" id="tombstoneFiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><input type="text"
										name="墓穴面积或墓碑高度超过规定标准20%至50%的个数得分" field="tombstoneFiftyScore"
										id="tombstoneFiftyScore" onchange="checkNum(this.id)" style="text-align:right"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴面积或墓碑高度超过规定标准20%至50%的个数原因" style="width: 400px" 
										field="tombstoneFiftyReason" id="tombstoneFiftyReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准50%以上的个数</td>
									<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数" style="text-align:right"
									field="tombstoneoverfiftyNum" id="tombstoneoverfiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">8</td>
									<td class="FieldInput"><input type="text"
										name="墓穴面积或墓碑高度超过规定标准50%以上的个数得分"
										field="tombstoneoverfiftyScore" id="tombstoneoverfiftyScore" style="text-align:right"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴面积或墓碑高度超过规定标准50%以上的个数原因" style="width: 400px" 
										field="tombstoneoverfiftyReason" id="tombstoneoverfiftyReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="7" class="FieldLabel" style="text-align:left">墓区管理(30分)</td>
									<td class="FieldLabel" colspan="2" style="text-align:left">道路畅通，安全防护措施到位</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text"
										name="道路畅通，安全防护措施到位得分" field="roadsafetyScore"
										id="roadsafetyScore" onchange="checkNum(this.id)" style="text-align:right"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="道路畅通，安全防护措施到位原因" style="width: 400px" 
										field="roadsafetyReason" id="roadsafetyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有文明祭奠举措,无封建迷信活动</td>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="有文明祭奠举措，无封建迷信活动得分" field="civilizationMemorialScore"
										id="civilizationMemorialScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有文明祭奠举措，无封建迷信活动原因" style="width: 400px" 
										field="civilizationMemorialReason" id="civilizationMemorialReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">允许明火祭奠的,设立固定明火祭奠设施、开设防火隔离带等措施,并经县（市、区）以上林业部门审批</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分"
										field="fireMemorialScore" id="fireMemorialScore"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批原因"
										style="width: 400px" field="fireMemorialReason" id="fireMemorialReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例(%)</td>
									<td class="FieldLabel"><input type="text" name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例" style="text-align:right"
									field="ecologyNum" id="ecologyNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><input type="text"
										name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分" field="ecologyScore"
										id="ecologyScore" onchange="checkNum(this.id)" style="width: 50px" style="text-align:right"
										maxlength="5" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例原因" style="width: 400px"
										field="ecologyReason" id="ecologyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿化覆盖率(%)</br>(注：指绿化植物的垂直投影面积占总用地面积的比值.)</td>
									<td class="FieldLabel"><input type="text" name="绿化覆盖率" style="text-align:right"
									field="greenCoverageNum" id="greenCoverageNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><input type="text" name="绿化覆盖率得分" style="text-align:right"
										field="greenCoverageScore" id="greenCoverageScore" style="width: 50px"
										onchange="checkNum(this.id)" maxlength="5" /> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿化覆盖率原因"
										style="width: 400px" field="greenCoverageReason" id="greenCoverageReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿地面积和占总面积的比例(%)</td>
									<td class="FieldLabel"><input type="text" name="绿地面积和占总面积的比例" style="text-align:right"
									field="greenareaRatioNum" id="greenareaRatioNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">5</td>
									<td class="FieldInput"><input type="text"
										name="绿地面积和占总面积的比例得分" field="greenareaRatioScore"
										id="greenareaRatioScore" onchange="checkNum(this.id)" style="text-align:right"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="绿地面积和占总面积的比例原因" style="width: 400px"
										field="greenareaRatioReason" id="greenareaRatioReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">按照所购墓穴(格位)标准进行安葬或安放,无自行改建墓穴(格位)</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><input type="text"
										name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分" style="text-align:right"
										field="burialTombScore" id="burialTombScore"
										onchange="checkNum(this.id)" maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）原因" style="width: 400px"
										field="burialTombReason" id="burialTombReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="8" class="FieldLabel" style="text-align:left">公墓管理(23分)</td>
									<td class="FieldLabel" colspan="2" style="text-align:left">墓区建设地点和规模与申报材料相符</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="墓区建设地点和规模与申报材料相符得分" field="burialConformScore"
										id="burialConformScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓区建设地点和规模与申报材料相符原因" style="width: 400px"
										field="burialConformReason" id="burialConformReason"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">无违法出租或买卖墓穴(格位)现象</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="无违法出租或买卖墓穴（格位）现象得分" field="nooffenseScore"
										id="nooffenseScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="无违法出租或买卖墓穴（格位）现象原因" style="width: 400px"
										field="nooffenseReason" id="nooffenseReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分"
										field="acceptanceComplianceScore"
										id="acceptanceComplianceScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定原因" style="width: 400px"
										field="acceptanceComplianceReason" id="acceptanceComplianceReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">公墓更名符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="公墓更名符合《山东省公墓管理办法》规定得分" field="changeComplianceScore"
										id="changeComplianceScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="公墓更名符合《山东省公墓管理办法》规定原因" style="width: 400px"
										field="changeComplianceReason" id="changeComplianceReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">墓区管理机构的组建与申报报告相符</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text" style="text-align:right"
										name="墓区管理机构的组建与申报报告相符得分" field="agenciesScore"
										id="agenciesScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓区管理机构的组建与申报报告相符原因" style="width: 400px"
										field="agenciesReason" id="agenciesReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">工作人员参加省或设区的市人民政府民政部门组织的业务培训</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput"><input type="text"
										name="工作人员参加省或设区的市人民政府民政部门组织的业务培训得分" style="text-align:right"
										field="businessTrainingScore" id="businessTrainingScore"
										onchange="checkNum(this.id)" maxlength="5"  style="width: 50px"/> </td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="工作人员参加省或设区的市人民政府民政部门组织的业务培训原因" style="width: 400px"
										field="businessTrainingReason" id="businessTrainingReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">公墓管理的各项规章制度健全</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text"
										name="公墓管理的各项规章制度健全得分" field="systemSoundScore" style="text-align:right"
										id="systemSoundScore" onchange="checkNum(this.id)"
										maxlength="5"  style="width: 50px"/></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="公墓管理的各项规章制度健全原因" style="width: 400px"
										field="systemSoundReason" id="systemSoundReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" colspan="2" style="text-align:left">有高峰应急预案</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"><input type="text"
										name="有高峰应急预案得分" field="contingencyPlansScore" style="text-align:right"
										id="contingencyPlansScore" onchange="checkNum(this.id)"
										maxlength="5" style="width: 50px" /></td>
									<td class="FieldInput"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="有高峰应急预案原因" style="width: 400px"
										field="contingencyPlansReason" id="contingencyPlansReason"></textarea> </td>
								</tr>
							</table>
							</fieldset>
							</form>
						</next:Html>
					</next:Panel>
					<!-- 分数合计及年检报告 -->
					<next:Panel title="分数合计及年检报告" height="100%" width="100%"
						autoScroll="true" id="statisticalScore">
						<next:Html>
							<form id="editForm" method="post" dataset="auditDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>分数合计</legend>
							<table width="100%" align="center">
								<tr>
									<td class="FieldLabel" width="24%">总得分:</td>
									<td class="FieldInput" colspan="3" width="76%"><input style="text-align:right"
										type="text" readonly="readonly" name="总得分" field="totalScore" maxlength="6" /></td>
								</tr>
							</table>
							</fieldset>
							<fieldset><legend>年检记录</legend>
							<div id="second" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" rowspan="2" width="100px;">年
									检</td>
									<td class="FieldLabel">年检时间</td>
									<td class="FieldInput"><input type="text" name="年检时间" 
										field="secondTime" readonly="readonly" format="Y-m-d"
										onclick="LoushangDate(this)" /></td>
									<td class="FieldLabel">年检结果</td>
									<td class="FieldInput"><select name="年检结果"
										field="secondResult">
										<option dataset="inspectionDataSet"></option></td>
								</tr>

								<tr>
									<td class="FieldLabel" width="100px;">年检报告:</td>
									<td class="FieldInput" colspan="3"><textarea onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="30" 
										style="width: 80%" name="年检报告" field="annuareport" id="annuareport"></textarea><font color="red">*可输入1000字</font></td>
								</tr>
							</table>
							</fieldset>
							</form>
						</next:Html>
					</next:Panel>

					<!-- 业务材料 -->

					<next:Panel title="业务材料">
						<next:EditGridPanel id="uploadGrid" width="99.9%"
							stripeRows="true" height="100%" dataset="accessoriesDataSet">
							<next:TopBar>
								<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="add" text="附件管理"
									handler="clickUploadFile"></next:ToolBarItem>
							</next:TopBar>

							<next:Columns>
								<next:RowNumberColumn />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column header="材料类型" field="code" width="40%"
									editable="false" dataset="accessoriesType">
									<next:TextField />
								</next:Column>
								<next:Column header="附件名称" field="accessoriesName" width="30%"
									editable="false">
									<next:TextField />
								</next:Column>
								<next:Column header="附件描述" field="note" width="28%"
									editable="false" >
									<next:TextField />
								</next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="accessoriesDataSet" />
							</next:BottomBar>
						</next:EditGridPanel>
					</next:Panel>

				</next:Tabs>
			</next:TabPanel>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>


<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230"
	width="666" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;"
			class="L5form">
		<table border="1" width="100%">

			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file"
					type="file" id="files" name="files" style="width: 95%; height: 40" /></br>
				<span style="color: red">上传文件最大不能超过5M</span></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width: 80%"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"  
					id="fileMess" rows="5" style="width: 95%"  ></textarea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
<!-- 下载附件列表 -->
<next:Window id="uploadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件"
				handler="addUploadFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭"
				handler="closeUploadList"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件名称" width="18%" field="accessoriesName"
				editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="附件描述" width="15%" field="note" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="删除附件" field="" width="10%" editable="false"
				renderer="delUploadFile">
				<next:TextField />
			</next:Column>
			<next:Column header="下载附件" field="" width="10%" editable="false"
				renderer="downloadUploadFile">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="accessoriesItemDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>
