<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>殡仪馆信息编辑</title>
<next:ScriptManager />
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="funeralOrganUserManage.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var method = "<%=request.getParameter("method")%>";
	var organCode = "<%=request.getParameter("organCode")%>";
	var uuid = "<%=IdHelp.getUUID30()%>";
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisFuneralOrganManage"></model:record>
	</model:dataset>
	<!-- 性质 -->
	<model:dataset id="propertiesDataSet"
		enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!-- 级别 -->
	<model:dataset id="titleDataSet" enumName="FIS.FUNERALHOME.TITLE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 殡葬改革示范单位 -->
	<model:dataset id="demonUnitDataSet"
		enumName="FIS.FUNERALHOME.DEMONUNIT" autoLoad="true" global="true"></model:dataset>
	<!-- 等级 -->
	<model:dataset id="gradeDataSet" enumName="FIS.FUNERALHOME.GRADE"
		autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel  height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="殡仪馆信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			class="L5form">
		<table border="1" width="100%" height="100%">

			<tr>
				<td class="FieldLabel" width="135">用户名</td>
				<td class="FieldInput" ><label id="organCode" type="text" name="用户名" field="organCode" /><font color="red">*</font></td>

				<td class="FieldLabel" width="135">殡仪馆编号</td>
				<td class="FieldInput" ><input id="unitId" type="text" name="殡仪馆编号" field="unitId" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="135">殡仪馆名称</td>
				<td class="FieldInput"><input id="unitName" type="text" name="殡仪馆名称" maxlength="50" field="unitName" /></td>
				
				<td class="FieldLabel" width="135">组织机构代码</td>
				<td class="FieldInput" ><input id="unitCode" type="text" name="组织机构代码" field="unitCode" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="135">主管单位</td>
				<td class="FieldInput">
					<input type="text"
					name="parentOrganName" id="parentOrganName" title="主管单位" field="parentOrganName"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="parentOrganCode" name="parentOrganCode" field="parentOrganCode" style="display: none;" />
					<button id="selectParent" style="cursor: hand" onclick="selectOrgan('parentOrganCode','parentOrganName')">选择</button>
						<font color="red">*</font></td>
				<td class="FieldLabel" width="135">所属行政区</td>
				<td class="FieldInput">
					<input type="text"
					name="areaName" id="areaName" title="所属行政区" field="areaName"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="areaCode" name="areaCode" field="areaCode" style="display: none;" />
					<button  id="selectArea" style="cursor: hand" onclick="selectArea('areaCode','areaName')">选择</button></td>  
			</tr>
			<tr>
				<td class="FieldLabel">性质</td>
				<td class="FieldInput"><select name="properties" id="properties"
					field="properties">
					<option dataset="propertiesDataSet"></option>
				</select></td>

				<td class="FieldLabel">法人代表</td>
				<td class="FieldInput"><input type="text" name="legalPeople" maxlength="36" id="legalPeople"
					field="legalPeople" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">编制人数(人)</td>
				<td class="FieldInput"><input type="text" id="numberOf" name="numberOf" maxlength="9" style="text-align:right" onchange="checkNum(this.id)"
					field="numberOf" /></td>

				<td class="FieldLabel">实有人数(人)</td>
				<td class="FieldInput"><input type="text" id="numberReal" name="实有人数" maxlength="9" style="text-align:right" onchange="checkNum(this.id)"
					field="numberReal" /></td>


			</tr>
			<tr>
				<td class="FieldLabel">占地面积(㎡)</td>
				<td class="FieldInput"><input type="text" name="占地面积" id="builtArea" maxlength="8" style="text-align:right" onchange="checkNum(this.id)"
					field="builtArea" /></td>
				<td class="FieldLabel">建筑面积(㎡)</td>
				<td class="FieldInput"><input type="text" name="建筑面积" id="builtTotalArea" maxlength="8" style="text-align:right" onchange="checkNum(this.id)"
					field="builtTotalArea" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">成立时间</td>
				<td class="FieldInput">
				<input type="text" id="gestionTime" format="Y-m-d" name="gestionTime" field="gestionTime" onclick="LoushangDate(this)"/>
				</td>
				<td class="FieldLabel">级别</td>
				<td class="FieldInput"><select name="title" field="title">
					<option dataset="titleDataSet"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel">所在地址</td>
				<td class="FieldInput"><input type="text" name="address" maxlength="100" id="address"
					field="address" /></td>

				<td class="FieldLabel">邮政编码</td>
				<td class="FieldInput"><input type="text" name="portCode" maxlength="6" id="portCode"
					field="portCode" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">服务电话</td>
				<td class="FieldInput"><input type="text" name="servicePhone" maxlength="16" id="servicePhone"
					field="servicePhone" /></td>

				<td class="FieldLabel">网站网址</td>
				<td class="FieldInput"><input type="text" name="web" maxlength="50" id="web"
					field="web" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">电子邮件地址</td>
				<td class="FieldInput"><input type="text" name="email" maxlength="50" id="email"
					field="email" /></td>

				<td class="FieldLabel">QQ群</td>
				<td class="FieldInput"><input type="text" name="qq" field="qq" id="qq" maxlength="15"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">殡葬改革示范单位</td>
				<td class="FieldInput"><select name="demonUnit"
					field="demonUnit">
					<option dataset="demonUnitDataSet"></option>
				</select></td>
				<td class="FieldLabel">等级</td>
				<td class="FieldInput"><select name="grade" field="grade">
					<option dataset="gradeDataSet"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel">服务内容</td>
				<td class="FieldInput"><input type="checkbox" id="serviceScope1"
					name="serviceScope" value="1" field="serviceScope" label="殡仪服务" />殡仪服务
				<br />
				<input type="checkbox" name="serviceScope" value="2" id="serviceScope2"
					field="serviceScope" label="骨灰寄存" />骨灰寄存 <br />
				<input type="checkbox" name="serviceScope" value="3" id="serviceScope3"
					field="serviceScope" label="殡葬用品销售 " />殡葬用品销售 <br />
				<input type="checkbox" name="serviceScope" value="4" id="serviceScope4"
					field="serviceScope" label="骨灰安葬" />骨灰安葬 <br/>
					<input type="checkbox" name="serviceScope" value="5" id="serviceScope5"
					field="serviceScope" label="国际运尸" />国际运尸
					</td>	
				<td class="FieldLabel">固定资产（万元）</td>
				<td class="FieldInput"><input type="text" name="fixedAssets" id="fixedAssets" maxlength="9" style="text-align:right" onchange="checkAssMon(this.id)"
					field="fixedAssets" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">受表彰情况</td>
				<td class="FieldInput" colspan="3"><textarea rows="5" name="受表彰情况" style="width: 60%" id="honours"
					onpropertychange="if(value.length>100) value=value.substr(0,100)" field="honours" ></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注</td>
				<td class="FieldInput" colspan="3"><textarea name="备注" field="note" id="note"
					onpropertychange="if(value.length>100) value=value.substr(0,100)" style="width: 60%"/> </td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>