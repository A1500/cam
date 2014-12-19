<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<!-- 基金会详细信息 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var sorgId='<%=request.getParameter("sorgId")%>';
</script>
<script type="text/javascript" src="somFundQuery.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<model:datasets>
	<!-- 基金会dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="nowBorgName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"
		method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"> </model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"
		method="queryPeople" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"> </model:record>
	</model:dataset>
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" autoLoad="true" method="queryArchiveCatalog" isGroup="true" groupField="taskCode" pageSize="500">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
		<model:params>
			<model:param name="sorgId" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	
	
	<!-- 证书正本 -->
	<model:dataset id="somCertDatasetZ"
		cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
				<model:param name="cert_Type" value='0'></model:param>
				<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书副本 -->
	<model:dataset id="somCertDatasetF"
		cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="cert_Type" value='1'></model:param>
			<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	   <!-- 账户 -->
	<model:dataset id="AccountDS"
		cmd="com.inspur.cams.sorg.base.cmd.SomAccountQueryCmd"
		 global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAccount"></model:record>
		<model:params>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<%--办事机构--%>
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice"></model:record>
	</model:dataset>
		<model:dataset id="winOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice"></model:record>
	</model:dataset>
	<!-- 举办实体 -->
	<model:dataset id="EntityDS" cmd="com.inspur.cams.sorg.base.cmd.SomEntityQueryCmd" autoLoad="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomEntity"></model:record>
		<model:params>
			<model:param name="sorg_Id" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<%-- 章程核准信息 --%>
	<model:dataset id="somRuleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule"> </model:record>
	</model:dataset>
	<!--查看主要负责人窗口-->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	
	<!-- 是否最新标准 -->
	<model:dataset id="ifCurrent" enumName="COMM.YESORNO"autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否专/兼职 -->
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书发证原因 -->
	<model:dataset id="issueReasonSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_ISSUEREASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书类别枚举 -->
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 是否离退休 --> 
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否专兼职 -->
	<model:dataset id="ifFulltime" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行（事)业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 任职状态 -->
	<model:dataset id="regStatusDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_REG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%"height='100%'>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="undo" text="返回" handler="returnQueryList" ></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel >
	<next:Tabs>
		<next:Panel title="法人登记表" width="100%" height='100%'>
			<next:TabPanel  id="tab1">
				<next:Tabs>
				<next:Panel title="基金会基本信息" width='100%'height="100%"  autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel"><label>登记证号：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:100%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会名称/中文：</label></td>
							<td class="FieldInput" colspan="5"><label field="cnName" style="width:100%"/></td>
						</tr>
							<td class="FieldLabel"><label>基金会名称/英文：</label></td>
							<td class="FieldInput" colspan="3"><label field="enName" style="width:97.5%"/></td>
							<td class="FieldLabel" style="width:18%"><label>基金会名称/缩写：</label></td>
							<td class="FieldInput"><label field="abName" /></td>
						<tr>
							<td class="FieldLabel"><label>组织机构代码：</label></td>
							<td class="FieldInput" colspan="3"><label field="organCode" style="width:97.5%"/></td>
							<td class="FieldLabel"><label>社会组织类型：</label></td>
							<td class="FieldInput"><label field="sorgKind" /></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>住所：</label></td>
							<td class="FieldInput" colspan="5"><label field="residence" style="width:100%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>住所来源：</label></td>
							<td class="FieldInput" colspan="5"><label  field="residenceSource"  style="width:100%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%"><label>基金会邮编：</label></td>
							<td class="FieldInput" style="width:17%"><label field="sorgPost"/></td>
							<td class="FieldLabel" style="width:17%"><label>基金会电话：</label></td>
							<td class="FieldInput" style="width:17%"><label field="sorgPhone" /></td>
							<td class="FieldLabel" style="width:15%"><label>基金会传真：</label></td>
							<td class="FieldInput" style="width:17%"><label field="sorgFax" /></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>基金会通信地址：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgAdds" style="width:100%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>基金会网址：</label></td>
							<td class="FieldInput" colspan="3"><label field="sorgWeb" style="width:97.5%"/></td>
							<td class="FieldLabel"><label>基金会电子邮箱：</label></td>
							<td class="FieldInput"><label field="sorgEmail" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>活动地域：</label></td>
							<td class="FieldInput" colspan="5"><label field="actArea" style="width:100%" style="width:100%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>基金会宗旨：</label></td>
							<td class="FieldInput" colspan="5"><label field="purpose" style="width:100%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>业务范围：</label></td>
							<td class="FieldInput" colspan="5"><label field="business" style="width:100%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>所属行（事）业：</label></td>
							<td class="FieldInput" colspan="3"><label field="busScope" dataset="busScopeSelect" style="width:97%"/></td>
							<td class="FieldLabel"><label>业务范围代码：</label></td>
							<td class="FieldInput"><label field="businessCode" dataset="" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>业务主管单位：</label></td>
							<td class="FieldInput" colspan="3"><label field="newBorgName" style="width:97.5%"/></td>
							<td class="FieldLabel"><label>主管单位审查日期：</label></td>
							<td class="FieldInput"><label field="borgCheckDate" format="Y-m-d" /></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>单位会员数：</label></td>
							<td class="FieldInput"><label field="unitsNum" /></td>
							<td class="FieldLabel"><label>个人会员数：</label></td>
							<td class="FieldInput"><label field="peopleNum" /></td>
							<td class="FieldLabel"><label>理事数：</label></td>
							<td class="FieldInput"><label field="councilNum"></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>常务理事数：</label></td>
							<td class="FieldInput"><label field="standCouncilNum" /></td>
							<td class="FieldLabel"><label>活动资金币种：</label></td>
							<td class="FieldInput"><label field="currency"/></td>
							<td class="FieldLabel"><label>活动资金数额（万元）：</label></td>
							<td class="FieldInput"><label field="regMon"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>验资单位：</label></td>
							<td class="FieldInput" colspan="5"><label field="checkCapitalOrgan" style="width:100%"></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>经费来源：</label></td>
							<td class="FieldInput" colspan="5"><label field="moneySource" style="width:100%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>产权单位：</label></td>
							<td class="FieldInput" colspan="3"><label field="housingOrgan" style="width:97.5%"/></td>
							<td class="FieldLabel"><label>产权单位用房面积（平方米）：</label></td>
							<td class="FieldInput"><label field="housingArea" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>租（借）期限：</label></td>
							<td class="FieldInput" colspan="5"><label field="leasePeriod" style="width:100%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>登记人：</label></td>
							<td class="FieldInput"><label field="regPeople" /></td>
							<td class="FieldLabel"><label>登记日期：</label></td>
							<td class="FieldInput" colspan="3"><label field="regDate" format="Y-m-d" /></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="常设办事机构"width='100%'height='100%'>
				<next:EditGridPanel id="officegrid" dataset="somOfficeDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="办事机构信息"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detailOffice"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="办事机构名称" field="name" width="25%"></next:Column>
						<next:Column header="场所" field="place" width="20%"></next:Column>
						<next:Column header="电话" field="phone" width="15%"></next:Column>
						<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
						<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somOfficeDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
	</next:Panel>
	<next:Panel title="基金会人员信息" width="100%"  autoScroll='true'>
		<next:EditGridPanel id="sessionGrid" dataset="somSessionDataSet" width="100%" stripeRows="true" height="150">
			<next:TopBar>
				<next:ToolBarItem symbol="届次信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="届次名称" field="sessionName" width="20%" editable="false"><next:TextField/></next:Column>
				<next:Column header="本届任期（年）" field="tenure" width="10%" editable="false"><next:TextField/></next:Column>
				<next:Column header="本届开始日期" field="startDate" width="18%" editable="false"><next:TextField/></next:Column>
				<next:Column header="章程规定换届日期" field="endDate" width="18%" editable="false"><next:TextField/></next:Column>
				<next:Column header="换届日期" field="realEndDate" width="18%" editable="false"><next:TextField/></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="somSessionDataSet"/>
			</next:BottomBar>
		</next:EditGridPanel>
		<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi" stripeRows="true" height="300" hasSum="true"title="理事备案表">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="查看" handler="detailL"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="担任职务" field="sorgDuties" width="15%"
					editable="false" summaryType="count">
					<next:ExtendConfig>
						summaryRenderer : countRender
					</next:ExtendConfig>
					<next:ComboBox dataset="sorgDutiesSelect" />
				</next:Column>
				<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
				<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
				<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
				<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
				<next:Column header="是否在任" field="ifServe" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
				<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
				<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
			
			</next:Columns>
		</next:EditGridPanel>
		<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi" stripeRows="true" hasSum="true" height="250"title="监事备案表">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="查看" handler="detailS"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="担任职务" field="sorgDuties" width="15%"editable="false" summaryType="count">
					<next:ExtendConfig>summaryRenderer : countRenderS</next:ExtendConfig>
					<next:ComboBox dataset="sorgDutiesSelect" />
				</next:Column>
				<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
				<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
				<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
				<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
				<next:Column header="是否在任" field="ifServe" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
				<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
				<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
			
			</next:Columns>
		</next:EditGridPanel>
		</next:Panel>
			<next:Panel title="基金会证书信息" width="100%" height="100%">
				<next:TabPanel>
					<next:Tabs>
						<next:Panel title="基金会证书正本" width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form method="post" onsubmit="return false" class="L5form"
									dataset="somCertDatasetZ">
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="sorgCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="organCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>证件类型：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="certType" readonly="readonly" dataset="certTypeSelect" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会名称：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="sorgName" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务范围：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="business" readonly="readonly" /></td>
									</tr>
									<tr></tr>

									<tr>
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="residence" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>法定代表人：</label></td>
										<td class="FieldInput"><label field="legalPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>活动地域：</label></td>
										<td class="FieldInput"><label field="actArea"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>注册资金(万元)：</label></td>
										<td class="FieldInput"><label field="regMon"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务主管单位：</label></td>
										<td class="FieldInput" colspan="3"><label id="borgName"
											field="borgName" readonly="readonly" /></td>
										<td class="FieldLabel"><label>登记日期：</label></td>
										<td class="FieldInput"><label id="regDate"
											field="regDate" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signBeginDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signEndDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signPeriod" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因：</label></td>
										<td class="FieldInput"><label field="issueReason"
											dataset="issueReasonSelect" /></td>
										<td class="FieldLabel"><label>发证机关：</label></td>
										<td class="FieldInput"><label field="signOrgan"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证日期：</label></td>
										<td class="FieldInput"><label field="signDate"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因描述：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="issueReasonSelectDesc"
											readonly="readonly" /></td>
									</tr>
									<tr></tr>
									<tr>
										<td class="FieldLabel"><label>制证人：</label></td>
										<td class="FieldInput"><label field="printPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>制证时间：</label></td>
										<td class="FieldInput"><label field="printTime"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label></label></td>
										<td class="FieldInput"></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>领证人：</label></td>
										<td class="FieldInput"><label field="fetchPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>领证日期：</label></td>
										<td class="FieldInput"><label field="fetchDate"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证人</label></td>
										<td class="FieldInput"><label field="issuePeople"
											readonly="readonly" /></td>
									</tr>
									<tr id="receive" style="display: none;">
										<td class="FieldLabel"><label>收缴标志：</label></td>
										<td class="FieldInput"><label field="ifReceive"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴人：</label></td>
										<td class="FieldInput"><label field="receivePeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴日期：</label></td>
										<td class="FieldInput"><label field="receiveDate"
											readonly="readonly" /></td>
									</tr>
									<tr style="display: none;">
										<td class="FieldLabel"><label>证件状态：</label></td>
										<td class="FieldInput"><input type="text"
											id="wincertStatus" field="certStatus" readonly="readonly" /></td>
									</tr>
								</table>
								</form>
							</next:Html>
						</next:Panel>
						<next:Panel title="基金会证书副本" width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form method="post" onsubmit="return false" class="L5form"
									dataset="somCertDatasetF">
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="sorgCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="organCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>证件类型：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											dataset="certTypeSelect" field="certType" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会名称：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="sorgName" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务范围：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="business" readonly="readonly" /></td>
									</tr>
									<tr></tr>

									<tr>
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="residence" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>法定代表人：</label></td>
										<td class="FieldInput"><label field="legalPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>活动地域：</label></td>
										<td class="FieldInput"><label field="actArea"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>注册资金(万元)：</label></td>
										<td class="FieldInput"><label field="regMon"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务主管单位：</label></td>
										<td class="FieldInput" colspan="3"><label id="borgName"
											field="borgName" readonly="readonly" /></td>
										<td class="FieldLabel"><label>登记日期：</label></td>
										<td class="FieldInput"><label id="regDate"
											field="regDate" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signBeginDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signEndDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signPeriod" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因：</label></td>
										<td class="FieldInput"><label field="issueReason"
											dataset="issueReasonSelect" /></td>
										<td class="FieldLabel"><label>发证机关：</label></td>
										<td class="FieldInput"><label field="signOrgan"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证日期：</label></td>
										<td class="FieldInput"><label field="signDate"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因描述：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="issueReasonSelectDesc"
											readonly="readonly" /></td>
									</tr>
									<tr></tr>
									<tr>
										<td class="FieldLabel"><label>制证人：</label></td>
										<td class="FieldInput"><label field="printPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>制证时间：</label></td>
										<td class="FieldInput"><label field="printTime"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label></label></td>
										<td class="FieldInput"></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>领证人：</label></td>
										<td class="FieldInput"><label field="fetchPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>领证日期：</label></td>
										<td class="FieldInput"><label field="fetchDate"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证人</label></td>
										<td class="FieldInput"><label field="issuePeople"
											readonly="readonly" /></td>
									</tr>
									<tr id="receive" style="display: none;">
										<td class="FieldLabel"><label>收缴标志：</label></td>
										<td class="FieldInput"><label field="ifReceive"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴人：</label></td>
										<td class="FieldInput"><label field="receivePeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴日期：</label></td>
										<td class="FieldInput"><label field="receiveDate"
											readonly="readonly" /></td>
									</tr>
									<tr style="display: none;">
										<td class="FieldLabel"><label>证件状态：</label></td>
										<td class="FieldInput"><input type="text"
											id="wincertStatus" field="certStatus" readonly="readonly" /></td>
									</tr>
								</table>
								</form>
							</next:Html>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
		<next:Panel title="基金会备案信息" width="100%" height="100%">
		<next:TabPanel>
		<next:Tabs>
		<next:Panel title="基金会账户备案信息" width="100%" height="100%" >
			<next:EditGridPanel id="accountgrid" dataset="AccountDS" width="100%" stripeRows="true" height="100%" autoScroll='true'>
				<next:TopBar>
					<next:ToolBarItem symbol="账户信息"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看" handler="detailAccount"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="账户名称" id="name" field="name" resizable="true" width="15%"></next:Column>
					<next:Column header="开户银行账户" field="accountCode" resizable="true" width="20%"></next:Column>
					<next:Column header="开户银行" field="bank" resizable="true" width="15%"></next:Column>
					<next:Column header="开户时间" field="accountDate" width="15%"></next:Column>
					<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
					<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="AccountDS"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
		<next:Panel title="基金会举办实体备案信息" width="100%" height="100%" >
			<next:EditGridPanel id="entitygrid" dataset="EntityDS" width="100%" stripeRows="true" height="100%" autoScroll='true'>
				<next:TopBar>
					<next:ToolBarItem symbol="举办实体信息"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看" handler="detailEntity"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="实体名称" field="name" width="20%"></next:Column>
					<next:Column header="地址" field="adds" width="24%"></next:Column>
					<next:Column header="注册时间"  field="registDate" width="20%"></next:Column>
					<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
					<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="EntityDS"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
		<next:Panel title="基金会章程核准信息" width="100%" height="100%" >
			<next:EditGridPanel id="rulegrid" dataset="somRuleDataSet" width="100%" stripeRows="true" height="100%"autoScroll='true'>
				<next:TopBar>
					<next:ToolBarItem symbol="章程信息"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看" handler="detailRule"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="会议名称" field="meetingName" width="30%"></next:Column>
					<next:Column header="时间" field="meetingDate" width="15%"></next:Column>
					<next:Column header="是否章程草案" field="ifDraft" width="14%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somRuleDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
		</next:Tabs>
		</next:TabPanel>
	</next:Panel>
	<next:Panel title="电子档案" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="fileGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
								<next:GroupingView forceFit="true"></next:GroupingView>
								<next:TopBar>
									<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
								</next:TopBar>
				
								<next:Columns>
									<next:RowNumberColumn />
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
									<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
									<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
									<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHrefForArchive"><next:TextField /></next:Column>
									<next:Column header="档案目录"    field="taskCode" hidden="true">
										<next:ExtendConfig>
											groupRenderer:grender
										</next:ExtendConfig>
									</next:Column>
									<next:Column header="业务类型"    field="applyType" hidden="true"></next:Column>
									<next:Column header="创建时间"    field="createTime" hidden="true"></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somElectronicDataSet" />
								</next:BottomBar>
							</next:EditGridPanel>
	</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../comm/people/fundPeopleDetail.jsp" flush="true"/>
</body>
</html>