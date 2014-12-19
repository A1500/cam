<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>参战参试抚恤统计表</title>
<next:ScriptManager />
<script type="text/javascript" src="testWarQueryStatistics.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
		 	 //查询条件打开合并函数
		 	 var organCode = '<%=BspUtil.getOrganCode()%>';
		 	 var query_organCode="<%=request.getParameter("query_organCode")%>";
			var autoQuery = "<%=request.getParameter("autoQuery")%>"
			var startTime = "<%=request.getParameter("startTime")%>";
			var endTime="<%=request.getParameter("endTime")%>";
		 	var serviceType = "<%=request.getParameter("serviceType")%>"; 
		 	 
		 	 
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
	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet"
		cmd="com.inspur.cams.bpt.query.cmd.BptPeopleQueryStatisticsCmd" method="queryWarTested"
		global="true" pageSize="100">
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
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象 -->
	<model:dataset id="ObjectDataset" enumName="OBJECT.TYPE.PART"
		autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	
	<!--参战类别代码-->
	<model:dataset id="dsWarData" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>

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
				<td class="FieldInput"><input type="text" id="domicileName" 
					class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" /> <input
					type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" />
				</td>
				<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><input type="text" id="name" 
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
				<td class="FieldInput"  ><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">户籍类别：</td>
				<td class="FieldInput"><select id="domicileType" >
					<option dataset="DomicileDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">证书编号：</td>
				<td class="FieldInput"><input type="text" id="demobilizedno" 
					class="TextEditor" title="证书编号" /></td>
				<td class="FieldLabel" nowrap="nowrap">发放起止日期：</td>
				<td class="FieldInput"><input type="text" id="cxsj_q"
						format="Y-m-d" style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_z" format="Y-m-d"
						style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
				<td class="FieldInput"><select id="demobilizedState">
					<option dataset="ObjectStateDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
				<td>
					<select id="serviceType">
						<option value="0">请选择</option>
						<option value="51">参战</option>
						<option value="61">参试</option>
					</select>
				</td>
				<td class="FieldInput" colspan="2">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button id="queryButton" onclick="query()">查 询</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button onclick="set()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="GridPanel" name="baseinfopeopleGrid" width="100%"
	stripeRows="true" height="100%" dataset="BptPeopleDisabilityDataSet"
	title="参战参试人员信息" notSelectFirstRow="true">
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="chart"  text="导出Excel" handler="toExcel"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn header="序号" width="35" />

		<next:Column id="name" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" width="35"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="IDCARD" width="140">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sex" header="出生日期" field="BIRTHDAY" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="domicileType" header="户籍类别" field="DOMICILETYPE"
			width="60" dataset="DomicileDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="domicileType" header="户口地址" field="ADDRESS"
			width="140">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="disabilityStateCode" header="工作单位" field="WORKUNIT"
			width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="disabilityNo" header="证书编号" field="DEMOBILIZEDNO"
			width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="disabilityStateCode" header="参保类型" field="SAFEGUARD"
			width="60"  dataset="SafeguardDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="disabilityStateCode" header="医疗保险证号" field="MEDICAL"
			width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="disabilityStateCode" header="类别" field="WARTYPE" dataset="ObjectDataset"
			width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="disabilityStateCode" header="参战类别" field="WARCODE" dataset="dsWarData"
			width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="disabilityStateCode" header="参试类别" field="TESTCODE" dataset="dsTest"
			width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="disabilityWarCode" header="抚恤金额(元)" field="MOUN"align="right"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="note" header="备注"  field="NOTE" width="90">
			<next:TextField />
		</next:Column>

	</next:Columns>

	<next:BottomBar>
		<next:PagingToolBar dataset="BptPeopleDisabilityDataSet" />
	</next:BottomBar>

</next:GridPanel>
</body>
</html>
