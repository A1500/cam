<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.marry.base.cmd.MrmBasePersonCommand"%>

<html>
	<head>
		<title>人员基本信息表编辑</title>
		<next:ScriptManager/>
		<script>
		    var organCode = '<%=BspUtil.getOrganCode()%>';
			var organId='<%=BspUtil.getOrganCode()%>';
			var personid='<%=request.getParameter("idField")%>';
			var deptId='<%=request.getParameter("deptId")%>';
		</script>
		<script type="text/javascript" src="mrmbaseperson_edit.js"></script>
		<script type="text/javascript" src="../../bpt/comm/bptComm.js"></script>
		<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
		<script type="text/javascript" src="mrmBasePersonElec.js"></script>
	</head>
<body>
<!--电子档案 -->
 <model:datasets>
	<model:dataset id="mrmElectronicDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" method="queryCatalog" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>	
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="MRM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
</model:datasets>


<next:GridPanel id="uploadGrid" title="上传证明材料" height="100%"  dataset="mrmElectronicDataSet" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
	</next:TopBar>		
	<next:Columns>
		<next:RowNumberColumn />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="证明材料目录" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"/>
		<next:Column header="附件名称" field="fileName" width="30%" editable="false"/>
	    <next:Column header="附件描述" field="fileMess" width="20%" editable="false"/>
	    <next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="mrmElectronicDataSet" />
	</next:BottomBar>
</next:GridPanel>
<jsp:include page="../common/mrmBasePersonUpload.jsp" flush="true"/>
</body>
</html>