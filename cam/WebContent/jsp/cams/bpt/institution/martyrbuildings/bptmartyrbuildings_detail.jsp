<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>烈士纪念建筑物保护单位信息</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src="bptmartyrbuildings_edit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="BptMartyrBuildingsDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings">
			<model:field name="domicileName" type="string" />	
			</model:record>
	</model:dataset>
	<model:dataset id="BptMartyrBuildingsLegalDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsLegalCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否爱国主义教育基地 -->
	<model:dataset id="patrioticEBase"
		enumName="COMM.YESORNO" global="true"
		autoLoad="true">
	</model:dataset>
	<!-- 是否红色旅游精品景点 -->
	<model:dataset id="redSSpots" enumName="COMM.YESORNO"
		global="true" autoLoad="true">
	</model:dataset>
	<!-- 行政级别 -->
	<model:dataset id="administrativelevel" enumName="BPT.BUILDINGADMINISTRATIVELEVEL" autoLoad="true" global="true"></model:dataset>
		<!-- 单位性质 -->
	<model:dataset id="unitsnature" enumName="BPT.UNITSNATURE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

		<next:Panel  bodyStyle="width:100%;height:100%">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print"  text="打印" handler="print"/>
				<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
			</next:TopBar>
			<next:TabPanel>
				<next:Tabs>
					<next:Panel title="烈士纪念建筑物保护单位信息" width="100%" autoScroll="true">
						<next:Html>
							<fieldset>
							<form id="BptMartyrBuildingsForm" method="post"
								dataset="BptMartyrBuildingsDataSet" onsubmit="return false"
								style="padding: 5px;" class="L5form">

							<table border="0" width="100%">

								<input type="hidden" name="mbuildingId" field="mbuildingId" />
								<tr>
									<td class="FieldInput" colspan="4">单位概况</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>行政区划:</td>
									<td class="FieldInput" style="width: 20%"><label
										field="domicileName" /></td>

									<td class="FieldLabel" style="width: 10%" nowrap>单位全称:</td>
									<td class="FieldInput" style="width: 20%"><label
										field="unitFullname" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>主管部门:</td>
									<td class="FieldInput" style="width: 20%"><label
										field="personSection" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>建立日期:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="creationDate" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>行政级别:</td>
									<td class="FieldInput" style="width: 35%"><label name="administrativelevel" field="administrativelevel" dataset="administrativelevel"></label>
		
									<td class="FieldLabel" style="width: 15%" nowrap>单位性质:</td>
									<td class="FieldInput" style="width: 35%"><label name="unitsnature" field="unitsnature" dataset="unitsnature"></label>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>注册资产(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="registerProperty" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>固定资产原值(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="immobilisations" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>占地面积(平方米):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="floorArea" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>业务用房面积(平方米):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="businessArea" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>联系电话:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="telContact" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>邮政编码:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="postcode" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>通信地址:</td>
									<td class="FieldInput" style="width: 35%" height="20"
										colspan="3"><label field="mailingAddress" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>单位介绍:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><label
										field="unitIntroduce" /></td>
								</tr>

								<tr>
									<td class="FieldInput" colspan="4">人员情况</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>编制人数:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="prepareNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>年末职工人数:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="yearWorkerNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>初级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="primaryTitleNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>中级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="intermediateTitleNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>高级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="seniorTitleNum" /></td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>

								<tr>
									<td class="FieldInput" colspan="4">经费情况(万元)</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>中央划拨维修改造经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="centralFunds" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>地方下拨的维修改造经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="placeFunds" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>办公经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="officialFunds" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>人员工资(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="personnelFunds" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>其他经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><label
										field="otherFunds" /></td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>
								<tr>
									<td class="FieldInput" colspan="4">褒扬情况</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>重点保护单位批准级别:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="protectionUnit" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>批准时间:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="noticeDate" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>安葬烈士人数:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="burialMartyrsNum" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>陈展烈士人数:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="showMartyrsNum" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>接待瞻仰人次:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="receptionLookedNum" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>革命文物数量:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="americanaNum" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>烈士纪念设施数量:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="martyrFacilityNum" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>是否爱国主义教育基地:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="patrioticEducationBase" dataset="patrioticEBase" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>是否红色旅游精品景点:</td>
									<td class="FieldInput" style="width: 35%">
										<label field="redScenicSpots" dataset="redSSpots" />
									</td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
									<td class="FieldInput" style="width: 35%" colspan="3">
										<label field="note" />
									</td>
								</tr>

							</table>
							</form>
							</fieldset>
						</next:Html>
					</next:Panel>

					<next:Panel title="法人代表信息" width="100%" autoScroll="true">
						<next:Html>
							<fieldset>
							<form id="BptHospitalLegalForm" method="post"
								dataset="BptMartyrBuildingsLegalDataSet" onsubmit="return false"
								style="padding: 5px;" class="L5form">

							<table border="0" width="98%" cellspacing="0" cellpadding="0">
								<tr>
									<td class="FieldInput" colspan="4">&nbsp;&nbsp;&nbsp;法人代表信息</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>姓名:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="name" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="idCord" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>民族:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="nation" dataset="NationDataset" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>性别:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="sex" dataset="SexDataset" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>出生日期:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="birthday" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>所学专业:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="learnMajor" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>专业职称:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="majorJob" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>文化程度:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="cultureDegree" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>联系电话:</td>
									<td class="FieldInput" style="width: 35%"><label
										field="telContact" /></td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><label
										field="note" /></td>
								</tr>
							</table>
							</form>
							</fieldset>
						</next:Html>
					</next:Panel>
				</next:Tabs>
			</next:TabPanel>
		</next:Panel>
		<input type="hidden" id="docpath"  value="jsp/cams/bpt/institution/print/martyrbuildings.doc"/>
<input type="hidden" id="mbuildingId" name="printQuery" queryData="queryData" value="<%=request.getParameter("dataBean")%>"/>
<input type="hidden" id="method" name="queryData" queryData="queryData" value="printMartyrBuildings"/>
<input type="hidden" id="scaconfPath"  value="dependantApp/dependantAppPrintDao"/>
</body>
</html>
