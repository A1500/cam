<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.fis.util.FisIdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公益性公墓信息编辑</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String method=request.getParameter("method");
		String organID = request.getParameter("organId");
		String organId = BspUtil.getOrganCode();
	%>
	var method='<%=method%>';
	var organID = '<%=organID%>';
	var organId = '<%=organId%>';
</script>
<script type="text/javascript" src="cemePublicfitInfomationEdit.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>

</head>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeteryOrganQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCemeteryOrgan">
			<model:field name="name" rule="require" />
			<model:field name="manaLevel" rule="require" />
			<model:field name="manaLevelId" rule="require" />
			<model:field name="prop" rule="require" />
			<model:field name="deptName" rule="require" />
			<model:field name="deptCode" rule="require" />
			<model:field name="address" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 性质 -->
	<model:dataset id="propertiesDataSet"
		enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dominationDS" enumName="FIS.CEME.DOMINATION"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="公墓信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="undo" text="取消" handler="reset" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			class="L5form">
		<table border="1" width="100%" >
			<tr>
				<td class="FieldLabel">公墓名称</td>
				<td class="FieldInput"><input type="text"
					name="公墓名称" maxlength="50" field="name" style="width: 200" /><font
					color=red>*</font></td>
				<td class="FieldLabel">公墓编号</td>
				<td class="FieldInput"><input name="公墓编号" id="organId"
					field="organId" style="font-weight: bold;" readonly="readonly"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">主管单位</td>
				<td class="FieldInput"><input type="text" name="主管单位"
					id="manaLevel" onclick="updateSelectManaCode()" readonly="readonly"
					field="manaLevel" maxlength="50" style="width: 200" /><font
					color=red>*</font><input type="hidden" name="主管单位代码"
					id="manaLevelId" field="manaLevelId" maxlength="50"
					style="width: 200" /></td>
				<td class="FieldLabel">管辖级别</td>
				<td class="FieldInput" ><select name="管辖级别"
					id="domination" field="domination" maxlength="50"
					style="width: 200">
					<option dataset="dominationDS"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel">主办单位</td>
				<td class="FieldInput"><input type="text" name="主办单位"
					field="organizer" style="width: 200" maxlength="25" /></td>
				<td class="FieldLabel">主办单位性质</td>
				<td class="FieldInput" ><input type="text"
					name="主办单位性质" field="organizerProperties" style="width: 200" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">公墓负责人</td>
				<td class="FieldInput"><input type="text" name="公墓负责人"
					maxlength="36" field="legalPeople" /></td>
				<td class="FieldLabel">负责人联系电话</td>
				<td class="FieldInput" ><input type="text"
					name="负责人联系电话" id="officePhone" field="officePhone" maxlength="50"
					style="width: 200" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">所属行政区</td>
				<td class="FieldInput"><input type="text" id="deptName"
					name="所属行政区" maxlength="100" style="width: 200" field="deptName" readonly="readonly"
					onclick="updateSelectDeptCode()" /><font color=red>*</font><input type="hidden"
					id="deptCode" name="所属行政区划Code" field="deptCode" /></td>
				<td class="FieldLabel">所在位置</td>
				<td class="FieldInput"><input type="text" name="所在位置"
					maxlength="100" style="width: 200" field="address" /><font color=red>*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">正式使用时间</td>
				<td class="FieldInput"><input type="text" name="正式营业时间"
					field="gestionTime" format="Y-m-d" onclick="LoushangDate(this)"
					readonly="readonly" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getDay(this);"></td>	
				<td class="FieldLabel">计划使用年限至</td>
				<td class="FieldInput"><input type="text" name="计划使用年限至"
					id="yearPlanto" field="yearPlanto" maxlength="4" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">占用土地性质</td>
				<td class="FieldInput"><input type="text" name="占用土地性质"
					id="landProperties" field="landProperties" maxlength="50" /></td>
				<td class="FieldLabel">占地面积（亩）</td>
				<td class="FieldInput"><input type="text" name="占地面积"
					id="totalArea" maxlength="13" style="text-align: right"
					onchange="checkAssMon(this.id)" field="totalArea" />亩</td>
			</tr>
			<tr>
				<td class="FieldLabel">建筑面积</td>
				<td class="FieldInput"><input type="text" name="建筑面积"
					id="builtTotalArea" maxlength="13" style="text-align: right"
					onchange="checkAssMon(this.id)" field="builtTotalArea" />㎡</td>
				<td class="FieldLabel">绿地面积</td>
				<td class="FieldInput"><input type="text" name="绿地面积（㎡）"
					id="greenArea" style="text-align: right"
					onchange="checkAssMon(this.id)" field="greenArea" maxlength="10" />㎡<font color=red>*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">绿化覆盖率</td>
				<td class="FieldInput"><input type="text" name="绿化覆盖率(%)"
					id="greenRatio" style="text-align: right"
					onchange="checkAssMon(this.id)" field="greenRatio" maxlength="10" />%<font color=red>*</font></td>
				<td class="FieldLabel">维护管理办法</td>
				<td class="FieldInput" colspan="5"><textarea
					name="维护管理办法" field="manageStyle"
					onpropertychange="if(value.length>100) value=value.substr(0,100)"
					style="width: 80%; height: 60"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">县级民政部门批准时间</td>
				<td class="FieldInput"><input type="text" name="县级民政部门批准时间"
					field="townApproveTime" format="Y-m-d" onclick="LoushangDate(this)"
					readonly="readonly" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getDay(this);"></td>	
				<td class="FieldLabel">县级民政部门批准文号</td>
				<td class="FieldInput"><input type="text" name="县级民政部门批准文号"
					id="townApproveNumber" field="townApproveNumber" maxlength="50" style="width: 200"/></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>