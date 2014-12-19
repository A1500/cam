<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>烈士纪念建筑物保护单位信息</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var organName = '<%=BspUtil.getOrganName()%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="bptmartyrbuildings_edit.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>  
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
	<model:dataset id="BptMartyrBuildingsLegalDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsLegalCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildingsLegal"></model:record>
	</model:dataset>
	<!-- 是否爱国主义教育基地 -->
	<model:dataset id="patrioticEBase" enumName="COMM.YESORNO" global="true" autoLoad="true">
	</model:dataset>
	<!-- 是否红色旅游精品景点 -->
	<model:dataset id="redSSpots" enumName="COMM.YESORNO" global="true" autoLoad="true">
	</model:dataset>
	<!-- 行政级别 -->
	<model:dataset id="administrativelevel" enumName="BPT.BUILDINGADMINISTRATIVELEVEL" autoLoad="true" global="true"></model:dataset>
		<!-- 单位性质 -->
	<model:dataset id="unitsnature" enumName="BPT.UNITSNATURE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 专业职称 -->
	<model:dataset id="majorJobName" enumName="BPT.MAJORJOBNAME.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
		<next:Panel bodyStyle="width:100%;height:100%">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
			</next:TopBar>
			<next:TabPanel id="tabPanel">
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
									<td class="FieldLabel" style="width: 15%" nowrap>行政区划:</td>
									<td class="FieldInput" style="width: 35%">
										<input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:90%" onclick="func_ForDomicileSelect1()" readonly="readonly"/>
										<input type="hidden" name="domicileCode" field="domicileCode" /><font color="red">*</font>
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>单位全称:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="unitFullname" field="unitFullname" /><font
										color="red">*</font></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>主管部门:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="personSection" field="personSection" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>建立日期:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" format="Y-m-d" maxlength="10"
										name="creationDate" field="creationDate" onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>行政级别:</td>
									<td class="FieldInput" style="width: 35%"><select name="administrativelevel" field="administrativelevel">
									<option dataset="administrativelevel"/>
									</select>
		
									<td class="FieldLabel" style="width: 15%" nowrap>单位性质:</td>
									<td class="FieldInput" style="width: 35%"><select name="unitsnature" field="unitsnature">
									<option dataset="unitsnature">
									</select>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>注册资产(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="registerProperty" field="registerProperty" /><font
										color="red">*</font></td>

									<td class="FieldLabel" style="width: 15%" nowrap>固定资产原值(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="immobilisations" field="immobilisations" /><font
										color="red">*</font></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>占地面积(平方米):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="floorArea" field="floorArea" /><font
										color="red">*</font></td>

									<td class="FieldLabel" style="width: 15%" nowrap>业务用房面积(平方米):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="businessArea" field="businessArea" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>联系电话:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="telContact" field="telContact" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>邮政编码:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="postcode" field="postcode" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>通信地址:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><textarea
										rows="2" cols="125%" name="mailingAddress"
										field="mailingAddress"></textarea></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>单位介绍:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><textarea
										name="unitIntroduce" field="unitIntroduce" rows="3"
										cols="125%"></textarea></td>
								</tr>

								<tr>
									<td class="FieldInput" colspan="4">人员情况</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>编制人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="prepareNum" field="prepareNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>年末职工人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="yearWorkerNum" field="yearWorkerNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>初级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="primaryTitleNum" field="primaryTitleNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>中级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="intermediateTitleNum"
										field="intermediateTitleNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>高级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="seniorTitleNum" field="seniorTitleNum" /></td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>

								<tr>
									<td class="FieldInput" colspan="4">经费情况(万元)</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>中央划拨维修改造经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="centralFunds" field="centralFunds" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>地方下拨的维修改造经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="placeFunds" field="placeFunds" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>办公经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="officialFunds" field="officialFunds" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>人员工资(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="personnelFunds" field="personnelFunds" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>其他经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="otherFunds" field="otherFunds" /></td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>
								<tr>
									<td class="FieldInput" colspan="4">褒扬情况</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>重点保护单位批准级别:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="protectionUnit" field="protectionUnit" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>批准时间:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="noticeDate" field="noticeDate" format="Y-m-d" 
										maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>安葬烈士人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="burialMartyrsNum" field="burialMartyrsNum" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>陈展烈士人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="showMartyrsNum" field="showMartyrsNum" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>接待瞻仰人次:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="receptionLookedNum"
										field="receptionLookedNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>革命文物数量:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="americanaNum" field="americanaNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>烈士纪念设施数量:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="martyrFacilityNum" field="martyrFacilityNum" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>是否爱国主义教育基地:</td>
									<td class="FieldInput" style="width: 35%">
									<select name="patrioticEducationBase" field="patrioticEducationBase">
										<option dataset="patrioticEBase" />
									</select>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>是否红色旅游精品景点:</td>
									<td class="FieldInput" style="width: 35%">
									<select name="redScenicSpots" field="redScenicSpots">
										<option dataset="redSSpots" />
									</select>
									</td>

									<td class="FieldLabel" style="width: 15%">&nbsp;</td>
									<td class="FieldInput" style="width: 35%">&nbsp;</td>
								</tr>

								<input type="hidden" name="regId" field="regId" />
								<!-- 录入人ID: -->
								<input type="hidden" name="regTime" field="regTime" />
								<!-- 录入时间: -->
								<input type="hidden" name="modId" field="modId" />
								<!-- 修改人ID: -->
								<input type="hidden" name="modTime" field="modTime" />
								<!-- 修改时间: -->

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
									<td class="FieldInput" style="width: 35%" colspan="3">
									<textarea rows="3" cols="125%" name="note" field="note" />
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
								<td class="FieldInput" colspan="4">法人代表信息</td>
							</tr>
								<input type="hidden" name="legalId" field="legalId" /><!-- ID -->
							<tr>
								<td class="FieldLabel" style="width: 15%">姓名:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
								name="name" field="name" /><font color="red">*</font></td>

								<td class="FieldLabel" style="width: 15%">身份证号码:</td>
								<td class="FieldInput" style="width: 50%"><input type="text" onchange="backMsgByIdCard('BptMartyrBuildingsLegalDataSet',this)"
								name="idCord" field="idCord" maxlength="18" style="width:55%"/><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">民族:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="nation" field="nation">
									<option dataset="NationDataset"/>
								</select><font color="red">*</font>
								</td>

								<td class="FieldLabel" style="width: 15%">性别:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="sex" field="sex">
									<option dataset="SexDataset"/>
								</select><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">出生日期:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
							 id="birthday"	name="birthday" field="birthday" format="Y-m-d" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>

								<td class="FieldLabel" style="width: 15%">所学专业:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
								name="learnMajor" field="learnMajor" style="width:55%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">专业职称:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="majorJob" field="majorJob" title="专业职称">
									 <option dataset="majorJobName"></option>
								</select></td>

								<td class="FieldLabel" style="width: 15%">文化程度:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="cultureDegree" field="cultureDegree" title="文化程度">
								 <option dataset="EducationDataset"></option>
							   </select>
								</td>
							</tr>
							<tr> 
								<td class="FieldLabel" style="width: 15%">联系电话:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
								name="telContact" field="telContact" /></td>
								
								<td class="FieldLabel" style="width: 15%">&nbsp;</td>
								<td class="FieldInput" style="width: 35%">&nbsp;</td>
							</tr>
							<input type="hidden" name="regId" field="regId" />
							<!-- 录入人ID: -->
							<input type="hidden" name="regTime" field="regTime" />
							<!-- 录入时间: -->
							<input type="hidden" name="modId" field="modId" />
							<!-- 修改人ID: -->
							<input type="hidden" name="modTime" field="modTime" />
							<!-- 修改时间: -->
							<input type="hidden" name="hospitalId" field="hospitalId" />
							<!-- 医院信息ID: -->
							
							<tr>
								<td class="FieldLabel" style="width: 15%">备注:</td>
								<td class="FieldInput" style="width: 35%" colspan="3">
								<textarea rows="3" cols="125%" name="note" field="note" ></textarea>	
								</td>
							</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
				</next:Tabs>
			</next:TabPanel>
		</next:Panel>
</body>
</html>
