<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<head>
<next:ScriptManager />
<title>殡葬</title>
<link href="../summary/demo.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../summary/externalInterface.js"></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="fis4Adm.js"></script>
</head>

<body>
<model:datasets>
<!--殡葬总表-->
	<model:dataset id="fisCremationInfoSumDs"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationInfoSumQueryCommand" pageAble="false" global="true">
	</model:dataset>
	
<!--殡葬地图-->
	<model:dataset id="fisFuneralDeadInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd"
		method="queryDeadInfoSumByArea" pageAble="flase">
	</model:dataset>	
</model:datasets>
<div class="container">
	
  <div class="top">
		  <div class="top-center">
<!--用于左上角为swf加载慢的问题，多加一个不显示的swf-->
		  	<div class="easyui-panel top-center-top " data-options="tools:'#mapTool'" style="display: none;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="main3"
					width="100%" height="0"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../summary/Department.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../summary/Department.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main3" align="middle" play="true"
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
			  </div>
			  <div class="easyui-panel top-left-t" data-options="title:'殡仪服务单位本年情况统计'" style="height:555px;">
				<div id="nongcun"></div>
			  </div>
			  <!--div class="easyui-panel top-center-top " data-options="title:'火化量分年龄段统计',tools:'#mapTool'">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="main2"
					width="100%" height="450"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../summary/Department.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../summary/Department.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main2" align="middle" play="true"
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
			  </div-->	
		  </div>
  </div>
</div>
</body>
</html>
