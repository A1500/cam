
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	//System.out.println(request.getAttributeNames());
	//System.out.println(request.getAttribute("organTypeList"));
%>
<html>
	<head>
		<title>PUB_STRU_VERSION</title>
		<script type="text/javascript">
			//ORGANTYPE.messType=确定
			var messType='<%=res.get("ORGAN.messType")%>';
			var messTypePrompt='<%=res.get("ORGAN.messTypePrompt")%>';
			//ORGANTYPE.Save.NoDataMess=没有需要保存的数据!
			var saveNoDataMess='<%=res.get("ORGAN.Save.NoDataMess")%>';
			var saveValidateMess='<%=res.get("ORGAN.Save.ValidateMess")%>';
			var saveValidateMessInputBigen='<%=res.get("ORGAN.Save.ValidateMessInputBigen")%>';
			var saveValidateMessInputEnd='<%=res.get("ORGAN.Save.ValidateMessInputEnd")%>';
			//ORGANTYPE.Save.SuccessMess="数据保存成功!
			var saveSuccessMess='<%=res.get("ORGAN.Save.SuccessMess")%>';
			//ORGANTYPE.Delete.PleaseSelectData=请选择要删除的记录！
			var deletePleaseSelectData='<%=res.get("ORGAN.Delete.PleaseSelectData")%>';
			//ORGANTYPE.Delete.SelectDataMess=你确定要删除吗？
			var deleteSelectDataMess='<%=res.get("ORGAN.Delete.SelectDataMess")%>';
		</script>
		<next:ScriptManager/>
		<script type="text/javascript" src="pubstruversion.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="org.loushang.bsp.organization.cmd.PubStruVersionQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.organization.dao.PubStruVersion"></model:record>
	</model:dataset>
</model:datasets>


<next:EditGridPanel id="editGridPanel" name="pubstruversionGrid" width="100%" stripeRows="true" height="400" dataset="ds" >
	<next:TopBar>
			<next:ToolBarItem symbol='<%=res.get("Stru_Version.gridTitle") %>' ></next:ToolBarItem>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="common-query"  text='<%=res.get("Stru_Version.query") %>' handler="query"/>
			<next:ToolBarItem  iconCls="add" text='<%=res.get("BUT.ADD") %>' handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text='<%=res.get("BUT.REMOVE") %>' handler="del"  />
			<next:ToolBarItem iconCls="submit"  text='<%=res.get("BUT.SAVE") %>' handler="save"/>
			<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO") %>' handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="version" header='<%=res.get("Stru_Version.code") %>' field="version" width="100" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="versionDate" header='<%=res.get("Stru_Version.version_Date") %>' field="versionDate" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="versionUser" header='<%=res.get("Stru_Version.version_User") %>' field="versionUser" width="100" >
			<next:TextField  />
		</next:Column>

		<next:Column id="endScn" header='<%=res.get("Stru_Version.incode") %>' field="endScn" width="80" >
			<next:NumberField allowBlank="false" />
		</next:Column>

		<next:Column id="versionNote" header='<%=res.get("Stru_Version.node") %>' field="versionNote" width="250" >
			<next:TextField  />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
