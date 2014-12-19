
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>年检业务</title>
<next:ScriptManager />
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeNoProfitCheckFinalList.js"></script>
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
<!--查询需要进行年检的公益性公墓-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckWfQueryCommand"
		global="true" method="cemeNoProfitCheckQuery">
	</model:dataset>
	
	<model:dataset id="inspectionresultDataSet"
		enumName="FIS.CEME.INSPECTION.STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="resultDataSet"
		enumName="FIS.CEME.RESULT" autoLoad="true" global="true"></model:dataset>
    <model:dataset id="istakeproofDataSet"
		enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	
	<!-- 是否 -->
	<model:dataset id="fisYesOrNo" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 公墓性质 -->
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="99.9%" border="0"
	 autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">公墓编号:</td>
				<td class="FieldInput"><input type="text" id="cemeID"
					class="TextEditor" title="公墓编号" /></td>
				<td class="FieldLabel">所属行政区:</td>
				<td class="FieldInput"><input type="text"
					name="areaLevel" id="areaLevel" field="areaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="areaLevelId" field="areaLevelId" style="display: none;" /> 
					<button  style="cursor: hand" onclick="selectAreaNoDs()">选择</button></td>
			</tr>
			<tr>
				<td class="FieldLabel">主管单位:</td>
				<td class="FieldInput"><input type="text"
					name="manaLevel" id="manaLevel" field="manaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="manaLevelId" field="manaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectOrganNoDs()">选择</button>
					</td>
				<td class="FieldLabel">年检年份:</td>
				<td class="FieldInput"><input type="text" id="year"
					class="TextEditor" title="年检年份" value="2011" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" >上报状态:</td>
					<td class="FieldInput">
							<select id="isReportQ" onchange="directOrder()">
								<option value="1" >是</option>
								<option value="0" selected="selected">否</option>
							</select>
						</td>
				<td class="FieldLabel" colspan="2">
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

<next:GridPanel id="editGridPanel" name="inspectionGrid" width="99.9%" notSelectFirstRow="true"
	stripeRows="true" height="99.9%" dataset="ds">
	<next:TopBar>
		<next:ToolBarItem id="cemeTitle" text="需要进行年检的公益性公墓"/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="年检办理" iconCls="detail" handler="accepted" />
		<next:ToolBarItem id="a1" text="上报" iconCls="export" handler="report" />
		<next:ToolBarItem id="a2" text="整改" iconCls="export" handler="fullChange" />
		<next:ToolBarItem text="打印年检报告" iconCls="print" handler="print"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="applyId" header="业务编号" field="END_APPLY_ID" width="150"
			hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="wfId" header="流程编号" field="WF_ID" width="150"
			hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="cemeId" header="公墓编号" field="CEME_ID" width="120"
			hidden="false">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="公墓名称" field="CEME_NAME" width="150">
			<next:TextField />
		</next:Column>
		<next:Column header="年检年份" field="CHECK_YEAR" width="60" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="本年度年检次数" field="CHECK_NUM" width="100">
			<next:TextField />
		</next:Column>
		<next:Column header="年检状态" field="CHECK_NUM" renderer="rendenerCheckNum" width="70">
			<next:TextField />
		</next:Column>
		<next:Column header="本级年检结果" field="CHECK_RESULT" dataset="resultDataSet" width="90">
			<next:TextField />
		</next:Column>
		<next:Column header="上报状态" field="IS_REPORT" dataset="fisYesOrNo" width="70" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="主管单位" field="MANA_LEVEL" width="170">
			<next:TextField />
		</next:Column>
		<next:Column header="所属行政区" field="AREA_LEVEL">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
