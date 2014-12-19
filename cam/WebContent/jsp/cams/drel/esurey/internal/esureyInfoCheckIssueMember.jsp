<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>申报家庭成员经济核对分发</title>
<script type="text/javascript">
			var jtids='<%=request.getParameter("id")%>';
			var regId='<%=BspUtil.getEmpOrgan().getOrganId()%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
		</script>
<next:ScriptManager />
<script type="text/javascript" src="comm.js"></script>
<script type="text/javascript" src="esureyInfoCheckIssueMember.js"></script>
</head>
<body>
<model:datasets>
	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd" >
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS"  cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd" global="true"  pageSize="3">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭赡养家庭成员基本信息-->
	<model:dataset id="esureyRelPeopleDS"  cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd" global="true" pageSize="3">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-用于读取对应家庭的成员-->
	<model:dataset id="esureyPeopleFeedDS"  cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报信息_抚养关系-->
	<model:dataset id="esureyRelationDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyRelation"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息-->
	<model:dataset id="esureySurveyDS"  cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySurveyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySurvey"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息的dataset-->
	<model:dataset id="FeedbackDataset" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd" global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>		
	<!-- 与户主关系 -->
	<model:dataset id="RelationDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!--民政_外部单位-->
	<model:dataset id="organConfigDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyOrganConfigQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig"></model:record>
	</model:dataset>
	<!--是否为赡养义务人员-->	
	<model:dataset id="isSupportDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	<!-- 核对/不核对 -->
	<model:dataset id="externalCheckDataset" enumName="EXTERNAL.CHECK" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel id="mainPanel" name="mainPanel" height="100%" width="100%"
	bodyStyle="padding:0px">

	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="核对分发" handler="checkIssue" />
			<next:ToolBarItem iconCls="return" text="返回" handler="returnList" />
	</next:TopBar>
	<next:Defaults>
		{collapsible:true,split:false,animFloat:false,autoHide:false,useSplitTips:true,bodyStyle:'padding:0px;'}
	</next:Defaults>
	<next:BorderLayout>
		<next:Left floatable="true" cmargins="0 0 0 0" margins="0 0 0 0"
			split="false">
			<next:Panel width="220" height="100%" title="待核对家庭">
				<next:GridPanel id="sbjtxxGridPanel" name="sbjtxxGridPanel"
					autoWidth="true" height="100%" notSelectFirstRow="true"
					stripeRows="true" dataset="esureyFamilyDS">
					<next:Columns>
						<next:RowNumberColumn width="15" />
						<next:Column id="familyName" header="户主" field="familyName"
							width="60" >
							<next:TextField />
						</next:Column>
						<next:Column id="familyCardNo" header="身份证号" field="familyCardNo"
							width="145" >
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="esureyFamilyDS"  displayInfo="false"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Left>
		
		<next:Center floatable="false" cmargins="0 0 0 0" margins="0 0 0 0" split="false">
		<next:Panel height="100%" autoWidth="true" floating="false">
			<next:Panel columnWidth="1" height="225" title="家庭成员列表"
				width="100%" collapsible="false">
				<next:FitLayout>
				<next:GridPanel id="memberGridPanel" name="memberGridPanel"
					width="100%" height="100%" notSelectFirstRow="true"
					stripeRows="true" autoScroll="true" dataset="esureyPeopleDS">
					<next:Columns>
						<next:RowNumberColumn width="15"/>
						<next:CheckBoxColumn ></next:CheckBoxColumn>
						<next:Column id="name" header="成员姓名" field="name" width="10%" >
							<next:TextField editable="false"  />
						</next:Column>
						<next:Column id="relationshipType" header="户主关系"
							field="relationshipType" width="10%"  dataset="RelationDS" >
							<next:TextField editable="false" />
						</next:Column>
						<next:Column header="人力资源和社会保障" field="externalSocialOrg"
							 width="15%">
							<next:ComboBox id="dfd" dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="房管" field="externalHouseOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="工商" field="externalBusinessOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="公安（车管）" field="externalCarOrg" width="12%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="国税" field="externalTaxGOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="地税" field="externalTaxDOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="公积金" field="externalFundOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="人民银行" field="externalBankOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="证监" field="externalSecuritiesOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="保监" field="externalInsuranceOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="esureyPeopleDS" />
					</next:BottomBar>
				</next:GridPanel>
				</next:FitLayout>
			</next:Panel>
			<next:Panel columnWidth="1" autoHeight="true" title="赡养家庭成员列表"
				width="100%" collapsible="false">
				<next:FitLayout>
				<next:GridPanel id="memberRelGridPanel" name="memberRelGridPanel"
					width="100%" height="100%" notSelectFirstRow="true"
					stripeRows="true" autoScroll="true" dataset="esureyRelPeopleDS">
					<next:Columns>
						<next:RowNumberColumn width="15"/>
						<next:CheckBoxColumn ></next:CheckBoxColumn>
						<next:Column id="name" header="成员姓名" field="name" width="10%" >
							<next:TextField editable="false" />
						</next:Column>
						<next:Column id="isSupport" header="赡养人员"
							field="isSupport" width="10%" dataset="isSupportDS" >
							<next:TextField editable="false" />
						</next:Column>
						<next:Column header="人力资源和社会保障" field="externalSocialOrg"
							 width="15%">
							<next:ComboBox id="dfd" dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="房管" field="externalHouseOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="工商" field="externalBusinessOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="公安（车管）" field="externalCarOrg" width="12%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="国税" field="externalTaxGOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="地税" field="externalTaxDOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="公积金" field="externalFundOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="人民银行" field="externalBankOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="证监" field="externalSecuritiesOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value" triggerAction="all" displayField="text"/>
						</next:Column>
						<next:Column header="保监" field="externalInsuranceOrg" width="8%">
							<next:ComboBox dataset="externalCheckDataset" valueField="value"triggerAction="all" displayField="text"/>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="esureyRelPeopleDS" />
					</next:BottomBar>
				</next:GridPanel>
				</next:FitLayout>
				</next:Panel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:Panel>
</body>
</html>