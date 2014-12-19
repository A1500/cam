<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%
	String familyId = IdHelp.getUUID30();
	String peopleId = IdHelp.getUUID30();
%>
<html>
<head>
<title></title>
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
			<% 
			if(request.getParameter("years")!=null&&request.getParameter("years")!=""){
		%>
				years='<%=request.getParameter("years")%>';	
		<%		
			}
		%>
		var method='<%=request.getParameter("method")%>';
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="bpthospital_edit.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="BptHospitalDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptHospitalDetail">
			<model:field name="domicileName" type="string" />
			<model:field name="years" type="string" />
			</model:record>
	</model:dataset>
	<model:dataset id="BptHospitalLegalDataSet"
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalLegalCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptHospitalLegal"></model:record>
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
	<!-- 优抚医院种类 -->
	<model:dataset id="bptHospitalType" enumName="BPT.HOSPITAL.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 优抚医院业务类别 -->
	<model:dataset id="bptHospitalServiceType" enumName="BPT.HOSPITAL.SERVICE.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 优抚医院等级代码 -->
	<model:dataset id="bptHospitalLevel" enumName="BPT.HOSPITAL.LEVEL" autoLoad="true" global="true"></model:dataset>
		<!-- 是否建立防治网络 -->
	<model:dataset id="ifPrevention" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
		<!-- 专业职称 -->
	<model:dataset id="majorJobName" enumName="BPT.MAJORJOBNAME.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 政治面貌 -->
	<model:dataset id="politicalLandscape" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
		<!-- 行政级别 -->
	<model:dataset id="administrativelevel" enumName="BPT.ADMINISTRATIVELEVEL" autoLoad="true" global="true"></model:dataset>
		<!-- 单位性质 -->
	<model:dataset id="unitsnature" enumName="BPT.UNITSNATURE" autoLoad="true" global="true"></model:dataset>
	
		
</model:datasets>
<next:Panel  bodyStyle="width:100%;height:100%">
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print"  text="打印" handler="print"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="优抚医院信息" width="100%" autoScroll="true"  >
				<next:Html>
					<fieldset>
					<form id="BptHospitalForm" method="post"
						dataset="BptHospitalDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="100%">
						<input type="hidden" name="hospitalId" field="hospitalId" />
						<!-- ID -->
						<tr>
							<td class="FieldInput" colspan="4">单位概况</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>年度:</td>
							<td class="FieldInput" style="width: 35%"  colspan="3"><label type="text"
								format="Y" style="width: 100px;" maxlength="10" name="years"
								field="years"  title="年度"/></td>
						
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%" nowrap>单位全称:</td>
							<td class="FieldInput" style="width: 20%"><label
								field="unitFullname" title="单位全称"/></td>
							<td class="FieldLabel" style="width: 10%" nowrap>行政区划:</td>
							<td class="FieldInput" style="width: 20%"><label
								field="domicileName" title="行政区划"/></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 10%" nowrap>主管部门:</td>
							<td class="FieldInput" style="width: 20%"><label
								field="personSection" title="主管部门"/></td>

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
							<td class="FieldLabel" style="width: 15%" nowrap>注册资本(万元):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="registerProperty" title="注册资本"/></td>

							<td class="FieldLabel" style="width: 15%" nowrap>固定资产原值(万元):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="immobilisations" title="固定资产原值"/></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>占地面积(平方米):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="floorArea" title="占地面积"/></td>

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
							<td class="FieldInput" style="width: 35%" height="20" colspan="3"><label
								field="mailingAddress" />
							</td>
						</tr>
						
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>单位介绍:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><label
								field="unitIntroduce" /></td>
						</tr>

						<tr>
							<td class="FieldInput" colspan="4">工作人员情况</td>
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
							<td class="FieldLabel" style="width: 15%" nowrap>三无人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="threewNum" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>初级职称人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="primaryTitleNum" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>中级职称人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="intermediateTitleNum" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>高级职称人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="seniorTitleNum" /></td>
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
							<td class="FieldLabel" style="width: 15%" nowrap>优抚对象医疗经费(万元):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="bptMedicalFunds" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>优抚对象的生活经费(万元):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="bptLiveFunds" /></td>
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

							<td class="FieldLabel" style="width: 15%">创收收入(万元)：</td>
							<td class="FieldInput" style="width: 35%"><label
								name="inCome" field="inCome" /></td>
						</tr>
						<tr>
							<td class="FieldInput" colspan="4">基础设施建设情况</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>新建扩建改建（平方米）:</td>
							<td class="FieldInput" style="width: 35%"><label
								name="newExpansion" field="newExpansion" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>新增大型设备（台）:</td>
							<td class="FieldInput" style="width: 35%"><label
								name="newEquipment" field="newEquipment" /></td>
						</tr>
						<tr>
							<td class="FieldInput" colspan="4">医疗科研情况</td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>优抚医院种类:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="bptHospitalSort" dataset="bptHospitalType"/></td>

							<td class="FieldLabel" style="width: 15%" nowrap>优抚医院业务类型:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="bptHospitalBusintype" dataset="bptHospitalServiceType"/></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>优抚医院等级:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="bptHospitalGrade" dataset="bptHospitalLevel"/></td>

							<td class="FieldLabel" style="width: 15%" nowrap>1-10万元设备数(件):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="tenbelowDevice" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>10万元以上设备数(件):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="tenaboveDevice" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>编制床位(张):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="formationBed" /></td>
						</tr>

						<tr>
							
							<td class="FieldLabel" style="width: 15%" nowrap>新增床位(张):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="addBed" /></td>
								
							<td class="FieldLabel" style="width: 15%" nowrap>年末实有床位(张):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="yearActualBed" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>全年收住院人次:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="allyearInhospital" /></td>
						
							<td class="FieldLabel" style="width: 15%" nowrap>全年门诊人次:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="allyearOutpatients" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>年末优抚对象人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="yearBptNum" /></td>
						
							<td class="FieldLabel" style="width: 15%" nowrap>1-4级残疾军人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="maimNum" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>带精神病回乡复员退伍军人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="psychosisHometown" /></td>
						
							<td class="FieldLabel" style="width: 15%" nowrap>带其他严重疾病回乡复员退伍军人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="otherillHometown" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>社会病员人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="societyNum" /></td>
						
							<td class="FieldLabel" style="width: 15%" nowrap>年内轮养优抚对象人数:</td>
							<td class="FieldInput" style="width: 35%"><label
								name="numInYear" field="numInYear" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>年末集中供养优抚对象人数:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><label
								name="numEndYear" field="numEndYear" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>精神病防治情况:</td>
							<td class="FieldInput"  colspan="4">
								<table style="width: 99%" nowrap>
									<tr>
									 	<td class="FieldLabel" style="width: 15%" nowrap>全市复退军人精神病患者人数:</td>
										<td class="FieldInput" style="width: 35%"><label
											name="mentalNum" field="mentalNum" /></td>
										<td class="FieldLabel" style="width: 15%" nowrap>是否建立防治网络:</td>
										<td class="FieldInput" style="width: 35%"><label
											name="ifPreventionNet" field="ifPreventionNet" dataset="ifPrevention"/></td>
									</tr>
									<tr>
									 	<td class="FieldLabel" style="width: 15%" nowrap>社会精神病患者治疗人数:</td>
										<td class="FieldInput" style="width: 35%"><label
											name="treatMentalNum" field="treatMentalNum" /></td>
										<td class="FieldLabel" style="width: 15%" nowrap>巡回医疗人数:</td>
										<td class="FieldInput" style="width: 35%"><label
											name="mobileMedical" field="mobileMedical" /></td>
									</tr>
									<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>住院治疗人数:</td>
										<td class="FieldInput" style="width: 35%"><label
											name="hospitalization" field="hospitalization" /></td>
											<td class="FieldLabel" style="width: 15%" nowrap>电话咨询人数:</td>
										<td class="FieldInput" style="width: 35%"><label
											name="telConsultation" field="telConsultation" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>服务人员情况:</td>
							<td class="FieldInput" style="width: 35%" colspan="4">
								<table style="width: 99%" nowrap>
									<tr>
									<td class="FieldLabel" style="width: 20%" nowrap>医护人员人数:</td>
									<td class="FieldInput" style="width: 34%" colspan="3"><label
										name="service" field="service" /></td>
									<td class="FieldLabel" style="width: 15%" nowrap>管理和后勤保障人员人数:</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><label
										name="rearServiceNum" field="rearServiceNum" /></td>
									</tr>
								</table>
							
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>康复疗养情况:</td>
							<td class="FieldInput" style="width: 35%" colspan="4">
								<table style="width: 99%" nowrap>
									<tr>
									<td class="FieldLabel" style="width: 20%" nowrap>床位:</td>
									<td><label name="resort" field="resort" /></td>
									</tr>
								</table>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>新技术新业务项目:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><label
								field="newArtBusiness" /></td>
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

			<next:Panel title="法人代表信息" width="100%" autoScroll="true" >
				<next:Html>
					<fieldset>
					<form id="BptHospitalLegalForm" method="post"
						dataset="BptHospitalLegalDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">

					<table border="0" width="98%" cellspacing="0" cellpadding="0">
						<tr>
							<td class="FieldInput" colspan="4">&nbsp;&nbsp;&nbsp;法人代表信息</td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>姓名:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="name" title="姓名"/></td>

							<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="idCard" title="身份证号码"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>民族:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="nation" title="民族" dataset="NationDataset" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>性别:</td>
							<td class="FieldInput" style="width: 35%"><label field="sex"
								dataset="SexDataset" title="性别" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>出生日期:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="birthday" title="出生日期" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>所学专业:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="learnMajor" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>专业职称:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="majorJob" dataset="majorJobName"/></td>

							<td class="FieldLabel" style="width: 15%" nowrap>文化程度:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="cultureDegree" dataset="EducationDataset"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>联系电话:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="telContact" /></td>
								
							<td class="FieldLabel" style="width: 15%">政治面貌:</td>
								<td class="FieldInput" style="width: 35%"><label
								name="politicalLandscape" field="politicalLandscape" dataset="politicalLandscape"/></td>
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
<input type="hidden" id="docpath"  value="jsp/cams/bpt/institution/print/hospital.doc"/>
<input type="hidden" id="id" name="printQuery" queryData="queryData" value="<%=request.getParameter("dataBean")%><%=request.getParameter("years")%>"/>
<input type="hidden" id="method" name="queryData" queryData="queryData" value="printHospital"/>
<input type="hidden" id="scaconfPath"  value="dependantApp/dependantAppPrintDao"/>
</body>
</html>
