<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
var applyType = '<%=StrUtil.n2b(request.getParameter("applyType"))%>';
var taskCode = '<%=StrUtil.n2b(request.getParameter("taskCode"))%>';
//初始化
function init(){
	somElectronicDataSet_load();
}
function somElectronicDataSet_load(){
	somElectronicDataSet.setParameter("sorgId",sorgId);
	somElectronicDataSet.setParameter("applyType",applyType);
	somElectronicDataSet.setParameter("taskCode",taskCode);
	somElectronicDataSet.load();
}
//下载附件
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId").split(";");
	if(ids[0]==""){
		return "";
	}
	if(ids[0]!="" && ids[1]==null){
		var url0=paths[0]+'/'+paths[1]+"/download?table=som_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+ids[0]+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}
	return '<a href="javascript:clickDownload(\'' + somElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
}
function clickDownload(index){
    var record= somElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("ids",ids);
	downloadDataSet.load();
	var win = L5.getCmp("downloadWin");
	win.show();
}
//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("electronicId");
       var url0=paths[0]+'/'+paths[1]+"/download?table=som_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
function winClosedownload(){
	var win = L5.getCmp("downloadWin");
	win.setVisible(false);
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
<%--电子档案--%>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
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
</model:datasets>
<%--定义界面--%>
<next:Panel>
	<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogCode" width="40%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
			<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
<next:Window id="downloadWin" closeAction="hide" height="400" width="740">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
	</next:TopBar>
	<next:EditGridPanel id="downloadGrid" width="725" stripeRows="true" height="360" dataset="downloadDataSet" >
		<next:Columns>
			<next:RowNumberColumn/>
			<next:Column header="电子档案ID" field="electronicId" editable="false" hidden="true"></next:Column>
			<next:Column header="档案目录名"  field="catalogCode" width="335" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="fileName" width="180" editable="false" renderer="winDownloadHref"></next:Column>
			<next:Column header="文件描述" field="fileMess" width="180" editable="false"></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>