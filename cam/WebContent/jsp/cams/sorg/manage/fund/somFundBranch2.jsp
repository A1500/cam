<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>分支/代表机构注销明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundBranch2.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript">
	var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
	var sorgStatus = '<%=StrUtil.n2b(request.getParameter("sorgStatus"))%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundOrganQueryCmd" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	
	<%--主要负责人--%>
	<model:dataset id="somPresidePeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundPeopleQueryCmd" method="queryPeopleList">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--查看主要负责人窗口--%>
	<model:dataset id="winPresidePeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundPeopleQueryCmd" method="queryPeopleByParam">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
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
	<model:dataset id="nationSelect" enumName="SORG.NATION" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="分支/代表机构注销明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>

	<next:TabPanel width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="分支/代表机构明细查看" width="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>基金会登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="mainSorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会名称：</label></td>
								<td class="FieldInput" colspan="3"><label field="name" style="width:60%"></label></td>
								<td class="FieldLabel"><label>法定代表人：</label></td>
								<td class="FieldInput"><label field="legalPeople" style="width:90%"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%"><label>机构类型：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%"><label>机构传真：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgFax" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构电话：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgPhone" style="width:90%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput" colspan="5"><label field="residence" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>住所来源：</label></td>
								<td class="FieldInput" colspan="5"><label field="resideSource" dataset="resideSourceSelect" style="width:17.5%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>租（借）期限：</label></td>
								<td class="FieldInput" colspan="5"><label field="leasePeriod" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea field="business" style="width:98%" rows="10" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="borgName" style="width:97%" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel"><label>主管单位审查日期：</label></td>
								<td class="FieldInput"><label field="borgCheckDate" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>申请理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" field="appReason" style="width:98%" readonly="readonly"></textarea></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>产权单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="housingOrgan" style="width:97%"/></td>
								<td class="FieldLabel"><label>用房面积（平方米）：</label></td>
								<td class="FieldInput"><label field="housingArea" style="width:65%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>登记人：</label></td>
								<td class="FieldInput"><label field="regPeople" style="width:90%"/></td>
								<td class="FieldLabel"><label>登记日期：</label></td>
								<td class="FieldInput"><label field="regDate" style="width:90%"/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput" colspan="5"><label field="busScope" dataset="busScopeSelect" style="width:17.5%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>机构通信地址：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgAdds" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>机构网址：</label></td>
								<td class="FieldInput" colspan="3"><label field="sorgWeb" style="width:97%"/></td>
								<td class="FieldLabel"><label>机构电子邮箱：</label></td>
								<td class="FieldInput"><label field="sorgEmail" style="width:90%"/></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="负责人情况" width="100%">
				<next:EditGridPanel id="grid" width="100%" stripeRows="true" height="100%" dataset="somPresidePeopleDataSet">
					<next:TopBar>
							<next:ToolBarItem ></next:ToolBarItem>
							<next:ToolBarItem symbol="负责人列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="detail" text="查看" handler="examine"></next:ToolBarItem>
					</next:TopBar>
					
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="20%" sortable="false" editable="false"><next:TextField /></next:Column>
						<next:Column header="姓名"    field="name" width="15%" sortable="false" editable="false"><next:TextField /></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" sortable="false" editable="false"><next:TextField /></next:Column>
						<next:Column header="性别" 	  field="sex"      width="5%" sortable="false" editable="false" dataset="sexSelect"><next:TextField /></next:Column>
						<next:Column header="机构职务" field="sorgDuties" width="15%" sortable="false" editable="false" dataset="sorgDutiesSelect"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="17%" sortable="false" editable="false" dataset="politicsSelect"><next:TextField /></next:Column>
						<next:Column header="电话"    field="phone" width="18%" sortable="false" editable="false"><next:TextField /></next:Column>
					</next:Columns>		
					<next:BottomBar>
						<next:PagingToolBar dataset="somPresidePeopleDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel id="panel" title="分支/代表机构注销登记表" width="100%">
				<next:Html>
					<form id="form" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>基金会登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="mainSorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="name" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:15%"><label>注销日期：</label></td>
								<td class="FieldInput" style="width:17%"><label field="cancelDate" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>成立日期：</label></td>
								<td class="FieldInput" style="width:17%"><label field="buildDate" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>机构类型：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" field="cancelReason" style="width:98%" readonly="readonly"></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel width="100%" title="成立电子档案查看">
				<next:Html>
				  <iframe id="uploadInfo1" src="../upload/somDownloadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=204"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel width="100%" title="注销电子档案查看">
				<next:Html>
				  <iframe id="uploadInfo2" src="../upload/somDownloadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=206"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="win" title="查看负责人"  resizable="false" width="740" height="376" closeAction="hide" autoScroll="true">
	<next:Panel id="panel_win">
		<next:Html>
			<form id="form_win" method="post" dataset="winPresidePeopleDataSet" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:12%"><label>证件类型：</label></td>
						<td class="FieldInput" style="width:22%"><label  field="cardType" dataset="cardTypeSelect" style="width:100%"/></td>
						<td class="FieldLabel" style="width:12%"><label>证件号码：</label></td>
						<td class="FieldInput" style="width:21%"><label field="idCard" style="width:100%"/></td>
						<td class="FieldLabel"><label>姓名：</label></td>
						<td class="FieldInput"><label  field="name" style="width:100%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>国籍：</label></td>
						<td class="FieldInput"><label field="nation" dataset="nationSelect" style="width:100%"/></td>
						<td class="FieldLabel"><label>性别：</label></td>
						<td class="FieldInput"><label field="sex" dataset="sexSelect" style="width:100%"/></td>
						<td class="FieldLabel"><label>出生年月：</label></td>
						<td class="FieldInput"><label field="birthday" style="width:100%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>政治面貌：</label></td>
						<td class="FieldInput"><label field="politics" dataset="politicsSelect" style="width:100%"/></td>
						<td class="FieldLabel"><label>本人电话：</label></td>
						<td class="FieldInput"><label field="phone" style="width:100%"/></td>
						<td class="FieldLabel"><label>机构职务：</label></td>
						<td class="FieldInput" ><label field="sorgDuties" dataset="sorgDutiesSelect" style="width:100%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>单位职务：</label></td>
						<td class="FieldInput" colspan="5"><label field="workDuties" style="width:100%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>工作单位：</label></td>
						<td class="FieldInput" colspan="5"><label field="workName" style="width:100%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>是否党政机关领导干部：</label></td>
						<td class="FieldInput"><label field="ifPartyLeader" dataset="ifPartyLeaderSelect" style="width:90%"/></td>
						<td class="FieldLabel"><label>批准文号：</label></td>
						<td class="FieldInput"><label field="promiseCode" style="width:90%"/></td>
						<td class="FieldLabel"><label>批准机关：</label></td>
						<td class="FieldInput"><label field="promiseOrgan" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>简历：</label></td>
						<td class="FieldInput" colspan="5"><textarea rows="10" field="resume" style="width:100%" readonly="readonly"></textarea></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="关闭窗口" handler="closeWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>