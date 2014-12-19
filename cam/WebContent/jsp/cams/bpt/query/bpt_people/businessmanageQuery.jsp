<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>优抚业务办理统计查询</title>
<next:ScriptManager />
<script type="text/javascript" src="businessmanageQuery.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName="";
	
	var query_organCode="<%=request.getParameter("query_organCode")%>";
	var autoQuery = "<%=request.getParameter("autoQuery")%>"
	var startTime = "<%=request.getParameter("startTime")%>";
	var endTime="<%=request.getParameter("endTime")%>";
	var type = "<%=request.getParameter("type") == null?"":request.getParameter("type")%>";

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

	<!-- 伤残信息 -->
	<model:dataset id="BptBusinessManage"
		cmd="com.inspur.cams.bpt.query.cmd.BptPeopleQueryStatisticsCmd"
		method="queryBusinessManage" global="true" pageSize="100">
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
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	 
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE"
		autoLoad="true" global="true"></model:dataset>
		
	<!-- 优抚业务类别 -->
	<model:dataset id="ApplyDataset" enumName="APPLY.TYPE"
		  global="true" autoLoad="true" ></model:dataset>
	
	 

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
				<td class="FieldInput" ><input type="text" id="domicileName" style="width: 150"
					class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" /> <input
					type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" />
				</td>
				<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" style="width: 135" maxlength="18"/></td>
 
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">起止日期：</td>
				<td class="FieldInput" colspan="4" ><input type="text" id="cxsj_q"
						format="Y-m-d" style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_z" format="Y-m-d"
						style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
				<td class="FieldInput"  style="text-align: center"><button id="queryButton" onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="GridPanel" name="baseinfopeopleGrid" width="100%"
	stripeRows="true" height="100%" dataset="BptBusinessManage"
	title="优抚业务办理统计查询" notSelectFirstRow="true">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="chart"  text="导出" handler="emport"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn header="序号" width="35" />

		<next:Column id="full_name" header="所属行政区划" field="FULL_NAME" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="name" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" width="50"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="nation" header="民族" field="NATION" width="50"
			dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="140">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="birthday" header="出生日期" field="BIRTHDAY" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="domicileType" header="户籍类别" field="DOMICILE_TYPE"
			width="60" dataset="DomicileDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="serviceType" header="优抚业务类别" field="SERVICE_TYPE"  
			width="260" renderer="format">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>

	<next:BottomBar>
		<next:PagingToolBar dataset="BptBusinessManage" />
	</next:BottomBar>

</next:GridPanel>
</body>
</html>
