<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>外部单位管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="comExtOrganEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var organId='<%=request.getParameter("organId")%>';
	var id='<%=request.getParameter("id")%>';
	var name='<%=request.getParameter("name")%>';
	name=decodeURIComponent(name);
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="comExtOrganDs" cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan">
			<model:field name="forAreaCode"/>
		</model:record>
	</model:dataset>
	<model:dataset id="comExtOrganTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="COM_EXT_ORGAN_TYPE"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	
	
	<model:dataset id="samMServiceAreaDs"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMServiceAreaQueryCmd"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMServiceArea"></model:record>
	</model:dataset>
	
	<model:dataset id="organTypeDsNew" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false" sortField="id" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_CITY"></model:param>
			<model:param name="value" value="ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	
	
	<model:dataset id="cityDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false" sortField="id" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_CITY"></model:param>
			<model:param name="value" value="ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="comExtOrganDs" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>外部单位管理</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">单位名称：</td>
						<td class="FieldInput" colspan="3"><input type="text" name="organName" id="organName" field="organName" style="width:90%"/><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:16%">单位类型：</td>
						<td class="FieldInput" style="width:30%">
							<select name="organType" id="organType" field="organType" onchange="showAreaCodeSelectDiv(this.value)">
								<option dataset="comExtOrganTypeDs"></option>
							</select>
						</td>
						<td class="FieldLabel" style="width:18%">单位级别：</td>
						<td class="FieldInput" style="width:36%">
							<select name="organLev" id="organLev" field="organLev">
								<option value="1">省级</option>
								<option value="2">市级</option>
								<option value="3">区县级</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">单位地址：</td>
						<td class="FieldInput" colspan="3"><input type="text" name="organAdds" id="organAdds" field="organAdds" maxlength="30" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">单位联系人：</td>
						<td class="FieldInput"><input type="text" name="organPeople" id="organPeople" field="organPeople" maxlength="30" style="width:90%"/></td>
						<td class="FieldLabel">单位联系电话：</td>
						<td class="FieldInput"><input type="text" name="organPhone" id="organPhone" field="organPhone" maxlength="100" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">单位状态：</td>
						<td class="FieldInput" colspan="3">
							<select name="organStatus" id="organStatus" field="organStatus">
								<option value="1">有效</option>
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">所属行政区划：</td>
						<td class="FieldInput"><label name="areaCode" id="areaCode" field="areaCode"/></td>
						<td class="FieldLabel">所属行政区划名称：</td>
						<td class="FieldInput"><label name="areaName" id="areaName" field="areaName"/></td>
					</tr>
					<input type="hidden" name="organId" id="organId" field="organId"/>
				</table>
			</fieldset>
		</form>
		<div>
			<form id="areaCodeSelectDiv" class="L5form" style="display: none;" dataset="comExtOrganDs">
			<fieldset>
				<legend>区县配置</legend>
				<div id="favordiv"></div>
				<input type="hidden" systype="itemselector"  id="targetRefId"  field="forAreaCode">
				</fieldset>
			</form>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>