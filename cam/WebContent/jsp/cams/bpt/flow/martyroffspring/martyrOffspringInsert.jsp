<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<title>部分烈士（错杀被平反人员）子女受理</title>
</head>
<body>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src="../../comm/idCardReader.js"></script>
<script type="text/javascript" src="martyrOffspringInsert.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="../../../comm/phoneticCode/phoneticCode.js"></script>
<script type="text/javascript" src="../../../comm/diccity/autoComplete.js"></script>
<link href="../../../comm/diccity/autoComplete.css" rel="stylesheet" type="text/css"/>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true" method="queryBaseInfoPeople">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="domicileName" type="string" />
			<model:field name="apanageName" type="string" />
		</model:record>
	</model:dataset>

	<!-- 部分烈士（错杀被平反人员）子女信息 -->  
	<model:dataset id="MartyrOffspringDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringQueryCommand" method="getMartyrOffsprinInfor" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring">
			<model:field name="oldLonelyFlag" type="string" rule="require" />
			<model:field name="orphanFlag" type="string" rule="require" />
			<model:field name="workAbilityCode" type="string" rule="require" />
			<model:field name="viabilityCode" type="string" rule="require" />
			<model:field name="supportPattern" type="string" rule="require" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/> 
		</model:record>
	</model:dataset>
	<!-- 行政区划自动补全 -->
	<model:dataset id="autoCompleteCity" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" method="autoComplete">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
    <!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BaseinfoFamilyCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 与牺牲者关系 -->
	<model:dataset id="RelationShipEnum" enumName="RELATION.SHIP" autoLoad="true" global="true"></model:dataset>
    <!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
    <!-- 是否持证人 -->
	<model:dataset id="HolderFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
    <!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
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
	<!-- 生活状况-->
    <model:dataset id="lifeStateEnum" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
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
    <!-- 医疗保障方式 --> 
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
    <!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
    <!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel bodyStyle="width:100%;height:100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存并添加其他信息" handler="saveClick" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="funClose" />
	</next:TopBar>
	<next:TabPanel >
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" autoScroll="true"
				 id="peopleTabPanel">
				<next:Html>
					<form id="BaseinfoPeopleForm" method="post"
						dataset="BaseinfoPeopleDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="99%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
							<td class="FieldInput"><input type="text" name="idCard" field="idCard" title="身份证件号码" maxlength="18" style="width: 135" onblur="func_QueryIdCardAllMessage()" />
							<input type="button" name="ReadCard" value="读身份证" onclick="ReadIDCard()" style="width:60px;" /><font color="red">*</font>
							    <!-- 标识优抚对象类型 -->
							    <input type="hidden" name="stype" id="stype" value="B1"/>
							</td>
							<td class="FieldLabel">姓名：</td>
							<td class="FieldInput"><input type="text" id="namebase" name="namebase" field="name" title="姓名"  onchange="getCrjCnStrSpell('namebase','phoneticCode','m')"/><font color="red">*</font></td>
							
							<td class="FieldLabel" width="12%" rowspan="3">照片:</td>
							<td nowrap   rowspan="3">
								<div  style="width:0px;">
								<img name="RELATIONER_PHOTOC_IMG" width=70 src="../../dataCollection/comm/default.jpg" style="float:left"
								 ondblclick="editPhoto(1,'photoTemp','RELATIONER_PHOTOC_IMG');"
								onerror="javascript:this.src='../../dataCollection/comm/default.jpg'" alt="暂无图片" />
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
				
						  
							<td class="FieldLabel">民族：</td>
							<td class="FieldInput"><select name="nation" field="nation"
								title="民族">
								<option dataset="NationDataset"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">性别：</td>
							<td class="FieldInput"><select name="sex" field="sex"
								title="性别">
								<option dataset="SexDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap>与户主关系：</td>
							<td class="FieldInput"><select name="relationshipType"
								field="relationshipType" title="与户主关系">
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
							<td class="FieldInput"><input type="text" name="telMobile" field="telMobile" title="联系方式(手机)"/></td>

							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput"><input type="text" name="telOther" field="telOther" title="其他联系方式"/></td>
							<td class="FieldLabel">邮政编码：</td>
							<td class="FieldInput"><input type="text" name="postCode" field="postCode" title="邮政编码"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">户籍类别：</td>
							<td class="FieldInput"><select onchange="func_Type()"
								name="domicileType" field="domicileType" title="户籍类别">
								<option dataset="DomicileDataset"></option>
								</select><font color="red">*</font></td>
							<td class="FieldLabel">文化程度：</td>
							<td class="FieldInput">
							 	<select name="eduCode" field="eduCode" title="文化程度">
									<option dataset="EducationDataset"></option>
								</select></td>
							<td class="FieldLabel">健康状况：</td>
							<td class="FieldInput"><select name="healthCode"
								field="healthCode" title="健康状况">
								<option dataset="HealthDataset"></option>
								</select></td>
						</tr>
						<tr>
							<td class="FieldLabel">婚姻状况：</td>
							<td class="FieldInput"><select name="marriageCode"
								field="marriageCode" title="婚姻状况">
								<option dataset="MarriageDataset"></option>
							</select></td>
							<td class="FieldLabel">政治面貌：</td>
							<td class="FieldInput" colspan="3"><select name="politicalCode"
								field="politicalCode" title="政治面貌">
								<option dataset="PoliticalDataset"></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel">就业状况：</td>
							<td class="FieldInput"><select name="employmentCode"
								field="employmentCode" title="就业状况">
								<option dataset="EmploymentCodeDataset"></option>
							</select></td>	
							<td class="FieldLabel">年收入：</td>
							<td class="FieldInput" colspan="3"><input type="text" name="incomeYear" field="incomeYear" title="年收入"/></td>
						</tr>
						<tr id="work">
							<td class="FieldLabel">工作单位名称：</td>
							<td class="FieldInput"><input type="text" name="workUnitName" field="workUnitName" title="工作单位名称"/></td>
							<td class="FieldLabel">工作单位性质：</td>
							<td class="FieldInput"><select name="workUnitCharacter"
								field="workUnitCharacter" title="工作单位性质">
								<option dataset="WorkUnitCharacterDataset"></option>
							</select></td>
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput"><input type="text" name="workUnitTel" field="workUnitTel" title="工作单位电话"/></td>
						</tr>
						<tr id="workAddress">
							<td class="FieldLabel">工作单位地址：</td>
							<td class="FieldInput" colspan="5"><input type="text" name="workUnitAdd" field="workUnitAdd" title="工作单位地址" style="width: 90%" id="workUnitAdd"></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(基本信息)：</td>
							<td class="FieldInput" colspan="5"><textarea name="note" field="note" rows="3" title="备注(基本信息)" style="width: 90%"></textarea></td>
						</tr>
						<div>
						<tr><td style= "display:none" ><input type="hidden" id="phoneticCode" name="phoneticCode" field="phoneticCode"  />
							</td></tr>
						<!--人员ID -->
						<input type="hidden" name="peopleId" id="peopleId" field="peopleId"/>
						<!--家庭ID -->
						<input type="hidden" name="familyId" id="familyId" field="peopleId"/>
						<input type="hidden" id="flag" name="flag"/>
					</table>	
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel id="typeInfo" title="类别信息" height="100%"  autoScroll="true"
				width="100%" autoHeight="true">
				<next:Html>
					<form id="editForm" dataset="MartyrOffspringDataSet"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="99%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap">身份类别：</td>
								<td class="FieldInput" ><select id="statusType" name="statusType"
									field="statusType" title="身份类别" style="width:80%">
									<option dataset="StatusTypeEnum"></option>
								</select><font color="red">*</font></td>
							<td class="FieldLabel">牺牲者姓名：</td>
							<td class="FieldInput"><input type="text" id="lezswName" name="lezswName" field="lezswName" title="牺牲者姓名" /></td>
							<td class="FieldLabel">牺牲时间：</td>
							<td class="FieldInput"><input type="text" id="sacrificeDate" maxlength="10" name="sacrificeDate" field="sacrificeDate"style= "width:100px;"  format="Y-m-d" onpropertychange="changeDateStyle(this)" title="牺牲时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)"><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">批准烈士（平反）时间：</td>
							<td class="FieldInput"><input type="text" id="lezswApproveDate" name="lezswApproveDate" maxlength="10" field="lezswApproveDate"style= "width:100px;"  format="Y-m-d" onpropertychange="changeDateStyle(this)" title="批准烈士（平反）时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)"><font color="red">*</font></td>
							<td class="FieldLabel" nowrap>与牺牲者关系：</td>
							<td class="FieldInput"><select id="relationship" name="relationship"
								field="relationship" title="与牺牲者关系">
								<option dataset="RelationShipEnum"></option>
								</select>
							</td>
							<td class="FieldLabel">是否持证人：</td>
							<td class="FieldInput"><select name="holderFlag"
								field="holderFlag" title="是否持证人">
								<option dataset="HolderFlagEnum"></option>
								</select></td>
						</tr>
						<tr>	
							<td class="FieldLabel">是否孤老：</td>
							<td class="FieldInput"><select name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老">
								<option dataset="OldLonelyFlagEnum"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel">是否孤儿：</td>
							<td class="FieldInput"><select name="orphanFlag"
								field="orphanFlag" title="是否孤儿">
								<option dataset="OrphanFlagEnum"></option>
							</select><font color="red">*</font></td>
							<td  class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput">
				     			<select name="lifeStateCode" field="lifeStateCode" title="生活状况">
					     			<option dataset="lifeStateEnum"></option>
				     			</select><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><select name="workAbilityCode"
								field="workAbilityCode" title="劳动能力">
								<option dataset="WorkAbilityCodeEnum"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><select name="viabilityCode"
								field="viabilityCode" title="生活能力">
								<option dataset="ViabilityCodeEnum"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">供养方式：</td>
							<td class="FieldInput"><select name="supportPattern"
								field="supportPattern" title="供养方式">
								<option dataset="SupportPatternEnum"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>
							<td  class="FieldLabel" nowrap>享受低保待遇：</td>
							<td class="FieldInput">
				     			<select id="guarantFlag" name="guarantFlag" field="guarantFlag" title="享受低保待遇">
					     			<option dataset="HolderFlagEnum"></option>
				     			</select>
							</td>
							<td  class="FieldLabel" nowrap>享受五保待遇：</td>
							<td class="FieldInput">
				     			<select id="fiveGuarantFlag" name="fiveGuarantFlag" field="fiveGuarantFlag" title="享受五保待遇">
					     			<option dataset="HolderFlagEnum"></option>
				     			</select>
							</td>
							<td  class="FieldLabel" nowrap>享受过抚恤金：</td>
							<td class="FieldInput">
				     			<select id="enjoyedTreatFlag" name="enjoyedTreatFlag" field="enjoyedTreatFlag" title="享受过抚恤金">
					     			<option dataset="HolderFlagEnum"></option>
				     			</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">开户银行：</td>
							<td class="FieldInput">
							    <select name="bank" field="bank" title="开户银行">
								<option dataset="BankEnum"></option>
							</select> </td>
							<td class="FieldLabel">开户名称：</td>
							<td class="FieldInput"><input type="text" name="accountName" field="accountName" title="开户名称"/></td>

							<td class="FieldLabel">银行账号：</td>
							<td class="FieldInput"><input type="text" name="accountCode" field="accountCode" title="银行账号" style="width: 200"></input></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><textarea name="note" field="note" style="width: 95%" rows="3"></textarea></td>
						</tr>
					</table>
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
