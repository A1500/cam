<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>民办非企业单位负责人备案</title> 
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ungovManagePeople.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName='<%=request.getParameter("cnName")%>';
	cnName=decodeURIComponent(cnName);
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var sessionId='<%=request.getParameter("sessionId")%>';
	var applyType='115';	
	var taskCode='<%=request.getParameter("taskCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>	
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>	
	
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
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
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
		<next:Tabs>
			<next:Panel id="panelSomOrgan" title="民办非企业单位负责人备案表" width="100%" height="100%" autoScroll="true">	
				<next:Panel>		
					<next:Html>
						<fieldset style="overflow:visible;">
						<legend>民办非企业单位信息</legend>
						<form id="form2" dataset="somSessionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" field="sessionId"/>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:17%">单位名称：</td>
									<td class="FieldInput" colspan="3"><label id="cnName"/></td>
									<td class="FieldLabel" style="width:17%">登记证号：</td>
									<td class="FieldInput"><label id="sorgCode"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">届次名称：</td>
									<td class="FieldInput" colspan="3"><label field="sessionName"/></td>
									<td class="FieldLabel">本届任期（年）：</td>
									<td class="FieldInput"><label field="tenure"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">本届开始日期：</td>
									<td class="FieldInput" style="width:17%"><label field="startDate"/></td>
									<td class="FieldLabel" style="width:17%">章程规定换届日期：</td>
									<td class="FieldInput" style="width:15%"><label field="endDate"/></td>
									<td class="FieldLabel" style="width:17%">换届日期：</td>
									<td class="FieldInput" style="width:17%"><label field="realEndDate"/></td>
								</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="负责人信息"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detail"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexDataSet"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesDataSet"/></next:Column>
						<next:Column header="是否法定代表人" field="ifLegal" width="15%" editable="false"><next:ComboBox dataset="yesornoDataSet"/></next:Column>		
						<next:Column header="是否在任" field="ifServe" width="10%" editable="false"><next:ComboBox dataset="yesornoDataSet"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
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
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>					
		</next:Tabs>
	</next:TabPanel>				
</next:Panel>	
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>		
<jsp:include page="../../comm/people/ungovPeopleDetail.jsp" flush="true"/>
</body>
</html>