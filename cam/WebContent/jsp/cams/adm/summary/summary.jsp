<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<next:ScriptManager />
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<title>辅助决策</title>
<%
	Calendar calendar = Calendar.getInstance();
	calendar.add(Calendar.DATE, -1);    //得到前一天
	String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy");
	String year=sdf.format(new Date());
	
%>
<link href="demo.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="externalInterface.js"></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="summaryCharts.js"></script>
<script type="text/javascript" src="summary.js"></script>
</head>

<body>

<model:datasets>
	<!-- 婚姻结婚离婚数量统计表 -->
	<model:dataset id="analysisDs" cmd="com.inspur.cams.marry.analysis.cmd.MarryAnalysisCmd" method="analysisMarry" global="true" ></model:dataset>
</model:datasets>
<model:datasets>
	<!-- 电子地图数据集-->
	<model:dataset id="cityMapDataSet" cmd="com.inspur.cams.marry.analysis.cmd.MarryAnalysisCmd" method="totalMarriageStatistics" global="true" ></model:dataset>
</model:datasets>

<div class="container">
	
  <div class="top" >
  	    <div class="top-right">
			  <div class="easyui-panel top-left-t" data-options="title:'过去六个月结婚/离婚对数折线图'" style="width:500px;height:300px; margin: 0 auto">
				<div id="MarryChart"></div>
			  </div>
			  <div class="easyui-panel top-right-t" data-options="title:'登记机关统计分析'" style="width:500px;height:230px; margin: 0 auto">
				<div id="marryDeptGridDiv"></div>
			  </div>
		  </div>
		  <div class="top-center" style="width:100%;">	
			  <div class="easyui-panel top-left-t" data-options="title:'婚姻登记(统计时间:<%=year  %>-01-01至<%=yestedayDate  %>)'" style="height:530px;">
				<div id="marryGridDiv"></div>	
			  </div>
		  </div>
  </div>
</div>

</body>
</html>
