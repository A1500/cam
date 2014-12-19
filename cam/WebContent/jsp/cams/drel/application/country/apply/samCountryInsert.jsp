<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.drel.comm.SamConfig"%>
<html>
<head>
<title>农村低保新申请录入页面</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String method=request.getParameter("method");//新增还是修改
		String applyId=request.getParameter("applyId");//业务主键
		String name=request.getParameter("name");//环节代码
		String assignmentId=request.getParameter("assignmentId");//委派实例ID
		String nowTime= DateUtil.getDay();
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		String address=DicUtil.getTextValueFromDic("dic_city","ID",organArea,"NAME");
		String cityCode=organArea.substring(0,4)+"00000000";
		String cityName=DicUtil.getTextValueFromDic("dic_city","ID",cityCode,"NAME");
		boolean ifFileCheck = SamConfig.getIfFileCheck();//获取流程里面受理时是否进行文件上传校验
		
		String organCodeStr = UserCommand.getSubOrganCode(organArea) ;
		
	%>
	var ifFileCheck='<%=ifFileCheck%>';
	var method='<%=method%>';
	var applyId='<%=applyId%>';
	var ActivityName='<%=name%>';
	var assignmentId='<%=assignmentId%>';
	var nowTime='<%=nowTime%>';
	var organArea = '<%=organArea%>';
	var organName = '<%=organName%>';
	var regId = '<%=BspUtil.getEmpOrgan().getOrganId()%>';
	var regOrg = '<%=BspUtil.getCorpOrgan().getOrganId()%>';
	var regOrgName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var regPeople = '<%=BspUtil.getEmpOrgan().getOrganName()%>';
	var regTime = '<%=DateUtil.getTime()%>';
	var regOrgType = '<%=BspUtil.getCorpOrgan().getOrganType()%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	var address='<%=address%>';
	var cityCode='<%=cityCode%>';
	var cityName='<%=cityName%>';
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
</script>
<script type="text/javascript" src="../../samApplyComm.js"></script>
<script type="text/javascript" src="samCountryInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>

<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.js"></script>
<link href="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
			<model:field name="familyName" type="string" rule="require|length{50}" />
			<model:field name="familyCardNo" type="string" rule="require|length{18}" />
			<model:field name="povertyCause" type="string" rule="require" />
			<model:field name="familyMobile" type="string" rule="length{20}" />
			<model:field name="address" type="string" rule="require|length{200}" />
			<model:field name="assistanceMode" type="string" rule="require" />
			<model:field name="familyPostcode" type="string" rule="length{6}" />
			<model:field name="assistanceMoney" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
			<model:field name="assistanceClassMoney" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
			<model:field name="applyReason" type="string" rule="length{500}" />
			<model:field name="applyDate" type="string" rule="require" />
			<model:field name="domicileName" type="string" rule="require" />
			<model:field name="domicileCode" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  method='queryPeopleForSam'>
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭房产信息 -->
	<model:dataset id="houseListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyHouseQueryCmd" global="true"   >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyHouse">
			<model:field name="propertyCertificate" type="string" rule="length{50}" />
			<model:field name="houseAdd" type="string" rule="length{100}" />
			<model:field name="buildArea" type="string" rule="regex{^[0-9]{1,14}\.[0-9]{0,2}$}" />
			<model:field name="useArea" type="string" rule="regex{^[0-9]{1,14}\.[0-9]{0,2}$}" />
		</model:record>
	</model:dataset>
	<!-- 家庭财产信息 -->
	<model:dataset id="estateListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyEstateQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyEstate">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 赡（抚、扶）养人信息 -->
	<model:dataset id="supportListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilySupportQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilySupport">
			<model:field name="name" type="string" rule="length{30}" />
			<model:field name="idCard" type="string" rule="length{18}" />
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
	<!-- 救助类型 -->
	<model:dataset id="AssistanceDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 申请材料 -->
	<model:dataset id="filesListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true"  pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="remarks" type="string" rule="length{500}" />
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
	<!-- 入户调查 -->
	<model:dataset id="acceptSurveyDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
			<model:field name="surveyResult" type="string" rule="require" />
			<model:field name="surveyPeople" type="string" rule="length{500}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='accept'></model:param>
		<model:param name="apply_Id" value='<%=applyId%>' ></model:param>
		</model:params>
	</model:dataset>
	<!-- 评议结果 -->
	<model:dataset id="acceptDiscussionDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyDiscussionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyDiscussion">
			<model:field name="content" type="string" rule="length{300}" />
			<model:field name="total" type="string" rule="regex{^[0-9]+$}|length{2}" />
			<model:field name="agreeNum" type="string" rule="regex{^[0-9]+$}|length{2}" />
			<model:field name="disagreeNum" type="string" rule="regex{^[0-9]+$}|length{2}" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='accept'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>' ></model:param>
		</model:params>
	</model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="acceptNoticeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
			<model:field name="noticeResult" type="string" rule="require" />
			<model:field name="principal" type="string" rule="require" />
			<model:field name="beginDate" type="string" rule="require" />
			<model:field name="endDate" type="string" rule="require" />
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='accept'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>' ></model:param>
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
	<model:dataset id="auditSurveyDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey"></model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>' ></model:param>
		</model:params>
	</model:dataset>
	<!-- 审批公示结果 -->
	<model:dataset id="auditNoticeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
			<model:param name="apply_Id" value='<%=applyId%>' ></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 主要致贫原因 -->
	<model:dataset id="povertyCauseDataset" enumName="SAM_CITY_PROVERTY_CAUSE" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
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
	<!-- 职业状况-->
   <model:dataset id="employmentCodeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY" autoLoad="true" global="true"></model:dataset>
	<!-- 住房类型 -->
	 <model:dataset id="houseQualityDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
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
	<!-- 与被赡（抚、扶）养人关系 -->
	<model:dataset id="supportedRelationDataset" enumName="SAM_SUPPORTED_RELATION" autoLoad="true" global="true"></model:dataset>
	<!-- 救助方式 -->
	<model:dataset id="assistanceModeDataset" enumName="SAM_ASSISTANCE_MODE" autoLoad="true" global="true"></model:dataset>
	<!-- 财产类型 -->
	<model:dataset id="estateTypeDataset" enumName="SAM_ESTATE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 申请证明材料 -->
	<model:dataset id="fileTypeDataset" enumName="SAM_FILE_NAME" autoLoad="true" global="true"></model:dataset>
	
	<!-- 调查结果 -->
	<model:dataset id="surveyResultDataSet" enumName="SURVEY_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 评议意见 -->
	<model:dataset id="discussionResultDataSet" enumName="DISCUSSION_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="noticeResultDataSet" enumName="NOTICE_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet_all" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 人员状态 -->
	<model:dataset id="samPersonalStatsDataSet" enumName="SAM_PERSONAL_STATS_TAG" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dicCityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
			<model:params>
			<model:param name="id@rlike" value='<%=organCodeStr%>'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 银行账户信息 -->
	<model:dataset id="bankAccountDS" cmd="com.inspur.cams.drel.sam.cmd.SamBankAccountQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamBankAccount">
			<model:field name="accountName" type="string" rule="length{25}" />
			<model:field name="accountNumber" type="string" rule="length{30}" />
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
   <next:Panel  height="100%" autoScroll="true" id="tab">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="newIdCard" iconCls="add" text="生成身份代码" disabled="" handler="newIdCard" hidden="true"/>
				<next:ToolBarItem id="saveId" iconCls="save" text="保存" disabled="" handler="save"/>
				<next:ToolBarItem id="submitId" iconCls="select" text="提交" disabled="" handler="submitApply" />
				<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
			</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="familyDataSet">
				<table width="100%">
					<input type="hidden" name="familyId" field="familyId" value="1"/>
					<input type="hidden" field="peopleNum" />
					<input type="hidden" field="monthIncome" />
					<input type="hidden" field="monthAverageIncome" />
					<tr>						
						<td class="FieldLabel" style="width: 15%">户主姓名</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="户主姓名" title="户主姓名" field="familyName" maxlength="25"  style="width:80%" /><font color="red">*</font>		</td>				
						<td class="FieldLabel" style="width: 15%">身份证号</td>
						<td class="FieldInput" style="width: 18%"><input type="text" id="familyCardNo"
							name="身份证号" title="身份证号" field="familyCardNo" maxlength="18" style="width:80%" onchange="checkCradNo(this)" /><font color="red">*</font></td>
						
						<td class="FieldLabel" style="width: 15%" rowspan="4">照片</td>
						<td class="FieldInput" style="width: 18%" rowspan="4">
							<div id="photoDiv">
								<img id="img" name="FAMILY_IMG"  width=140 height=90  src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
									align="top" ondblclick="editPhoto(4,'familyPhotoId','FAMILY_IMG');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
								<input type="hidden" id="familyPhotoId" name="familyPhotoId"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" >主要致贫原因</td>
						<td class="FieldInput" style="width: 18%"><select
							name="主要致贫原因" title="主要致贫原因" field="povertyCause" style="width:80%" ><option dataset="povertyCauseDataset"></option></select><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 15%">保障人口数</td>
						<td class="FieldInput" style="width: 18%"><label field="assistancePeopleNum"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">家庭年总收入（元）</td>
						<td class="FieldInput" style="width: 18%"><label field="yearIncome"></label></td>
						<td class="FieldLabel" style="width: 15%">家庭年均收入（元）</td>
						<td class="FieldInput" style="width: 18%"><label field="yearAverageIncome"></label></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">地区<font color="red" >(点击？选择或者输入汉字、首字母拼音检索)</font></td>
						<td class="FieldInput" style="width: 18%">
						  <input type="text" style="width:78%" name="地区" id="lrdwmc" field="domicileName" onkeyup="findDiv2(this,'lrdwId','popup','','dicCityDs','PY_CAPITAL@like','NAME@like','id','name','30')" onblur="clearDiv()"  style="width:300"/>
		                	 <div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
      								<ul></ul> </div>
						<input type="hidden"  name="地区编码" id="lrdwId" field="domicileCode" />
						 <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" /><font color="red">*</font>
						</td>
						<td class="FieldLabel" style="width: 15%">联系电话</td>
                        <td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
                            name="联系电话" title="联系电话" field="familyMobile" style="width:80%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">家庭地址</td>
						<td class="FieldInput" style="width: 18%" colspan="3"><input type="text" maxlength="100"
							name="居住地址" title="居住地址" field="address" style="width:93%" /><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 15%">邮政编码</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
							name="邮政编码" title="邮政编码" field="familyPostcode" style="width:80%" /></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">申请日期</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="申请日期" title="申请日期" field="applyDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 15%">救助金计算方式</td>
						<td class="FieldInput" style="width: 18%"><select 
							name="救助金计算方式" title="救助金计算方式" id="assistanceModeID" onchange="countAssistanceMoney(this.value)"field="assistanceMode" style="width:80%" ><option dataset="assistanceModeDataset"></option></select><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 15%"></td>
						<td class="FieldInput" style="width: 18%">
						</td>	
					</tr>
					<tr>	
						<td class="FieldLabel" style="width: 15%">户月保障金（元）<br/><font color="red">(不含分类施保金)</font></td>
						<td class="FieldInput" style="width: 18%">
						<label id="assistanceMoneyID1"onchange="countTotle();" field="assistanceMoney" style="display:none"></label>
						<input type="text" maxlength="14"
							name="户月保障金" title="户月保障金" onchange="countTotle();"id="assistanceMoneyID"field="assistanceMoney" style="width:80%;display:block" />
							
							</td>
							<td class="FieldLabel" style="width: 15%">分类施保类别</td>
						<td class="FieldInput" style="width: 18%">
							<select name="分类施保类别" title="分类施保类别" id='asisstanceClass' field="assistanceClass" style="width:80%" onchange="getClassMoney(this.value);">
								<option dataset='asisstanceClassDataset'></option>
							</select>
						</td>
						<td class="FieldLabel" style="width: 15%">分类施保金（元）</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="14"
							name="分类施保金" title="分类施保金" onchange="countTotle();" id="assistanceClassMoneyID" field="assistanceClassMoney" style="width:80%" /></td>	
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">合计<br/><font color="red">（户月保障金+分类施保金）</font></td>
						<td class="FieldInput" style="width: 18%"><label id="totalMoney"></label></td>
					    <td class="FieldLabel" width="15%">家庭类型</td>
					    <td class="FieldInput" width="18%" colspan='3'>
					    	<input type="text" field="assistanceTypeName" id='assistanceTypeName' style="width:85.8%" readOnly="true" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
							<input type="hidden" field="assistanceType" id='assistanceType'>
					    </td>	
				    </tr>	
				    <tr>
						<td class="FieldLabel" style="width: 15%">申请理由</td>
						<td class="FieldInput" style="width: 18%" colspan="5"><textarea name="申请理由" title="申请理由" 
										field="applyReason" style="width: 95.8%"   /></textarea><font color="red">*</font></td>
					</tr>	
				</table>
				</form>
					<form  method="post" onsubmit="return false" class="L5form" dataset="bankAccountDS">
				<table width="100%" >
				<tr>
						<td class="FieldLabel" style="width: 15%;border-top:none">开户银行</td>
						<td class="FieldInput" style="width: 18%;border-top:none">
							<select name="开户银行" title="开户银行" field="bank" style="width:80%" >
								<option dataset="bankDataset"></option>
							</select>
						</td>	
						<td class="FieldLabel" style="width: 15%;border-top:none">账户名称</td>
						<td class="FieldInput" style="width: 18%;border-top:none"><input type="text"
							name="账户名称" title="账户名称" field="accountName" style="width:80%" />
						</td>
						<td class="FieldLabel" style="width: 15%;border-top:none">银行账号</td>
						<td class="FieldInput" style="width: 18%;border-top:none"><input type="text"
							name="银行账号" title="银行账号" field="accountNumber" style="width:80%"  />
						</td>
						
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		
		<next:GridPanel id="peoplePanel" titleCollapse="true" collapsible="true"  stripeRows="true" autoHeight="true" dataset="peopleListDataSet" title="家庭成员基本信息" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="peopleAdd" iconCls="add" text="新增" handler="addPeople"  disabled="" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changePeople" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removePeople" />
			</next:TopBar>
			
			<next:Columns>
				 <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column  id="name" field="NAME" header="姓名" width="100">
					<next:TextField editable="false"/>
				</next:Column>
				
				<next:Column field="RELATIONSHIP_TYPE" header="与户主关系" width="115">
					<next:ComboBox editable="false" dataset="relationshipTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="HEALTH_CODE" header="健康状况" width="100" >
					<next:ComboBox editable="false" dataset="healthCodeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="IS_ASSISTANCE" header="是否保障对象" width="100">
					<next:ComboBox editable="false" dataset="comm_yesorno" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="DISABILITY_TYPE" header="残疾类别" width="100" >
					<next:ComboBox editable="false" dataset="disabilityTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="EMPLOYMENT_CODE" header="就业状况" width="110">
					<next:ComboBox editable="false" dataset="employmentCodeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column  field="LABOR_CAPACITY" header="劳动能力" width="100">
					<next:ComboBox editable="false" dataset="laborCapacityDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="EDU_CODE" header="文化程度" width="110">
					<next:ComboBox editable="false" dataset="eduDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="INCOME_YEAR" header="年收入（元）" width="80" align='right'>
					<next:TextField editable="false"/>
				</next:Column>
			</next:Columns>
		</next:GridPanel>
		<next:GridPanel id="housePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="houseListDataset" title="家庭房产信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem disabled="" id="houseAdd" iconCls="add" text="新增" handler="addHouse" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changeHouse" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeHouse" />
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 
			    <next:Column header="所有权人" field="propertyOwner" dataset="supportedPeopleDataSet" width="140" />	
				<next:Column header="住房性质" field="houseQuality" width="140" >
					<next:ComboBox dataset="houseQualityDataset" displayField="text" valueField="value" typeAhead="true" />
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
		
		<next:GridPanel id="estatePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="estateListDataset" title="家庭财产信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" disabled=""  id="estateAdd" text="新增" handler="addEstate" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changeEstate" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeEstate" />
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
		
	<next:GridPanel id="supportPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="supportListDataset" title="赡（抚、扶）养义务人员信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="supportAdd" iconCls="add" disabled=""  text="新增" handler="addSupport" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changeSupport" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeSupport" />
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
				<next:Column header="被赡（抚、扶）养人" field="supportedPeople" width="140" >
					<next:ComboBox dataset="supportedPeopleDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="与被赡（抚、扶）养人关系" field="relation" width="178" >
					<next:ComboBox dataset="supportedRelationDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="年负担赡（抚、扶）养费（元）" field="supportedPay" width="175" align='right'>
					<next:TextField  />
				</next:Column>
			</next:Columns>
	</next:GridPanel>
		
	<next:GridPanel id="filesPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="ArchCatalogDS" title="申请证明材料">
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
	</next:GridPanel>
	<next:Panel title="入户调查|评议|公示结果信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptSurveyDataset">
			<fieldset><legend>入户调查</legend>
				<table width="100%">
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%" onchange="checkOpinion(this.value);"><option dataset="surveyResultDataSet"></option></select>
						<font color="red">*</font></td>				
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
					<tr id="beizhuhang" style="display:none">						
						<td class="FieldLabel" id="beizhu" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5">
							<textarea id="surveyContents" name="备注" title="备注" 
								field="surveyContents" style="width:80%"  /></textarea><font color="red">*</font>
						</td>
					</tr>
					</table>
				</fieldset>
				</form>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptDiscussionDataset">
					<fieldset><legend>评议</legend>
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
					</table>
				</fieldset>
				</form>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptNoticeDataset">
					<fieldset><legend>公示结果</legend>
				<table width="100%">
					<tr>						
						<td class="FieldLabel" style="width: 10%">公示结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="公示结果" title="公示结果" field="noticeResult"  style="width:80%"  ><option dataset="noticeResultDataSet"></option></select>
						<font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">公示开始日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="公示开始日期" title="公示开始日期" field="beginDate" style="width:80%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 10%">公示结束日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="公示结束日期" title="公示结束日期" field="endDate" style="width:80%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font></td>	
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">经办人</td>
						<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
							name="经办人" title="经办人"  style="width:80%" field="principal" /><font color="red">*</font></td>	
						<td class="FieldInput" colspan="4"></td>				
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
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="审核意见" title="审核意见" disabled="disabled" field="checkRemarks"
						style="width: 97%" /></textarea></td>
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
			<form method="post" onsubmit="return false" class="L5form"
				dataset="applyDataSet">
			<fieldset><legend>审批意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">审批意见</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="审核意见" title="审核意见" disabled="disabled" field="auditRemarks"
						style="width: 97%" /></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">审批结果</td>
					<td class="FieldInput" style="width: 10%">
					<label field="auditOpinionId" dataset="opinionDataSet_all"></label></td>
					<td class="FieldLabel" style="width: 10%">民政局负责人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditPrincipal"></label></td>
					<td class="FieldLabel" style="width: 10%">审批日期</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditDate"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">低保证号</td>
					<td class="FieldInput" style="width: 10%"><label
						field="cardNo"></label></td>
					<td class="FieldLabel" style="width: 10%">救助开始月份</td>
					<td class="FieldInput" style="width: 10%"><label
						field="beginDate"></label></td>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><label
						field="auditAgent"></label></td>
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
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%"><option dataset="surveyResultDataSet"></option></select>
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
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="checkNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%"><select name="公示结果"
						title="公示结果" field="noticeResult" style="width: 80%">
						<option dataset="noticeResultDataSet"></option>
					</select> </td>
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
						<option dataset="opinionDataSet"></option>
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
		</next:Panel>

<jsp:include page="../../../comm/newIdCard.jsp" flush="true"></jsp:include>
<jsp:include page="../../../comm/assistanceType.jsp" flush="true">
	<jsp:param name= "assistanceType" value= "02"/> 
</jsp:include>	
<jsp:include page="../../../comm/uploadListCheck.jsp" flush="true"></jsp:include>
</body>
</html>
