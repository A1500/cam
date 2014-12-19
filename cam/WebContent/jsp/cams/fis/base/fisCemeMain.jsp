<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>殡葬首页</title>
<script type="text/javascript">
    var userId ='<%=GetBspInfo.getBspInfo().getUserId()%>';
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
</script>
<next:ScriptManager />
	<script type="text/javascript" src="../comm/common.js"></script>
	<script type="text/javascript" src="../comm/common_selectCity.js"></script>
	<script type="text/javascript" src="fisCemeMain.js"></script>
	<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
</head>
<body>
<model:datasets>
	<!-- 上报概要信息 -->
	<model:dataset id="fisImportDS"
		cmd="com.inspur.cams.fis.base.cmd.FisImportDataQueryCmd" global="true"
		pageSize="15" method="queryForCemeImport">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisImportData"></model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="editGridPanel"
	stripeRows="true" height="100%" width="100%" dataset="fisImportDS"
	clickToSelectedForChkSM="true" title="数据上报情况(红灯：超过3天未上报，黄灯：超过2天未上报，绿灯：正常上报)">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column id="UNIT_ID" header="亮灯类型" field="UNIT_ID" align="center" width="70" renderer="ldlxRenderer"/>
		<next:Column id="UNIT_NAME" header="单位" field="UNIT_NAME" width="170" renderer="detailHref" />
		<next:Column id="END_TIME" header="最近上报时间" field="END_TIME" align="center" width="100" />
		<next:Column id="DAY_DIFF" header="未上报天数" field="DAY_DIFF" align="right" width="90" />
		<next:Column id="DAY_DIFF2" header="上年安葬/安放量" field="DAY_DIFF2" align="right" width="110" renderer="testRenderer"/>
		<next:Column id="DAY_DIFF22" header="本年安葬/安放量" field="DAY_DIFF22" align="right" width="110" renderer="testRenderer"/>
		<next:Column id="DAY_DIFF23" header="差值" field="DAY_DIFF23" align="right" width="90" renderer="testRenderer"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisImportDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>