<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<html>
<head>
<title>农村五保历史数据录入页面</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String method=request.getParameter("method");//新增还是修改
		String applyId=request.getParameter("applyId");//业务主键
		String nowTime= DateUtil.getDay();
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		String address=DicUtil.getTextValueFromDic("dic_city","ID",organArea,"NAME");
		String apanageCode=organArea.substring(0,6)+"000000";
		String apanageName=DicUtil.getTextValueFromDic("dic_city","ID",apanageCode,"NAME");
		String cityCode=organArea.substring(0,4)+"00000000";
		String cityName=DicUtil.getTextValueFromDic("dic_city","ID",cityCode,"NAME");
		String organCodeStr = UserCommand.getSubOrganCode(organArea) ;
        String hideFlag=request.getParameter("hideFlag");

	%>
	var method='<%=method%>';
	var applyId='<%=applyId%>';
	var nowTime='<%=nowTime%>';
	var organArea = '<%=organArea%>';
	var organName = '<%=organName%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	var address='<%=address%>';
	var apanageCode='<%=apanageCode%>';
	var apanageName='<%=apanageName%>';
	var cityCode='<%=cityCode%>';
	var cityName='<%=cityName%>';
	var hideFlag='<%=hideFlag%>';
	//获取当前时间
	function getCurrent(){		
		return (new Date()).getTime();
	}
</script>
<script type="text/javascript" src="samFiveHisInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
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
	<!-- 家庭信息查询 -->
	<model:dataset id="familyQueryDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" method="querySamFamilyList" global="true">
		<model:params>
			<model:param name="assistanceType" value='03'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
			<model:field name="familyName" type="string" rule="require|length{50}" />
			<model:field name="familyCardNo" type="string" rule="require|length{18}" />
			<model:field name="beginDate" type="string" rule="require" />
			<model:field name="familyMobile" type="string" rule="length{20}" />
			<model:field name="address" type="string" rule="require|length{200}" />
			<model:field name="familyPostcode" type="string" rule="length{6}" />
				<model:field name="domicileName" type="string" rule="require" />
			<model:field name="domicileCode" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true" method='queryPeopleForSam' >
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
	<model:dataset id="filesListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 入户调查 -->
	<model:dataset id="acceptSurveyDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
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
	<!-- 生活自理能力 -->
	<model:dataset id="selfCareAbilityDataset" enumName="SAM_SELF_CARE_ABILITY" autoLoad="true" global="true"></model:dataset>
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
	<!-- 供养机构 -->
	<model:dataset id="supportOrgDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_GEROCOMIUM_INFO'></model:param>
			<model:param name="value" value='GEROCOMIUM_ID'></model:param>
			<model:param name="text" value='GEROCOMIUM_NAME'></model:param>
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
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 人员状态 -->
	<model:dataset id="samPersonalStatsDataSet" enumName="SAM_PERSONAL_STATS_TAG" autoLoad="true" global="true"></model:dataset>
	<!-- 银行账户信息 -->
	<model:dataset id="bankAccountDS" cmd="com.inspur.cams.drel.sam.cmd.SamBankAccountQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamBankAccount">
			<model:field name="bank" type="string" rule="require" />
			<model:field name="accountName" type="string" rule="require|length{25}" />
			<model:field name="accountNumber" type="string" rule="require" />
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
	
	<model:dataset id="dicCityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
			<model:params>
			<model:param name="id@rlike" value='<%=organCodeStr%>'></model:param>
		</model:params>
	</model:dataset>
	
</model:datasets>
   <next:Panel  height="100%" autoScroll="true" id="tab">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<%if(!"true".equals(hideFlag)){ %>
				<next:ToolBarItem id="newIdCard" iconCls="add" text="生成身份代码" disabled="" handler="newIdCard"/>
				<%} %>
				<next:ToolBarItem iconCls="save" id="saveId" text="保存" handler="save"/>
				<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
			</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="familyDataSet">
				<table width="100%">
					<input type="hidden" name="familyId" field="familyId" value="1"/>
					<input type="hidden" field="peopleNum" />
					<tr>						
						<td class="FieldLabel" style="width: 15%">户主姓名</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="户主姓名" title="户主姓名" id="familyName" field="familyName"  style="width:80%" maxlength="25" /><font color="red">*</font>		</td>				
						<td class="FieldLabel" style="width: 15%">身份证号</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="身份证号" title="身份证号" field="familyCardNo" id="familyCardNo" style="width:80%" maxlength="18" onchange="checkCradNo(this)" /><font color="red">*</font></td>
						
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
						<td class="FieldLabel" style="width: 15%">供养方式</td>
						<td class="FieldInput" style="width: 18%">
							<select id='supportWay' name='供养方式' style="width:80%" onblur='getSupportOrg()'>
								<option dataset='supportWayDataset'></option>
							</select><font color="red">*</font>
						</td>
						<td class="FieldLabel" style="width: 15%">供养机构</td>
						<td class="FieldInput" style="width: 18%">
							<select id='supportOrg' name='供养机构' style="width:80%" disabled=true >
								<option dataset='supportOrgDataset'></option>
							</select>
						</td>
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
						<td class="FieldLabel" style="width: 15%">邮政编码</td>
                        <td class="FieldInput" style="width: 18%"><input type="text"
                            name="居住地邮编" title="居住地邮编" field="familyPostcode" maxlength="6" style="width:80%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">家庭地址</td>
						<td class="FieldInput" style="width: 18%" colspan="3"><input type="text" maxlength="100"
							name="家庭地址" title="家庭地址" field="address" style="width:93%" /><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">联系人</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
							name="联系人" title="联系人" field="familyContact" style="width:80%" /></td>
						<td class="FieldLabel" style="width: 15%">联系电话</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
							name="联系电话" title="联系电话" field="familyMobile" style="width:80%" /></td>
						<td class="FieldLabel" style="width: 15%">供养人口数</td>
						<td class="FieldInput" style="width: 18%"><label field="assistancePeopleNum"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">救助开始月份</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="救助开始月份" title="救助开始月份" field="beginDate" style="width:80%"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly"/><font color="red">*</font>
						</td>
							<td class="FieldLabel" style="width: 15%">救助结束月份</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="救助结束月份" title="救助结束月份" field="endDate" style="width:80%" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly"/>
						</td>
						<td class="FieldLabel" style="width: 15%">五保证号</td>
						<td class="FieldInput" style="width: 18%">
							<input type="text" name="五保证号" title="五保证号" field="cardNo" style="width:80%"  />
						</td>
					</tr>
					<tr  style="display:none">
						<td class="FieldLabel" style="width: 15%">家庭类型</td>
						<td class="FieldInput" style="width: 18%" colspan="5">
							<input type="text" field="assistanceTypeName" id='assistanceTypeName' style="width:95.8%" readOnly="true" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
							<input type="hidden" field="assistanceType" id='assistanceType'>
						</td>
					</tr>
				</table>
				</form>
				<form  method="post" onsubmit="return false" class="L5form" dataset="bankAccountDS">
				<table width="100%" >
				<tr id="bankTr"  style="display:none">
						<td class="FieldLabel" style="width: 15%;border-top:none">开户银行</td>
						<td class="FieldInput" style="width: 18%;border-top:none">
							<select name="开户银行" title="开户银行" field="bank" style="width:80%" >
								<option dataset="bankDataset"></option>
							</select><font color="red">*</font>
						</td>	
						<td class="FieldLabel" style="width: 15%;border-top:none">账户名称</td>
						<td class="FieldInput" style="width: 18%;border-top:none"><input type="text"
							name="账户名称" title="账户名称" field="accountName" style="width:80%" /><font color="red">*</font>
						</td>
						<td class="FieldLabel" style="width: 15%;border-top:none">银行账号</td>
						<td class="FieldInput" style="width: 18%;border-top:none"><input type="text"
							name="银行账号" title="银行账号" field="accountNumber" style="width:80%"  /><font color="red">*</font>
						</td>
						
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		
		<next:GridPanel id="peoplePanel" titleCollapse="true" collapsible="true"  stripeRows="true" autoHeight="true" dataset="peopleListDataSet" title="家庭成员基本信息" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<%if(!"true".equals(hideFlag)){ %>
					<next:ToolBarItem id="peopleAdd" iconCls="add" text="新增" handler="addPeople"  disabled="" />
					<%} %>
					<next:ToolBarItem iconCls="detail" text="修改" handler="changePeople" />
                    <%if(!"true".equals(hideFlag)){ %>
					<next:ToolBarItem  iconCls="detail" text="变更户主" handler="changePeopleRelationshipType"  />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removePeople" />
					<%} %>
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
				<next:Column   field="IS_ASSISTANCE" header="是否供养对象" width="100">
					<next:ComboBox editable="false" dataset="comm_yesorno" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="DISABILITY_TYPE" header="残疾类别" width="100" >
					<next:ComboBox editable="false" dataset="disabilityTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="EDU_STATUS" header="学业状况" width="110">
					<next:ComboBox editable="false" dataset="eduStatusDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column  field="SELF_CARE_ABILITY" header="生活自理能力" width="100">
					<next:ComboBox editable="false" dataset="selfCareAbilityDataset" displayField="text" valueField="value" typeAhead="true" />
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
			    <next:Column header="姓名" field="name" width="70" >
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
	<next:Panel id="acceptEditPanel" title="入户调查|评议|公示结果信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptSurveyDataset">
			<fieldset><legend>入户调查</legend>
				<table width="100%">
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%"><option dataset="surveyResultDataSet"></option></select>
						<font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  onClick="WdatePicker()" maxlength="10"/></td>	
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><input type="text"
							name="调查负责人" title="调查负责人" maxlength="100" field="surveyPeople" style="width:80%" /></td>
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
										field="content" style="width: 97%"   /></textarea>
						</td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">评议意见</td>
						<td class="FieldInput" style="width: 10%">
						<select name="评议意见" title="评议意见" field="discussionResult"  style="width:80%" ><option dataset="discussionResultDataSet"></option></select>
						<font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">乡镇（街道）负责人</td>
						<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
							name="负责人" title="负责人" field="principal"  style="width:80%" /></td>	
						<td class="FieldLabel" style="width: 10%">评议日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="评议日期" title="评议日期" field="discussionDate" style="width:80%"  onClick="WdatePicker()" maxlength="10"/></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">评议人数量</td>
						<td class="FieldInput" style="width: 10%">
						<input type="text"  name="评议总人数" maxlength="2" title="评议总人数" field="total"id="total" onchange="countDiscussionNum();"   style="width:80%" /></td>				
						<td class="FieldLabel" style="width: 10%">同意人数</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="同意人数" title="同意人数" maxlength="2" field="agreeNum"id="agreeNum" onchange="countDiscussionNum();"   style="width:80%" /></td>	
						<td class="FieldLabel" style="width: 10%">不同意人数</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="不同意人数" title="不同意人数" maxlength="2" field="disagreeNum" style="width:80%" /></td>
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
							name="公示开始日期" title="公示开始日期" field="beginDate" style="width:80%"  onClick="WdatePicker()" maxlength="10" /></td>
						<td class="FieldLabel" style="width: 10%">公示结束日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="公示结束日期" title="公示结束日期" field="endDate" style="width:80%"  onClick="WdatePicker()" maxlength="10" /></td>	
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">经办人</td>
						<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
							name="经办人" title="经办人"  style="width:80%" field="principal" /></td>	
						<td class="FieldInput" colspan="4"></td>				
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
							name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  onClick="WdatePicker()" maxlength="10"/></td>	
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
					</select></td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示开始日期" name="公示开始日期" field="beginDate" style="width: 80%"
						 onClick="WdatePicker()" maxlength="10" />
					</td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示结束日期" name="公示结束日期" field="endDate" style="width: 80%"
						 onClick="WdatePicker()" maxlength="10"/>
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
						title="负责人" name="负责人" style="width: 80%" field="checkPrincipal" />
					</td>
					<td class="FieldLabel" style="width: 10%">审核日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="审核日期" name="审核日期" field="checkDate" style="width: 80%"
						 onClick="WdatePicker()" maxlength="10" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%">
					<input type="text"
						title="经办人" name="经办人" style="width: 80%" field="checkAgent" maxlength="16" /></td>
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
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%"><option dataset="surveyResultDataSet"></option></select>
						</td>				
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  onClick="WdatePicker()" maxlength="10"/></td>	
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
				dataset="auditNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%"><select name="公示结果"
						title="公示结果" field="noticeResult" style="width: 80%">
						<option dataset="noticeResultDataSet"></option>
					</select> <font color="red">*</font></td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示开始日期" name="公示开始日期" field="beginDate" style="width: 80%"
						 onClick="WdatePicker()" maxlength="10"/>
					</td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示结束日期" name="公示结束日期" field="endDate" style="width: 80%"
						 onClick="WdatePicker()" maxlength="10" />
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
					<td class="FieldInput" style="width: 10%"><select name="审批结果"
						title="审批结果" field="auditOpinionId" style="width: 80%" >
						<option dataset="opinionDataSet"></option>
					</select><font color="red">*</font></td>
					<td class="FieldLabel" style="width: 10%">民政局负责人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="民政局负责人" name="民政局负责人" style="width: 80%" field="auditPrincipal" />
					</td>
					<td class="FieldLabel" style="width: 10%">审批日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="审批日期" name="审批日期" field="auditDate" style="width: 80%"
						 onClick="WdatePicker()" maxlength="10" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="经办人" name="经办人" style="width: 80%" field="auditAgent" /></td>
					<td class="FieldLabel" style="width: 10%"></td>
					<td class="FieldInput" style="width: 10%"></td>
					<td class="FieldLabel" style="width: 10%"></td>
					<td class="FieldInput" style="width: 10%"></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>		
		</next:Panel>
<!-- 变更户主 -->
<next:Window id="changeApplyPeople" closeAction="hide" title="变更户主" width="350" height="210" modal="true">
	<next:EditGridPanel dataset="peopleListDataSet" height="150" >
			<next:Columns>
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column field="NAME" header="姓名" width="140">
					<next:TextField editable="false"/>
				</next:Column>
				<next:Column field="RELATIONSHIP_TYPE" header="与户主关系" width="140">
					<next:ComboBox  dataset="relationshipTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>	
	<next:Html>
		<div align="center">
			<button style="width:100" onclick="changeRelationshipType()">保存</button> &nbsp;&nbsp;
			<button style="width:100" onclick="closeWin()">关闭</button>
		</div>
	</next:Html>
</next:Window>
<jsp:include page="../../comm/newIdCard.jsp" flush="true"></jsp:include>	
<jsp:include page="../../comm/assistanceType.jsp" flush="true">   
	<jsp:param name= "assistanceType" value= "03"/> 
</jsp:include>
</body>	
</body>
</html>
