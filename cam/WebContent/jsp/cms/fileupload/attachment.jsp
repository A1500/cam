<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/cms-upload" prefix="upload"%>  
<%@ page import="org.loushang.cms.core.component.document.api.*" %>
<%@ page import="java.util.*" %>
<%@page import="org.loushang.bsp.share.permit.security.SecurityFactory"%>
<%@page import="org.loushang.bsp.share.permit.security.provider.ISecurityProvider"%>

<%@page import="org.loushang.cms.util.FileUtil"%><%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="org.loushang.bsp.security.context.BspInfo"%>
<html>
<%
	String bizType = request.getParameter("biz");
	String processID = request.getParameter("processid");
	if(bizType == null && processID == null){
		out.write("缺少流程相关类型及ID");
		return;
	}
	String encryption = request.getParameter("encryption");
	String bizClass = request.getParameter("bizclass");
	String fileCount = request.getParameter("filecount");
	String fileSelectCount = request.getParameter("fileselectcount");
	Document doc = null;
	try{
		doc = DocFactory.getDocumentByProcessObjID(processID,bizType);
	}
	catch(Exception e){
		out.write(e.getMessage());
		return;
	}
	List files = null;
	if(doc == null){
		files = new ArrayList();
	}else{
		files = doc.getFileElementByBizClass(bizClass);
	}
	int  fileStored = files.size();
	long fileStoredSize = 0;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy年MM月dd日HH时mm分ss秒");
	//用户名，调用BSP相关方法，会少许影响速度
	
	ISecurityProvider securityProvider = SecurityFactory
	.getISecurityProvider();
	
	BspInfo bi = GetBspInfo.getBspInfo();
%>
<head>
<title>附件信息</title>
<next:ScriptManager></next:ScriptManager>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/skins/css/cms/cms-upload.css"/>

<script type="text/javascript" src="uploaddefault.js"></script>
</head>
<body>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="附件信息"></next:ToolBarItem>
	</next:TopBar>
	
	<next:Html>
		<form id="userForm" class="L5form">
		<input type="hidden" id = "attachment-biz" value="<%= bizType %>" />
		<input type="hidden" id = "attachment-processid" value="<%= processID %>" />
		<input type="hidden" id = "attachment-encryption" value="<%= encryption %>" />
		<input type="hidden" id = "attachment-bizclass" value="<%= bizClass %>" />
		<input type="hidden" id = "attachment-filecount" value="<%= fileCount %>" />
		<input type="hidden" id = "attachment-filestored" value="<%= fileStored %>" />
		<input type="hidden" id = "attachment-fileselectcount" value="<%=fileSelectCount  %>" />
		<input type="hidden" id = "attachment-creatorid" value="<%=bi.getUserId()  %>" />
		<input type="hidden" id = "attachment-creatorname" value="<%=bi.getUserName()  %>" />
		
		<table width="100%" border="1">
			
			<tr>
				<td class="FieldLabel" >待上传附件</td>
				<td>
				<table id="att" width="100%" border="1" class="FieldLabel">
					<tr>
						<td width="30%">文件名</td>
						<td width="8%">文件类型</td>
						<td width="12%">文件大小</td>
						<td width="30%">进度条</td>
						<td width="10%">状态</td>
						<td width="10%">操作</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">操作</td>
				
				<td>
				<upload:File name="fj" 
					totalUploadSize="20400000" uploadURL="UploadServlet" 
					fileSizeLimit="10240000" fileCount="1" buttonHeight="22" buttonWidth="120" backColor="#FFFFFF" fontSize="12" width="120" buttonName="上传附件"/>
				<input type="button" value="上传" name="upload" id="upload"
					title="上传" onclick="uploadatt()"/>
					<span id="showinfo" style="color: red;font-weight: bold"></span>
					
				<input type="button" value="下载所有附件" name="downloadAll" id="downloadAll"
					title="下载所有附件" onclick="downloadall()"/>
					<span id="showinfo" style="color: red;font-weight: bold"></span>
					
					</td>
				
			</tr>
			<tr>
				<td class="FieldLabel">附件</td>
				<td>
					<table id="att-complete" width="100%" border="1" class="FieldLabel">
						<tr>
							<td width="20%">文件名</td>
							<td width="8%">文件类型</td>
							<td width="12%">文件大小</td>
							<td width="15%">上传人</td>
							<td width="15%">上传时间</td>
							<td width="10%">操作</td>
						</tr>
						<%for(int i=0;i<fileStored;i++){ 
							FileElement fe = (FileElement)files.get(i);
							fileStoredSize +=fe.getSize();
						%>
						<tr id="<%=fe.getFileID() %>" class="FieldInput">
						<td><div onclick="fdown('<%=fe.getFileID() %>')" class="cmsDelLink"><%=fe.getFileName() %></div></td>
						<td><%=fe.getFileType() %></td>
						<td><%=FileUtil.convertLongToString(fe.getSize()) %></td>
						<td><%=securityProvider.getUserInfo(fe.getCreatorID()) == null?"未知用户": securityProvider.getUserInfo(fe.getCreatorID()).getUserName()%></td>
						<td><%=sd.format(fe.getCreateTime())%></td>
						<td><div onclick="fdelbyuuid('<%=fe.getFileID() %>')" class="cmsDelLink">删除</div></td>
						</tr>
						<% }%>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" id = "attachment-filestoredsize" value="<%=fileStoredSize  %>" />
		</form>
	</next:Html>
</next:Panel>
<script type="text/javascript" src="fileprogress.js"></script>
<div class="progressFieldset progressFlash" id="fsUploadProgress" style="position:absolute;right:0;bottom:0;height:0px;width:370px;border:1px solid; display: none; background: white">
	<span class="progressLegend">上传进度</span>
</div>	
<iframe id="downloadFrame" style="display: none;"></iframe>

</body>
</html>
<script>
function uploadatt(){
	upload("fj",null);
}
function init(){
  //var actiondef = L5.DatasetMgr.lookup("actiondef");
	//actiondef.newRecord();
	L5.QuickTips.init();
}
</script>