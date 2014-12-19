<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script type="text/javascript">
	var user = '<%=GetBspInfo.getBspInfo().getUserId()%>'
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>在乡复员军人导入</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
		<script type="text/javascript" src="ErrMessage.js"></script>
	</head>
<body>
<model:datasets>
	
	<!-- 在乡复员军人错误 -->
	<model:dataset id="DemobilizedErrDataset"
		cmd="com.inspur.cams.bpt.excelToTable.ExcelToTableQueryCommand" global="true"
		 method="queryErrData" pageSize="100">
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
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="indb" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="isvaildate" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="isrepeat" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="baseGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true" dataset="DemobilizedErrDataset" notSelectFirstRow="true" autoExpandColumn="ERROR_MESSAGE">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem handler="errExp" iconCls="chart" text="错误导出" ></next:ToolBarItem>
		<next:ToolBarItem handler="downTemplate" iconCls="import" text="导入模版下载" ></next:ToolBarItem>
		<next:ToolBarItem handler="into" iconCls="save" text="导入Excel" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		
		<next:Column id="ROW_NUM" header="在Excel中行数" field="ROW_NUM" width="100" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id='NAME' header='姓名' field='NAME' width='60' >
			<next:TextField allowBlank='false' />
		</next:Column>
		
		<next:Column id='ID_CARD' header='身份证号' field='ID_CARD' width='140' >
			<next:TextField allowBlank='false' />
		</next:Column>
		<next:Column id='ERROR_MESSAGE' header='错误信息' field='ERROR_MESSAGE' width='800' valueTip="true">
			<next:TextField allowBlank='false' />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="DemobilizedErrDataset"/>
	</next:BottomBar>
</next:GridPanel>

</body>
</html>
