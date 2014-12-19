<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>残疾军人伤残器械发放查询</title>
<next:ScriptManager />

<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName="";
	
	var query_organCode="<%=request.getParameter("organCode")%>";
	var autoQuery = "<%=request.getParameter("autoQuery")%>"
	var startTime = '<%=request.getParameter("startTime") == null?"":request.getParameter("startTime")%>';
	var endTime="<%=request.getParameter("endTime")%>";
	var query_timeType='<%=request.getParameter("timeType")%>';
	var assDevicesType = '<%=request.getParameter("assDevicesType")%>';

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
		<script type="text/javascript" src="disabilityAssDevicesNew.js"></script>
		
</head>
<body>
<model:datasets>

	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet"
		cmd="com.inspur.cams.bpt.query.cmd.BptPeopleQueryStatisticsCmd"
		method="queryAssDevicesLater" global="true" pageSize="100">
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 伤残器械类别 -->
	<model:dataset id="assDevicesDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BPT_ASSISTIVE_DEVICES_MAINTENA'></model:param>
			<model:param name="value" value='APPLY_APPARATUS_ID'></model:param>
			<model:param name="text" value='APPARATUS_NAME'></model:param>
			<model:param name="filterSql" value='IS_EFFICIENT=1 and LEVE=2'></model:param>
		</model:params>
	</model:dataset>
	
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	 
	 
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE"
		autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel name="form" width="100%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>"
			onclick="collapse(this)" /></legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
				<td class="FieldInput" ><input type="text" id="domicileName" 
					class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" /> <input
					type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" />
				</td>
				<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" style="width:135px;" /></td>
				<td  align="center"><button id="queryButton" onclick="query()">查 询</button></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>器械类别：</td>
				<td class="FieldInput"><select id="assDevicesType"
					 title="器械类别">
					<option dataset="assDevicesDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap>配置类别：</td>
				<td class="FieldInput"><select id="configuration"
					 title="配置类别">
					<option value='0'>配置</option>
					<option value='1'>维修</option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">批准日期：</td>
					<td  nowrap="nowrap" style="background-color: #f5fafa;text-align: left;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="timeType" style="width:80px;" onchange="showTime()">
					<option value="2">截止日期</option>
					<option value="1">起止日期</option>
					</select>  
					<span  id ="times" style="display: none;" ><input type="text" id="cxsj_qs"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_zs" format="Y-m-d"
						style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</span>
					<span  id = "time" ><input type="text" id="cxsj_z"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</span>
					<td  align="center"><button onclick="reset()">重 置</button></td>
				</tr>	
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="disbilityGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true"  dataset="BptPeopleDisabilityDataSet" title="残疾军人伤残器械发放列表" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="chart"  text="导出" handler="export_excel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="FULL_NAME" width="240">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="NAME" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="ID_CARD" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="SEX" header="性别" field="SEX" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="NATION" header="民族" field="NATION" width="70" dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectState" header="优抚对象状态" field="DISABILITY_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="disabilityLevelCode" header="伤残等级" field="DISABILITY_LEVEL_CODE" width="60" dataset="DisabilityLevelDataset">
			<next:TextField  />
		</next:Column>
		<next:Column id="disabilityCaseCode" header="伤残性质" field="DISABILITY_CASE_CODE" width="90" dataset="DisabilityCaseDataset">
			<next:TextField  />
		</next:Column>
		<next:Column id="disabilityNo" header="证书编号" field="DISABILITY_NO" width="90">
			<next:TextField  />
		</next:Column>	
		<next:Column id="apparatus_name" header="伤残器械名称" field="APPARATUS_NAME" width="120">
			<next:TextField  />
		</next:Column>	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BptPeopleDisabilityDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
