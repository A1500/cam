<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 党建组织登记表 -->
<head>
<title>党建情况登记表</title>
<next:ScriptManager />
<script type="text/javascript" src="somPartyHisEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
var partyId='<%=request.getParameter("partyId")%>';
var morgArea='<%=BspUtil.getOrganCode()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty">
			<model:field name="sorgId" type="string" rule=""/>
		    <model:field name="ifBuildParty" type="string" rule=""/>
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
		    <model:field name="nobuildReason" type="string" rule=""/>
		    <model:field name="createTime" type="string" rule="require"/>
		    <model:field name="instructor" type="string" rule="length{72}"/>
		    <model:field name="instructorWorkName" type="string" rule="length{100}"/>
		    <model:field name="nobuildReason" type="string" rule=""/>
		    <model:field name="nobuildReason" type="string" rule=""/>
		    <model:field name="inFromOrgan" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseInsertDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" sortField="PRAISE_DATE">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="winPartyPraiseDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" global='true'>
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="somPartyChangeDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyChangeQueryCmd" sortField="CHANGE_DATE">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyChange"></model:record>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan" method="queryOrgan"  >
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
	<model:dataset id="partyStatusDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_STATUS'></model:param>
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
	<model:dataset id="somPartyChangeItemSelect" enumName="SOM.PARTY.CHANGE.ITEM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="inTypeSelect" enumName="SOM.PARTY.IN_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="praiseOrPunnishSelect" enumName="SOM.PARTY.PRAISE_OR_PUNNISH" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="praiseTypeSelect" enumName="SOM.PARTY.PRAISE_TYPE" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="grantedTitleSelect" enumName="SOM.PARTY.GRANTED_TITLE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存"  handler="saveParty"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="panelPartyMember" height="100%" autoScroll="true" title='基本信息'>
	<next:Html>
		<form id="somPartyBuildForm" method="post" onsubmit="return false" dataset="somPartyDS" class="L5form" >
		<fieldset>
		<legend>基本信息</legend>
		<table width="100%">
				<input type="hidden" id="sorgId" field="sorgId"  value="社会组织ID">
				<input type="hidden" id="partyId" field="partyId"  value="党建ID">
			<tr>
				<td class="FieldLabel" width="14%"><label>社会组织名称:</label></td>
				<td class="FieldInput" colspan='3'><label  id="sorgName" field="sorgName" style="width: 95%"></label></td>
				<td class="FieldLabel" width="14%"><label>社会组织类型:</label></td>
				<td class="FieldInput" width="19%"><select   id="sorgType"  field="sorgType" style="width: 95%" disabled="disabled"><option dataset="sorgTypeDS" ></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="14%"><label>社会组织住所:</label></td>
				<td class="FieldInput" width="19%"><label  id="sorgAdds"  style="width: 95%"></label></td>
				<td class="FieldLabel" width="14%"><label>社会组织电话:</label></td>
				<td class="FieldInput" width="19%"><label   id="sorgPhone"   style="width: 95%" /></td>
				<td class="FieldLabel" width="14%"><label>党组织是否建立:</label></td>
				<td class="FieldInput" width="19%"><select id="ifBuildParty" field="ifBuildParty" onchange="showParty(this.options[this.options.selectedIndex]);" style="width: 95%"><option dataset="yesOrNo"></option></select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>法定代表人:</label></td>
				<td class="FieldInput" ><label  id="legalPeople" field="legalPeople" style="width: 95%"></label></td>
				<td class="FieldLabel"><label>法定代表人政治面貌:</label></td>
				<td class="FieldInput" ><select   id="politics" field="politics" style="width: 95%" disabled="disabled"><option dataset="politicsDS"></option></select></td>
				<td class="FieldLabel"><label>社会组织从业人员数:</label></td>
				<td class="FieldInput" ><label  id="meetingNum" field="meetingNum" style="width: 95%"></label></td>
			</tr>
			<tr >
				<td class="FieldLabel"><label>业务主管单位:</label></td>
				<td class="FieldInput"><select  id="borgName"  style="width: 95%" disabled><option dataset='borgNameSelect'/></select></td>
				<td class="FieldLabel"><label>业务主管单位成立社会组织<br>党委标记:</label></td>
				<td class="FieldInput"><select   id="borgIfBuildParty" field='borgIfBuildParty'  style="width: 95%" disabled><option dataset='yesOrNo'></option></select></td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"></td>
			</tr>
		</table>
		</fieldset>
<!-- 已建党组织 -->
		<div id="buildDiv" style="display:block;">
				<fieldset>
				<legend>党建情况</legend>
				<input type="hidden" id="sorgId" field="sorgId">
				<table width="100%">
					<tr>
						<td class="FieldLabel"><label>党组织名称:</label></td>
						<td class="FieldInput" colspan='5'><input name="党组织名称:" id="partyName" field="partyName" style="width: 99%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="14%"><label>党组织成立时间:</label></td>
						<td class="FieldInput" width="19%"><input type="text" name="党组织成立时间" id="buildDate" format="Y-m-d"  field="buildDate" onclick="WdatePicker();" style="width: 95%"/></td>
						<td class="FieldLabel" width="14%"><label>党建状态:</label></td>
						<td class="FieldInput" width="19%"><label name="党建状态:" id="partyStatus"  field="partyStatus"  dataset="partyStatusDS" style="width: 95%"></label></td>
						<td class="FieldLabel" width="14%"><label>审批单位:</label></td>
						<td class="FieldInput" width="19%"><input type="text" name="审批单位" id="auditOrgan" field="auditOrgan" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>审批文号:</label></td>
						<td class="FieldInput"><input type="text" name="审批文号" id="auditFileCode" field="auditFileCode" style="width: 95%"/></td>
						<td class="FieldLabel"><label>党组织类别:</label></td>
						<td class="FieldInput"><select name="党组织类别" id="buildType" field="buildType"  style="width: 95%"><option dataset="build_type"></option></select></td>
						<td class="FieldLabel"><label>党组织类型:</label></td>
						<td class="FieldInput"><select name="党组织类型" id="partyType" field="partyType" style="width: 95%" disabled><option dataset="party_type"></option></select></td>
					</tr>
					<tr id="combinedTr" style="display:none;">
						<td class="FieldLabel"><label>联合支部名称:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="联合支部名称:" id="combined" field="combined" style="width:99%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党组织隶属关系:</label></td>
						<td class="FieldInput"><select id="belongRel" field="belongRel"  style="width: 95%"><option dataset="belong_rel"></option></select><font color="red">*</font></td>
						<td class="FieldLabel"><label>党组织负责人身份证号：</label></td>
						<td class="FieldInput"><input name="党组织负责人身份证号" id="idCard_partyChief" field="idCard" onblur="checkIdCradNo()" style="width:95%"/></td>
						<td class="FieldLabel"><label>是否兼合式党组织：</label></td>
						<td class="FieldInput"><select name="是否兼合式党组织" id="ifComParty" field="ifComParty"  style="width:95%" disabled><option dataset='yesOrNo'></option></select></td>
					</tr>
					<tr id="belongRelTr" style="display:none;">
						<td class="FieldLabel"><label>隶属关系说明:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="隶属关系说明:" id="belongRelDesc" field="belongRelDesc" style="width:99%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党组织负责人姓名:</label></td>
						<td class="FieldInput"><input type="text" id="partyChief" field="partyChief" style="width: 95%"/></td>
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
							<select name="党组织负责人社会组织职务:" id="sorgDuties"  field="sorgDuties" style="width: 95%">
								<option dataset="somDutySelect"></option>
							</select>
						</td>
						<td class="FieldLabel"><label>党组织负责人工作单位:</label></td>
						<td class="FieldInput"><input type="text" id="workName" field="workName" style="width: 95%"/></td>
						<td class="FieldLabel"><label>党组织负责人工作单位职务:</label></td>
						<td class="FieldInput"><input type="text" id="workDuties"  field="workDuties" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>专职党员人数:</label></td>
						<td class="FieldInput"><label type="text" name="专职党员人数" id="fulltimeNum" field="fulltimeNum" style="width: 95%" /></td>
						<td class="FieldLabel"><label>兼职党员人数:</label></td>
						<td class="FieldInput"><label type="text" name="兼职党员人数" id="parttimeNum"  field="parttimeNum" style="width: 95%" /></td>
						<td class="FieldLabel"><label>党员总数:</label></td>
						<td class="FieldInput"><label type="text" name="党员总数" id="engagedMemberNum" field="engagedMemberNum" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>预备党员人数:</label></td>
						<td class="FieldInput"><label type="text" name="预备党员人数" id="prepareNum" field="prepareNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>发展对象人数:</label></td>
						<td class="FieldInput"><label type="text" name="发展对象人数:" id="developNum" field="developNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>入党积极分子人数:</label></td>
						<td class="FieldInput"><label type="text" name="入党积极分子人数:" id="energeticNum"  field="energeticNum" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>申请入党人数:</label></td>
						<td class="FieldInput"><label type="text" name="申请入党人数:" id="appPartyNum" field="appPartyNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>已建群团组织:</label></td>
						<td class="FieldInput" ><select  name="已建群团组织" id="groupType"  field="groupType"  style="width: 95%"><option dataset="groupTypeDS" ></option></select></td>
						<td class="FieldLabel"><label>填表日期:</label></td>
						<td class="FieldInput"><input type="text"name='填表日期' id="createTime"format="Y-m-d"  field="createTime" onclick="WdatePicker();" style="width: 95%"/></td>
					</tr>
					<tr id="groupDescTr" style="display:none;">
						<td class="FieldLabel"><label>已建群团组织说明:</label></td>
						<td class="FieldInput" colspan="5"><input type="text" name="已建群团组织说明:" id="groupDesc" field="groupDesc" style="width:99%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>登记管理机关名称：</label></td>
						<td class="FieldInput" colspan="3"><label name="morgName" id="morgName" field="morgName"  style="width:95%"/></td>
						<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
						<td class="FieldInput"><label name="morgArea" id="morgArea" field="morgArea"  style="width:95%"/></td>
					</tr>
				</table>
				</fieldset>
			</div>

<!-- 未建党组织 -->
			<div id="unfoundedDiv" style="display:none;">
				<fieldset>
				<legend>党建情况</legend>
				<input type="hidden" id="sorgId" field="sorgId">
				<table width="100%">

					<tr>
						<td class="FieldLabel" width="14%"><label>党建状态:</label></td>
						<td class="FieldInput" width="19%"><label name="党建状态:" id="partyStatus"  field="partyStatus"  dataset="partyStatusDS" style="width: 95%"></label></td>
						<td class="FieldLabel" width="14%"><label>专职党员人数:</label></td>
						<td class="FieldInput" width="19%"><label type="text" name="专职党员人数" id="fulltimeNum_unfounded" field="fulltimeNum" style="width: 95%"/></td>
						<td class="FieldLabel" width="14%"><label>兼职党员人数:</label></td>
						<td class="FieldInput" width="19%"><label type="text" name="兼职党员人数" id="parttimeNum_unfounded"  field="parttimeNum" style="width: 95%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>党员总数:</label></td>
						<td class="FieldInput"><input type="text" name="党员总数" id="engagedMemberNum" field="engagedMemberNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>拟建党组织时间:</label></td>
						<td class="FieldInput"><input type="text" name="拟建党组织时间" id="planBuildDate" format="Y-m-d"  field="planBuildDate" onclick="WdatePicker();" style="width: 95%"/></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>申请入党人数:</label></td>
						<td class="FieldInput"><input type="text" name="申请入党人数" id="appPartyNum" field="appPartyNum" style="width: 95%"/></td>
						<td class="FieldLabel"><label>已建群团组织:</label></td>
						<td class="FieldInput"><select  name="已建群团组织" id="groupType" field="groupType" onchange="showGroupDesc2(this.options[this.options.selectedIndex]);" style="width: 95%"><option dataset="groupTypeDS" ></option></select></td>
						<td class="FieldLabel"><label>未建党组织原因:</label></td>
						<td class="FieldInput" ><select id="nobuildReason"  field="nobuildReason" onchange="showInstructor(this.options[this.options.selectedIndex]);" style="width: 95%"><option dataset="noBuildReasonDS"></option></select></td>
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
					<tr>
						<td class="FieldLabel"><label>登记管理机关名称：</label></td>
						<td class="FieldInput" ><label name="morgName" id="morgName" field="morgName"  style="width:95%"/></td>
						<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
						<td class="FieldInput"><label name="morgArea" id="morgArea" field="morgArea"  style="width:95%"/></td>
						<td class="FieldLabel"><label>填表时间:</label></td>
						<td class="FieldInput"><input type="text"name='填表时间' id="createTime" format="Y-m-d"  field="createTime" onclick="WdatePicker();" style="width: 95%"/></td>
					</tr>
				</table>
			</fieldset>
			</div>
			</form>
			</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>