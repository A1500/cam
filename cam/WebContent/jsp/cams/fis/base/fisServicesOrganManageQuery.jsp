<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>服务机构查询</title>
<next:ScriptManager />
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="fisServicesOrganManageQuery.js"></script>
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
			    <td class="FieldLabel" >性质:</td>
				<td class="FieldInput" >
					<select id="qProperties"> 
						<option dataset="propertiesDataSet"></option>
					</select>
				</td>
			</tr>
			<tr>
			    <td class="FieldLabel" >主管单位:</td>
				<td class="FieldInput" ><input type="text"
					name="manaLevel" id="manaLevel" field="manaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="manaLevelId" field="manaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectOrganNoDs()">选择</button></td>
				<td class="FieldLabel">所属行政区:</td>
				<td class="FieldInput"><input type="text"
					name="areaLevel" id="areaLevel" field="areaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="areaLevelId" field="areaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectAreaNoDs(1)">选择</button></td>
				<td class="FieldLabel" >级别:</td>
				<td class="FieldInput" >
					<select id="qTitle"> 
						<option dataset="titleDataSet"></option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">注册（或登记）单位:</td>
				<td class="FieldInput">
					<input type="text" id="qOrganizer" name="qOrganizer"/>
				</td>

				<td class="FieldLabel" colspan="4">
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
		<next:ToolBarItem text="导出" iconCls="export"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>

		<next:Column header="记录编号" field="recordId" width="90" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column header="单位编号" field="unitId" width="90" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="服务机构名称" field="unitName" width="160"
			renderer="showDetailsRendener" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="性质" field="properties"
			dataset="propertiesDataSet" width="80" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="法人代表" field="legalPeople" width="80" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="级别" field="title" dataset="titleDataSet"
			width="60" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="服务内容" field="serviceScope"
			width="110" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="受表彰情况" field="honours"
			width="80" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="主管单位" field="parentOrganName" width="90" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="注册（或登记）单位" field="organizer" width="150" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="所属行政区" field="areaName" width="200" align="center">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>