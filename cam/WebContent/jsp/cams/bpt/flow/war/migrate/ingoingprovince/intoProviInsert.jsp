<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
   var familyId  = '<%=IdHelp.getUUID30()%>';
   var peopleId  = '<%=IdHelp.getUUID30()%>';
</script>
<html>
<head>
<title>参战人员信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("dataBean")%>';
	var method='<%=request.getParameter("method")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
<script type="text/javascript" src="intoProviInsert.js"></script>
<script type="text/javascript" src="../../../../../comm/phoneticCode/phoneticCode.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="../../../../comm/idCardReader.js"></script>
<script type="text/javascript" src="../../../../../comm/diccity/autoComplete.js"></script>
<link href="../../../../../comm/diccity/autoComplete.css" rel="stylesheet" type="text/css" />
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true" method="queryBaseInfoPeople">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		    <model:field name="domicileName" type="string"/>
		    <model:field name="apanageName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 烈属类别代码 -->
	<model:dataset id="DependantTypeCodeEnum" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BaseinfoFamilyCommand" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
		</model:record>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 养老保障方式 -->
	<model:dataset id="PensionDataset" enumName="COMM.PENSION_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
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
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	
	
	<!-- 行政区划自动补全 -->
	<model:dataset id="autoCompleteCity" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="autoComplete">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
	
	<model:dataset id="dsWar"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand" method="queryPeopleWarInfo"
		global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleWar">
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<!--model:field name="orphanFlag" type="string" /-->
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="serviceType" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" defaultValue="1" rule="require"/>
			<model:field name="warNo" type="string" />
			<model:field name="approvalDate" type="string" />
			<model:field name="ingoingReason" type="string" />
			<model:field name="allowanceMonth" type="string" />
			<model:field name="ingoingAddress" type="string" />
			<model:field name="ingoingCode" type="string" />
			<model:field name="oldPaperNo" type="string" rule="require"/>	
		</model:record>
	</model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
    <!--参战类别代码-->
	<model:dataset id="dsWarData" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

<next:Panel bodyStyle="width:100%;height:100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="基本信息" width="100%" autoScroll="true"
				id="peopleTabPanel">
				<next:Html>
					<fieldset>
					<form id="BaseinfoPeopleForm" method="post"
						dataset="BaseinfoPeopleDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
						
						<tr>
							<td class="FieldLabel"  nowrap >身份证件号码：</td>
							<td class="FieldInput" ><input  type="text" id="idCard"
								name="idCard" field="idCard" title="身份证件号码" style="width:135" maxlength="18" onchange="func_QueryIdCardAllMessage()"/>
								<input type="hidden"	name="stype" value="14" title="身份证件号码" style="width:135"/>
								<input type="button" name="ReadCard" value="读身份证" onclick="ReadIDCard()" style="width:60px;" /><font color="red">*</font></td>
						
							<td class="FieldLabel" >姓名：</td>
							<td class="FieldInput" ><input type="text"
								id="namebase" name="namebase" field="name" title="姓名"/><font color="red">*</font>
							</td>
							<td class="FieldLabel" width="12%" rowspan="3">照片:</td>
							<td nowrap   rowspan="3">
								<div  style="width:0px;">
								<img name="RELATIONER_PHOTOC_IMG" width=70 src="../../../../dataCollection/comm/default.jpg" style="float:left"
								 ondblclick="editPhoto(1,'photoTemp','RELATIONER_PHOTOC_IMG');"
								onerror="javascript:this.src='../../../../dataCollection/comm/default.jpg'" alt="暂无图片" />
								<a href="javascript:idcardlookup();" style="text-decoration:none;font-size:14;">身份证扫描件</a>
								</div>
								
									<input type="hidden" id="photoTemp" name="photoTemp">
									<input type="hidden" id="cardPhotoTemp" name="cardPhotoTemp">
									<input type="hidden" id="photoId" name="photoId"></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >出生日期：</td>
							<td class="FieldInput" ><input type="text"
								name="birthday" field="birthday" readonly="readonly"  format="Y-m-d"maxlength="10" title="出生日期"/><font color="red">*</font></td>

							<td class="FieldInput" style="display:none"><input type="text" id="phoneticCode" name="phoneticCode" field="phoneticCode" title="姓名拼音码" /><font color="red">*</font>
							</td>
														<td class="FieldLabel" >民族：</td>
							<td class="FieldInput" ><select name="nation" field="nation" title="民族">
								<option dataset="NationDataset"></option>
							</select><font color="red">*</font></td>
						</tr>

						<tr>
							<td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><select name="sex"
								field="sex" title="性别">
								<option dataset="SexDataset"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" nowrap>与户主关系：</td>
							<td class="FieldInput" ><select
								name="relationshipType" field="relationshipType" title="与户主关系">
								<option dataset="RelationshipTypeDataset"></option>
							</select><font color="red">*</font></td>
						</tr>
						
						<tr>
						   <td class="FieldLabel" >户口薄(行政区划)：</td>
						   <td class="FieldInput">
						       <input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:75%" onkeyup="findDiv(this,'domicileCode','popup','apanageName:apanageCode')" onblur="clearDiv()"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="func_ForDomicileSelect()"/><font color="red">*</font>
						       <div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        						<ul></ul> 
     					   	   </div>  
						       <input type="hidden" id="domicileCode" name="domicileCode" field="domicileCode" title="属地行政区划"/></td>
						       
						   <td class="FieldLabel">户口薄住址:</td>
						   <td class="FieldInput" colspan="3"><input type="text" onblur="changes()" id ="domicileAddress" name="domicileAddress" field="domicileAddress" title="户口薄住址" style="width:85%"></td>      
						</tr>
						<tr>
							<td class="FieldLabel" >实际居住(行政区划)：</td> 
							<td class="FieldInput" ><input type="text" id="apanageName" name="apanageName" field="apanageName" title="行政区划"  style="width:75%" onkeyup="findDiv(this,'apanageCode','popup2')" onblur="clearDiv()"  /><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="func_ForApanageSelect()"/><font color="red">*</font>
							<div id="popup2"  style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        						<ul></ul> 
     					   	   </div>  
							<input type="hidden" id="apanageCode" name="apanageCode" field="apanageCode" title="行政区划"/></td>
							<td class="FieldLabel">实际居住地址:</td>
							<td class="FieldInput" colspan="3"><input type="text" id ="address" name="address" field="address" title="实际居住地址" style="width:85%"></td>
						</tr>
						<tr>
						   <td class="FieldLabel" >医疗保障方式：</td>
						   <td class="FieldInput" >
						       <select name="safeguardType" field="safeguardType" title="医疗保障方式">
								 <option dataset="SafeguardDataset"></option>
							   </select><font color="red">*</font>
							</td>
                            <td class="FieldLabel" >医疗保险号：</td>
							<td class="FieldInput"><input type="text" name="medicalCode" field="medicalCode" title="医疗保险号"/></td>
						    <td class="FieldLabel" >养老保障方式：</td>
						    <td class="FieldInput" >
						       <select name="penSionCode" field="penSionCode" title="养老保障方式">
								 <option dataset="PensionDataset"></option>
							   </select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><input type="text"
								name="telMobile" field="telMobile" title="联系方式（手机）"/></td>
								
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><input type="text"
								name="telOther" field="telOther" title="其他联系方式"/></td>
							
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><input type="text"
								name="postCode" field="postCode" title="邮政编码"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" ><select
							id="domicileType" name="domicileType" field="domicileType" title="户籍类别" onchange="func_Type()">
								<option dataset="DomicileDataset"></option>
							</select><font color="red">*</font></td>
						
							<td class="FieldLabel" >文化程度：</td>
							<td class="FieldInput" ><select
								name="eduCode" field="eduCode">
								<option dataset="EducationDataset"></option>
							</select></td>
						
							<td class="FieldLabel" >健康状况：</td>
							<td class="FieldInput" ><select
								name="healthCode" field="healthCode" title="健康状况">
								<option dataset="HealthDataset"></option>
							</select></td>
						</tr>

						<tr>
							<td class="FieldLabel" >婚姻状况：</td>
							<td class="FieldInput" ><select
								name="marriageCode" field="marriageCode" title="婚姻状况">
								<option dataset="MarriageDataset"></option>
							</select></td>
							<!--td class="FieldLabel" >职业：</td>
							<td class="FieldInput" >
								<select name="careerCode" field="careerCode">
										<option dataset="CareerDataset"></option>
								</select>
							</td-->

							<td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput" colspan="3"><select
								name="politicalCode" field="politicalCode" title="政治面貌">
								<option dataset="PoliticalDataset"></option>
							</select></td>
						</tr>

						<tr>
							<td class="FieldLabel" >就业状况：</td>
							<td class="FieldInput" >
								<select name="employmentCode" field="employmentCode" id="employmentCode" title="就业状况">
										<option dataset="EmploymentCodeDataset"></option>
								</select>
							</td>
							
							<td class="FieldLabel" >年收入：</td>
							<td class="FieldInput" colspan="3"><input type="text" name="incomeYear" field="incomeYear" title="年收入"/></td>
						</tr>

						<tr id="work">
						
							<td class="FieldLabel" >工作单位名称：</td>
							<td class="FieldInput" ><input type="text"
								name="workUnitName" field="workUnitName" id="workUnitName" title="工作单位名称"/></td>
								
							<td class="FieldLabel" >工作单位性质：</td>
							<td class="FieldInput" >
									<select name="workUnitCharacter" field="workUnitCharacter" id="workUnitCharacter" title="工作单位性质">
										<option dataset="WorkUnitCharacterDataset"></option>
									</select></td>
								
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><input type="text"
								name="workUnitTel" field="workUnitTel" id="workUnitTel" title="工作单位电话"/></td>
						</tr>

						<tr id="workAddress">
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><input type="text"
								name="workUnitAdd" field="workUnitAdd" style="width: 90%" id="workUnitAdd" title="工作单位地址"></td>
						</tr>

						<tr>
							<td class="FieldLabel" >备注(基本信息)：</td>
							<td class="FieldInput"  colspan="5"><textarea
								name="note" field="note" rows="3" style="width: 90%" title="备注(基本信息)"></textarea></td>
						</tr>

						<!--人员ID -->
						<input type="hidden" name="peopleId" id="peopleId" field="peopleId"/>
						<!--家庭ID -->
						<input type="hidden" name="familyId" id="familyId" field="familyId"/>
						<input type="hidden" name="flag" id="flag" value=""/>
					  </table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>


			<next:Panel id="typeInfo" title="类别信息" width="100%"  autoScroll="true">
				<next:Html>
					<form id="editForm" dataset="dsWar" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%" align="left" >
						<tr>
						<!--  	<td class="FieldLabel" nowrap>优抚对象状态：</td>
							<td class="FieldInput"><select style="width: 120px;"
								id="warStateCode" field="warStateCode" title="优抚对象状态">
								<option dataset="ObjectStateDataset"></option>
							</select><font color="red">*</font></td>
						-->
							
							
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>入伍（参加工作）时间：</td>
							<td class="FieldInput"><input type="text"
								name="conscriptcDate" title="入伍时间" field="conscriptcDate"
								format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font
								color="red">*</font></td>
							<td class="FieldLabel" nowrap>退伍时间：</td>
							<td class="FieldInput"><input type="text"
								name="decruitmentDate" title="退伍时间" field="decruitmentDate"
								format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font
								color="red">*</font></td>

							<td class="FieldLabel" nowrap>离退休时间：</td>
							<td class="FieldInput"><input type="text" name="retiredDate"
								title="离退休时间" field="retiredDate" format="Y-m-d"
								style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>退伍证号：</td>
							<td class="FieldInput"><input type="text" name="asdpNo"
								field="asdpNo" title="退伍证号" /></td>

							<td class="FieldLabel" nowrap>原部队代号：</td>
							<td class="FieldInput"><input type="text" name="forcesNo"
								id="forcesNo" field="forcesNo" title="原部队代号" onblur="func_blur()"/>
							</td>
							
							<td class="FieldLabel" nowrap>职务（级别）：</td>
							<td class="FieldInput"><input type="text" name="position"
								field="position" title="职务(级别)"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" nowrap>参战类别：</td>
							<td class="FieldInput"><select style="width: 120px;"
								id="warTypeCode" field="warTypeCode" title="参战类别代码">
								<option dataset="dsWarData"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" nowrap>是否孤老：</td>
							<td class="FieldInput"><select name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老">
								<option dataset="OldLonelyFlagEnum"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" nowrap>是否精神病：</td>
							<td class="FieldInput"><select name="insanityFlag"
								field="insanityFlag" title="是否精神病">
								<option dataset="InsanityFlagEnum"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>劳动能力：</td>
							<td class="FieldInput"><select name="workAbilityCode"
								field="workAbilityCode" title="劳动能力">
								<option dataset="WorkAbilityCodeEnum"></option>
							</select><font color="red">*</font></td>
						
							
							
							<td class="FieldLabel" nowrap>生活能力：</td>
							<td class="FieldInput"><select name="viabilityCode"
								field="viabilityCode" title="生活能力">
								<option dataset="ViabilityCodeEnum"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap>供养方式：</td>
							<td class="FieldInput"><select name="supportPattern"
								field="supportPattern" title="供养方式">
								<option dataset="SupportPatternEnum"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>	
							<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput"><select style="width: 120px;"
								id="healthStateCode" field="healthStateCode" title="健康状况">
								<option dataset="HealthDataset"></option>
							</select><font color="red">*</font></td>
						
							<td class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput" ><select style="width: 120px;"
								id="lifeStateCode" field="lifeStateCode" title="生活状况">
								<option dataset="dsLife"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap>原生活补助证编号：</td>
							<td class="FieldInput" ><input type="text" name="oldPaperNo" field="oldPaperNo" title="原生活补助证编号" maxlength="20"></input><font color="red">*</font></td>
							
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>开户银行：</td>
							<td class="FieldInput"><select name="bank" field="bank" title="开户银行"><option dataset="BankEnum"></option></select></td>
							<td  class="FieldLabel" nowrap>开户名称：</td>
							<td class="FieldInput"><input type="text" name="accountName" field="accountName" title="开户名称"/> </td>
							<td  class="FieldLabel" nowrap>银行账号：</td>
							<td class="FieldInput" colspan="5"><input type="text" name="accountCode" field="accountCode" title="银行帐号" style="width:200" ></input></td>	
						</tr>
						<tr>
							<td class="FieldLabel">由何地迁入</td>
							<td class="FieldInput"><input type="text" name="ingoingAddress" onclick="getCodeAndName()" readonly="readonly" field="ingoingAddress" title="由何地迁入"/><font color="red">*</font></td>
							<td class="FieldLabel">抚恤金已发至月份</td>
							<td class="FieldInput" colspan="3"><input type="text" name="allowanceMonth" field="allowanceMonth" title="抚恤金已发至月份"  readonly="readonly" format="Y-12" style="width: 100px;" maxlength="10"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">迁入原因</td>
							<td class="FieldInput" colspan="5"><textarea type="text" rows="2" name="ingoingReason" field="ingoingReason" style="width:90%" title="迁入原因"></textarea><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3"
								cols="120" name="note" field="note" title="备注(类别信息)"></textarea></td>
						</tr>
						
					</table>
					<input type="hidden" name="ingoingCode" field="ingoingCode" title="由何地迁入代码">
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="imgshow" title='身份证信息' resizable="false"
	width="360" height="400" lazyRender="false" closable="false">
	<next:FitLayout>
		<next:Panel id="fextend" border="false">
			<next:Html>
				<div align="center">
				<img name="RELATIONER_PHOTOC_IMG" width=250 src="../../dataCollection/comm/default.jpg"  
							valign="top" onerror="javascript:this.src='../../dataCollection/comm/default.jpg'" alt="暂无图片" />
				</div>
			</next:Html>
		</next:Panel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="idcardclose()"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
