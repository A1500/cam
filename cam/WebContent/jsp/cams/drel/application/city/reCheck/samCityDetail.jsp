<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>城市低保复查页面</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String applyId=request.getParameter("applyId");//业务主键
		String method=request.getParameter("method");//是待办还是已办
		String applyName=request.getParameter("name");//环节名称
		String assignmentId=request.getParameter("assignmentId");//委派实例ID
		String nowMonth= DateUtil.getMonth();
	%>
	var applyId='<%=applyId%>';
	var method='<%=method%>';
	
	var applyName='<%=applyName%>';
	var assignmentId='<%=assignmentId%>';
	var nowMonth='<%=nowMonth%>';
	var nowTime='<%= DateUtil.getDay()%>';
	var parentOrganArea = '<%=BspUtil.getParentOrgan().getOrganCode()%>';
	var organArea = '<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
</script>
<script type="text/javascript" src="samCityDetail.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>	
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
			<model:field name="assistanceMoney" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
			<model:field name="assistanceClassMoney" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" method='queryPeopleForSam'
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭房产信息 -->
	<model:dataset id="houseListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyHouseQueryCmd" global="true"   >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyHouse">
		</model:record>
	</model:dataset>
	<!-- 家庭财产信息 -->
	<model:dataset id="estateListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyEstateQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyEstate">
		</model:record>
	</model:dataset>
	<!-- 赡（抚、扶）养人信息 -->
	<model:dataset id="supportListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilySupportQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilySupport">
		</model:record>
	</model:dataset>
	<!-- 被赡（抚、扶）养人 -->
	<model:dataset id="supportedPeopleDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BASEINFO_PEOPLE'></model:param>
			<model:param name="value" value='PEOPLE_ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 申请材料 -->
	<model:dataset id="filesListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 审核入户有异议证明文件 -->
	<model:dataset id="checkruhuFileDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<!-- 审核评议有异议证明文件 -->
	<model:dataset id="checkpingyiFileDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>	
	<!-- 审核公示有异议证明文件 -->
	<model:dataset id="checkDisNoticeFileDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<!-- 审批入户有异议证明材料 -->
	<model:dataset id="auditruhuFileDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>	
	<!-- 审批公示有异议证明材料 -->
	<model:dataset id="auditDisNoticeFileDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>	
	
	<!-- 评议结果 -->
	<model:dataset id="acceptDiscussionDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyDiscussionQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.sam.data.SamApplyDiscussion">
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='check'></model:param>
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
			<model:field name="principal" type="string" rule="length{32}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>'></model:param>
		</model:params>
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

	<model:dataset id="comm_yesorno" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_YES_NO'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 主要致贫原因 -->
	<model:dataset id="povertyCauseDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_PROVERTY_CAUSE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="healthCodeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_HEALTH'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类别  -->
	<model:dataset id="disabilityTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	<model:dataset id="employmentCodeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
 
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_LABOR_CAPACITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房类型 -->
	<model:dataset id="houseQualityDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_HOUSEFRAME'></model:param>
		</model:params>
	</model:dataset>
	 <!-- 性别代码-->
	 <model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度-->
	 <model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='dic_education'></model:param>
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
	
	<model:dataset id="getClassMoneyDataset" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceClass"></model:record>
	</model:dataset>
	<!-- 与被赡（抚、扶）养人关系 -->
	<model:dataset id="supportedRelationDataset" enumName="SAM_SUPPORTED_RELATION" autoLoad="true" global="true"></model:dataset>
	<!-- 救助方式 -->
	<model:dataset id="assistanceModeDataset" enumName="SAM_ASSISTANCE_MODE" autoLoad="true" global="true"></model:dataset>
	<!-- 财产类型 -->
	<model:dataset id="estateTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_ESTATE_TYPE'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 申请证明材料 -->
	<model:dataset id="fileTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_FILE_NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 调查结果 -->
	<model:dataset id="surveyResultDataSet" enumName="SURVEY_RESULT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 评议意见 -->
	<model:dataset id="discussionResultDataSet" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_DISCUSSION_RESULT'></model:param>
		</model:params>
	</model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="noticeResultDataSet" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_NOTICE_RESULT'></model:param>
		</model:params>
	</model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 复查结果 -->
   		<model:dataset id="samRecheckResultDs" enumName="SAM.RECHECK.RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel height="100%" autoScroll="true" id="tab">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
							if(!"detail".equals(method)){	
							if("audit".equals(applyName)){
								
		%>

		<%-- <next:ToolBarItem id="checkId" disabled="" iconCls="edit" text="转核对"
			handler="addCheck" /> --%>
			<%
					}
				%>
		<next:ToolBarItem id="saveId" disabled="" iconCls="save" text="保存"
			handler="save" />
		<next:ToolBarItem id="submitId" disabled="" iconCls="select" text="提交"
			handler="submitApply" />
		<%
					}
				%>

		<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack" />
	</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"
		autoHeight="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="家庭详细信息"
				handler="detailexpand" />
		</next:TopBar>
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="familyDataSet">
			<table width="100%">
				<input type="hidden" name="familyId" field="familyId" value="1" />
				<tr>
					<td class="FieldLabel" style="width: 15%">户主姓名</td>
					<td class="FieldInput" style="width: 18%"><label name="户主姓名"
						title="户主姓名" field="familyName" style="width: 80%"></label></td>
					<td class="FieldLabel" style="width: 15%">身份证号</td>
					<td class="FieldInput" style="width: 18%"><label name="身份证号"
						title="身份证号" field="familyCardNo" style="width: 80%" /></label></td>

					<td class="FieldLabel" style="width: 15%" rowspan="4">照片</td>
					<td class="FieldInput" style="width: 18%" rowspan="4">
					<div id="photoDiv"><img id="img" name="FAMILY_IMG" width=140
						height=90
						src="<%=SkinUtils.getRootUrl(request) %>skins/images/family.png"
						align="top"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>skins/images/family.png'"
						alt="暂无图片" /> <input type="hidden" id="familyPhotoId"
						name="familyPhotoId" /></div>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">主要致贫原因</td>
					<td class="FieldInput" style="width: 18%"><label
						field="povertyCause" dataset="povertyCauseDataset"></label></td>
					<td class="FieldLabel" style="width: 15%">保障人口数</td>
					<td class="FieldInput" style="width: 18%"><label name="保障人口数"
						title="保障人口数" field="assistancePeopleNum" style="width: 80%"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">家庭月总收入（元）</td>
					<td class="FieldInput" style="width: 18%"><label name="家庭月总收入"
						title="家庭月总收入" field="monthIncome" style="width: 80%"></label></td>
					<td class="FieldLabel" style="width: 15%">家庭月均收入（元）</td>
					<td class="FieldInput" style="width: 18%"><label name="家庭月均收入"
						title="家庭月均收入" field="monthAverageIncome" style="width: 80%"></label></td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">地区</td>
					<td class="FieldInput" style="width: 18%"><label
						name="地区" title="地区" field="domicileName"
						readonly id="lrdwmc"></label> <input style="display: none;"
						name="lrdwId" id="lrdwIdquery" field="domicileCode" /></td>
					<td class="FieldLabel" style="width: 15%">联系电话</td>
					<td class="FieldInput" style="width: 18%"><label name="联系电话"
						title="联系电话" field="familyMobile" style="width: 80%"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">家庭地址</td>
					<td class="FieldInput" style="width: 18%" colspan="3"><label
						name="居住地址" title="居住地址" field="address" style="width: 90%"></label></td>
					<td class="FieldLabel" style="width: 15%">邮政编码</td>
					<td class="FieldInput" style="width: 18%"><label  field="familyPostcode"></label></td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">申请日期</td>
					<td class="FieldInput" style="width: 18%"><label name="申请日期"
						title="申请日期" field="applyDate" style="width: 80%"></label>
					</td>
					
					<td class="FieldLabel" style="width: 15%">户人均居住面积（㎡）</td>
					<td class="FieldInput" style="width: 18%">
						<label id="averageArea"> </label>
					</td>
					<td class="FieldLabel" style="width: 15%">家庭类型</td>
					<td class="FieldInput" style="width: 18%" >
						<label field="assistanceTypeName" ></label>
					</td>	
				</tr>
				<tr >
					<td class="FieldLabel" style="width: 15%" id="assistanceMoneyName">户月保障金（元）<br/><font color="red">(不含低保金加发金额)</font></td>
					<td class="FieldInput" style="width: 18%;display: none" id="assistanceMoney" >
						<input type="text" name="户月保障金" title="户月保障金"  maxlength="16"
							field="assistanceMoney" style="width:80%" onchange="countTotle();" id="assistanceMoneyID"/>
					</td>
					<td class="FieldInput" style="width: 18%" id="assistanceMoneyL">
						<label id="assistanceMoneyID1" onchange="countTotle();" field="assistanceMoney" ></label>
					</td>
					
					<td class="FieldLabel" style="width: 15%" id="asisstanceClassName">低保金加发类别</td>
					<td class="FieldInput" style="width: 18%;display: none" id="asisstanceClass">
						<select name="低保金加发类别" title="低保金加发类别"field="assistanceClass" style="width:80%"onchange="getClassMoney(this.value);" >
								<option dataset='asisstanceClassDataset'></option>
						</select>
					</td>
					<td class="FieldInput" style="width: 18%" id="asisstanceClassL">
						<label field="assistanceClass" dataset='asisstanceClassDataset' ></label>					
					</td>
					
					<td class="FieldLabel" style="width: 15%" id="assistanceClassMoneyName" > 低保金加发金额（元）</td>
					<td class="FieldInput" style="width: 18%;display: none" id="assistanceClassMoney" >
						<input type="text" name="低保金加发金额" maxlength="16" onchange="countTotle();" id="assistanceClassMoneyID"
							title="低保金加发金额" field="assistanceClassMoney" style="width:80%" />
					</td>
					<td class="FieldInput" style="width: 18%" id="assistanceClassMoneyL">					
						<label field="assistanceClassMoney" id="assistanceClassMoneyID1" ></label>					
					</td>
					
				</tr>
				<tr >
					<td class="FieldLabel" style="width: 15%" id="assistanceModeName">救助金计算方式</td>					
					<td class="FieldInput" style="width: 18%;display:none" id="assistanceMode">
						<select name="救助金计算方式" title="救助金计算方式" field="assistanceMode"id="assistanceModeID"
						 		onchange="countAssistanceMoney(this.value)" style="width:80%" >
							<option dataset="assistanceModeDataset"></option>
						</select>
						<font color="red">*</font>
					</td>
							
					<td class="FieldInput" style="width: 18%" id="assistanceModeL">
						<label field="assistanceMode" dataset="assistanceModeDataset" id="assistanceModeID"></label>
					</td>
					
					<td class="FieldLabel" style="width: 15%" id="totalMoneyName" >合计<br/><font color="red">（户月保障金+低保金加发金额）</font></td>
					<td class="FieldInput" style="width: 18%" id="totalMoneyL" ><label id="totalMoney" ></label></td>
					<td class="FieldLabel" style="width: 15%" id="totalMoneyNamenull"></td>
					<td class="FieldInput" style="width: 18%" id="totalMoneyLnull">
					</td>					
				</tr>
				
				<tr>
					<td class="FieldLabel" style="width: 15%">申请理由</td>
					<td class="FieldInput" style="width: 18%" colspan="5"><textarea
						name="applyReason"
						style="width: 98%; background-color: #F5FAFA; border: 0; overflow: auto;" 
						readonly="readonly" field="applyReason" /></textarea></td>
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
			<next:Column id="name" field="NAME" header="姓名" width="100" renderer="getName">
				<next:TextField editable="false" />
			</next:Column>

			<next:Column field="RELATIONSHIP_TYPE" header="与户主关系" width="115">
				<next:ComboBox editable="false" dataset="relationshipTypeDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>

			<next:Column field="HEALTH_CODE" header="健康状况" width="100">
				<next:ComboBox editable="false" dataset="healthCodeDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
				<next:Column   field="IS_ASSISTANCE" header="是否保障对象" width="100">
					<next:ComboBox editable="false" dataset="comm_yesorno" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			<next:Column field="DISABILITY_TYPE" header="残疾类别" width="100">
				<next:ComboBox editable="false" dataset="disabilityTypeDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>

			<next:Column field="EMPLOYMENT_CODE" header="就业状况" width="110">
				<next:ComboBox editable="false" dataset="employmentCodeDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>

			<next:Column field="LABOR_CAPACITY" header="劳动能力" width="100">
				<next:ComboBox editable="false" dataset="laborCapacityDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column   field="EDU_CODE" header="文化程度" width="110">
				<next:ComboBox editable="false" dataset="eduDataSet" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column   field="INCOME_MONTH" header="月收入（元）" width="80" align="right">
				<next:TextField editable="false"/>
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
	
	<next:GridPanel id="housePanel"titleCollapse="true" hidden="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="houseListDataset" title="家庭房产信息">
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 
			    <next:Column header="所有权人" field="propertyOwner" dataset="supportedPeopleDataSet" width="140" >
                </next:Column>	
				<next:Column header="住房性质" field="houseQuality"  width="140"  >
					<next:ComboBox editable="false" dataset="houseQualityDataset"  displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="房产（建房）证号" field="propertyCertificate" width="140" >
					<next:TextField />
				</next:Column>
				<next:Column header="住房地址" field="houseAdd" width="140" >
					<next:TextField  />
				</next:Column>
				<next:Column header="建筑面积（㎡）" field="buildArea" width="140" align='right'>
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column header="使用面积（㎡）" field="useArea" width="140" align='right'>
					<next:TextField   editable="false"/>
				</next:Column>
			</next:Columns>
		</next:GridPanel> 
		
	<next:GridPanel id="estatePanel"titleCollapse="true" hidden="true"  collapsible="true"  stripeRows="true"  autoHeight="true" dataset="estateListDataset" title="家庭财产信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column header="财产类型" field="estateType" width="140" >
					<next:ComboBox   dataset="estateTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="备注" field="remarks" width="340" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
		</next:GridPanel>
		
	<next:GridPanel id="supportPanel"titleCollapse="true" hidden="true"  collapsible="true"  stripeRows="true"  autoHeight="true" dataset="supportListDataset" title="监护人员信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="姓名" field="name" width="100" >
					<next:TextField  />
				</next:Column>
				<next:Column header="身份证号" field="idCard" width="149" >
					<next:TextField  />
				</next:Column>
				<next:Column header="家庭住址" field="homeAddress" width="140" >
					<next:TextField  />
				</next:Column>
				<next:Column header="联系电话" field="telePhone" width="178" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
	</next:GridPanel>
	<next:GridPanel id="filesPanel"titleCollapse="true" hidden="true"  collapsible="true"  stripeRows="true"  autoHeight="true" dataset="filesListDataset" title="申请证明材料">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="证明材料名称" field="fileType" width="200" dataset="fileTypeDataset">
					<next:TextField  />
				</next:Column>
				<next:Column header="文件名" field="applyFileId" width="400" renderer="downloadFile">
				</next:Column>
				<next:Column header="备注" field="remarks" width="400" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
	
	</next:GridPanel>
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
					<tr id="checkbeizhuhang" style="display: none">						
						<td class="FieldLabel" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyContents"></label></td>
					</tr>
					<tr id="crhFile" style="display: none">
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%" colspan="5">
							<label id="fileName_crh" ></label>
						</td>	
					</tr>
					<td  class="FieldInput" style="width:10%;border-right:none;display: none">
							&nbsp;&nbsp;<label id="del_crh" ></label>
					</td>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form" style="display: none"
				dataset="acceptDiscussionDataset">
			<fieldset><legend>民主评议</legend>
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
					<td class="FieldLabel" style="width: 10%">回避备案</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="回避备案" title="回避备案"  readonly field="avoidfilling"
						style="width: 98%; background-color: #F5FAFA; border: 0; overflow: auto;" /></textarea></td>
				</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%" colspan="5">
							<label id="fileName_cpy" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none;display: none">
							&nbsp;&nbsp;<label id="del_cpy" ></label>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form" style="display: none"
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
				<tr id="yiyihangcheck" style="display: none">
					<td class="FieldLabel" style="width: 10%">异议详情</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="异议详情" title="异议详情" field="noticeDisDetail"
						style="width: 97%" /></textarea></td>
				</tr>
				 <tr id="wenjianhangcheck" style="display: none">
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_cgs" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none;display: none">
							&nbsp;&nbsp;<label id="del_cgs" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('CGS')">上传</a>
						</td>
							
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
						<label field="checkOpinionId" dataset="opinionDataSet"></label>
					</td>
					<td class="FieldLabel" style="width: 10%">审核日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="checkDate"></label>
					</td>
					<td class="FieldLabel" style="width: 10%"></td>
					<td class="FieldInput" style="width: 10%">
					</td>				
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="checkAgent"></label></td>
					
					<td class="FieldLabel" style="width: 10%">民政局负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="checkPrincipal"></label></td>
					<td class="FieldLabel" style="width: 10%"></td>
					<td class="FieldInput" style="width: 10%">
					</td>			
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
					<tr id="auditbeizhuhang" style="display:none">						
						<td class="FieldLabel" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><label
						field="surveyContents"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%" colspan="5">
							<label id="fileName_arh" ></label>
						</td>	
						<td  class="FieldInput" style="width:10%;border-right:none;display: none">
							&nbsp;&nbsp;<label id="del_arh" ></label>
					</td>
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
					
					<td class="FieldLabel" style="width: 10%">审批日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditDate"></label></td>
					<td class="FieldInput" style="width: 10%" colspan="2"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">低保证号</td>
					<td class="FieldInput" style="width: 10%"><label
						field="cardNo"></label></td>
					<td class="FieldLabel" style="width: 10%">救助开始月份</td>
					<td class="FieldInput" style="width: 10%"><label
						field="beginDate"></label></td>
					
					<td class="FieldInput" style="width: 10%" colspan="2"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditAgent"></label></td>
					<td class="FieldLabel" style="width: 10%">低保局负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditPrincipal"></label></td>
					<td class="FieldLabel" style="width: 10%">民政局负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditPrincipal"></label></td>
				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form" style="display: none"
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
				
				<tr id="yiyihangAudit" style="display: none">
					<td class="FieldLabel" style="width: 10%">异议详情</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="异议详情" title="异议详情" field="noticeDisDetail"
						style="width: 97%" /></textarea></td>
				</tr>
				<tr id="wenjianhangAudit" style="display: none">
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_ags" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none;display: none">
							&nbsp;&nbsp;<label id="del_ags" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('AGS')">上传</a>
						</td>	
					</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>


	<next:Panel title="审核意见信息" id="checkEditPanel" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="checkSurveyDataset">
			<fieldset><legend>入户调查</legend>
			<table width="100%">
				<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<!-- <td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%" onchange="checkOpinionCheck(this.value)"><option dataset="surveyResultDataSet"></option></select>
						 </td>  -->
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%" onchange="checkOpinioncheck(this.value)"><option dataset="surveyResultDataSet"></option></select>
						 </td>				
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>	
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><input type="text" maxlength="100"
							name="调查负责人" title="调查负责人" field="surveyPeople" style="width:80%" /><font color="red">*</font></td>
					</tr>
					<tr id="checkbeizhuhang" style="display:none">						
						<td class="FieldLabel" id="beizhu" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5">
							<textarea id="surveyContents" name="备注" title="备注" 
								field="surveyContents" style="width:80%"  /></textarea><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_crh" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none">
							&nbsp;&nbsp;<label id="del_crh" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('CRH')">上传</a>
						</td>		
					</tr>
					
			</table>
			</fieldset>
			</form>
			
			<form  method="post" onsubmit="return false" class="L5form" dataset="acceptDiscussionDataset" style="display: none">
					<fieldset><legend>民主评议</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 10%" >评议内容</td>
						<td class="FieldInput" style="width: 10%" colspan="5">
							<textarea name="评议内容" title="评议内容"
										field="content" style="width: 97%"   /></textarea><font color="red">*</font>
						</td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">评议意见</td>
						<td class="FieldInput" style="width: 10%">
						<select name="评议意见" title="评议意见" field="discussionResult"  style="width:80%" ><option dataset="discussionResultDataSet"></option></select>
						<font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">乡镇（街道）负责人</td>
						<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
							name="负责人" title="负责人" field="principal"  style="width:80%" /><font color="red">*</font></td>	
						<td class="FieldLabel" style="width: 10%">评议日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="评议日期" title="评议日期" field="discussionDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">评议人数量</td>
						<td class="FieldInput" style="width: 10%">
						<input type="text"  name="评议总人数" title="评议总人数" field="total"id="total" onchange="countDiscussionNum();"  maxlength="2" style="width:80%" /><font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">同意人数</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="同意人数" title="同意人数" id="agreeNum" field="agreeNum" maxlength="2"  onchange="countDiscussionNum();" style="width:80%" /><font color="red">*</font></td>	
						<td class="FieldLabel" style="width: 10%">不同意人数</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="不同意人数" title="不同意人数" field="disagreeNum" maxlength="2" style="width:80%" /><font color="red">*</font></td>
					</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">近亲属备案</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="近亲属备案" title="近亲属备案"  field="avoidfilling"
						style="width: 97%" /></textarea><font color="red">*</font></td>
				</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_cpy" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none">
							&nbsp;&nbsp;<label id="del_cpy" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('CPY')">上传</a>
						</td>	
					</tr>
					</table>
				</fieldset>
				</form>
			<form method="post" onsubmit="return false" class="L5form" style="display: none"
				dataset="checkNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%"><select name="公示结果"
						title="公示结果" field="noticeResult" style="width: 80%" onchange="checknoticeResult(this.value)">
						<option dataset="noticeResultDataSet"></option>
					</select></td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示开始日期" name="公示开始日期" field="beginDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
					</td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示结束日期" name="公示结束日期" field="endDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="经办人" name="经办人" style="width: 80%" field="principal" /></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
				<tr id="yiyihangcheck" style="display: none">
					<td class="FieldLabel" style="width: 10%">异议详情</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="异议详情" title="异议详情" field="noticeDisDetail"
						style="width: 97%" /></textarea></td>
				</tr>
				<tr id="wenjianhangcheck" style="display: none">
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_cgs" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none;">
							&nbsp;&nbsp;<label id="del_cgs" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('CGS')">上传</a>
						</td>
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
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="审核意见" title="审核意见" field="checkRemarks" style="width: 97%" /></textarea>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">审核结果</td>
					<td class="FieldInput" style="width: 10%"><select name="审核结果"
						title="审核结果" field="checkOpinionId" style="width: 80%">
						<option dataset="samRecheckResultDs"></option>
					</select> <font color="red">*</font></td>
					<td class="FieldLabel" style="width: 10%">负责人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="负责人" name="负责人" style="width: 80%" field="checkPrincipal" /><font color="red">*</font>
					</td>
					<td class="FieldLabel" style="width: 10%">审核日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="审核日期" name="审核日期" field="checkDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%">
					<input type="text" maxlength="16"
						title="经办人" name="经办人" style="width: 80%" field="checkAgent" /><font color="red">*</font></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
				
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel title="审批意见信息" id="auditEditPanel" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="auditSurveyDataset">
			<fieldset><legend>入户调查</legend>
			<table width="100%">
				<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%" onchange="checkOpinionaudit(this.value);"><option dataset="surveyResultDataSet"></option></select>
						</td>				
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>	
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><input type="text" maxlength="100"
							name="调查负责人" title="调查负责人" field="surveyPeople" style="width:80%" /></td>
					</tr>
					<tr id="auditbeizhuhang" style="display:none">						
						<td class="FieldLabel" id="beizhu" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5">
							<textarea id="surveyContents" name="备注" title="备注" 
								field="surveyContents" style="width:80%"  /></textarea><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_arh" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none">
							&nbsp;&nbsp;<label id="del_arh" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('ARH')">上传</a>
						</td>		
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
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="审批意见" title="审批意见" field="auditRemarks" style="width: 97%" /></textarea>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">审批结果</td>
					<td class="FieldInput" style="width: 10%"><select name="审批结果" onchange="checkOpinion(this.value);showToCheckReason(this.value)"
						title="审批结果" field="auditOpinionId" style="width: 80%" >
						<option dataset="samRecheckResultDs"></option>
					</select><font color="red">*</font></td>
					
					<td class="FieldLabel" style="width: 10%">审批日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="审批日期" name="审批日期" field="auditDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font>
					</td><td class="FieldInput" style="width: 10%" colspan="2"></td>
				</tr>
				<tr id="toChangeReasonTr" style="display: none">
						<td class="FieldLabel" style="width: 10%">转变更意见</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><textarea
							name="转变更意见" title=”审核转变更意见"  field=""
								style="width: 97%" /></textarea><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%">
						<input type="text" title="经办人" name="auditAgent" field="auditAgent" style="width: 80%" />
					</td>
					<td class="FieldLabel" style="width: 10%">低保局负责人</td>
					<td class="FieldInput" style="width: 10%">
						<input type="text" title="低保局负责人" name="auditLowPrincipal" field="auditLowPrincipal" style="width: 80%"/>
					</td>
					<td class="FieldLabel" style="width: 10%">民政局负责人</td>
					<td class="FieldInput" style="width: 10%">
						<input type="text" title="民政局负责人" name="auditPrincipal" field="auditPrincipal" style="width: 80%"/>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
			
			<form method="post" onsubmit="return false" class="L5form" style="display: none"
				dataset="auditNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%"><select name="公示结果"
						title="公示结果" field="noticeResult" style="width: 80%" onchange="checkAuditnoticeResult(this.value);">
						<option dataset="noticeResultDataSet"></option>
					</select> <font color="red">*</font></td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示开始日期" name="公示开始日期" field="beginDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font>
					</td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示结束日期" name="公示结束日期"  field="endDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="经办人" name="经办人" style="width: 80%" field="principal" /><font color="red">*</font></td>
					
					<td class="FieldLabel" id='card1' style="width: 10%;display:none">救助开始月份</td>
					<td class="FieldInput" id='card2'  style="width: 10%;display:none "><input type="text"
						title="救助开始月份" name="救助开始月份" style="width: 80%"  id="beginDate" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" />
						<label style='color:red'>*</label>
					</td>
					<td class="FieldLabel" id="noCard1" style="width: 10%;display:block"></td>
					<td class="FieldInput" id="noCard2" style="width: 10%;display:block"></td>
					
					<td class="FieldLabel" style="width: 10%"></td>
					<td class="FieldInput" style="width: 10%"></td>
				</tr>
				<tr id="yiyihangAudit" style="display: none">
					<td class="FieldLabel" style="width: 10%">异议详情</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="异议详情" title="异议详情" field="noticeDisDetail"
						style="width: 97%" /></textarea></td>
				</tr>
				<tr id="wenjianhangAudit" style="display: none">
						<td class="FieldLabel" style="width:10%">上传文件</td>
						<td class="FieldInput" style="width:10%;border-right:none" colspan="4">
							<label id="fileName_ags" ></label>
						</td>
						<td  class="FieldInput" style="width:10%;border-right:none">
							&nbsp;&nbsp;<label id="del_ags" ></label>
							&nbsp;&nbsp;<a href=# onclick="uploadCheckFile('AGS')">上传</a>
						</td>	
					</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
<jsp:include page="../../../comm/uploadListCheck.jsp" flush="true"></jsp:include>
</body>
</html>
