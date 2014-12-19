<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil;"%>
<html>
<head>
<title>添加机关图片</title>
<next:ScriptManager/>
<script type="text/javascript">
	var deptCode = '<%=request.getParameter("deptCode")%>';
	var deptName = decodeURIComponent('<%=request.getParameter("deptName")%>');
	var dateNow = '<%=DateUtil.getTime()%>';
</script>
<script type="text/javascript" src="mrmPhotoInfoUpload.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../bpt/comm/bptComm.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="mrmPhotoInfoDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmPhotoInfoQueryCommand" pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmPhotoInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="upload" text="保存" handler="upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="关闭" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form id="editForm" method="post" dataset="mrmPhotoInfoDataSet" onsubmit="return false" class="L5form">
		<table width="100%" border="0">
			<tr>
				<td  class="FieldLabel"  width="20%" height="100">预览图</td>
				<td nowrap >
					<div id="photoDiv">
						<img id="img" name="RELATIONER_PHOTOC_IMG" width=170 height=140 src="<%=SkinUtils.getRootUrl(request) %>/jsp/cams/marry/image/default.jpg" 
						align="top" ondblclick="editPhoto(1,'photo','RELATIONER_PHOTOC_IMG');"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>/jsp/cams/marry/image/default.jpg'" alt="暂无图片" />
						<input type="hidden" id="photo" name="photo"/>
					</div>
				</td>	
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