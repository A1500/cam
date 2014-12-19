<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>农村五保家庭页面</title>
<next:ScriptManager />
<script type="text/javascript">
<%
		String applyId=request.getParameter("applyId");//业务主键
	%>
	var treatmentId='<%=request.getParameter("treatmentId")%>';
	var assistanceType='<%=request.getParameter("assistanceType")%>';
	var applyId='<%=request.getParameter("applyId")%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	var organArea = '<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
<script type="text/javascript" src="samRuralAreasFamilyDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 家庭待遇信息 -->
	<model:dataset id="familyTreatmentDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyTreatmentQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyTreatment">
		</model:record>
	</model:dataset>
	<!-- 基础信息_家庭信息 -->
	<model:dataset id="familyDataSet"
		cmd="com.inspur.cams.drel.archive.baseinfofamilyarchive.cmd.BaseinfoFamilyArchiveQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.archive.baseinfopeoplearchive.cmd.BaseinfoPeopleArchiveQueryCmd" global="true" method='queryPeopleForSamArchive'>
		<model:record fromBean="com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive"></model:record>
	</model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭房产信息 -->
	<model:dataset id="houseListDataset" cmd="com.inspur.cams.drel.archive.samfamilyhousearchive.cmd.SamFamilyHouseArchiveQueryCmd" global="true"   >
		<model:record fromBean="com.inspur.cams.drel.archive.samfamilyhousearchive.data.SamFamilyHouseArchive"></model:record>
	</model:dataset>
	<!-- 家庭财产信息 -->
	<model:dataset id="estateListDataset" cmd="com.inspur.cams.drel.archive.samfamilyestatearchive.cmd.SamFamilyEstateArchiveQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.archive.samfamilyestatearchive.data.SamFamilyEstateArchive">
		</model:record>
	</model:dataset>
	<!-- 赡（抚、扶）养人信息 -->
	<model:dataset id="supportListDataset" cmd="com.inspur.cams.drel.archive.samfamilysupportarchive.cmd.SamFamilySupportArchiveQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.archive.samfamilysupportarchive.data.SamFamilySupportArchive"></model:record>
	</model:dataset>
	<!-- 申请材料 -->
	<model:dataset id="filesDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<!-- 入户调查申请材料 -->
	<model:dataset id="surveyFileDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<!-- 评议申请材料 -->
	<model:dataset id="discussionFileDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<!-- 公示申请材料 -->
	<model:dataset id="noticeFileDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<!-- 被赡（抚、扶）养人 -->
	<model:dataset id="supportedPeopleDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BASEINFO_PEOPLE_ARCHIVE'></model:param>
			<model:param name="value" value='PEOPLE_ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
   <model:dataset id="employmentCodeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房类型 -->
	 <model:dataset id="houseQualityDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
		<!-- 分类施保类别 -->
	<model:dataset id="asisstanceClassDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
			<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
			<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与被赡（抚、扶）养人关系 -->
	<model:dataset id="supportedRelationDataset" enumName="SAM_SUPPORTED_RELATION" autoLoad="true" global="true"></model:dataset>
	<!-- 无赡（抚、扶）养能力原因 -->
	<model:dataset id="noSupportReasonDataset" enumName="SAM_NO_SUPPORT_REASON" autoLoad="true" global="true"></model:dataset>
	<!-- 救助方式 -->
	<model:dataset id="assistanceModeDataset" enumName="SAM_ASSISTANCE_MODE" autoLoad="true" global="true"></model:dataset>
	<!-- 财产类型 -->
	<model:dataset id="estateTypeDataset" enumName="SAM_ESTATE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 主要致贫原因 -->
	<model:dataset id="povertyCauseDataset" enumName="SAM_CITY_PROVERTY_CAUSE" autoLoad="true" global="true"></model:dataset>
	<!-- 属别 -->
	<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY" autoLoad="true" global="true"></model:dataset>
	<!-- 人员状态 -->
	<model:dataset id="samPersonalStatsDataSet" enumName="SAM_PERSONAL_STATS_TAG" autoLoad="true" global="true"></model:dataset>
	
	<!-- 分类施保类别 -->
	<model:dataset id="assistance" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
			<model:param name="itemType" value='01'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="education" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>

	<!-- 入户调查 -->
	<model:dataset id="acceptSurveyDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey"></model:record>
		<model:params>
			<model:param name="activity_Id" value='accept'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 评议结果 -->
	<model:dataset id="acceptDiscussionDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyDiscussionQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.sam.data.SamApplyDiscussion">
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='accept'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="acceptNoticeDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='accept'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 审核入户调查 -->
	<model:dataset id="checkSurveyDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
			<model:field name="surveyPeople" type="string" rule="length{500}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='check'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 审核公示结果 -->
	<model:dataset id="checkNoticeDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
			<model:field name="principal" type="string" rule="length{32}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='check'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 审批入户调查 -->
	<model:dataset id="auditSurveyDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
			<model:field name="surveyPeople" type="string" rule="length{500}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 审批公示结果 -->
	<model:dataset id="auditNoticeDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
			<model:field name="noticeResult" type="string" rule="require" />
			<model:field name="principal" type="string" rule="length{32}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
	</model:dataset>
		<!-- 调查结果 -->
	<model:dataset id="surveyResultDataSet" enumName="SURVEY_RESULT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 评议意见 -->
	<model:dataset id="discussionResultDataSet"
		enumName="DISCUSSION_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="noticeResultDataSet" enumName="NOTICE_RESULT_TYPE"
		autoLoad="true" global="true"></model:dataset>
		<!-- 生活自理能力 -->
	<model:dataset id="selfCareAbilityDataset" enumName="SAM_SELF_CARE_ABILITY" autoLoad="true" global="true"></model:dataset>
	<!-- 变更事项 -->
    <model:dataset id="samChangeItemDs" enumName="SAM_CHANGE_ITEM" autoLoad="true" global="true"></model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_CHANGE_OPINION_TYPE"
		autoLoad="true" global="true"></model:dataset>
		<!-- 申请证明材料 -->
	<model:dataset id="fileTypeDataset" enumName="SAM_FILE_NAME" autoLoad="true" global="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
	<!-- 供养机构 -->
	<model:dataset id="supportOrgDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_GEROCOMIUM_INFO'></model:param>
			<model:param name="value" value='GEROCOMIUM_ID'></model:param>
			<model:param name="text" value='GEROCOMIUM_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 银行账户信息 -->
	<model:dataset id="bankAccountDS" cmd="com.inspur.cams.drel.sam.cmd.SamBankAccountQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamBankAccount">
			<model:field name="accountName" type="string" rule="length{25}" />
		</model:record>
	</model:dataset>
	<!-- 开户银行 -->
	<model:dataset id="bankDataset" autoLoad="true" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
			
	<model:dataset id="ArchCatalogDS"  cmd="com.inspur.comm.arch.cmd.ArchCatalogQueryCommand"  method="queryCataLogAndFile" global="true"  pageSize="20">
	</model:dataset>
	
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true" id="tab">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看救助历史信息" handler="hisDetail"/>
		<next:ToolBarItem iconCls="return" text="关闭" handler="returnBack" />
	</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"
		autoHeight="true" autoScroll="true">
		<next:Html>
						<form  method="post" onsubmit="return false" class="L5form" dataset="familyDataSet">
				<table width="100%">
					<input type="hidden" name="familyId" field="familyId" value="1"/>
					<tr>						
						<td class="FieldLabel" style="width: 15%">户主姓名</td>
						<td class="FieldInput" style="width: 18%"><label
							name="户主姓名" title="户主姓名" field="familyName"  style="width:80%" ></label>		</td>				
						<td class="FieldLabel" style="width: 15%">身份证号</td>
						<td class="FieldInput" style="width: 18%"><label
							name="身份证号" title="身份证号" field="familyCardNo" style="width:80%" /></label></td>
						
						<td class="FieldLabel" style="width: 15%" rowspan="4">照片</td>
						<td class="FieldInput" style="width: 18%" rowspan="4">
							<div id="photoDiv">
								<img id="img" name="FAMILY_IMG"  width=140 height=90  src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
									align="top" 
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
								<input type="hidden" id="familyPhotoId" name="familyPhotoId"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">供养方式</td>
						<td class="FieldInput" style="width: 18%"><label id='supportWay' /></td>
						<td class="FieldLabel" style="width: 15%">供养机构</td>
						<td class="FieldInput" style="width: 18%"><label id='supportOrg' /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">地区</td>
						<td class="FieldInput" style="width: 18%">
						 <label name="地区" title="地区"  field="domicileName" readonly id="lrdwmc" ></label>
						<input style="display: none;"  name="lrdwId" id="lrdwIdquery" field="domicileCode" />
						</td>
						<td class="FieldLabel" style="width: 15%">邮政编码</td>
						<td class="FieldInput" style="width: 18%"><label
							name="居住地邮编" title="居住地邮编" field="familyPostcode" style="width:80%" ></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">家庭地址</td>
						<td class="FieldInput" style="width: 18%" colspan="3"><label
							name="居住地址" title="居住地址" field="address" style="width:90%" ></label></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">联系人</td>
						<td class="FieldInput" style="width: 18%"><label field='familyContact'/></td>					
						<td class="FieldLabel" style="width: 15%">联系电话</td>
						<td class="FieldInput" style="width: 18%"><label
							name="联系电话" title="联系电话" field="familyMobile" style="width:80%" ></label></td>					
						<td class="FieldLabel" style="width: 15%"></td>
						<td class="FieldInput" style="width: 18%"></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">供养人口数</td>
						<td class="FieldInput" style="width: 18%"><label field="assistancePeopleNum" style="width:80%" ></label></td>
						<td class="FieldLabel" style="width: 15%">申请日期</td>
						<td class="FieldInput" style="width: 18%"><label
							name="申请日期" title="申请日期" field="applyDate" style="width:80%"></label></td>
						<td class="FieldLabel" style="width: 15%"></td>
						<td class="FieldInput" style="width: 18%"></td>
					</tr>
					<tr id="changeTR" style="display:none">
                    <td class="FieldLabel" style="width: 15%">变更项目</td>
                    <td class="FieldInput" style="width: 18%" id="changeItemText" colspan="5"></td>
                 </tr>
				<tr>
					<td class="FieldLabel" style="width: 15%"><label id="reasonLabel">申请理由</label></td>
					<td class="FieldInput" style="width: 18%" colspan="5"><textarea
						name="applyReason"
						style="width: 98%; background-color: #F5FAFA; border: 0; overflow: auto;"
						readonly field="applyReason" /></textarea></td>
				</tr>
					<tr style="display:none">
					<td class="FieldLabel" style="width: 15%">家庭类型</td>
					<td class="FieldInput" style="width: 18%" colspan="5">
						<label field="assistanceTypeName" ></label>
					</td>
				</tr>
				</table>
			</form>
			<form  method="post" onsubmit="return false" class="L5form" dataset="bankAccountDS">
				<table width="100%" >
				<tr>
						<td class="FieldLabel" style="width: 15%;border-top:none">开户银行</td>
						<td class="FieldInput" style="width: 18%;border-top:none">
							<label field="bank" dataset="bankDataset"></label>
						</td>	
						<td class="FieldLabel" style="width: 15%;border-top:none">账户名称</td>
						<td class="FieldInput" style="width: 18%;border-top:none">
						<label field="accountName" ></label>
						</td>
						<td class="FieldLabel" style="width: 15%;border-top:none">银行账号</td>
						<td class="FieldInput" style="width: 18%;border-top:none">
							<label field="accountNumber" ></label>
						</td>
						
					</tr>
				</table>
				</form>
		</next:Html>
	</next:Panel>

	<next:EditGridPanel id="peoplePanel" titleCollapse="true"
		collapsible="true" stripeRows="true" autoHeight="true"
		dataset="peopleListDataSet" title="家庭成员基本信息">
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column  id="name" field="NAME" header="姓名" width="60" renderer="getName">
				<next:TextField editable="false"/>
			</next:Column>
			
			<next:Column field="RELATIONSHIP_TYPE" header="与户主关系" width="100">
				<next:ComboBox editable="false" dataset="relationshipTypeDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column   field="HEALTH_CODE" header="健康状况" width="90" >
				<next:ComboBox editable="false" dataset="healthCodeDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column   field="IS_ASSISTANCE" header="是否供养对象" width="100">
					<next:ComboBox editable="false" dataset="comm_yesorno" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			<next:Column   field="DISABILITY_TYPE" header="残疾类别" width="90" >
				<next:ComboBox editable="false" dataset="disabilityTypeDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column   field="EDU_STATUS" header="学业状况" width="90">
				<next:ComboBox editable="false" dataset="education" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column  field="SELF_CARE_ABILITY" header="生活自理能力" width="90">
				<next:ComboBox editable="false" dataset="selfCareAbilityDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column  field="PERSONAL_STATS_TAG" header="人员状态" width="140">
				<next:ComboBox editable="false" dataset="samPersonalStatsDataSet" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>

	<next:EditGridPanel id="housePanel" titleCollapse="true"
		collapsible="true" stripeRows="true" autoHeight="true"
		dataset="houseListDataset" title="家庭房产信息">
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="所有权人" field="propertyOwner" dataset="supportedPeopleDataSet" width="140" />
			<next:Column header="住房性质" field="houseQuality" width="140">
				<next:ComboBox editable="false" dataset="houseQualityDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column header="房产（建房）证号" field="propertyCertificate"
				width="140" >
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="住房地址" field="houseAdd" width="240">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="建筑面积（㎡）" field="buildArea" width="100"
				align='right'>
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="使用面积（㎡）" field="useArea" width="100"
				align='right'>
				<next:TextField editable="false" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>

	<next:EditGridPanel id="estatePanel" titleCollapse="true"
		collapsible="true" stripeRows="true" autoHeight="true"
		dataset="estateListDataset" title="家庭财产信息">
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="财产类型" field="estateType" width="140">
				<next:ComboBox editable="false" dataset="estateTypeDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column header="备注" field="remarks" width="340">
				<next:TextField editable="false" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>

	<next:GridPanel id="supportPanel" titleCollapse="true"
		collapsible="true" stripeRows="true" autoHeight="true"
		dataset="supportListDataset" title="赡（抚、扶）养义务人员信息" notSelectFirstRow="true">
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			    <next:Column header="姓名" field="name" width="70" renderer="getSupportName">
					<next:TextField  />
				</next:Column>
				<next:Column header="身份证号" field="idCard" width="140" >
					<next:TextField  />
				</next:Column>
				<next:Column header="被赡（抚、扶）养人" field="supportedPeople" width="125" >
					<next:ComboBox dataset="supportedPeopleDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="与被赡（抚、扶）养人关系" field="relation" width="160" >
					<next:ComboBox dataset="supportedRelationDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="年负担赡（抚、扶）养费（元）" field="supportedPay" width="170" align='right'>
					<next:TextField  />
				</next:Column>
				<next:Column header="无赡（抚、扶）养能力原因" field="noSupportReason" width="155" >
					<next:ComboBox dataset="noSupportReasonDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
		</next:Columns>
	</next:GridPanel>
	<next:EditGridPanel id="filesPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="ArchCatalogDS" title="申请证明材料">
		<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="filesUpload" disabled=""  iconCls="upload" text="电子文件相关" handler="scanFiles" />
			</next:TopBar>
			<next:Columns>
			     <next:RowNumberColumn width="50" header="编号"/>
			    <next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="catalogName" header="档案目录" field="CATALOG_NAME" width="300" >
				</next:Column>
				<next:Column id="pageSize" header="页数" field="PAGE_SIZE" width="80">
				</next:Column>
			</next:Columns>
	</next:EditGridPanel>
	<next:Panel title="入户调查|评议|公示结果信息" id="panel2" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="acceptSurveyDataset">
			<fieldset><legend>入户调查</legend>
			<table width="100%">
				<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<label field="surveyResult" dataset="surveyResultDataSet"></label></td>		
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><label
						field="surveyDate"></label></td>
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyPeople"></label></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyContents"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%" colspan="5">
							<label id="fileName_survey" ></label>
						</td>	
					</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="acceptDiscussionDataset">
			<fieldset><legend>评议</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">评议内容</td>
					<td class="FieldInput" style="width: 10%" colspan="5">
					<textarea
						name="applyReason"
						style="width: 98%; background-color: #F5FAFA; border: 0; overflow: auto;"
						readonly field="content" /></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">评议意见</td>
					<td class="FieldInput" style="width: 10%"><label
						field="discussionResult" dataset="discussionResultDataSet"></label></td>
					<td class="FieldLabel" style="width: 10%">乡镇（街道）负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="principal"></label></td>
					<td class="FieldLabel" style="width: 10%">评议日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="discussionDate"></label></td>
				</tr>
				<tr>						
					<td class="FieldLabel" style="width: 10%">评议人数量</td>
					<td class="FieldInput" style="width: 10%">
						<label field="total"></label></td>
					<td class="FieldLabel" style="width: 10%">同意人数</td>
					<td class="FieldInput" style="width: 10%">
						<label field="agreeNum"></label></td>
					<td class="FieldLabel" style="width: 10%">不同意人数</td>
					<td class="FieldInput" style="width: 10%">
						<label field="disagreeNum"></label></td>
				</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%" colspan="5">
							<label id="fileName_discussion" ></label>
						</td>	
					</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="acceptNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%">
					<label field="noticeResult" dataset="noticeResultDataSet"></label></td>
					</td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="beginDate"></label></td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="endDate"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="principal"></label></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%" colspan="5">
							<label id="fileName_notice" ></label>
						</td>	
					</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>

	<next:Panel title="审核意见信息" id="checkDetailPanel" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="checkSurveyDataset">
			<fieldset><legend>入户调查</legend>
			<table width="100%">
				<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<label field="surveyResult" dataset="surveyResultDataSet"></label></td>		
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><label
						field="surveyDate"></label></td>
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyPeople"></label></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyContents"></label></td>
					</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="checkNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%">
					<label field="noticeResult" dataset="noticeResultDataSet"></label></td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="beginDate"></label></td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="endDate"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="principal"></label></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="applyDataSet">
			<fieldset><legend>审核意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">审核意见</td>
					<td class="FieldInput" style="width: 10%" colspan="5">
					<textarea
						name="applyReason"
						style="width: 98%; background-color: #F5FAFA; border: 0; overflow: auto;"
						readonly field="checkRemarks" /></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">审核结果</td>
					<td class="FieldInput" style="width: 10%">
					<label field="checkOpinionId" dataset="opinionDataSet"></label></td>
					<td class="FieldLabel" style="width: 10%">负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="checkPrincipal"></label></td>
					<td class="FieldLabel" style="width: 10%">审核日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="checkDate"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="checkAgent"></label></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel title="审批意见信息" id="auditDetailPanel" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="auditSurveyDataset">
			<fieldset><legend>入户调查</legend>
			<table width="100%">
				<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<label field="surveyResult" dataset="surveyResultDataSet"></label></td>		
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><label
						field="surveyDate"></label></td>
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyPeople"></label></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyContents"></label></td>
					</tr>
			</table>
			</fieldset>
			</form>
			
			<form method="post" onsubmit="return false" class="L5form"
				dataset="applyDataSet">
			<fieldset><legend>审批意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">审批意见</td>
					<td class="FieldInput" style="width: 10%" colspan="5">
					<textarea
						name="applyReason"
						style="width: 98%; background-color: #F5FAFA; border: 0; overflow: auto;"
						readonly field="auditRemarks" /></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">审批结果</td>
					<td class="FieldInput" style="width: 10%">
					<label field="auditOpinionId" dataset="opinionDataSet"></label></td>
					<td class="FieldLabel" style="width: 10%">民政局负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditPrincipal"></label></td>
					<td class="FieldLabel" style="width: 10%">审批日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditDate"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">五保证号</td>
					<td class="FieldInput" style="width: 10%"><label
						field="cardNo"></label></td>
					<td class="FieldLabel" style="width: 10%">
					<label id="beginDateL" style="display:none">救助截止月份</label>
					<label id="beginDateSL" style="display:none">救助开始月份</label>
					</td>
					<td class="FieldInput" style="width: 10%"><label
						field="beginDate"></label></td>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditAgent"></label></td>
				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="auditNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%">
					<label field="noticeResult" dataset="noticeResultDataSet"></label></td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="beginDate"></label></td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="endDate"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="principal"></label></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	
</next:Panel>

<jsp:include page="hisDetail.jsp" flush="true" />   
</body>
</html>