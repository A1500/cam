<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>通知通告信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var noticeType='<%=request.getParameter("noticeType")%>';
	var noticeId='<%=request.getParameter("noticeId")%>';
	var fileId='<%=request.getParameter("fileId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeInfoQueryCmd" method="query" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNoticeInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcNoticeDataset" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报单位</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" >发布单位：</td>
			<td class="FieldInput" ><label field="organName" style="width:200"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>填报内容</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" >主题：</td>
			<td class="FieldInput" ><label id="name" field="name" style="width:200"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">内容:</td>
			<td class="FieldInput"><label id="content" field="content"  ></label></td>
		</tr>
		<tr>
			<td class="FieldLabel">附件：</td>
			<td class="FieldInput"><a id="fj"  href="<%=SkinUtils.getRootUrl(request) %>download?table=com_file&column=file_content&filename=file_name&pk=file_id&file_id='<%=request.getParameter("fileId") %>'"><font size=2>下载</font></a></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){

	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
	cdcNoticeDataset.on("load",function(){
		var nominate = cdcNoticeDataset.getCurrent();
		if(nominate==null){
			cdcNoticeDataset.newRecord({"organArea":organCode,"organName":organName,"parentCode":parentCode,
			"username":organName,"organLevel":organLevel,"noticeType":noticeType});
		}
	});
	cdcNoticeDataset.setParameter("NOTICE_ID@=",noticeId);
	cdcNoticeDataset.load();
	cdcNoticeDataset.on("load",function(){
		if(cdcNoticeDataset.get("fileId")==''){
			document.getElementById("fj").style.display="none";
		}
		
	});
}
function returnBack(){
	history.go(-1);
}






</script>