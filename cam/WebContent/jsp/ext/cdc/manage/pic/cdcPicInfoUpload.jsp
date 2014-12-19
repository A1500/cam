<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.DateUtil;"%>
<html>
<head>
<title>图片预览效果</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcPicInfoUpload.js"></script>
<script type="text/javascript" src="imgPreview/CJL.0.1.min.js"></script>
<script type="text/javascript" src="imgPreview/QuickUpload.js"></script>
<script type="text/javascript" src="imgPreview/ImagePreviewd.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var dateNow = '<%=DateUtil.getTime()%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcPicInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPicInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPicInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="upload" text="保存" handler="upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form id="editForm" method="post" dataset="cdcPicInfoDataSet" onsubmit="return false" class="L5form">
		<table width="100%" border="0">
			<tr>
				<td  class="FieldLabel"  width="20%" height="100">预览图</td>
				<td class="FieldInput" width="50%" align="center" height="100"><img id="idImg" height="100" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">选择图片</td>
				<td class="FieldInput"><input id="idFile" name="idFile" type="file" style="width:50%"/><font color="red"> *</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">展示描述</td>
				<td class="FieldInput"><textarea rows="3" id="note" field="note" style="width:90%" /></td>
			</tr>
		</table>
	</form>
	</next:Html>
</next:Panel>

</body>
</html>