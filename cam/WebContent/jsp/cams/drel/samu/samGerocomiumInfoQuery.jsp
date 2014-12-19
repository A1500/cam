<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>敬老院基础信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samGerocomiumInfoQuery.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript">
		 	<%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="samGerocomiumInfoDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGerocomiumInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGerocomiumInfo"/>
	</model:dataset>
	<!-- 敬老院等级 -->
	<model:dataset id="gerocomiumLevelDataset"
		enumName="SAM_GEROCOMIUM_LEVEL" autoLoad="true" global="true"></model:dataset>
		<!-- 房屋性质 -->
	<model:dataset id="housePropertyDataset"
		enumName="SAM_HOUSE_PROPERTY" autoLoad="true" global="true"></model:dataset>
		<!-- 取暖方式 -->
	<model:dataset id="heatingWayDataset"
		enumName="SAM_HEATING_WAY" autoLoad="true" global="true"></model:dataset>
		<!-- yes or no -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">所属行政区划</td>
					<td class="FieldInput" style="width:20%"><input type="text"
						name="所属行政区划" id="areaLevel" field="areaLevel" maxlength="50"
						style="width: 80%" readonly="readonly"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForAreaSelect()" /> <input
						type="text" id="areaLevelId" name="areaLevelId" field="areaLevelId"
						style="display: none" /></td>
					<td class="FieldLabel" style="width:10%">敬老院名称</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="gerocomiumName" style="width:80%"/>
					<td class="FieldLabel" style="width:10%">建院时间</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="startMonth" format="Y-m"  onclick="setmonth(this)" style="width:40%" readonly="readonly"/>
		                        至<input type="text" id="endMonth" format="Y-m"  onclick="setmonth(this)" style="width:40%" readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">主管单位名称</td>
					<td class="FieldInput" style="width:20%"><input type="text"
						name="所属行政区划" id="manaLevel" field="manaLevel" maxlength="50"
						style="width: 80%" readonly="readonly"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForManaSelect()" /> <input
						type="text" id="manaLevelId" name="manaLevelId" field="manaLevelId"
						style="display: none" /></td>
					<td class="FieldLabel" style="width:10%">法人代表</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="legelPeople" style="width:80%"/>
					<td class="FieldLabel" style="width:10%"></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="samGerocomiumInfoDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem  text="敬老院信息列表" ></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看历史明细" handler="detailAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="year" header="年份" sortable="false"/>
		<next:Column field="gerocomiumName" header="名称" sortable="false"/>
		<next:Column field="establishDate" header="建院时间" sortable="false"/>
		<next:Column field="manaLevel" header="主管单位名称" sortable="false"/>
		<next:Column field="areaLevel" header="所属行政区划" sortable="false"/>
		<next:Column field="legelPeople" header="法人代表" sortable="false"/>
		<next:Column field="gerocomiumLevel" header="等级" dataset="gerocomiumLevelDataset" sortable="false"/>
		<next:Column field="totalArea" header="占地面积" sortable="false"/>
		<next:Column field="buildArea" header="建筑面积" sortable="false"/>
		<next:Column field="outdoorArea" header="室外娱乐场所面积" sortable="false"/>
		<next:Column field="indoorArea" header="室内娱乐场所面积" sortable="false"/>
		<next:Column field="fixedAssets" header="固定资产" sortable="false"/>
		<next:Column field="supportStandard" header="五保对象供养标准" sortable="false"/>
		<next:Column field="managementFunds" header="管理工作经费" sortable="false"/>
		<next:Column field="yearSidelineIncome" header="年副业收入" sortable="false"/>
		<next:Column field="contactPhone" header="联系电话" sortable="false"/>
		<next:Column field="location" header="所在地址" sortable="false"/>
		<next:Column field="houseProperty" header="房屋性质" dataset="housePropertyDataset" sortable="false"/>
		<next:Column field="serveTowns" header="所服务乡镇" sortable="false"/>
		<next:Column field="heatingWay" header="取暖方式" dataset="heatingWayDataset" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samGerocomiumInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>