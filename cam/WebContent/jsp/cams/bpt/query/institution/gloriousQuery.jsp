<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>光荣院发展情况统计表</title>
<next:ScriptManager />
<script type="text/javascript" src="gloriousQuery.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName="";
	
	var query_organCode="<%=request.getParameter("query_organCode")%>";
	var autoQuery = "<%=request.getParameter("autoQuery")%>"
	var cxsj="<%=request.getParameter("cxsj")%>";
	var buildState = "<%=ifNull(request.getParameter("buildState"))%>";
	var buildingapproach = "<%=ifNull(request.getParameter("buildingapproach"))%>";
	var approval = "<%=ifNull(request.getParameter("approval"))%>";
	var prepareNum = "<%=ifNull(request.getParameter("prepareNum"))%>";
	var bedNum = "<%=ifNull(request.getParameter("bedNum"))%>";
	var totalFunds = "<%=ifNull(request.getParameter("totalFunds"))%>";
	var countyfunds = "<%=ifNull(request.getParameter("countyfunds"))%>";
	var cityfunds = "<%=ifNull(request.getParameter("cityfunds"))%>";
	var aboveCityfunds = "<%=ifNull(request.getParameter("aboveCityfunds"))%>";
	var specialassistance = "<%=ifNull(request.getParameter("specialassistance"))%>";
	var otherNum = "<%=ifNull(request.getParameter("otherNum"))%>";
	var careRotation = "<%=ifNull(request.getParameter("careRotation"))%>";
	var gloryroom = "<%=ifNull(request.getParameter("gloryroom"))%>";
	var carePeople = "<%=ifNull(request.getParameter("carePeople"))%>";

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
<%!
	//是否为空
	String ifNull(String val){
		return val!=null?val:"";
	}
%>		
		
</head>
<body>
<model:datasets>
	<!-- 光荣院信息 -->
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousInstituteQueryCommand" method="queryGlorious" global="true">
	</model:dataset>
	<!-- 建设状况 -->
	<model:dataset id="buildstatedataset" enumName="BPT.BUILDSTATE" autoLoad="true" global="true"></model:dataset>
	<!-- 建设方式 -->
	<model:dataset id="buildingApproach" enumName="BPT.BUILDINGAPPROACH.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 有无编委批文-->
	<model:dataset id="approvaldataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
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
				<td class="FieldLabel" nowrap="nowrap">属地行政区划：</td>
				<td class="FieldInput" >
					<input type="text" id="domicileName" style="width:150" class="TextEditor" onclick="query_selectDomicile()" /> 
					<input type="hidden" id="domicileCode" class="TextEditor"  />
				</td>
				<td class="FieldLabel">光荣院名称：</td>
				<td class="FieldInput"><input type="text" id="unitFullname" style="width:150" /></td>
				<td class="FieldLabel" >建设状况：</td>
				<td class="FieldInput">
					<select id="buildState" style="width:150">
						<option dataset="buildstatedataset"></option>
					</select>
				</td>
				<td class="FieldButton"><button id="queryButton" onclick="query()">查 询</button></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">查询年份：</td>
				<td class="FieldInput" >
					<input type="text" id="cxsj" format="Y" style="width: 100px;" maxlength="4" /><img src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
				</td>
				<td class="FieldLabel">建设方式：</td>
				<td class="FieldInput">
					<select id="buildingapproach" style="width:150">
						<option dataset="buildingApproach"/>
					</select>
				</td>
				<td class="FieldLabel">有无编委批文：</td>
				<td class="FieldInput">
					<select id="approval" style="width:150">
						<option dataset="approvaldataset"></option>
					</select>
				</td>
				<td class="FieldButton"><button onclick="reset()">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="GridPanel" name="baseinfopeopleGrid" width="100%"
	stripeRows="true" height="100%" dataset="ds"
	title="光荣院信息" notSelectFirstRow="true">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="chart"  text="导出Excel" handler="excel_export"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn header="序号" width="35" />
		<next:Column header="属地行政区划" field="name" align="center" width="170">
			<next:TextField allowBlank="false" />
		</next:Column>	
		<next:Column header="光荣院名称" field="unitFullname" align="center" width="170">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="年度" field="years" align="center" width="70">
			<next:TextField allowBlank="false" />
		</next:Column>		
		<next:Column header="建立日期" field="creationDate" align="center" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>		
		<next:Column header="建设状况" field="buildState" align="center" width="95" dataset="buildstatedataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="建设方式" field="buildingapproach" align="center" width="70" dataset="buildingApproach"> 
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="有无编委批文" field="approval" align="center" width="90" dataset="approvaldataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="编制人数" field="prepareNum" align="center" width="65">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="床位数" field="bedNum" align="center" width="65">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="总计投入（万元）" field="totalFunds" align="right" width="110">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="县级投入（万元）" field="countyfunds" align="right" width="110">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="市级投入（万元）" field="cityfunds" align="right" width="110">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="省级投入（万元）" field="provincefunds" align="right" width="110">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="中央投入（万元）" field="centralFunds" align="right" width="110">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="市级以上投入（万元）" field="aboveCityfunds" align="right" width="135">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="孤老优抚对象（人）" field="specialassistance"align="center" width="120">
			<next:TextField />
		</next:Column>
		<next:Column header="其他优抚对象（人）" field="otherNum" align="center" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="轮养（人次）" field="careRotation" align="center" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="敬老院光荣间（间）" field="gloryroom" align="center" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="在敬老院孤老优抚对象（人）" field="carePeople" align="center" width="175">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>

</next:GridPanel>
</body>
</html>
