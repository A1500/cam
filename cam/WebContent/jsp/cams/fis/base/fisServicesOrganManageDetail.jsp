<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>服务机构信息</title>
<next:ScriptManager />
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="fisServicesOrganManageDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<script type="text/javascript">
	var method = "<%=request.getParameter("method")%>";
	var recordId = "<%=request.getParameter("recordId")%>";
</script>
</html>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesOrganManageQueryCmd"
		global="true" pageSize="15" sortField="unitId">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisServicesOrganManage"></model:record>
	</model:dataset>
	<!-- 性质 -->
	<model:dataset id="propertiesDataSet"
		enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!-- 级别 -->
	<model:dataset id="titleDataSet" enumName="FIS.FUNERALHOME.TITLE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 等级 -->
	<model:dataset id="gradeDataSet" enumName="FIS.FUNERALHOME.GRADE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="服务机构信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印" handler="print" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			class="L5form">
		<table border="1" width="100%" height="100%">

			<tr>
				<td class="FieldLabel" width="135">单位编号</td>
				<td class="FieldInput" colspan="3"><label type="text" name="单位编号" field="unitId" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="135">服务机构名称</td>
				<td class="FieldInput"><label type="text" name="服务机构名称" maxlength="50" field="unitName" /></td>
				
				<td class="FieldLabel" width="135">注册（或登记）单位</td>
				<td class="FieldInput" ><label type="text" name="注册（或登记）单位" field="organizer" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="135">主管单位</td>
				<td class="FieldInput">
					<label type="text"
					name="parentOrganName" id="parentOrganName" title="主管单位" field="parentOrganName"
					class="TextEditor" readonly="readonly" /> <label type="text"
					id="parentOrganCode" name="parentOrganCode" field="parentOrganCode" style="display: none;" />
					<button  style="cursor: hand" onclick="selectOrgan('parentOrganCode','parentOrganName')">选择</button>
						<font color="red">*</font></td>
				<td class="FieldLabel" width="135">所属行政区</td>
				<td class="FieldInput">
					<label type="text"
					name="areaName" id="areaName" title="所属行政区" field="areaName"
					class="TextEditor" readonly="readonly" /> <label type="text"
					id="areaCode" name="areaCode" field="areaCode" style="display: none;" />
					<button  style="cursor: hand" onclick="selectArea('areaCode','areaName')">选择</button></td>  
			</tr>
			<tr>
				<td class="FieldLabel">性质</td>
				<td class="FieldInput"><label name="properties" field="properties" dataset="propertiesDataSet"></label>
			</td>
				
				<td class="FieldLabel">级别</td>
				<td class="FieldInput"><label name="title" field="title" dataset="titleDataSet"></label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">法人代表</td>
				<td class="FieldInput"><label type="text" name="legalPeople" maxlength="36"
					field="legalPeople" /></td>
					
				<td class="FieldLabel">法人代表联系电话</td>
				<td class="FieldInput"><label type="text" id="legalPeoplePhone" name="legalPeoplePhone"  field="legalPeoplePhone" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">负责人</td>
				<td class="FieldInput"><label type="text" id="director" name="director" field="director" /></td>
					
				<td class="FieldLabel">负责人联系电话</td>
				<td class="FieldInput"><label type="text" id="directorPhone" name="directorPhone" field="directorPhone" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">占地面积(㎡)</td>
				<td class="FieldInput"><label type="text" name="占地面积" id="builtArea" maxlength="8" style="text-align:right" onchange="checkNum(this.id)"
					field="builtArea" /></td>
				<td class="FieldLabel">建筑面积(㎡)</td>
				<td class="FieldInput"><label type="text" name="建筑面积" id="builtTotalArea" maxlength="8" style="text-align:right" onchange="checkNum(this.id)"
					field="builtTotalArea" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">所在地址</td>
				<td class="FieldInput"><label type="text" name="address" maxlength="100"
					field="address" /></td>

				<td class="FieldLabel">邮政编码</td>
				<td class="FieldInput"><label type="text" name="portCode" maxlength="6"
					field="portCode" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">服务电话</td>
				<td class="FieldInput"><label type="text" name="servicePhone" maxlength="16"
					field="servicePhone" /></td>

				<td class="FieldLabel">网站网址</td>
				<td class="FieldInput"><label type="text" name="web" maxlength="50" 
					field="web" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">电子邮件地址</td>
				<td class="FieldInput"><label type="text" name="email" maxlength="50"
					field="email" /></td>

				<td class="FieldLabel">QQ群</td>
				<td class="FieldInput"><label type="text" name="qq" field="qq" maxlength="15"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">服务内容</td>
				<td class="FieldInput" colspan="3">
					<input type="checkbox" name="serviceScope" value="1"
						field="serviceScope" label="殡仪服务" disabled="disabled"/>殡仪服务 <br/>
					<input type="checkbox" name="serviceScope" value="2"
						field="serviceScope" label="骨灰寄存" disabled="disabled"/>骨灰寄存 <br/>
					<input type="checkbox" name="serviceScope" value="3"
						field="serviceScope" label="殡葬用品销售" disabled="disabled"/>殡葬用品销售 <br/>
					<input type="checkbox" name="serviceScope" value="4"
						field="serviceScope" label="骨灰安葬" disabled="disabled"/>骨灰安葬 <br/>
					<input type="checkbox" name="serviceScope" value="5"
						field="serviceScope" label="国际运尸" disabled="disabled"/>国际运尸
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">受表彰情况</td>
				<td class="FieldInput" colspan="3"><label name="受表彰情况" field="honours" ></label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">备注</td>
				<td class="FieldInput" colspan="3"><label name="备注" field="note" /></label>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>