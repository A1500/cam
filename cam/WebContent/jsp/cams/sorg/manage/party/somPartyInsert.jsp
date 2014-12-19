<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.*" %>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<!-- 党建组织登记表 -->
<head>
<title>党建情况登记表</title>
<next:ScriptManager />
<script type="text/javascript" src="somPartyInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
var createTime='<%=DateUtil.getDay()%>';
var partyId='<%=IdHelp.getUUID32()%>';
var searchSorgName=decodeURIComponent('<%=request.getParameter("searchSorgName")%>');
var searchSorgCode=decodeURIComponent('<%=request.getParameter("searchSorgCode")%>');
var searchSorgType=decodeURIComponent('<%=request.getParameter("searchSorgType")%>');
var applyType="401";
var taskCode='';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty">
		    <model:field name="ifBuildParty" type="string" rule="require"/>
		    <model:field name="auditOrgan" type="string" rule="length{100}"/>
		    <model:field name="auditFileCode" type="string" rule="length{30}"/>
		    <model:field name="groupDesc" type="string" rule="length{100}"/>
		    <model:field name="belongRelDesc" type="string" rule="length{100}"/>
		    <model:field name="combined" type="string" rule="length{100}"/>

		    <model:field name="partyChief" type="string" rule="length{72}"/>
		    <model:field name="sorgDuties" type="string" rule="length{10}"/>
		    <model:field name="workName" type="string" rule="length{100}"/>
		    <model:field name="workDuties" type="string" rule="length{50}"/>
		    <model:field name="fulltimeNum" type="string" rule="number"/>
		    <model:field name="parttimeNum" type="string" rule="number"/>
		    <model:field name="engagedMemberNum" type="string" rule="number"/>
		    <model:field name="developNum" type="string" rule="number"/>
		    <model:field name="energeticNum" type="string" rule="number"/>
		    <model:field name="appPartyNum" type="string" rule="number"/>
		    <model:field name="instructor" type="string" rule="length{72}"/>
		    <model:field name="instructorWorkName" type="string" rule="length{100}"/>
		    <model:field name="nobuildReason" type="string" rule=""/>
		    <model:field name="nobuildReason" type="string" rule=""/>
		    <model:field name="inFromOrgan" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somPartyCheckDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseInsertDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan"  >
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet1" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet_1" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet2" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet3" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet4" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet5" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="party_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="build_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_BUILD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="belong_rel" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_RELATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="groupTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_GROUP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="noBuildReasonDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_NOBUILD_REASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somDutySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="nationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="borgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifSorgPartySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='IF_SORG_PARTY'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="SEX" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="yesOrNo" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="inTypeSelect" enumName="SOM.PARTY.IN_TYPE" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="praiseOrPunnishSelect" enumName="SOM.PARTY.PRAISE_OR_PUNNISH" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="praiseTypeSelect" enumName="SOM.PARTY.PRAISE_TYPE" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="grantedTitleSelect" enumName="SOM.PARTY.GRANTED_TITLE" global="true"></model:dataset>

</model:datasets>
<next:Panel  width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存"  handler="saveParty"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabPartyMember">
		<next:Tabs>
	<next:Panel id="panelPartyMember" height="100%" autoScroll="true" title='基本信息'>
	<next:Html>
		<form id="somPartyBuildForm" method="post" onsubmit="return false" dataset="somPartyDS" class="L5form" >
		<fieldset>
		<legend>社会组织基本信息</legend>
		<table width="100%">
				<input type="hidden" id="sorgId" field="sorgId"  value="社会组织ID">
			<tr>
				<td class="FieldLabel" width="14%"><label>社会组织登记证号:</label></td>
				<td class="FieldInput" width="19%"><input type="text" id="sorgCode" onchange="querySorgOrganMess();" style="width: 95%"/><font color="red">*</font></td>
				<td class="FieldLabel" width="14%"><label>社会组织类型:</label></td>
				<td class="FieldInput" width="19%"><select  id="sorgType"  style="width: 95%" onchange="querySorgOrganMess();"><option dataset="sorgTypeDS" ></option></select><font color="red">*</font></td>
				<td class="FieldLabel" width="14%"><label>党组织是否建立:</label></td>
				<td class="FieldInput" width="19%"><select name='党组织是否建立' id="ifBuildParty" field="ifBuildParty" onchange="showParty()" style="width: 95%"><option dataset="yesOrNo"></option></select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>社会组织名称:</label></td>
				<td class="FieldInput" ><label  id="sorgName" ></label></td>
				<td class="FieldLabel" width="14%"><label>社会组织住所:</label></td>
				<td class="FieldInput" width="19%"><label  id="sorgAdds"  style="width: 95%"></label></td>
				<td class="FieldLabel" width="14%"><label>社会组织电话:</label></td>
				<td class="FieldInput" width="19%"><label   id="sorgPhone"   style="width: 95%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>法定代表人:</label></td>
				<td class="FieldInput" ><label  id="legalPeople" ></label></td>
				<td class="FieldLabel"><label>法定代表人政治面貌:</label></td>
				<td class="FieldInput" ><select   id="politics" style="width: 95%" disabled="disabled"><option dataset="politicsDS"></option></select></td>
				<td class="FieldLabel"><label>社会组织从业人员数:</label></td>
				<td class="FieldInput" ><label  id="meetingNum" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>转入类型:</label></td>
				<td class="FieldInput"><select   id="inType" field='inType'  style="width: 95%" onchange="showInInfo(this.value)"><option dataset='inTypeSelect'></option></select></td>
				<td class="FieldLabel"><label>业务主管单位:</label></td>
				<td class="FieldInput"><select  id="borgName"  style="width: 95%" disabled><option dataset='borgNameSelect'/></select></td>
				<td class="FieldLabel"><label>业务主管单位成立社会组织党委标记:</label></td>
				<td class="FieldInput"><select   id="borgIfBuildParty" field='borgIfBuildParty'  style="width: 95%" disabled><option dataset='yesOrNo'></option></select></td>
			</tr>
		</table>
		</fieldset>
		<div id="fullSystemInDiv" style="display:none;">
				<fieldset>
				<legend>转入情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel"  width="14%"><label>转入时间:</label></td>
						<td class="FieldInput"  width="19%"><input type="text" name="转入时间" id="inTime" format="Y-m-d"  field="inTime" onclick="WdatePicker();" style="width: 95%"/><font color="red">*</font></td>
						<td class="FieldLabel"  width="14%"><label>从何单位转入:</label></td>
						<td class="FieldInput"  width="19%"><input type="text" name="从何单位转入" id="inFromOrgan" field="inFromOrgan" style="width: 95%"/><font color="red">*</font></td>
						<td class="FieldLabel"  width="14%"></td>
						<td class="FieldInput"  width="19%"></td>
					</tr>
				</table>
				</fieldset>
		</div>
<!-- 已建党组织 -->
		<div id="buildDiv" style="display:none;">
				<fieldset>
				<legend>党建情况</legend>
				<input type="hidden" id="sorgId" field="sorgId">
				<table width="100%">
					<tr>
						<td class="FieldLabel"><label>党组织名称:</label></td>
						<td class="FieldInput" colspan='5'><input name="党组织名称:" id="partyName" field="partyName" style="width: 99%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"  width="14%"><label>党组织成立时间:</label></td>
						<td class="FieldInput"  width="19%"><input type="text" name="党组织成立时间" id="buildDate" format="Y-m-d"  field="buildDate" onclick="WdatePicker();" style="width: 95%"/></td>
						<td class="FieldLabel"  width="14%"><label>审批单位:</label></td>
						<td class="FieldInput"  width="19%" colspan='3'><input type="text" name="审批单位:" id="auditOrgan" field="auditOrgan" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="14%"><label>审批文号:</label></td>
						<td class="FieldInput" width="19%"><input type="text" name="审批文号:" id="auditFileCode" field="auditFileCode" maxlength="30" style="width: 95%"/></td>
						<td class="FieldLabel" width="14%"><label>党组织类别:</label></td>
						<td class="FieldInput" width="19%"><select name="党组织类别:" id="buildType" field="buildType" onchange="showCombined(this.options[this.options.selectedIndex]);" style="width: 95%"><option dataset="build_type"></option></select><font color="red">*</font></td>
						<td class="FieldLabel" width="14%"><label>党组织类型:</label></td>
						<td class="FieldInput" width="19%"><select name="党组织类型:" id="partyType" field="partyType" style="width: 95%" disabled><option dataset="party_type"></option></select></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党组织隶属关系:</label></td>
						<td class="FieldInput"><select name="党组织隶属关系:" id="belongRel" field="belongRel" onchange="showBelongRel(this.options[this.options.selectedIndex]);" style="width: 95%"><option dataset="belong_rel"></option></select><font color="red">*</font></td>
						<td class="FieldLabel"><label>党组织负责人身份证号：</label></td>
						<td class="FieldInput"><input name="党组织负责人身份证号" id="idCard_partyChief" field="idCard"  style="width:95%" onblur='getPartyChief()'/></td>
						<td class="FieldLabel"><label>是否兼合式党组织：</label></td>
						<td class="FieldInput"><select name="是否兼合式党组织" id="ifComParty" field="ifComParty"  style="width:95%" disabled><option dataset='yesOrNo'></option></select></td>
					</tr>
					<tr id="combinedTr" style="display:none;">
						<td class="FieldLabel"><label>联合支部名称:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="联合支部名称:" id="combined" field="combined" style="width:99%"/></td>
					</tr>
					<tr id="belongRelTr" style="display:none;">
						<td class="FieldLabel"><label>隶属关系说明:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="隶属关系说明:" id="belongRelDesc" field="belongRelDesc" style="width:99%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党组织负责人姓名:</label></td>
						<td class="FieldInput"><input type="text" name="党组织负责人姓名:" id="partyChief" field="partyChief" style="width: 95%"/></td>
						<td class="FieldLabel"><label>党组织负责人性别:</label></td>
						<td class="FieldInput"><select id="sex" field="sex" style="width: 95%"><option dataset="SEX"></option></select></td>
						<td class="FieldLabel"><label>党组织负责人出生年月:</label></td>
						<td class="FieldInput"><input type="text" id="birthday" format="Y-m-d"  field="birthday" onclick="WdatePicker();" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党组织负责人电话:</label></td>
						<td class="FieldInput"><input type="text" name="党组织负责人电话" id="phone" field="phone" style="width: 95%"/></td>
						<td class="FieldLabel"><label>党组织负责人学历:</label></td>
						<td class="FieldInput">
							<select name="党组织负责人学历" id="education" field="education" style="width: 95%">
								<option dataset="educationSelect"></option>
							</select>
						</td>
						<td class="FieldLabel"><label>党组织负责人民族:</label></td>
						<td class="FieldInput">
							<select name="党组织负责人民族" id="folk" field="folk" style="width: 95%">
								<option dataset="nationSelect"></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党组织负责人社会组织职务:</label></td>
						<td class="FieldInput">
							<input type="text" name='社会组织职务' field="sorgDuties" style="width:98%" maxlength="50"/>
						</td>
						<td class="FieldLabel"><label>党组织负责人工作单位:</label></td>
						<td class="FieldInput"><input type="text" name="党组织负责人工作单位:" id="workName" field="workName" style="width: 95%"/></td>
						<td class="FieldLabel"><label>党组织负责人工作单位职务:</label></td>
						<td class="FieldInput"><input type="text" name="党组织负责人工作单位职务:" id="workDuties"  field="workDuties" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>专职党员人数:</label></td>
						<td class="FieldInput"><label type="text" name="专职党员人数" id="fulltimeNum" field="fulltimeNum" style="width: 95%" maxlength="6" /></td>
						<td class="FieldLabel"><label>兼职党员人数:</label></td>
						<td class="FieldInput"><label type="text" name="兼职党员人数" id="parttimeNum"  field="parttimeNum" maxlength="6" style="width: 95%" /></td>
						<td class="FieldLabel"><label>党员总数:</label></td>
						<td class="FieldInput"><label type="text" name="党员总数" id="engagedMemberNum" field="engagedMemberNum" maxlength="6" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>预备党员人数:</label></td>
						<td class="FieldInput"><label type="text" name="预备党员人数" id="prepareNum" field="prepareNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>发展对象人数:</label></td>
						<td class="FieldInput"><label type="text" name="发展对象人数:" id="developNum" field="developNum" maxlength="6" style="width: 95%"/></td>
						<td class="FieldLabel"><label>入党积极分子人数:</label></td>
						<td class="FieldInput"><label type="text" name="入党积极分子人数:" id="energeticNum"  field="energeticNum" maxlength="6" style="width: 95%"/></td>
					</tr>
					<tr >
						<td class="FieldLabel"><label>申请入党人数:</label></td>
						<td class="FieldInput"><label type="text" name="申请入党人数:" id="appPartyNum" field="appPartyNum" maxlength="6" style="width: 95%"/></td>
						<td class="FieldLabel"><label>已建群团组织:</label></td>
						<td class="FieldInput" ><input type="checkbox" name="groupType" value="0" field="groupType" label="工会" />工会
						<input type="checkbox" name="groupType" value="1" field="groupType" label="共青团" />共青团
						<input type="checkbox" name="groupType" value="2" field="groupType" label="妇联" />妇联
						<input type="checkbox" name="groupType" value="3" field="groupType" label="其他" />其他</td>
						<td class="FieldLabel"><label>填表日期:</label></td>
						<td class="FieldInput"><input type="text" id="createTime_build"format="Y-m-d"name='填表日期'  field="createTime" onclick="WdatePicker();" style="width: 95%"/><font color="red">*</font></td>
					</tr>
					<tr id="groupDescTr" style="display:none;">
						<td class="FieldLabel"><label>已建群团组织说明:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="已建群团组织说明:" id="groupDesc" field="groupDesc" style="width:99%"/></td>
					</tr>
				</table>
				</fieldset>
			</div>

<!-- 未建党组织 -->
			<div id="unfoundedDiv" style="display:block;">
				<fieldset>
				<legend>党建情况</legend>
				<input type="hidden" id="sorgId" field="sorgId">
				<table width="100%">

					<tr>
						<td class="FieldLabel"  width="14%"><label>专职党员人数:</label></td>
						<td class="FieldInput"  width="19%"><label type="text" name="专职党员人数" id="fulltimeNum" field="fulltimeNum" style="width: 95%"/></td>
						<td class="FieldLabel"  width="14%"><label>兼职党员人数:</label></td>
						<td class="FieldInput"  width="19%"><label type="text" name="兼职党员人数" id="parttimeNum"  field="parttimeNum" style="width: 95%"/></td>
						<td class="FieldLabel"  width="14%"><label>负责人党员数:</label></td>
						<td class="FieldInput"  width="19%"><input type="text" name="负责人党员数" id="" field="" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党员总数:</label></td>
						<td class="FieldInput"><input type="text" name="党员总数" id="engagedMemberNum" field="engagedMemberNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>拟建党组织时间:</label></td>
						<td class="FieldInput"><input type="text" name="拟建党组织时间" id="planBuildDate" format="Y-m-d"  field="planBuildDate" onclick="WdatePicker();" style="width: 95%"/></td>
						<td class="FieldLabel"><label>申请入党人数:</label></td>
						<td class="FieldInput"><input type="text" name="申请入党人数" id="appPartyNum" field="appPartyNum" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>已建群团组织:</label></td>
						<td class="FieldInput">
						<input type="checkbox" name="groupType" value="0" field="groupType" label="工会" />工会
						<input type="checkbox" name="groupType" value="1" field="groupType" label="共青团" />共青团
						<input type="checkbox" name="groupType" value="2" field="groupType" label="妇联" />妇联
						<input type="checkbox" name="groupType" value="3" field="groupType" label="其他" />其他
						</td>

						<td class="FieldLabel"><label>未建党组织原因:</label></td>
						<td class="FieldInput" ><select id="nobuildReason"  field="nobuildReason" onchange="showInstructor(this.options[this.options.selectedIndex]);" style="width: 95%"><option dataset="noBuildReasonDS"></option></select><font color="red">*</font></td>
						<td class="FieldLabel"><label>填表时间:</label></td>
						<td class="FieldInput"><input type="text" id="createTime" format="Y-m-d" name='填表时间' field="createTime" onclick="WdatePicker();" style="width: 95%"/><font color="red">*</font></td>
					</tr>
					<tr id="groupDescTr2" style="display:none;">
						<td class="FieldLabel"><label>已建群团组织说明:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="已建群团组织说明:" id="groupDesc" field="groupDesc" style="width:99%"/></td>
					</tr>
					<tr id="instructorTr" style="display:none;">
						<td class="FieldLabel"><label>党建指导员姓名:</label></td>
						<td class="FieldInput"><input type="text" name="党建指导员姓名:" id="instructor" field="instructor" style="width: 95%"/></td>
						<td class="FieldLabel"><label>指导员工作单位:</label></td>
						<td class="FieldInput"><input type="text" name="指导员工作单位:" id="instructorWorkName" field="instructorWorkName" style="width: 95%" /></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr id="instructorTr2" style="display:none">
						<td class="FieldLabel"><label>指导员电话:</label></td>
						<td class="FieldInput"><input type="text" name="指导员电话:" id="instructorPhone" field="instructorPhone" style="width: 95%"/></td>
						<td class="FieldLabel"><label>指导员组织关系:</label></td>
						<td class="FieldInput"><select   id="instructorRel" field="instructorRel" style="width: 95%"><option dataset="belong_rel"></option></select></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>

				</table>
			</fieldset>
			</div>
			</form>
			</next:Html>
		</next:Panel>
			<next:EditGridPanel id="partyPraiseGrid" dataset="somPartyPraiseInsertDataSet" stripeRows="true" title="奖惩情况" height="100%" >
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加" handler="addPraise"></next:ToolBarItem>
					<next:ToolBarItem iconCls="delete" text="删除" handler="delPraise"></next:ToolBarItem>
					<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="uploadFile_praise"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="内码" field="praiseId" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="奖惩批准日期" field="praiseDate" width="10%" editable="true"><next:DateTimeField allowBlank="true" format="Y-m-d"/></next:Column>
					<next:Column header="奖惩类型" field="praiseOrPunnish" width="10%" editable="true"><next:ComboBox dataset="praiseOrPunnishSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩事项分类" field="praiseItemType" width="20%" editable="true"><next:ComboBox dataset="praiseTypeSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩名称" field="praiseName" width="30%" editable="true" ><next:TextField/></next:Column>
					<next:Column header="表彰授予称号" field="grantedTitle" width="10%" editable="true"><next:ComboBox id="grantedTitleComboBox" dataset="grantedTitleSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩批准单位名称" field="praiseOrg" width="30%" editable="true"><next:TextField/></next:Column>
					<next:Column header="文件号" field="fileNo" width="15%" editable="true"><next:TextField/></next:Column>
					<next:Column header="相关文件" field="fileName" width="25%" editable="true"><next:TextField/></next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="download_praise"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPartyPraiseInsertDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel title="法律要件" id="uploadGrid" dataset="somElectronicDataSet" width="100%" stripeRows="true" height="100%">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../comm/upload/partyUpload.jsp" flush="true"/>
</body>
</html>