<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>申报家庭经济核对分发</title>
<script type="text/javascript">
			var jtids='<%=request.getParameter("id")%>';
			var regId='<%=BspUtil.getEmpOrgan().getOrganId()%>';
			var surveyOrg='<%=BspUtil.getCorpOrgan().getOrganId()%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
			
		</script>
<next:ScriptManager />
<script type="text/javascript" src="esureyInfoCheckIssueFamily.js"></script>
<script type="text/javascript" src="comm.js"></script>
<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
</head>
<body>
<model:datasets>

	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS" global="true"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-用于读取对应家庭的成员-->
	<model:dataset id="esureyPeopleFeedDS" global="true"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报信息_抚养关系-->
	<model:dataset id="esureyRelationDS" autoLoad="true"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyRelation"></model:record>
	</model:dataset>
	<!--经济核对_核对流水信息-->
	<model:dataset id="esureySurveyDS" global="true"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySurveyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySurvey"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息的dataset-->
	<model:dataset id="FeedbackDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>
	<!--民政_外部单位-->
	<model:dataset id="organConfigDS" global="true"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyOrganConfigQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig"></model:record>
	</model:dataset>
	<!-- 核对/不核对 -->
	<model:dataset id="externalCheckDataset" enumName="EXTERNAL.CHECK"
		autoLoad="true"></model:dataset>
	<!-- 审核范围 -->
	<model:dataset id="checkTypeDataset" enumName="SAM.ESUREY.CHECK.TYPE"></model:dataset>

</model:datasets>

<next:Panel id="mainPanel" name="mainPanel" height="100%" width="100%">
	<next:GridPanel id="familyGridPanel" name="sbjtxxGridPanel"
		width="100%" height="65%" notSelectFirstRow="true" stripeRows="true"
		dataset="esureyFamilyDS">

		<next:TopBar>
			<next:ToolBarItem text="家庭基本信息列表:"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="详细" />
			<next:ToolBarItem iconCls="save" text="进行核对分发" handler="checkIssue" />
			<next:ToolBarItem iconCls="return" text="返回" handler="returnList" />
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn width="20" locked="true" />
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column id="familyName" header="户主姓名" field="familyName"
				width="10%" locked="true" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column id="familyCardNo" header="户主身份证件号码" field="familyCardNo"
				width="18%" locked="true" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="人力资源和社会保障" field="externalSocialOrg" width="15%">
				<next:ComboBox id="dfd" dataset="externalCheckDataset"
					valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column header="房管" field="externalHouseOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="工商" field="externalBusinessOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="公安（车管）" field="externalCarOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="国税" field="externalTaxGOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="地税" field="externalTaxDOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="公积金" field="externalFundOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="人民银行" field="externalBankOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="证监" field="externalSecuritiesOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
			<next:Column header="保监" field="externalInsuranceOrg" width="8%">
				<next:ComboBox dataset="externalCheckDataset" valueField="value"
					typeAhead="true" />
			</next:Column>
		</next:Columns>

		<next:BottomBar>
			<next:PagingToolBar dataset="esureyFamilyDS" />
		</next:BottomBar>
	</next:GridPanel>

	<next:GridPanel id="jtcyxxGridPanel" name="jtcyxxGridPanel"
		width="100%" height="35%" notSelectFirstRow="true" stripeRows="true"
		autoScroll="true" dataset="esureyPeopleDS">

		<next:TopBar>
			<next:ToolBarItem text="所选家庭的成员信息列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="详细" />
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="20" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="name" header="成员姓名" field="name" width="60">
				<next:TextField />
			</next:Column>
			<next:Column id="relationshipType" header="户主关系"
				field="relationshipType" width="60">
				<next:TextField />
			</next:Column>
		</next:Columns>

		<next:BottomBar>
			<next:PagingToolBar dataset="esureyPeopleDS" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>

<next:Panel id="subPanel" name="subPanel" hidden="true"
	title="申报家庭经济核对详细情况">
	<next:Html>
		<table dataset="esureyPeopleDS"
			style="border-collapse: collapse; font-size: 13px;" bgColor="#DAE9F3"
			width="100%" border="1">
			<tr height="50">
				<td rowspan="2" align="center" style="font-size: 15px;" width="80px">
				家庭户主姓名</td>
				<td rowspan="2" align="center" style="font-size: 15px;"
					width="100px">身份证号码</td>
				<td rowspan="2" align="center" style="font-size: 15px;"
					width="100px">家庭人口数量</td>
				<td colspan="10" align="center" style="font-size: 15px;">
				外部核对单位</td>
			</tr>
			<tr height="50">
				<td align="center" style="font-size: 14px;">人力资源和社会保障</td>
				<td align="center" style="font-size: 14px;">房管</td>
				<td align="center" style="font-size: 14px;">工商</td>
				<td align="center" style="font-size: 14px;">公安（车管）</td>
				<td align="center" style="font-size: 14px;">国税</td>
				<td align="center" style="font-size: 14px;">地税</td>
				<td align="center" style="font-size: 14px;">公积金</td>
				<td align="center" style="font-size: 14px;">人民银行</td>
				<td align="center" style="font-size: 14px;">证监</td>
				<td align="center" style="font-size: 14px;">保监</td>
			</tr>

			<tr repeat="true" align="center" bgcolor="FFFFFF" height="30">
				<td align="center"><label type="text" field="hzxm"
					style="font-weight: bold;" /></td>
				<td align="center"><label type="text" field="sfzh" /></td>
				<td align="center"><label type="text" field="jtrksl" /></td>
				<td align="center"><label type="text" field="deptRlText" /></td>
				<td align="center"><label type="text" field="deptFgText" /></td>
				<td align="center"><label type="text" field="deptGsText" /></td>
				<td align="center"><label type="text" field="deptGaText" /></td>
				<td align="center"><label type="text" field="deptGshText" /></td>
				<td align="center"><label type="text" field="deptDsText" /></td>
				<td align="center"><label type="text" field="deptGjjText" /></td>
				<td align="center"><label type="text" field="deptRmyhText" /></td>
				<td align="center"><label type="text" field="deptZjText" /></td>
				<td align="center"><label type="text" field="deptBjText" /></td>
			</tr>
		</table>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="完成并返回" handler="returnQuery"></next:ToolButton>
	</next:Buttons>
</next:Panel>

</body>
</html>
