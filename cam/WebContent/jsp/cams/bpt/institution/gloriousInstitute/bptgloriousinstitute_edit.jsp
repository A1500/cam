<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>光荣院信息</title>
<next:ScriptManager />
<script>
			var idField;
			var years;
			<% 
				if(request.getParameter("dataBean")!=null&&request.getParameter("dataBean")!=""){
			%>
					idField='<%=request.getParameter("dataBean")%>';	
			<%		
				}
			%>
			years='<%=request.getParameter("years")%>';
			<% 
				if(request.getParameter("years")!=null&&request.getParameter("years")!=""){
			%>

			<%		
				}
			%>
			var method='<%=request.getParameter("method")%>';
			var organName = '<%=BspUtil.getOrganName()%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="bptgloriousinstitute_edit.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="BptGloriousInstituteDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousInstituteQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptGloriousDetail">
			<model:field name="domicileName" type="string" />	
			<model:field name="domicileCode" type="string" />
			<model:field name="years" type="string" />
			<model:field name="id" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="BptGloriousLegalDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousLegalCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal">
			<model:field name="majorJobName" type="string" />	
			<model:field name="majorJob" type="string" />	
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
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
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
		<!-- 专业职称 -->
	<model:dataset id="majorJobName" enumName="BPT.MAJORJOBNAME.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 职称 -->
	<model:dataset id="CareerDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_CAREER'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<!-- 优抚医院性质 -->
	<model:dataset id="bptHonorType" enumName="BPT.HONOR.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 建设方式 -->
	<model:dataset id="buildingApproach" enumName="BPT.BUILDINGAPPROACH.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 行政级别 -->
	<model:dataset id="administrativelevel" enumName="BPT.ADMINISTRATIVELEVEL" autoLoad="true" global="true"></model:dataset>
		<!-- 单位性质 -->
	<model:dataset id="unitsnature" enumName="BPT.UNITSNATURE" autoLoad="true" global="true"></model:dataset>
		<!-- 建设状况 -->
	<model:dataset id="buildstatedataset" enumName="BPT.BUILDSTATE" autoLoad="true" global="true"></model:dataset>
		<!-- 有无编委批文-->
	<model:dataset id="approvaldataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

		<next:Panel bodyStyle="width:100%;height:100%">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
			</next:TopBar>
			<next:TabPanel>
				<next:Tabs>
					<next:Panel title="光荣院信息" width="100%" autoScroll="true">
						<next:Html>
							<fieldset>
							<form id="BptGloriousInstituteForm" method="post"
								dataset="BptGloriousInstituteDataSet" onsubmit="return false"
								style="padding: 5px;" class="L5form">
							<table border="0" width="100%">

								<input type="hidden" name="gloriousId" field="gloriousId" />
								<input type="hidden" name="id" field="id" />
								<tr>
									<td colspan="4" class="FieldInput">单位概况</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>年度:</td>
									<td class="FieldInput" style="width: 35%"  colspan="3"><label name="years"  field="years" /></td>
								</tr>
								<tr>
								
									<td class="FieldLabel" style="width: 15%" nowrap>单位全称:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="unitFullname" field="unitFullname" /><font
										color="red">*</font></td>
									<td class="FieldLabel" style="width: 15%" nowrap>行政区划:</td>
									<td class="FieldInput" style="width: 35%">
									<input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:90%" onclick="func_ForDomicileSelect1()" readonly="readonly"/>
									<input type="hidden" id="domicileCode" name="domicileCode" field="domicileCode" /><font color="red">*</font>
									</td>

								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>主管部门:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="personSection" field="personSection" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>建立日期:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" id="creationDate" name="creationDate" field="creationDate" format="Y-m-d" style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
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
									<td class="FieldLabel" style="width: 15%" nowrap>建设状况:</td>
									<td class="FieldInput" style="width: 35%">
										<select type="text" name="buildstate" field="buildstate" >
											<option dataset="buildstatedataset"></option>
										</select>
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>有无编委批文:</td>
									<td class="FieldInput" style="width: 35%">
									<select type="text" name="approval" field="approval" >
										<option dataset="approvaldataset"></option>
									</select>
									</td>
								</tr>
								
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>轮养（人次）:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="carerotation" field="carerotation" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>在敬老院孤老优抚对象:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="carepeople" field="carepeople" /></td>
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
										type="text" name="floorArea" field="floorArea" title="占地面积"/><font
										color="red">*</font></td>

									<td class="FieldLabel" style="width: 15%" nowrap>业务用房面积(平方米):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="businessArea" field="businessArea" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>光荣院性质：</td>
									<td class="FieldInput" style="width: 35%" >
									<select name="properties" field="properties" style="width:35%">
										<option dataset="bptHonorType"/>
									</select>
									</td>
									<td class="FieldLabel" style="width: 15%" nowrap>建设方式：</td>
									<td class="FieldInput" style="width: 35%" >
									<select name="buildingApproach" field="buildingApproach" style="width:35%">
										<option dataset="buildingApproach"/>
									</select>
									</td>
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
										rows="3" cols="125%" name="unitIntroduce"
										field="unitIntroduce"></textarea></td>
								</tr>
								<tr>
									<td colspan="4" class="FieldInput">工作人员情况</td>
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
									<td class="FieldLabel" style="width: 15%" nowrap>三无人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="threewNum" field="threewNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>初级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="primaryTitleNum" field="primaryTitleNum" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>中级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="intermediateTitleNum"
										field="intermediateTitleNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>高级职称人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="seniorTitleNum" field="seniorTitleNum" />
									</td>
								</tr>
								<tr>
									<td class="FieldInput" colspan="4">经费情况(万元)</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>中央划拨投入经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="centralFunds" field="centralFunds" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>地方下拨的维修投入经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input id="placeFunds"
										type="text" name="placeFunds" field="placeFunds" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>优抚对象医疗经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="bptMedicalFunds" field="bptMedicalFunds" />
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>优抚对象的生活经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="bptLiveFunds" field="bptLiveFunds" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>办公经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="officialFunds" field="officialFunds" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>人员工资(万元):</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="personnelFunds" field="personnelFunds" />
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>其他经费(万元):</td>
									<td class="FieldInput" style="width: 35%"><input id="otherFunds"
										type="text" name="otherFunds" field="otherFunds" onchange="sum()"/></td>

									<td class="FieldLabel" style="width: 15%" nowrap>省级资金投入(万元):</td>
									<td class="FieldInput" style="width: 35%"><input id="provinceFunds"
										type="text" name="provinceFunds" field="provinceFunds" onchange="sum()"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>市级资金投入(万元):</td>
									<td class="FieldInput" style="width: 35%"><input id="cityFunds"
										type="text" name="cityFunds" field="cityFunds" onchange="sum()"/></td>

									<td class="FieldLabel" style="width: 15%" nowrap>县级资金投入(万元):</td>
									<td class="FieldInput" style="width: 35%"><input id="countyFunds"
										type="text" name="countyFunds" field="countyFunds" onchange="sum()"/></td>
								</tr>
								<tr>
									<td colspan="4" class="FieldInput" >供养情况</td>
								</tr>
								<tr>
									

									
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>“三属”人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="threeCategory" field="threeCategory" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>“三红”人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="threeRedNum" field="threeRedNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>残疾军人人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="maimNum" field="maimNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>复员军人人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="demobilizeNum" field="demobilizeNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>退伍军人人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="veteraneNum" field="veteraneNum" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>其他人数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="otherNum" field="otherNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>收养人员总数:</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="adoptNum" field="adoptNum" /></td>

									<input type="hidden" name="regId" field="regId" /><!-- 录入人ID -->
									<input type="hidden" name="regTime" field="regTime" /><!-- 录入时间 -->
									<input type="hidden" name="modId" field="modId" /><!-- 修改人ID -->
									<input type="hidden" name="modTime" field="modTime" /><!-- 修改时间 -->
										
									<td class="FieldLabel" style="width: 15%" nowrap>床位数:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><input
										type="text" name="bedNum" field="bedNum" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><textarea
										rows="2" cols="125%" name="note" field="note"></textarea></td>
								</tr>

							</table>
							</form>
							</fieldset>
						</next:Html>
					</next:Panel>
					
				<next:Panel id="Info"  title="法人代表信息" width="100%" autoScroll="true" >
				<next:Html>
					<fieldset>
					<form id="BptGloriousLegalForm" method="post"
							dataset="BptGloriousLegalDataSet" onsubmit="return false"
							style="padding: 5px;" class="L5form">
	
						<table border="0" width="98%" cellspacing="0" cellpadding="0">
							<tr>
								<td class="FieldInput" colspan="4" nowrap>法人代表信息</td>
							</tr>
								<input type="hidden" name="legalId" field="legalId" /><!-- ID -->
							<tr>
								<td class="FieldLabel" style="width: 15%" nowrap>姓名:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
								name="name" field="name" /><font color="red">*</font></td>

								<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
								<td class="FieldInput" style="width: 35%"><input type="text" id="idCard" onchange="backMsgByIdCard('BptGloriousLegalDataSet',this)"
								name="idCard" field="idCard"  maxlength="18" style="width:55%"/><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%" nowrap>民族:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="nation" field="nation">
									<option dataset="NationDataset"/>
								</select><font color="red">*</font>
								</td>

								<td class="FieldLabel" style="width: 15%" nowrap>性别:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="sex" field="sex">
									<option dataset="SexDataset"/>
								</select><font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%" nowrap>出生日期:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
								name="birthday" id="birthday" field="birthday" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>

								<td class="FieldLabel" style="width: 15%" nowrap>所学专业:</td>
								<td class="FieldInput" style="width: 35%"><input type="text"
								name="learnMajor" field="learnMajor" style="width:55%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%" nowrap>专业职称:</td>
								<td class="FieldInput" style="width: 35%">
									<select name="majorJob" field="majorJob" title="专业职称">
									 <option dataset="majorJobName"></option>
								   </select>
								</td>

								<td class="FieldLabel" style="width: 15%" nowrap>文化程度:</td>
								<td class="FieldInput" style="width: 35%">
								<select name="cultureDegree" field="cultureDegree" title="文化程度">
								 <option dataset="EducationDataset"></option>
							   </select>
								</td>
							</tr>
							<tr> 
								<td class="FieldLabel" style="width: 15%" nowrap>联系电话:</td>
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
							<input type="hidden" name="gloriousId" field="gloriousId" />
							<!-- 光荣院信息ID: -->
							
							<tr>
								<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
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
