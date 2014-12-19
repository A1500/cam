 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="../../comm/js/wealUpload.js"></script>
<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	//假肢企业
 	var applyType = "1";
 	//流程--认定
 	var companyType = "1";
 	//电子档案目录类别
 	var catalogType = "01";
 	
function init(){
	//初始化
	somElectronicDataSet_load();
	getProsthesisName();
}
//页面跳转
function backPage(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt1.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPage(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt2.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
</script>
</head>
<body>
<model:datasets>
	<%--电子档案目录字典--%>
	<model:dataset id="catalogDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_ELECTRONICFILE_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_ID'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--电子档案内容表--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealElectronicfileContentQueryCommand" autoLoad="true" global="true" method="queryElectronicfileCatalog">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealElectronicfileContent"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel title="法律要件" >
	<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="上一页" handler="lastPage"></next:ToolBarItem>
			<next:ToolBarItem iconCls="undo" text="返回" handler="backPage"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogId" width="38%" editable="false" dataset="catalogDataSet" ><next:TextField /></next:Column>
			<next:Column header="附件名称" width="220" field="catalogName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述"    field="catalogNote" width="20%" editable="false"><next:TextField /></next:Column>
			<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
<jsp:include page="../../comm/jsp/wealUpload.jsp" flush="true"/>
</body>
</html>
