<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>60周岁以上农村籍退役士兵新增</title>
		<next:ScriptManager/>
		<script>
			var organCode = '<%=BspUtil.getOrganCode()%>';
            var familyId  = '<%=IdHelp.getUUID30()%>';
            var peopleId  = '<%=IdHelp.getUUID30()%>';
		</script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
        <script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
		<script type="text/javascript" src="../../../../../comm/phoneticCode/phoneticCode.js"></script>
        <script type="text/javascript" src="../../../../comm/bptComm.js"></script>
		<script type="text/javascript" src="sintoProviInsert.js"></script>
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
	<!-- 类别信息 -->
	<model:dataset id="RetiredSoldierDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" method ="queryBptRetiredSoldier"  global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		    <model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			
			<model:field name="ingoingAddress" type="string" rule="require"/>
			<model:field name="ingoingReason" type="string" rule="require"/>
			<model:field name="allowanceMonth" type="string" rule="require"/>
			<model:field name="ingoingCode" type="string" />
			<model:field name="serviceType" type="string"/>
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
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
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
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 养老保障方式 -->
	<model:dataset id="PensionDataset" enumName="COMM.PENSION_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
    <model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
    <!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
    <model:dataset id="HealthDataset" enumName="HEALTH.TYPE" autoLoad="true" global="true"></model:dataset>
    <!-- 婚姻状况 -->
    <model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受低保待遇-->
	<model:dataset id="dsGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受五保待遇-->
	<model:dataset id="dsFiveGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 是否具有其他优抚对象身份 -->
	<model:dataset id="OtherBptObjectEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力-->
	<model:dataset id="workAbilityEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 生活状况-->
    <model:dataset id="lifeStateEnum" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 身份认定依据-->
    <model:dataset id="identityEnum" enumName="IDENTITY.CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel autoHeight="true" >
	<next:TopBar >
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存并添加其它信息" handler="save"/>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
	</next:TopBar>
<next:TabPanel>
<next:Tabs>
    <next:Panel title="人员基本信息" autoHeight="true" width="100%"  autoScroll="true" id="peopleTabPanel">
				<next:Html>
					<form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
					    <tr>
							<td class="FieldLabel"  nowrap >身份证件号码：</td>
							<td class="FieldInput" ><input type="text" id="idCard" name="idCard" field="idCard" title="身份证件号码" style="width:135" maxlength="18" onblur="func_QueryIdCardAllMessage()"/>
							<input type="button" name="ReadCard" value="读身份证" onclick="ReadIDCard()" style="width:60px;" /><font color="red">*</font>
							    <input type="hidden" id="stype" name="stype" value="81"/>
							</td>
						    <td class="FieldLabel" >姓名：</td>
							<td class="FieldInput" ><input type="text" id="namebase" name="namebase" field="name" title="姓名"/><font color="red">*</font>
								<input type="hidden"  id="phoneticCode" name="phoneticCode" field="phoneticCode" title="姓名拼音码" />
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
								name="birthday" readonly="readonly" field="birthday" format="Y-m-d"maxlength="10" title="出生日期"/><font color="red">*</font></td>
						     <td class="FieldLabel" >民族：</td>
							<td class="FieldInput" ><select
								name="nation" field="nation" title="民族">
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
							<td class="FieldInput" >
							<select name="relationshipType" field="relationshipType" title="与户主关系">
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
							   </select><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><input type="text"name="telMobile" field="telMobile" title="联系方式(手机)"/></td>
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><input type="text" name="telOther" field="telOther" title="其他联系方式"/></td>
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><input type="text" name="postCode" field="postCode" title="邮政编码"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" >
							   <select name="domicileType" field="domicileType" title="户籍类别" onchange="func_Type()">
								<option dataset="DomicileDataset"></option>
							   </select><font color="red">*</font>
							</td>
						    <td class="FieldLabel" >文化程度：</td>
							<td class="FieldInput" >
							   <select name="eduCode" field="eduCode" title="文化程度">
								<option dataset="EducationDataset"></option>
							   </select>
							</td>
						    <td class="FieldLabel" >健康状况：</td>
							<td class="FieldInput" >
							   <select name="healthCode" field="healthCode" title="健康状况">
								<option dataset="HealthDataset"></option>
							   </select>
							</td>
						</tr>
                        <tr>
							<td class="FieldLabel" >婚姻状况：</td>
							<td class="FieldInput" >
							    <select name="marriageCode" field="marriageCode" title="婚姻状况">
								  <option dataset="MarriageDataset"></option>
							    </select>
							</td>
                            <td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput" colspan="3">
							   <select name="politicalCode" field="politicalCode" title="政治面貌">
								<option dataset="PoliticalDataset"></option>
							   </select>
							</td>
						</tr>
                        <tr id="work">
						    <td class="FieldLabel" >工作单位名称：</td>
							<td class="FieldInput" ><input type="text" name="workUnitName" field="workUnitName" title="工作单位名称"/></td>
							<td class="FieldLabel" >工作单位性质：</td>
							<td class="FieldInput" >
							       <select name="workUnitCharacter" field="workUnitCharacter" title="工作单位性质">
										<option dataset="WorkUnitCharacterDataset"></option>
									</select>
						    </td>
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><input type="text" name="workUnitTel" field="workUnitTel" title="工作单位电话"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >就业状况：</td>
							<td class="FieldInput" >
							    <select name="employmentCode" field="employmentCode" title="就业状况">
										<option dataset="EmploymentCodeDataset"></option>
								</select>
							</td>
							<td class="FieldLabel" >年收入：</td>
							<td class="FieldInput" colspan="3"><input type="text" name="incomeYear" field="incomeYear" title="年收入"/></td>
							
						</tr>
						<tr id="workAddress">
							<td class="FieldLabel" nowrap>工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><input type="text" name="workUnitAdd" field="workUnitAdd" title="工作单位地址"  style="width: 88%"></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >备注(基本信息)：</td>
							<td class="FieldInput"  colspan="5"><textarea name="note" field="note" rows="3" title="备注(基本信息)" style="width: 88%"></textarea></td>
						</tr>
                        <!--人员ID -->
						<input type="hidden" name="peopleId" id="peopleId" field="peopleId"/>
						<!--家庭ID -->
						<input type="hidden" name="familyId" id="familyId" field="peopleId"/>
						<input type="hidden" name="flag" id="flag" value=""/>
					</table>
					</form>
				</next:Html>
			</next:Panel>
    <next:Panel id="typeInfo" title="类别信息" autoHeight="true" width="100%"  autoScroll="true">
		<next:Html>
		<form id="editForm"   dataset="RetiredSoldierDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		      <tr> 
	   		    <td class="FieldLabel" >是否具有其他优抚对象身份：</td>
				<td class="FieldInput" colspan="5">
				    <select id ="isOtherBptobject" name="isOtherBptobject" field="isOtherBptobject" title="是否具有其他优抚对象身份" onchange="func_show()">
					     <option dataset="OtherBptObjectEnum"></option>
				     </select>
				</td>
	   		</tr>
			<tr id="objectType">
			   <td class="FieldLabel" nowrap>优抚对象类别：</td>
			   <td colspan="5" class="FieldLabel">
			       <table border="0" width="99%" >
			          <tr>
			            <td class="FieldInput" > 
			               <input type="checkbox" id="disabilityCivil" name="disabilityCivil" field="disabilityCivil"/>伤残公务员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilityPolice" name="disabilityPolice" field="disabilityPolice"/>伤残人民警察&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilityMigrant" name="disabilityMigrant" field="disabilityMigrant"/>伤残民兵民工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilitySoldier" name="disabilitySoldier" field="disabilitySoldier"/>残疾军人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="dependMartyrs" name="dependMartyrs" field="dependMartyrs"/>烈属&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="dependDied" name="dependDied" field="dependDied"/>病故军人遗属
			            </td>
			          </tr>
			          <tr>
			            <td class="FieldInput" >
			               <input type="checkbox" id="dependPublic" name="dependPublic" field="dependPublic"/>因公牺牲军人遗属
			               <input type="checkbox" id="demobilizedSoldier" name="demobilizedSoldier" field="demobilizedSoldier"/>在乡老复员军人
			               <input type="checkbox" id="demobilizedIllnessPeople" name="demobilizedIllnessPeople" field="demobilizedIllnessPeople"/>带病回乡退伍军人
			               <input type="checkbox" id="warPeople" name="warPeople" field="warPeople"/>参战退役人员
			               <input type="checkbox" id="testedPeople" name="testedPeople" field="testedPeople"/>参试退役人员
			            </td>
			          </tr>
			       </table>
			   </td>
			</tr>
	   		<tr>
	   		    <td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptDate" field="conscriptDate" format="Y-m-d" maxlength="10"  onpropertychange="changeDateStyle(this)"  style="width: 100px;"title="入伍时间"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
	   		    <td class="FieldLabel" nowrap>退役时间：</td>
				<td class="FieldInput"><input type="text" name="decruitmentDate" field="decruitmentDate" format="Y-m-d" maxlength="10" onpropertychange="changeDateStyle(this)"  style="width: 100px;" title="退役时间"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>退役证件号：</td>
				<td class="FieldInput"><input type="text" name="retiredNo" field="retiredNo" title="退役证件号"/></td>
			</tr>
			<tr>
		        <td class="FieldLabel" nowrap>服役部队名称(番号)：</td>
				<td class="FieldInput"><input type="text" name="forcesName" field="forcesName" title="服役部队名称(番号)"/><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>服役部队代号：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="forcesNo" field="forcesNo" title="服役部队代号"/><font color="red">*</font></td>
		    </tr>
	   		<tr>
	   		    <td  class="FieldLabel" nowrap>服义务兵(开始时间)：</td>
				<td class="FieldInput"><input type="text" name="soldierStartDate" field="soldierStartDate" format="Y-m-d"style="width: 100px;"  onpropertychange="changeDateStyle(this)" maxlength="10" title="服义务兵开始时间" onblur="func_StartDate()"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>服义务兵(结束时间)：</td>
				<td class="FieldInput"><input type="text" name="soldierEndDate" field="soldierEndDate" format="Y-m-d"style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"  title="服义务兵结束时间" onblur="func_EndDate()"/><img  src="../../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
	   		    <td  class="FieldLabel" nowrap>所服义务兵役折算年限：</td>
				<td class="FieldInput"><input type="text" id="soldierYears" name="soldierYears" field="soldierYears" title="所服义务兵役折算年限" disabled="disabled"/> </td>
	   		</tr>
		    <tr>
				<td  class="FieldLabel" nowrap>家庭人口：</td>
				<td class="FieldInput"><input type="text" name="familyNum" field="familyNum" title="家庭人口"/> </td>
				<td  class="FieldLabel" nowrap>18岁(含)以下：</td>
				<td class="FieldInput"><input type="text" name="youngNum" field="youngNum" title="18岁(含)以下"/> </td>
			    <td  class="FieldLabel" nowrap>60岁(含)以上：</td>
				<td class="FieldInput"><input type="text" name="oldNum" field="oldNum" title="60岁(含)以上"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap>是否孤老：</td>
				<td class="FieldInput">
				    <select name="oldLonelyFlag" field="oldLonelyFlag" title="是否孤老">
					     <option dataset="OldLonelyFlagEnum"></option>
				     </select><font color="red">*</font>
				 </td>
			    <td  class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput">
				    <select name="workAbilityCode" field="workAbilityCode" title="劳动能力">
					     <option dataset="workAbilityEnum"></option>
				     </select><font color="red">*</font>
				</td>
				<td  class="FieldLabel" nowrap>生活状况：</td>
				<td class="FieldInput">
				     <select name="lifeStateCode" field="lifeStateCode" title="生活状况">
					     <option dataset="lifeStateEnum"></option>
				     </select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap>是否享受低保待遇：</td>
				<td class="FieldInput">
				     <select name="isGuarant" field="isGuarant" title="是否享受低保待遇">
					     <option dataset="dsGuarant"></option>
				     </select>
				</td>
			    <td  class="FieldLabel" nowrap>是否享受五保待遇：</td>
				<td class="FieldInput">
				     <select name="isFiveGuarant" field="isFiveGuarant" title="是否享受五保待遇">
					     <option dataset="dsFiveGuarant"></option>
				     </select>
				</td>
				<td class="FieldLabel" nowrap>身份认定依据：</td>
				<td class="FieldInput">
				    <select name="identityBasis" field="identityBasis" title="身份认定依据">
					     <option dataset="identityEnum"></option>
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
				<td  class="FieldLabel" >备注(类别信息)：</td>
				<td class="FieldInput" class="FieldInput" colspan="5"><textarea rows="3" cols="155" name="note" field="note" title="备注(类别信息)"></textarea></td>
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
