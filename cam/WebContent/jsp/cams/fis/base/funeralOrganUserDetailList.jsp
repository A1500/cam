
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>殡仪馆查询</title>
<next:ScriptManager />
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="funeralOrganUserDetailList.js"></script>
<script>
        var orgCode ='<%=BspUtil.getParentOrgan().getOrganCode()%>';
		var orgName ='<%=BspUtil.getParentOrgan().getOrganName()%>';
       </script>
<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd" global="true" pageSize="10" sortField="unitId">
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
	<!-- 等级 -->
	<model:dataset id="gradeDs" enumName="FIS.MANA.LEVEL"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="99.9%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件 
				<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" />
			</legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">殡仪馆编号:</td>
				<td class="FieldInput"><input type="text" id="queryUnitId" /></td>
				<td class="FieldLabel">殡仪馆名称:</td>
				<td class="FieldInput"><input type="text" id="queryUnitName" /></td>
			    <td class="FieldLabel" >主管单位:</td>
				<td class="FieldInput" ><input type="text"
					name="manaLevel" id="manaLevel" field="manaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="manaLevelId" field="manaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectOrganNoDs()">选择</button></td>
			</tr>
			<tr>
			    <td class="FieldLabel" >性质:</td>
				<td class="FieldInput" >
					<select id="qProperties"> 
						<option dataset="propertiesDataSet"></option>
					</select>
				</td>
				<td class="FieldLabel" >级别:</td>
				<td class="FieldInput" >
					<select id="qTitle"> 
						<option dataset="titleDataSet"></option>
					</select>
				</td>
				<td class="FieldLabel">所属行政区:</td>
				<td class="FieldInput"><input type="text"
					name="areaLevel" id="areaLevel" field="areaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="areaLevelId" field="areaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectAreaNoDs(1)">选择</button></td>
			</tr>
			<tr>
			    <td class="FieldLabel" >殡葬改革示范单位:</td>
				<td class="FieldInput" >
					<select id="qDemonUnit"> 
						<option dataset="demonUnitDataSet"></option>
					</select>
				</td>
				<td class="FieldLabel">等级:</td>
				<td class="FieldInput">
					<select id="qGrade"> 
						<option dataset="gradeDataSet"></option>
					</select>
				</td>
				<td class="FieldLabel">成立时间:</td>
				<td class="FieldInput">
				<input type="text" id="qGestionTimeFrom" format="Y-m-d" name="qGestionTimeFrom" onclick="LoushangDate(this)"/>
				至
				<input type="text" id="qGestionTimeTo" format="Y-m-d" name="qGestionTimeTo" onclick="LoushangDate(this)"/>
				</td>
			</tr>
			<tr>
			    <td class="FieldLabel">主管单位等级:</td>
				<td class="FieldInput" colspan="5">
					<select id="qManaGrade"> 
						<option dataset="gradeDs"></option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="6">
					<button onclick="query()">查 询</button>
					&nbsp;
					<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="fiscemeGrid" width="99.9%" stripeRows="true" height="100%" dataset="ds" clickToSelectedForChkSM="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text=""></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail" />
		<next:ToolBarItem text="导出" iconCls="export"  handler="excel_click"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="殡仪馆编号" field="unitId" width="90">
			<next:TextField />
		</next:Column>
		<next:Column header="殡仪馆名称" field="unitName" width="160" renderer="showDetailsRendener">
			<next:TextField />
		</next:Column>
		<next:Column header="性质" field="properties" dataset="propertiesDataSet" width="80" >
			<next:TextField />
		</next:Column>
		<next:Column header="法人代表" field="legalPeople" width="80" >
			<next:TextField />
		</next:Column>
		<next:Column header="成立时间" field="gestionTime" width="80" >
			<next:TextField />
		</next:Column>
		<next:Column header="级别" field="title" dataset="titleDataSet" width="60" >
			<next:TextField />
		</next:Column>
		<next:Column header="殡葬改革示范单位" field="demonUnit" dataset="demonUnitDataSet" width="110" >
			<next:TextField />
		</next:Column>
		<next:Column header="等级" field="grade" dataset="gradeDataSet" width="80" >
			<next:TextField />
		</next:Column>
		<next:Column header="主管单位" field="parentOrganName" width="100">
			<next:TextField />
		</next:Column>
		<next:Column header="所属行政区" field="areaName" width="250">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
