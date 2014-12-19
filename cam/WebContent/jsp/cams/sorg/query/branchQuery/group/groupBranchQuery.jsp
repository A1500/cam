<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="org.loushang.next.skin.SkinUtils,com.inspur.cams.comm.util.StrUtil"%>
<html>
<head>
<title>社团分支/代表信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupBranchQuery.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
	var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
	var sorgStatus = '<%=StrUtil.n2b(request.getParameter("sorgStatus"))%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomGroupOrganQueryCmd" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" method="getCurrentSession" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 负责人详情窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
		
</model:datasets>	

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="社团分支/代表信息明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeThisWindow"></next:ToolBarItem>
	</next:TopBar>
	
	<next:TabPanel width="100%" height="100%"  activeTab="0" id="tab">
		<next:Tabs>
			<next:Panel title="社团分支/代表机构明细查看" width="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>社会团体登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label  field="mainSorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社会团体名称：</label></td>
								<td class="FieldInput" colspan="5"><label id="name" style="width:98%"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>办公场所：</label></td>
								<td class="FieldInput" colspan="5"><label field="residence" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><label id="sorgPhone" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构类型：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" field="business" style="width:98%" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>设立理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" field="appReason" style="width:98%" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="borgName" style="width:97%" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" format="Y-m-d" style="width:90%"/></td>
							</tr>
							<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="机构主要负责人情况" width="100%">
				<next:EditGridPanel id="peopleGrid" width="100%" stripeRows="true" height="100%" dataset="somDutyDataSet">
					<next:TopBar>
							<next:ToolBarItem ></next:ToolBarItem>
							<next:ToolBarItem symbol="机构主要负责人列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="detail" text="查看" handler="detailPeople"></next:ToolBarItem>
					</next:TopBar>
					
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="18%" editable="false" ><next:TextField /></next:Column>		
						<next:Column header="姓名" field="name" width="12%" editable="false" ><next:TextField /></next:Column>
						<next:Column header="性别" field="sex" width="5%" editable="false"  dataset="sexSelect"><next:TextField /></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false" ><next:TextField /></next:Column>
						<next:Column header="拟任机构职务" field="sorgDuties" width="18%" editable="false" dataset="sorgDutiesSelect"><next:TextField /></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="12%" editable="false" ><next:TextField /></next:Column>
						<next:Column header="工作单位" field="workName" width="23%" editable="false" ><next:TextField /></next:Column>
					</next:Columns>		
					<next:BottomBar>
						<next:PagingToolBar dataset="somDutyDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel width="100%" title="成立电子档案查看">
				<next:Html>
				  <iframe id="uploadInfo" src="../../../manage/upload/somDownloadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=005"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="peopleWin" title="查看主要负责人"  resizable="false" width="740" height="400" closeAction="hide" autoScroll="true">
	<next:Panel id="panel_win">
		<next:Html>
			<form id="form_win" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:13%"><label>身份证号：</label></td>
						<td class="FieldInput" style="width:20%"><label field="idCard" /></td>
						<td class="FieldLabel" style="width:13%"><label>姓名：</label></td>
						<td class="FieldInput" style="width:20%"><label field="name" /></td>
						<td class="FieldLabel" style="width:13%"><label>曾用名：</label></td>
						<td class="FieldInput" style="width:20%"><label field="aliasName" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>性别：</label></td>
						<td class="FieldInput"><label field="sex" dataset="sexSelect"/></td>
						<td class="FieldLabel"><label>民族：</label></td>
						<td class="FieldInput"><label field="folk" dataset="folkSelect"/></td>
						<td class="FieldLabel"><label>专/兼职：</label></td>
						<td class="FieldInput"><label field="ifFulltime" dataset="ifFulltimeSelect"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>出生年月：</label></td>
						<td class="FieldInput"><label field="birthday" /></td>
						<td class="FieldLabel"><label>政治面貌：</label></td>
						<td class="FieldInput"><label field="politics" dataset="politicsSelect"/></td>
						<td class="FieldLabel"><label>本人电话：</label></td>
						<td class="FieldInput"><label field="phone" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>家庭住址：</label></td>
						<td class="FieldInput" colspan="5"><label field="adds" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>户口所在地：</label></td>
						<td class="FieldInput" colspan="5"><label field="populace" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>其他社团职务：</label></td>
						<td class="FieldInput" colspan="3"><label field="otherDuties" /></td>
						<td class="FieldLabel"><label>家庭住址邮编：</label></td>
						<td class="FieldInput"><label field="postCode" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>单位职务：</label></td>
						<td class="FieldInput"><label field="workDuties" style="width:90%"/></td>
						<td class="FieldLabel"><label>社团职务：</label></td>
						<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesSelect" style="width:90%"/></td>
						<td class="FieldLabel"><label>是否连任：</label></td>
						<td class="FieldInput"><label field="ifRedo" dataset="comm_yesorno" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>工作单位：</label></td>
						<td class="FieldInput" colspan="5"><label field="workName" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>是否党政机关领导干部：</label></td>
						<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno" style="width:90%"/></td>
						<td class="FieldLabel"><label>批准文号：</label></td>
						<td class="FieldInput"><label field="promiseCode" style="width:90%"/></td>
						<td class="FieldLabel"><label>批准机关：</label></td>
						<td class="FieldInput"><label field="promiseOrgan" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>所在单位人事部门审查意见：</label></td>
						<td class="FieldInput" colspan="5"><textarea  rows="2"  field="workOpinion" readonly="readonly" style="width:99%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>审查日期：</label></td>
						<td class="FieldInput" colspan="5"><label field="workCheckDate" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>社团意见：</label></td>
						<td class="FieldInput" colspan="5"><textarea   rows="2" field="sorgOpinion" readonly="readonly" style="width:99%"></textarea></td>
					</tr>
					<tr>	
						<td class="FieldLabel"><label>签署日期：</label></td>
						<td class="FieldInput" colspan="5"><label field="sorgCheckDate" /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>备注：</label></td>
						<td class="FieldInput" colspan="5"><textarea rows="2" field="memberNote" readonly="readonly" style="width:99%"></textarea></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" width="740" stripeRows="true" height="250" title="本人简历">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="关闭窗口" handler="closeWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>