<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员照片表明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="comPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var photoId='<%=request.getParameter("photoId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="comPhotoDataSet" cmd="com.inspur.cams.jcm.cmd.ComPhotoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.ComPhoto"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="comPhotoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员照片表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><label field="photoId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">照片类型：</td>
			<td class="FieldInput" style="width:36%"><label field="photoKind"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">照片大小：</td>
			<td class="FieldInput" style="width:36%"><label field="photoSize"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">照片类别：</td>
			<td class="FieldInput" style="width:36%"><label field="photoType"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">照片：</td>
			<td class="FieldInput" style="width:36%"><label field="photoContent"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">创建日期：</td>
			<td class="FieldInput" style="width:36%"><label field="createDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">创建组织机构：</td>
			<td class="FieldInput" style="width:36%"><label field="createOrgan"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldInput" style="width:36%"><label field="note"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">创建人：</td>
			<td class="FieldInput" style="width:36%"><label field="createOpr"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">照片内容：</td>
			<td class="FieldInput" style="width:36%"><label field="cardPhotoContent"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>