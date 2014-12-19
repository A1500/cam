<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<head>
<next:ScriptManager />
<title>社会救助</title>
<link href="../summary/demo.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="map.js"></script>
<script type="text/javascript" src="../summary/externalInterface.js"></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="samAdminQuery.js"></script>
</head>
<body onresize="document.location.reload()">

<model:datasets>
	<model:dataset id="baseDS"        cmd="com.inspur.cams.drel.admin.cmd.SamAdminQueryCmd" pageAble="false" method="queryBaseFamilyCaseNow" global="true">
	</model:dataset>
	
	<model:dataset id="changeDS"      cmd="com.inspur.cams.drel.admin.cmd.SamAdminQueryCmd" pageAble="false" method="queryBaseChange" global="true">
	</model:dataset>
	
	<model:dataset id="monthchangeDS" cmd="com.inspur.cams.drel.admin.cmd.SamAdminQueryCmd" pageAble="false" method="queryBaseChangeByMonth" global="true">
	</model:dataset>
</model:datasets>
<div class="container">
	 <!-- 
    <div class="top-center-sam">
  		  <div class="top-center-sam-l">
 					<div class="easyui-panel top-left-t" data-options="title:'低保最近6个月的户数统计（单位：户）'" style="height:400px;">
						<div id="MarryChart"></div>	
				
					</div>
		  </div>
		  <div class="top-center-sam-r">	
 					<div class="easyui-panel top-left-t" data-options="title:'低保最近6个月的人数统计（单位：人）'" style="height:262px;">
						<div id="marryDiv"></div>	
					</div>
		  </div>
		  
	</div>
	 --> 
		<div class="top-botton-sam">	
			  <div class="easyui-panel top-left-t" data-options="title:'低保最近6个月的户数统计（单位：户）'" style="height:262px;">
				<div id="MarryChart"></div>
			  </div>	
		  </div>
	 	<div class="top-botton-sam">	
			  <div class="easyui-panel top-left-t" data-options="title:'低保最近6个月的人数统计（单位：人）'" style="height:262px;">
				<div id="marryDiv"></div>
			  </div>	
		  </div>
	<!-- 
		  <div class="top-botton-sam">	
			  <div class="easyui-panel top-left-t" data-options="title:'当前低保基本情况（单位：人、户、万元）'" style="height:200px;">
				<div id="nongcun"></div>
			  </div>	
		  </div>
		  <div class="top-botton-sam">	
			  <div class="easyui-panel top-left-t" data-options="title:'本月低保、五保变动情况（单位：户）'" style="height:200px;">
				  <div id="change"></div>
		      </div>	
		  </div>   
	 --> 
</div>
</body>
</html>
