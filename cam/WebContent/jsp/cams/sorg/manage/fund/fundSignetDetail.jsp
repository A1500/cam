<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基金会印章式样备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundSignetEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var id='<%=request.getParameter("id")%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var taskCode='<%=request.getParameter("taskCode")%>';
	var applyType='218';
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';	
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somSignetDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSignetQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSignet">
		</model:record>
	</model:dataset>
	<model:dataset id="somSignetDirectoryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSignetDirectoryQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSignetDirectory">
		</model:record>
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
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="基金会印章式样备案" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">	
					<next:Html>
						<form id="signetForm" method="post" dataset="somSignetDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>基金会印章式样备案</legend>
						<input type="hidden" id="sorgId" field="sorgId" value="基金会ID">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:18%">基金会名称：</td>
								<td class="FieldInput"  style="width:36%"><label id="cnName"/></td>
								<td class="FieldLabel" style="width:16%">登记证号：</td>
								<td class="FieldInput"  style="width:30%"><label id="sorgCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">领章人：</td>
								<td class="FieldInput" ><label field="fetchPeople" /></td>
								<td class="FieldLabel">印章启用时间：</td>
								<td class="FieldInput" ><label field="signetDate" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">备案承办人：</td>
								<td class="FieldInput" ><label field="regPeople" /></td>
								<td class="FieldLabel">备案时间：</td>
								<td class="FieldInput" ><label field="regDate" /></td>
							</tr>
						</table>
						</fieldset>
						</form>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:EditGridPanel id="signetDirectoryGrid" title="印章名录表" dataset="somSignetDirectoryDataSet" width="100%" stripeRows="true" height="100%">
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="印章名录" field="directory" width="50%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somSignetDirectoryDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
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
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>