<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>公墓数据上报导入</title>
<next:ScriptManager />
<script type="text/javascript">
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript" src="fisCemeImport.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dsTemp"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCeme">
		</model:record>
	</model:dataset>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true"
		pageSize="-1" sortField="cemeId">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCeme">
			<model:field name="value" mapping="cemeId" type="string"/>
			<model:field name="text" mapping="cemeName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset><legend>公墓数据上报导入 </legend>
		<div>
		<form id="form_content_upload" onsubmit="return false" class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="100">公墓</td>
				<td class="FieldInput" colspan="2" >
					<input type="text" name="公墓"
						id="qUnitName" readonly="readonly" style="width: 150px"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand;display: none;" onclick="forOrganHelp(this.id)" />
					<input type="text" id="qUnit" style="display: none;"/>&nbsp;
					<button id="selectBtn" style="cursor: hand" onclick="forOrganHelp(this.id)">选择</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="100">选择数据上报文件</td>
				<td class="FieldInput">
					<input class="file" type="file" id="upload_file" name="upload_photo" style="width:95%;height:40"/>
				</td>
				<td  class="FieldButton" style="width: 100px;">
					<button onclick="addUploadFile()">上传</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>
