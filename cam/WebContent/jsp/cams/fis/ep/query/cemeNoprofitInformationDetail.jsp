<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>公益性公墓信息补录编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script>
		var idField='<%=request.getParameter("idField")%>';
</script>
<script type="text/javascript" src="cemeNoprofitInformationDetail.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCeme">
		   	<model:field name="cemeName" type="string" rule="require"/>
			<model:field name="cemeId" type="string" rule="require"/>
			<model:field name="organizer" type="string" rule="require"/>
			<model:field name="manaLevel" type="string" rule="require"/>
			<model:field name="legalPerson" type="string" rule="require"/>
			<model:field name="directorMobile" type="string" rule="require"/>
			<model:field name="gestionTime" type="string" rule="require"/>
			<model:field name="address" type="string" rule="require"/>
			<model:field name="caDeptBuildNum" type="string" rule="require"/>
			<model:field name="caDeptBuildTime" type="string" rule="require"/>
			<model:field name="caDeptGestionNum" type="string" rule="require"/>
			<model:field name="caDeptGestionTime" type="string" rule="require"/>
			<model:field name="totalArea" type="string" rule="require"/>
			<model:field name="totalAreaUnits" type="string" rule="require"/>
		</model:record>
	</model:dataset>
        <model:dataset id="propDataSet" enumName="FIS.CEME.PROP"  autoLoad="true" global="true"></model:dataset>
        <model:dataset id="AreaUnitsDataSet" enumName="FIS.CEME.AREAUNITS"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="公墓信息" height="100%" width="100%" autoScroll="true">
			<next:Html>
				<form id="editForm" method="post" dataset="ds"
					onsubmit="return false" class="L5form">
				<fieldset><legend>公墓基本信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 20%">公墓名称</td>
						<td class="FieldInput"><label type="text" id="cemeName"
							name="公墓名称" field="cemeName" title="补录公墓的全称" maxlength="25"
							style="width: 200px;" /></td>
						<td class="FieldLabel">管辖单位</td>
						<td class="FieldInput"><label type="text" name="管辖单位"
							id="manaLevel" field="manaLevel" readonly="readonly" /> <label
							type="text" id="manaLevelId" field="manaLevelId"
							style="display: none;" /> <img
							src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
							style="cursor: hand" onclick="selectUser()" alt="选择管辖单位" /> <img
							src="<%=SkinUtils.getImage(request, "l5/function.gif")%>"
							style="cursor: hand" alt="按管辖单位生成公墓编号" id="createID"
							onclick="createCode()" /></td>
						
					</tr>
					<tr>
						<td class="FieldLabel">主办单位</td>
						<td class="FieldInput"><label type="text" name="主办单位"
							field="organizer" maxlength="25" />
						<td class="FieldLabel" style="width: 20%">公墓编号</td>
						<td class="FieldInput" style="width: 31%"><label type="text"
							id="cemeId" name="公墓编号" field="cemeId"
							title="省厅民政部门授予的组织编码，全省唯一\n请按所管辖单位的批准时间编写公墓顺序号" maxlength="11" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓负责人</td>
						<td class="FieldInput"><label type="text" name="公墓负责人"
							field="legalPerson" maxlength="25" /></td>
						<td class="FieldLabel">公墓性质</td>
						<td class="FieldInput"><label title="公墓性质">公益性</label></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓负责人手机</td>
						<td class="FieldInput"><label type="text" name="公墓负责人手机"
							id="directorMobile" field="directorMobile" maxlength="16"
							onchange="checkNum(this.id)" /></td>
						<td class="FieldLabel">正式使用时间</td>
						<td class="FieldInput"><label type="text" name="正式使用时间"
							field="gestionTime" format="Y-m-d" onclick="LoushangDate(this)"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓所在位置</td>
						<td class="FieldInput"><label type="text" name="公墓所在位置"
							field="address" style="width: 300px" maxlength="50" /></td>
						<td class="FieldLabel">资金来源</td>
							<td class="FieldInput">
							<input type="checkbox" name="资金来源" value="1" id="fundSources"  field="fundSources">
							<label >财政拨款</label>
							
							<input type="checkbox" name="资金来源" value="2" id="fundSources" field="fundSources">
							<label >上级部门拨款</label>
							<input type="checkbox" name="资金来源" value="3" id="fundSources" field="fundSources">
							<label >自筹</label>
							<br/>
							<input type="checkbox" name="资金来源" value="4" id="fundSources" field="fundSources">
							<label >福彩资助</label>
							<input type="checkbox" name="资金来源" value="5" id="fundSources" field="fundSources">
							<label >其他</label>
							</td>
							
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 20%">县级民政部门批准建设文号</td>
						<td class="FieldInput"><label type="text" name="县级民政部门批准建设文号"
							field="caDeptBuildNum" maxlength="25" /></td>
						<td class="FieldLabel" style="width: 20%">县级民政部门批准建设时间</td>
						<td class="FieldInput"><label type="text" name="县级民政部门批准建设时间"
							field="caDeptBuildTime" format="Y-m-d"
							onclick="LoushangDate(this)" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">市级民政部门备案文号</td>
						<td class="FieldInput"><label type="text" name="市级民政部门备案文号"
							field="caDeptGestionNum" maxlength="25" /></td>
						<td class="FieldLabel">市级民政部门备案时间</td>
						<td class="FieldInput"><label type="text" name="市级民政部门备案时间"
							field="caDeptGestionTime" format="Y-m-d"
							onclick="LoushangDate(this)" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 20%">公墓占地面积</td>
						<td class="FieldInput"><label type="text" name="公墓占地面积" style="text-align:right"
							field="totalArea" id="totalArea" onchange="checkAssMon(this.id)"
							maxlength="10" /></td>
						<td class="FieldLabel" style="width: 20%">公墓占地面积计量单位</td>
						<td class="FieldInput"><select name="公墓占地面积计量单位"
							field="totalAreaUnits">
							<option dataset="AreaUnitsDataSet"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">服务范围</td>
						<td class="FieldInput" colspan="5"><textarea disabled="disabled"
							onpropertychange="if(value.length>49) value=value.substr(0,49)"
							rows="3" maxlength="49" name='服务范围' field="serviceScope" style="width: 60%"></textarea></td>

					</tr>
				</table>
				</fieldset>

				</form>
			</next:Html>
		</next:Panel>

	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
