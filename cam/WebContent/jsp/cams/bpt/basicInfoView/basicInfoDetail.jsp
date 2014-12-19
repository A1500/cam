<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<%
BptBaseinfoPeopleCommand command = new BptBaseinfoPeopleCommand();
String photoId = command.findPhotoId(request.getParameter("peopleId"));
String photoTable = "COM_PHOTO";
if(photoId!=null && photoId.length()>0){
	photoTable = photoTable+"_"+photoId.substring(0,6);
}
%>
<html>
<head>
<title>优抚对象基本信息查看</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var username = '<%=request.getParameter("username")%>';
			
		</script>
<script type="text/javascript" src="basicInfoDetail.js"></script>
<script type="text/javascript" src="../comm/idCardReader.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
			method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="domicileName" type="string"/>
			<model:field name="apanageName" type="string"/>
		</model:record>
		<model:params>
			<model:param name="PEOPLE_ID" value='<%=request.getParameter("peopleId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
		method="queryFamilyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
		<model:params>
			<model:param name="FAMILY_ID" value='<%=request.getParameter("familyId")%>'></model:param>
		</model:params>
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
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
		<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
		<!-- 养老保障方式 -->
	<model:dataset id="PensionDataset" enumName="COMM.PENSION_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
<next:TabPanel animScroll="true" enableTabScroll="true" width="100%">
		<next:Tabs>
			<next:Panel title="基本信息" width="100%" height="100%" autoScroll="false"
				id="peopleTabPanel">
				<next:Panel title="人员基本信息">
				<next:Html>
					<fieldset>
					<form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					  <table border="0" width="98%">
					     <tr>
							<td class="FieldLabel"  nowrap style="width:15%">身份证件号码：</td>
							<td class="FieldInput" style="width:15%" nowrap="nowrap"><label field="idCard" title="身份证件号码"></label></td>
						    <td class="FieldLabel" style="width:15%">姓名：</td>
							<td class="FieldInput" style="width:15%"><label field="name" title="姓名"></label></td>
							<td class="FieldLabel" width="10%" rowspan="3">照片:</td>
							<td nowrap  rowspan="3">
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
							<td class="FieldInput" ><label name="birthday" field="birthday" title="出生日期"></label></td>
						    <td class="FieldLabel" >民族：</td>
							<td class="FieldInput" ><label name="nation" field="nation" title="民族" dataset="NationDataset"></label></td>
						    
						</tr>
						<tr>
							<td class="FieldLabel" nowrap style="width:15%">与户主关系：</td>
							<td class="FieldInput" style="width:15%"><label name="relationshipType" field="relationshipType" dataset="RelationshipTypeDataset" title="与户主关系"></label></td>
							<td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><label name="sex" 	field="sex" dataset="SexDataset" title="性别"></label></td>
						</tr>
						<tr>
						   <td class="FieldLabel" >户口薄(行政区划)：</td>
						   <td class="FieldInput" >
						       <label id="domicileName" name="domicileName" field="domicileName" title="属地行政区划"></label>
						   <td class="FieldLabel">户口薄住址:</td>
						   <td class="FieldInput" colspan="3">
						       <label name="domicileAddress" field="domicileAddress" title="户口薄住址" style="width:85%">
						   </td>      
						</tr>
						<tr>
							<td class="FieldLabel" >实际居住(行政区划)：</td> 
							<td class="FieldInput">
							    <label id="apanageName" name="apanageName" field="apanageName" title="行政区划"></td>
							<td class="FieldLabel">实际居住地址:</td>
							<td class="FieldInput" colspan="3"><label name="address" field="address" title="实际居住地址" style="width:85%"></td>
						</tr>
						<tr>
						   <td class="FieldLabel" >医疗保障方式：</td>
						   <td class="FieldInput" >
						       <label name="safeguardType" field="safeguardType" title="医疗保障方式" dataset="SafeguardDataset">
						    </td>
                            <td class="FieldLabel" >医疗保险号：</td>
							<td class="FieldInput">
							    <label name="medicalCode" field="medicalCode" title="医疗保险号">
							</td>
						    <td class="FieldLabel" >养老保障方式：</td>
						    <td class="FieldInput" >
						       <label name="penSionCode" field="penSionCode" title="养老保障方式" dataset="PensionDataset">
						    </td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><label  name="telMobile" field="telMobile" title="联系方式(手机)"></label></td>
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><label name="telOther" field="telOther" title="其他联系方式"></label></td>
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><label name="postCode" field="postCode" title="邮政编码"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" ><label name="domicileType" field="domicileType" dataset="DomicileDataset" title="户籍类别"></label></td>
						    <td class="FieldLabel" >文化程度：</td>
							<td class="FieldInput" ><label name="eduCode" field="eduCode" dataset="EducationDataset" title="文化程度"></label></td>
						    <td class="FieldLabel" >健康状况：</td>
							<td class="FieldInput" ><label name="healthCode" field="healthCode" dataset="HealthDataset" title="健康状况"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >婚姻状况：</td>
							<td class="FieldInput" ><label name="marriageCode" field="marriageCode" dataset="MarriageDataset" title="婚姻状况"></label></td>
							<!--td class="FieldLabel" >职业：</td>
							<td class="FieldInput" >
							    <label name="careerCode" field="careerCode" dataset="CareerDataset"></label>
							</td-->
                            <td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput" colspan="3"><label name="politicalCode" field="politicalCode" dataset="PoliticalDataset" title="政治面貌"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >就业状况：</td>
							<td class="FieldInput" ><label name="employmentCode" field="employmentCode" dataset="EmploymentCodeDataset" title="就业状况"></label></td>
							<td class="FieldLabel" >年收入：</td>
							<td class="FieldInput" colspan="3"><label name="incomeYear" field="incomeYear" title="年收入"></label></td>
						</tr>
                        <tr>
						    <td class="FieldLabel" >工作单位名称：</td>
							<td class="FieldInput" ><label name="workUnitName" field="workUnitName" title="工作单位名称"></label></td>
							<td class="FieldLabel" >工作单位性质：</td>
							<td class="FieldInput" ><label name="workUnitCharacter" field="workUnitCharacter" dataset="WorkUnitCharacterDataset" title="工作单位性质"></label>	</td>
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><label name="workUnitTel" field="workUnitTel" title="工作单位电话"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><label name="workUnitAdd" field="workUnitAdd" title="工作单位地址" style="width: 90%"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >备注(基本信息)：</td>
							<td class="FieldInput"  colspan="5"><label name="note" field="note" rows="3" title="备注(基本信息)" style="width: 90%"></label></td>
						</tr>
                     </table>
					</form>
					</fieldset>
				</next:Html>
				</next:Panel>
			</next:Panel>
            
       
			
			<next:Panel title="类别信息" width="100%" height="100%" autoScroll="false"
				id="objectTypeTabPanel">
				<next:Html>
					<%	String objectType = request.getParameter("objectType");
						if("11".equals(objectType) || "12".equals(objectType) || "13".equals(objectType) || "14".equals(objectType)|| "15".equals(objectType)|| "16".equals(objectType)){%>
						<iframe id="instanceDisability" src="disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<% }else if("21".equals(objectType) || "22".equals(objectType) || "23".equals(objectType)){ %>
		   				<iframe id="instance" src="dependantTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<% }else if("41".equals(objectType)){ %>
		   				<iframe id="instance" src="demobilizedDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<% }else if("42".equals(objectType)){ %>
		   				<iframe id="instance" src="demobilizedIllnessDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%} else if("51".equals(objectType)){%>
		   			    <iframe id="instance" src="bptwarDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%} else if("61".equals(objectType)){%>
		   			    <iframe id="instance" src="bpttestedDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%} else if("81".equals(objectType)){%>
		   			    <iframe id="countretiredsoldierDetail" src="../dataCollection/bptcountretiredsoldier/cbptcountretiredsoldierInfo.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%} else if("B1".equals(objectType)){%>
		   			    <iframe id="countretiredsoldierDetail" src="../dataCollection/martyroffspring/cmartyrOffspringDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%}%>
				</next:Html>
			</next:Panel>
			     <next:Panel title="家庭成员信息" width="100%" height="100%" autoScroll="false"
				id="familyTabPanel">
				<next:Html>
				   <iframe id="instanceDisability" src="familyPeopleInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>&familyId=<%=request.getParameter("familyId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="审批信息" width="100%" height="100%" autoScroll="false"
				id="approveTabPanel">
				<next:Html>
				<iframe id="instance" src="../peopleBasicInfo/applyInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="经费发放" width="100%" height="100%" autoScroll="false"
				id="fundingIssueTabPanel">
				<next:Html>
				  <iframe id="instance" src="grantFund.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="临时救助" width="100%" height="100%" autoScroll="false"
				id="tempHelpTabPanel">
				<next:Html>
				  <iframe id="tempHelpIframe" src="temporaryHelpDetails.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="医疗情况" width="100%" height="100%" autoScroll="false"
				id="healthCareTabPanel">
				<next:Html>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="住房信息" width="100%" height="100%" autoScroll="false"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="休养情况" width="100%" height="100%" autoScroll="false" id="recuperateTabPanel">
				<next:Html>
					<iframe id="recuperateDetail" src="recuperateDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<%  String objectType = request.getParameter("objectType");
				if("11".equals(objectType) || "12".equals(objectType) || "13".equals(objectType) || "14".equals(objectType)|| "15".equals(objectType)|| "16".equals(objectType)){ %>
				<next:Panel title="辅助器械配置" width="100%" height="100%" autoScroll="false" id="asisDeviceConfigPanel">
					<next:Html>
						<iframe id="asisDeviceConfig" src="asisDeviceConfig.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
					</next:Html>
				</next:Panel>
			<% }%>
			
			<next:Panel title="信访信息" width="100%" height="100%" autoScroll="false"
				id="petitionTabPanel">
				<next:Html>
					<iframe id="instance" src="petitionDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
					&idCard=<%=request.getParameter("idCard")%>&objectType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="身份认证" width="100%" height="100%" autoScroll="false"
				id="regularIdentificationTabPanel">
				<next:Html>
					<iframe id="instance" src="regularIdentificationDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
					&idCard=<%=request.getParameter("idCard")%>&objectType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="状态变更" width="100%" height="100%" autoScroll="false"
				id="stateChangeTabPanel">
				<next:Html>
					<iframe id="instance" src="stateChangeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
					&idCard=<%=request.getParameter("idCard")%>&objectState=<%=request.getParameter("objectState")%>&objectType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			 <next:Panel title="电子档案" width="100%" height="100%" autoScroll="false"
				id="archiveTabPanel">
				<next:Html>
					<iframe id="electronic" src="../peopleBasicInfo/electronicListDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>&serviceType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="年度照片" width="100%" height="100%" autoScroll="false"
				id="yearphotopanel">
				<next:Html>
					<iframe id="yearPhoto" src="../comm/yearPhotoDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			
			<%	if("11".equals(objectType) ){%>
			<next:Panel title="残疾军人换证呈报表" width="100%" height="100%" autoScroll="false"
				id="replacement">
				<next:Html>
				<iframe id="replacementtable" src="../flow/disability/assessdisability/table/replacementTable.jsp?peopleId=<%=request.getParameter("peopleId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
   				</iframe>
   				</next:Html>
			</next:Panel>
   			<% } %>
		</next:Tabs>
	</next:TabPanel>	
</next:Panel>
</body>
</html>
