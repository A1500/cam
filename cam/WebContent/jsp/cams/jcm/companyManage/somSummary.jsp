<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<head>
<next:ScriptManager />
<title>辅助决策</title>
<link href="demo.css" rel="stylesheet" type="text/css" />
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="summary.js"></script>
</head>

<body onresize="document.location.reload()">

<div class="container">

  <div class="top">
		  <div class="top-center">
			  <div class="easyui-panel top-left-t" data-options="title:'社会组织全年增减情况图'" style="height:548px;">
				<div id="sorgYearCheckDiv"></div>
			  </div>
		  </div>
		  <!--
		  <div class="top-right">
			  <div class="easyui-panel top-right" data-options="title:'社会组织所属行（事）业统计图'"
					style="height:440px;">
					<div style="height: 40px;"></div>
					<div id="mapie" style="min-width: 250px; height: 250px; margin: 0 auto"></div>
				</div>
		  </div>
		  <div class="top-center">
			  <div class="easyui-panel top-left-t" data-options="title:'全省社会组织数量图'" style="height:440px;">
				<div id="sorgNumDiv"></div>
			  </div>
		  </div>
		  -->
  </div>
</div>
</body>
</html>
