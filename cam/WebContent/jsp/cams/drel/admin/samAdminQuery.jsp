<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<head>
<next:ScriptManager />
<title>辅助决策</title>
<link href="demo.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="externalInterface.js"></script>
<script type="text/javascript" src="map.js"></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
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
<div class="container">
	
  <div class="top">
  	  
		  <div class="top-right">
			  <div class="easyui-panel top-left-t" data-options="title:'城市低保'" style="height:155px;">
				<div id="chengshi"></div>	
			  </div>
			  <div class="easyui-panel top-left-t" data-options="title:'农村低保'" style="height:155px;">
				<div id="nongcun"></div>
			  </div>
			  
			  <div class="easyui-panel top-left-t" data-options="title:'优抚对象'" style="height:155px;">
				<div id="bptDiv"></div>
			  </div>	
			  <div class="easyui-panel top-left-t" data-options="title:'社会组织'" style="height:155px;">
				<div id="sorgGridDiv"></div>
			  </div>	
			  <div class="easyui-panel top-left-b" data-options="title:'婚姻登记'" style="height:155px;">
				<div id="marryGridDiv"></div>
			  </div>	
		  </div>
		  <div class="top-center">	
			  <div class="easyui-panel top-center-top " data-options="title:'电子地图',tools:'#mapTool'">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="main"
					width="100%" height="500"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="Department.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="Department.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" play="true"
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
			  </div>
			  <div class="top-center-bottom">
			    <div class="top-center-b-l">
  					<div class="easyui-panel" data-options="title:'结婚/离婚对数折线图'" style="height:262px;">
						<div id="MarryChart"></div>	
					
					</div>
				</div>
			    <div class="top-center-b-r">
  					<div class="easyui-panel" data-options="title:'结婚登记近十年趋势'" style="height:262px;">
						<div id="marryDiv"></div>	
					</div>
			    </div>
			  </div>
		  </div>
  </div>
</div>

<div id="mapTool">
	<div class="icon-hy" title="婚姻登记量分地区统计" onclick="showMarryDetail();"></div>
</div>
</body>
</html>
