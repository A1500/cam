<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<head>
<title>辅助决策</title>
<link href="demo.css" rel="stylesheet" type="text/css" />
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="demo.js"></script>
</head>

<body>
<div class="container">
	
  <div class="top">
  	  <div class="top-left">
			  <div class="easyui-panel top-left-t " data-options="title:'社会组织列表条状图'">top-left-top</div>
			  <div class="easyui-panel top-left-c"  data-options="title:'退役士兵三类列表'">to-left-center</div>
			  <div class="easyui-panel top-left-b"  data-options="title:'救灾资金使用情况近六个月走势'">top-left-bottom</div>
  	  </div>
		  <div class="top-right">
			  <div class="easyui-panel top-left-t" data-options="title:'城市低保'">top-right-top</div>
			  <div class="easyui-panel top-left-c" data-options="title:'农村低保'">top-right-center</div>
			  <div class="easyui-panel top-left-b" data-options="title:'农村五保'">top-left-bottom</div>	
		  </div>
		  <div class="top-center">	
			  <div class="easyui-panel top-center-top " data-options="title:'当前累计结婚/离婚对数电子地图'">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="main"
					width="100%" height="600px"
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
  					<div class="easyui-panel" data-options="title:'结婚/离婚/出具证明量柱状图'">center-right</div>
				</div>
			    <div class="top-center-b-r">
  					<div class="easyui-panel" data-options="title:'社会福利单位环状图'">center-right</div>
			    </div>
			  </div>
		  </div>
  </div>
  <div class="center">
  	<div class="center-right">
  		<div class="easyui-panel" data-options="title:'殡葬本年火化/安葬/安放数、火化率列表'">center-right</div>
  	</div>
  	<div class=" center-left">
  	 <div class="easyui-panel" data-options="title:'优抚对象数量列表'">center-left</div>
  	</div>
   </div>
  <div class="easyui-panel bottom"  data-options="title:'行政区划统计表'">bottom</div>
</div>
</body>
</html>
