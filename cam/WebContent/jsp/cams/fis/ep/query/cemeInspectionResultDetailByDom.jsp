<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公墓年检统计报表</title>
<next:ScriptManager />
<script type="text/javascript">
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>'
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
	 var year='<%=request.getParameter("year")%>';
	 var xzqu='<%=request.getParameter("xzqu")%>';
	 var xz='<%=request.getParameter("xz")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="cemeInspectionResultDetailByDom.js"></script>
</head>
<body>
<model:datasets>
	<!-- 一站式救助报表统计 -->
	<model:dataset id="reportDataset"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand"
		method="queryForCheckReport" pageSize="-1">
		<model:record>
		
			<model:field name="CITYNAME" />
			<model:field name="CITYCODE" />
			<model:field name="TOTALNUM" />
			<model:field name="TOTALCHECKNUM" />
			<model:field name="UNDOCHECKNUM" />
			<model:field name="PASSNUM" />
			<model:field name="NOTPASSNUM" />
			<model:field name="FIRSTNOTPASSNUM" />
			<model:field name="FIRPASSNUM" />
			<model:field name="FIRNOTPASSNUM" />
			<model:field name="FIRNOTPASSNUM" />
			<model:field name="SECPASSNUM" />
			<model:field name="SECNOTPASSNUM" />
			<model:field name="PASSPER" />
			<model:field name="FIRPASSPER" />
			<model:field name="SECPASSPER" />
			<model:field name="IFSUM" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
	width="99.9%" stripeRows="true" height="100%" dataset="reportDataset">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="backToBefore" />
	</next:TopBar>
		<next:Columns>
		<next:RowNumberColumn width="20" />
		<next:Column id="domicileCode" header="所属行政区" field="CITYNAME" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="公墓总数" field="TOTALNUM" width="100" renderer="showDetailAllMsg" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="年检总数" field="TOTALCHECKNUM" width="100" renderer="showDetailCheckedMsg" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsPay" header="未年检数" renderer="showDetailunCheckedMsg" field="UNDOCHECKNUM"
			align="right" width="100"  align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumTotalExp" header="年检合格数" field="PASSNUM" renderer="showDetailQualifiedMsg"
			align="right" width="100"  >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsExp" header="年检不合格数" field="NOTPASSNUM" renderer="showDetailunQualifiedMsg"
			align="right" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumAssPay" header="整改" field="FIRSTNOTPASSNUM" renderer="showDetailfirstUnQualifiedMsg"
			align="right" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumPersonalPay" header="年检合格率" field="PASSPER"
			 align="right"  width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="num" header="初检合格数" field="FIRPASSNUM" width="70" renderer="showDetailfirstqQualifiedMsg"
			align="right" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="assFirPerNum" header="初检合格率" field="FIRPASSPER" 
			 align="right"  width="70" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="totalExpPerNum" header="复检合格数" align="right" renderer="showDetailsecondQualifiedMsg"
			field="SECPASSNUM" width="70" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column id="assPerNum" header="复检不合格数" field="SECNOTPASSNUM" renderer="showDetailsecondUnQualifiedMsg"
			align="right" width="80" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="personalPayPerNum" header="复检合格率" align="right"
		 field="SECPASSPER"  width="70" hidden="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
</next:GridPanel>
</body>
</html>