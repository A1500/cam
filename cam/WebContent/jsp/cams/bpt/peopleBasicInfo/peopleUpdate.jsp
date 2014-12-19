<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<%
BptBaseinfoPeopleCommand command = new BptBaseinfoPeopleCommand();
String photoId = command.findPhotoId(request.getParameter("peopleId"));
String photoTable = "COM_PHOTO";
if(photoId!=null && photoId.length()>0){
	photoTable = photoTable+"_"+photoId.substring(0,6);
}
%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
</script>
<html>
<head>
<title>伤残人员业务受理</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="../comm/idCardReader.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>	
<script type="text/javascript" src="peopleUpdate.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="domicileName" type="string" />
			<model:field name="apanageName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 养老保障方式 -->
	<model:dataset id="PensionDataset" enumName="COMM.PENSION_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>	
				<next:Html>
					<fieldset>
					<form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
					    <tr>
							<td class="FieldLabel"  nowrap >身份证件号码：</td>
							<td class="FieldInput"><label name="idCard" field="idCard"/></td>
						    <td class="FieldLabel" >姓名：</td>
							<td class="FieldInput" ><label id="namebase" name="namebase" field="name" /></td>
							<td class="FieldLabel" width="10%" rowspan="3">照片:</td>
									<td nowrap colspan="1" rowspan="3">
									<div id="RELATIONER_PHOTOC_IMG_DIV" style="width:0px;">
							<img name="RELATIONER_PHOTOC_IMG" width=70  src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" style="float:left"
								onerror="javascript:this.src='../dataCollection/comm/default.jpg'" alt="暂无图片" />
							<!-- <img name="RELATIONER_PHOTOC_IMG" width=75 src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=CARD_PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" style="float:left"
								valign="top" ondblclick="opneidcard();"
								onerror="javascript:this.src='../comm/default.jpg'" alt="暂无图片" /> -->
							
							<a href="javascript:opneidcard();" style="text-decoration:none;font-size:14;">身份证扫描件</a>
							
							</div>
									<input type="hidden" id="photoTemp" name="photoTemp">
									<input type="hidden" id="cardPhotoTemp" name="cardPhotoTemp">
									<input type="hidden" id="photoId" name="photoId"></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >出生日期：</td>
							<td class="FieldInput" ><label name="birthday" field="birthday"/></td>
						    <td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><label name="sex" field="sex" title="性别" dataset="SexDataset"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>与户主关系：</td>
							<td class="FieldInput" >
							  <select name="relationshipType" field="relationshipType" title="与户主关系">
								<option dataset="RelationshipTypeDataset"></option>
							  </select><font color="red">*</font>
							</td>
							
							<td class="FieldLabel" >民族：</td>
							<td class="FieldInput" >
							   <select name="nation" field="nation" title="民族">
								<option dataset="NationDataset"></option>
							   </select><font color="red">*</font>
							</td>
						</tr>
						<tr>
						   <td class="FieldLabel" >属地行政区划：</td>
						   <td class="FieldInput" >
						       <input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:90%" onclick="func_ForDomicileSelect()" readonly="readonly"/><font color="red">*</font>
						       <input type="hidden" id="domicileCode" name="domicileCode" field="domicileCode" title="属地行政区划"/></td>
						       
						   <td class="FieldLabel">户口薄住址:</td>
						   <td class="FieldInput" colspan="3"><input type="text" name="domicileAddress" field="domicileAddress" title="户口薄住址" style="width:85%"></td>      
						   
						   
						</tr>
						<tr>
							<td class="FieldLabel" >住址(行政区划)：</td> 
							<td class="FieldInput"><input type="text" id="apanageName" name="apanageName" field="apanageName" title="行政区划" style="width:90%" readonly="readonly" onclick="func_ForApanageSelect()"/><font color="red">*</font>
							<input type="hidden" name="apanageCode" field="apanageCode" title="行政区划"/></td>
							<td class="FieldLabel">实际居住地址:</td>
							<td class="FieldInput" colspan="3"><input type="text" name="address" field="address" title="实际居住地址" style="width:85%"></td>
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
							<td class="FieldInput" ><input type="text" name="telMobile" field="telMobile" title="联系方式(手机)"/></td>
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><input type="text" name="telOther" field="telOther" title="其他联系方式"/></td>
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><input type="text" name="postCode" field="postCode" title="邮政编码"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" >
							   <select name="domicileType" field="domicileType" id="domicileType" title="户籍类别" onchange="fun_Type()">
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
							<!--td class="FieldLabel" >职业：</td>
							<td class="FieldInput" >
								<select name="careerCode" field="careerCode">
										<option dataset="CareerDataset"></option>
								</select>
							</td-->
                            <td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput" colspan="3">
							  <select
								name="politicalCode" field="politicalCode" title="政治面貌">
								<option dataset="PoliticalDataset"></option>
							  </select>
							</td>
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
                        <tr id="workAddress">
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><input type="text" name="workUnitAdd" field="workUnitAdd" title="工作单位地址" style="width: 90%"></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >备注(基本信息)：</td>
							<td class="FieldInput"  colspan="5"><textarea name="note" field="note" rows="3" title="备注(基本信息)" style="width: 90%"></textarea></td>
						</tr>
                     </table>
					</form>
				</fieldset>
			</next:Html>
	</next:Panel>
</body>
</html>
