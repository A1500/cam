<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>党建撤销备案</title>
<next:ScriptManager />
<script type="text/javascript" src="somPartyCancelX.js"></script>	
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>	
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>			
<script type="text/javascript">
var partyId='<%=request.getParameter("partyId")%>';
var ifBuildParty='<%=request.getParameter("ifBuildParty")%>';
var searchSorgName=decodeURIComponent('<%=request.getParameter("searchSorgName")%>');
var searchSorgCode=decodeURIComponent('<%=request.getParameter("searchSorgCode")%>');
var searchSorgType=decodeURIComponent('<%=request.getParameter("searchSorgType")%>');
var sorgId='';
var applyType="401,402";
var taskCode='';
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan"  >
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
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
	<model:dataset id="sorgTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
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
	<model:dataset id="noBuildReasonDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_NOBUILD_REASON'></model:param>
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
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="SEX" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="if_build_par" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset> 
</model:datasets>
<%--定义界面--%>
<next:Panel  width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="1">
		<next:Tabs>
			<next:Panel title="党建撤销备案查看" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form id="somPartyBuildForm" method="post" onsubmit="return false" dataset="somPartyDS" class="L5form" >
					<fieldset>
					<legend>党建撤销备案</legend>
					<table width="100%">
							<input type="hidden" id="partyId" field="partyId"  value="党建ID">			
						<tr>
							<td class="FieldLabel"><label>社会组织名称:</label></td>
							<td class="FieldInput" colspan="5"><label  id="sorgName" field="sorgName"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="14%"><label>社会组织类型:</label></td>
							<td class="FieldInput" width="19%"><label   id="sorgType" field="sorgType" style="width: 95%" dataset="sorgTypeDS" ></label></td>	
							<td class="FieldLabel" width="14%"><label>党组织类别:</label></td>
							<td class="FieldInput" width="19%"><label name="党组织类别" id="buildType" field="buildType" dataset="build_type"></label></td>
							<td class="FieldLabel" width="14%"><label>撤销党组织日期:</label></td>
							<td class="FieldInput" width="19%"><label id="cancelDate" format="Y-m-d"  field="cancelDate"  readonly="readonly"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>撤销文件编号:</label></td>
							<td class="FieldInput"><label name='撤销文件编号' field='cancelFileNo'/></td>
							<td class="FieldLabel"><label>撤销审批党组织名称:</label></td>
							<td class="FieldInput"><label name='撤销审批党组织名称' field='cancelAuditParty'/></td>
							<td class="FieldLabel"></td>
							<td class="FieldInput"></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>撤销理由:</label></td>
							<td class="FieldInput" colspan="5"><textArea  name="撤销理由:" id="cancelReason" field="cancelReason" readonly="readonly" cols="75" rows="15" style="width:99%"></textArea></td>
						</tr>	
						<tr>
							<td class="FieldLabel"><label>登记管理机关名称：</label></td>
							<td class="FieldInput"  colspan="3"><label name="morgName" id="morgName" field="morgName"  style="width:90%"/></td>
							<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
							<td class="FieldInput"><label name="morgArea" id="morgArea" field="morgArea"  style="width:100%"/></td>
						</tr>			
					</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="党建情况登记表查看" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form id="somPartyUnfoundedForm" method="post" onsubmit="return false" class="L5form" dataset="somPartyDS" style="display:none">
						<fieldset>
						<legend>未建党组织的单位填写党建情况登记表</legend>
							<input type="hidden" id="sorgId" field="sorgId">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="12%"><label>社会组织名称:</label></td>
									<td class="FieldInput" colspan="3"><label id="sorgName"  field="sorgName"></label></td>
									<td class="FieldLabel" width="12%"><label>社会组织类型:</label></td>
									<td class="FieldInput" width="18%"><label id="sorgType" field="sorgType" dataset="sorgTypeDS"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="14%"><label>社会组织住所:</label></td>
									<td class="FieldInput" width="19%"><label  id="sorgAdds"  style="width: 95%"></label></td>
									<td class="FieldLabel" width="14%"><label>社会组织电话:</label></td>
									<td class="FieldInput" width="19%"><label   id="sorgPhone"   style="width: 95%" /></td>	
									<td class="FieldLabel" width="14%"><label>党组织是否建立:</label></td>
									<td class="FieldInput" width="19%"><label id="ifBuildParty" field="ifBuildParty"  dataset="if_build_par"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>法人姓名:</label></td>
									<td class="FieldInput"><label id="legalPeople" field="legalPeople" ></label></td>
									<td class="FieldLabel"><label>政治面貌:</label></td>
									<td class="FieldInput"><label id="politics" field="politics" dataset="politicsDS"></label></td>
									<td class="FieldLabel"><label>社会组织专职人员数:</label></td>
									<td class="FieldInput"><label id="meetingNum" field="meetingNum"  ></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>社会组织兼职人员数:</label></td>
									<td class="FieldInput"><label   id="practiceNum"   style="width: 95%" /></td>	
									<td class="FieldLabel"><label>业务主管单位:</label></td>
									<td class="FieldInput"><select  id="borgName"  style="width: 95%" disabled><option dataset='borgNameSelect'/></select></td>				
									<td class="FieldLabel"><label>业务主管单位成立社会组织党委标记:</label></td>
									<td class="FieldInput"><label   id="borgIfBuildParty" field='borgIfBuildParty'  style="width: 95%" dataset='if_build_par'/></td>	
								</tr>
								<tr>
									<td class="FieldLabel"><label>党建状态:</label></td>
									<td class="FieldInput"><label name="党建状态:" id="partyStatus"  field="partyStatus"  dataset="partyStatusDS"></label></td>							
									<td class="FieldLabel"><label>专职党员人数:</label></td>
									<td class="FieldInput"><label name="专职党员人数" id="fulltimeNum" field="fulltimeNum"></label></td>
									<td class="FieldLabel"><label>兼职党员人数:</label></td>
									<td class="FieldInput"><label name="兼职党员人数" id="parttimeNum"  field="parttimeNum"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>负责人党员数:</label></td>
									<td class="FieldInput"><label name="负责人党员数" id="" field=""></label></td>
									<td class="FieldLabel"><label>党员总数:</label></td>
									<td class="FieldInput"><label name="党员总数" id="engagedMemberNum" field="engagedMemberNum"></label></td>
									<td class="FieldLabel"><label>拟建党组织时间:</label></td>
									<td class="FieldInput"><label name="拟建党组织时间" id="planBuildDate" format="Y-m-d"  field="planBuildDate" ></label></td>		
								</tr>
								<tr>
									<td class="FieldLabel"><label>申请入党人数:</label></td>
									<td class="FieldInput"><label name="申请入党人数" id="appPartyNum" field="appPartyNum" ></label></td>
									<td class="FieldLabel"><label>已建群团组织:</label></td>
									<td class="FieldInput"><label  name="已建群团组织" id="groupType" field="groupType" dataset="groupTypeDS" ></label></td>
									<td class="FieldLabel"><label>未建党组织原因:</label></td>
									<td class="FieldInput" ><label id="nobuildReason"  field="nobuildReason" dataset="noBuildReasonDS"></label></td>				
								</tr>
								<tr id="groupDescTr2" style="display:none;">
									<td class="FieldLabel"><label>已建群团组织说明:</label></td>
									<td class="FieldInput" colspan="5"><label name="已建群团组织说明:" id="groupDesc" field="groupDesc" style="width:100%"></label></td>
								</tr>
								<tr id="instructorTr" style="display:none;">
									<td class="FieldLabel"><label>党建指导员姓名:</label></td>
									<td class="FieldInput"><label name="党建指导员姓名:" id="instructor" field="instructor" style="width: 95%"></label></td>
									<td class="FieldLabel"><label>指导员工作单位:</label></td>
									<td class="FieldInput"><label name="指导员工作单位:" id="instructorWorkName" field="instructorWorkName" style="width: 95%" ></label></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>										
								</tr>
								<tr id="instructorTr2" style="display:none">
									<td class="FieldLabel"><label>指导员电话:</label></td>
									<td class="FieldInput"><label name="指导员电话:" id="instructorPhone" field="instructorPhone" style="width: 95%"></label></td>
									<td class="FieldLabel"><label>指导员组织关系:</label></td>
									<td class="FieldInput"><label   id="instructorRel" field="instructorRel" style="width: 95%"  dataset="belong_rel"></label></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>						
								</tr>
								<tr>
									<td class="FieldLabel"><label>登记管理机关名称：</label></td>
									<td class="FieldInput"><label name="morgName" id="morgName" field="morgName"  style="width:90%"/></td>
									<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
									<td class="FieldInput"><label name="morgArea" id="morgArea" field="morgArea"  style="width:100%"/></td>
									<td class="FieldLabel"><label>填表时间:</label></td>
									<td class="FieldInput"><label id="createTime" format="Y-m-d"  field="createTime" ></label></td>
								</tr>
							</table>
						</fieldset>
					</form>
					<form id="somPartyBuildForm" method="post" onsubmit="return false" dataset="somPartyDS" class="L5form" style="display:none">
						<fieldset>
						<legend>已建党组织的单位填写党建情况登记表</legend>
							<input type="hidden" id="sorgId" field="sorgId">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="12%"><label>社会组织名称:</label></td>
									<td class="FieldInput" colspan="3"><label id="sorgName" field="sorgName" style="width: 95%"></label></td>
									<td class="FieldLabel" width="12%"><label>社会组织类型:</label></td>
									<td class="FieldInput" width="18%"><label id="sorgType" field="sorgType"  dataset="sorgTypeDS" style="width: 95%"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="14%"><label>社会组织住所:</label></td>
									<td class="FieldInput" width="19%"><label  id="sorgAdds1"  style="width: 95%"></label></td>
									<td class="FieldLabel" width="14%"><label>社会组织电话:</label></td>
									<td class="FieldInput" width="19%"><label   id="sorgPhone1"   style="width: 95%" /></td>	
									<td class="FieldLabel" width="12%"><label>党组织是否建立:</label></td>
									<td class="FieldInput" width="18%"><label id="ifBuildParty" field="ifBuildParty"  dataset="if_build_par" style="width: 95%"></label></td>
								<tr>
									<td class="FieldLabel"><label>法人姓名:</label></td>
									<td class="FieldInput"><label id="legalPeople" field="legalPeople" style="width: 95%"></label></td>
									<td class="FieldLabel"><label>政治面貌:</label></td>
									<td class="FieldInput"><label id="politics" field="politics" dataset="politicsDS" style="width: 95%"></label></td>
									<td class="FieldLabel"><label>社会组织专职人员数:</label></td>
									<td class="FieldInput"><label id="meetingNum" field="meetingNum"  ></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>社会组织兼职人员数:</label></td>
									<td class="FieldInput"><label   id="practiceNum1"   style="width: 95%" /></td>	
									<td class="FieldLabel"><label>业务主管单位:</label></td>
									<td class="FieldInput"><select  id="borgName1"  style="width: 95%" disabled><option dataset='borgNameSelect'/></select></td>				
									<td class="FieldLabel"><label>业务主管单位成立社会组织党委标记:</label></td>
									<td class="FieldInput"><label   id="borgIfBuildParty" field='borgIfBuildParty'  style="width: 95%" /></td>	
								</tr>
								<tr>
									<td class="FieldLabel"><label>党组织名称:</label></td>
									<td class="FieldInput" colspan='5'><label name="党组织名称:" id="partyName" field="partyName" style="width: 95%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>党组织成立时间:</label></td>
									<td class="FieldInput"><label name="党组织成立时间" id="buildDate" format="Y-m-d"  field="buildDate" style="width: 95%"></label></td>		
									<td class="FieldLabel"><label>党建状态:</label></td>
									<td class="FieldInput"><label name="党建状态:" id="partyStatus"  field="partyStatus"  dataset="partyStatusDS" style="width: 95%"></label></td>		
									<td class="FieldLabel"><label>审批单位:</label></td>
									<td class="FieldInput"><label name="审批单位" id="auditOrgan" field="auditOrgan"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审批文号:</label></td>
									<td class="FieldInput"><label name="审批文号" id="auditFileCode" field="auditFileCode" ></label></td>
									<td class="FieldLabel"><label>党组织类别:</label></td>
									<td class="FieldInput"><label name="党组织类别" id="buildType" field="buildType" dataset="build_type"></label></td>
									<td class="FieldLabel"><label>党组织类型:</label></td>
									<td class="FieldInput"><label name="党组织类型" id="partyType" field="partyType" dataset="party_type"></label></td>
								</tr>
								<tr id="combinedTr" style="display:none;">
									<td class="FieldLabel"><label>联合支部名称:</label></td>
									<td class="FieldInput" colspan="5"><label name="联合支部名称:" id="combined" field="combined" style="width:100%"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>党组织隶属关系:</label></td>
									<td class="FieldInput"><label id="belongRel" field="belongRel" dataset="belong_rel"></label></td>					
									<td class="FieldLabel"><label>党组织负责人身份证号：</label></td>
									<td class="FieldInput"><label name="党组织负责人身份证号" id="idCard" field="idCard"  style="width:95%" /></td>
									<td class="FieldLabel"><label>是否兼合式党组织：</label></td>
									<td class="FieldInput"><label name="是否兼合式党组织" id="ifComParty" field="ifComParty"  style="width:95%" dataset='if_build_par'/></td>
								</tr>
								<tr id="belongRelTr" style="display:none;">
									<td class="FieldLabel"><label>隶属关系说明:</label></td>
									<td class="FieldInput" colspan="5"><label name="隶属关系说明:" id="belongRelDesc" field="belongRelDesc" style="width:100%"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>党组织负责人姓名:</label></td>
									<td class="FieldInput"><label id="partyChief" field="partyChief"></label></td>
									<td class="FieldLabel"><label>党组织负责人性别:</label></td>
									<td class="FieldInput"><label id="sex" field="sex" dataset="SEX"></label></td>
									<td class="FieldLabel"><label>党组织负责人出生年月:</label></td>
									<td class="FieldInput"><label id="birthday" format="Y-m-d"  field="birthday" ></label></td>		
								</tr>									
								<tr>
									<td class="FieldLabel"><label>党组织负责人电话:</label></td>
									<td class="FieldInput"><label name="党组织负责人电话" id="phone" field="phone"></label></td>
									<td class="FieldLabel"><label>党组织负责人学历:</label></td>
									<td class="FieldInput"><label name="党组织负责人学历" id="education" field="education" dataset="educationSelect"></label></td>
									<td class="FieldLabel"><label>党组织负责人民族:</label></td>
									<td class="FieldInput"><label name="党组织负责人民族" id="folk" field="folk" dataset="nationSelect"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>党组织负责人社会组织职务:</label></td>
									<td class="FieldInput"><label id="sorgDuties"  field="sorgDuties" dataset="somDutySelect"></label></td>
									<td class="FieldLabel"><label>党组织负责人工作单位:</label></td>
									<td class="FieldInput"><label id="workName" field="workName"></label></td>
									<td class="FieldLabel"><label>党组织负责人工作单位职务:</label></td>
									<td class="FieldInput"><label id="workDuties"  field="workDuties"></label></td>				
								</tr>
								<tr>
									<td class="FieldLabel"><label>专职党员人数:</label></td>
									<td class="FieldInput"><label name="专职党员人数" id="fulltimeNum" field="fulltimeNum"></label></td>
									<td class="FieldLabel"><label>兼职党员人数:</label></td>
									<td class="FieldInput"><label name="兼职党员人数" id="parttimeNum"  field="parttimeNum"></label></td>
									<td class="FieldLabel"><label>党员总数:</label></td>
									<td class="FieldInput"><label name="党员总数" id="engagedMemberNum" field="engagedMemberNum"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>预备党员人数:</label></td>
									<td class="FieldInput"><label type="text" name="预备党员人数" id="prepareNum" field="prepareNum" style="width: 95%"/></td>				
									<td class="FieldLabel"><label>发展对象人数:</label></td>
									<td class="FieldInput"><label name="发展对象人数:" id="developNum" field="developNum"></label></td>
									<td class="FieldLabel"><label>入党积极分子人数:</label></td>
									<td class="FieldInput"><label name="入党积极分子人数:" id="energeticNum"  field="energeticNum"></label></td>
								</tr>
								<tr >
									<td class="FieldLabel"><label>申请入党人数:</label></td>
									<td class="FieldInput"><label name="申请入党人数:" id="appPartyNum" field="appPartyNum"></label></td>
									<td class="FieldLabel"><label>已建群团组织:</label></td>
									<td class="FieldInput" ><label  name="已建群团组织" id="groupType" field="groupType" dataset="groupTypeDS"></label></td>
									<td class="FieldLabel"><label>填表日期:</label></td>
									<td class="FieldInput"><label id="createTime"format="Y-m-d"  field="createTime" ></label></td>
								</tr>
								<tr id="groupDescTr" style="display:none;">
									<td class="FieldLabel"><label>已建群团组织说明:</label></td>
									<td class="FieldInput" colspan="5"><label name="已建群团组织说明:" id="groupDesc" field="groupDesc" style="width:100%"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>登记管理机关名称：</label></td>
									<td class="FieldInput"  colspan="3"><label name="morgName" id="morgName" field="morgName"  style="width:90%"/></td>
									<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
									<td class="FieldInput"><label name="morgArea" id="morgArea" field="morgArea"  style="width:100%"/></td>
								</tr>
							</table>
						</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel title="法律要件" id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:GroupingView forceFit="true"></next:GroupingView>
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
					<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					<next:Column header="业务类型"    field="applyType" hidden="true">
						<next:ExtendConfig>
							groupRenderer:grender,groupName:"法律要件目录"
						</next:ExtendConfig>
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>		
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>