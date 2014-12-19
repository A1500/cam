
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>照片增加</title>
<next:ScriptManager />
<script>
</script>
<script type="text/javascript" src="comPhoto.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsPhoto.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 一站式结算登记信息 -->
	<model:dataset id="comPhotoDs"
		cmd="com.inspur.cams.comm.comphoto.cmd.ComPhotoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.comm.comphoto.data.ComPhoto"></model:record>
	</model:dataset>
	
</model:datasets>

<next:Panel title="照片增加" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="comPhotoDs" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table>
		<tr><td>照片</td>
		
		<td align="center" nowrap colspan="1">
        <input type="hidden" name="photoTemp" id="photoTemp"/>
        <img name="PHOTO_IMG" width=150 height=200
        src="/cam/download?table=com_photo_201106&column=photo_content&pk=photo_id&photo_id='120110628b88130bfad630130bfad63e60001'&"+(new Date()).toTimeString()";
        onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
        ondblclick="editPhoto(1,'photoTemp','PHOTO_IMG')"
         />
		<!--  ondblclick="editPhoto(1,'photoTemp','PHOTO_IMG')"-->
		</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>



</body>
</html>
