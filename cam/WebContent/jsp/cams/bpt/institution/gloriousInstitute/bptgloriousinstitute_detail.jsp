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
			<% 
				if(request.getParameter("years")!=null&&request.getParameter("years")!=""){
			%>
					years='<%=request.getParameter("years")%>';	
			<%		
				}
			%>
			var method='<%=request.getParameter("method")%>';
		</script>
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
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptGloriousLegal"></model:record>
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
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
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
				<next:ToolBarItem iconCls="print"  text="打印" handler="print"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
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
						<input type="hidden" name="id" field="id" />
						<input type="hidden" name="gloriousId" field="gloriousId" />
						<tr>
							<td colspan="4" class="FieldInput">单位概况</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>年度:</td>
							<td class="FieldInput" style="width: 35%"  colspan="3"><label type="text"
								format="Y" style="width: 100px;" maxlength="10" name="years"
								field="years" /></td>
						</tr>
						<tr>
						
							<td class="FieldLabel" style="width: 10%" nowrap>单位全称:</td>
							<td class="FieldInput" style="width: 20%"><label
								field="unitFullname" /></td>
								
							<td class="FieldLabel" style="width: 10%" nowrap>行政区划:</td>
							<td class="FieldInput" style="width: 20%"><label
								field="domicileName" /></td>

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
									<td class="FieldLabel" style="width: 15%" nowrap>建设状况:</td>
									<td class="FieldInput" style="width: 35%">
										<label type="text" name="buildstate" field="buildstate"  dataset="buildstatedataset">
										</label>
									</td>

									<td class="FieldLabel" style="width: 15%" nowrap>有无编委批文:</td>
									<td class="FieldInput" style="width: 35%">
									<label type="text" name="approval" field="approval" dataset="approvaldataset">
									</label>
									</td>
								</tr>
								
								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>轮养（人次）:</td>
									<td class="FieldInput" style="width: 35%"><label
										type="text" name="carerotation" field="carerotation" /></td>

									<td class="FieldLabel" style="width: 15%" nowrap>在敬老院孤老优抚对象:</td>
									<td class="FieldInput" style="width: 35%"><label
										type="text" name="carepeople" field="carepeople" /></td>
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
							<td class="FieldLabel" style="width: 15%" nowrap>光荣院性质：</td>
							<td class="FieldInput" style="width: 35%" >
							<label name="properties" field="properties"  dataset="bptHonorType"/ >
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>建设方式：</td>
							<td class="FieldInput" style="width: 35%" >
							<label name="buildingApproach" field="buildingApproach"  dataset="buildingApproach"/ >
							</td>
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
								field="mailingAddress" /></td>
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
							<td class="FieldLabel" style="width: 15%" nowrap>中央划拨投入经费(万元):</td>
							<td class="FieldInput" style="width: 35%"><label
								field="centralFunds" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>地方下拨的维修投入经费(万元):</td>
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
							<td class="FieldInput" style="width: 35%"><label name="otherFunds" field="otherFunds" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>省级资金投入(万元):</td>
							<td class="FieldInput" style="width: 35%"><label name="provinceFunds" field="provinceFunds" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>市级资金投入(万元):</td>
							<td class="FieldInput" style="width: 35%"><label name="cityFunds" field="cityFunds" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>县级资金投入(万元):</td>
							<td class="FieldInput" style="width: 35%"><label name="countyFunds" field="countyFunds" /></td>
						</tr>

						<tr>
							<td colspan="4" class="FieldInput">供养情况</td>
						</tr>

						

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>“三属”人数:</td>
							<td class="FieldInput" style="width: 35%"><label field="threeCategory" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>“三红”人数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="threeRedNum" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>残疾军人人数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="maimNum" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>复员军人人数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="demobilizeNum" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>退伍军人人数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="veteraneNum" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>其他人数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="otherNum" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>收养人员总数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="adoptNum"></td>

							<td class="FieldLabel" style="width: 15%" nowrap>床位数:</td>
							<td class="FieldInput" style="width: 35%">
							<label field="bedNum" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
							<td class="FieldInput" style="width: 35%" colspan="3">
							<label field="note" /></td>
						</tr>

					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>

			<next:Panel title="法人代表信息" width="100%" autoScroll="true">
				<next:Html>
					<fieldset>
					<form id="BptGloriousLegalForm" method="post"
						dataset="BptGloriousLegalDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">

					<table border="0" width="98%" cellspacing="0" cellpadding="0">
						<tr>
							<td class="FieldInput" colspan="4">法人代表信息</td>
						</tr>
						<input type="hidden" name="legalId" field="legalId" />
						<!-- ID -->
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>姓名:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="name" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="idCard" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>民族:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="nation" dataset="NationDataset" /></td>

							<td class="FieldLabel" style="width: 15%" nowrap>性别:</td>
							<td class="FieldInput" style="width: 35%"><label field="sex"
								dataset="SexDataset" /></td>
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
								field="majorJob" dataset="majorJobName"/></td>

							<td class="FieldLabel" style="width: 15%" nowrap>文化程度:</td>
							<td class="FieldInput" style="width: 35%"><label
								field="cultureDegree" dataset="EducationDataset"/></td>
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
<input type="hidden" id="docpath"  value="jsp/cams/bpt/institution/print/glorious.doc"/>
<input type="hidden" id="id" name="printQuery" queryData="queryData" value="<%=request.getParameter("dataBean")%><%=request.getParameter("years")%>"/>
<input type="hidden" id="method" name="queryData" queryData="queryData" value="printGlorious"/>
<input type="hidden" id="scaconfPath"  value="dependantApp/dependantAppPrintDao"/>
</body>
</html>
