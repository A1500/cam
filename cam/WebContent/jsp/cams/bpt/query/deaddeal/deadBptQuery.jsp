<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<head>
<next:ScriptManager />
<title></title>
<script type="text/javascript">
var organCode="";
if('<%=request.getParameter("organCode")%>'==''){
	organCode='<%=request.getParameter("organCode")%>';
	
}else {
	organCode='<%=BspUtil.getOrganCode()%>';
}
</script>
<script type="text/javascript"
	src="../../../../../jsp/cams/adm/summary/externalInterface.js"></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>

<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="deadBptQuery.js"></script>



<style type="text/css">
body { font-family:Verdana; font-size:14px; margin:0;}
.container {margin:0 auto; width:100%;}
.top{margin-bottom:0px; }

.top-center-b-r {  height:620px;}
.top-center-b-l { float:left; width:30%;height:620px;}

</style>
</head>

<body>

<model:datasets>
	
	<model:dataset id="bymonthds" cmd="com.inspur.cams.bpt.query.cmd.DeadBptObjectQueryCmd" pageAble="false" method="queryDeadBptObjectByMonth" global="true">
		<model:record>
			<model:field name="d3num" type="string" />
			<model:field name="d6num" type="string" />
			<model:field name="d9num" type="string" />
			<model:field name="d12num" type="string" />
			<model:field name="dsnum" type="string" />
		</model:record>
	</model:dataset>
	
</model:datasets>
<div class="container">
	
  <div class="top">
	  <div class="top-center-b-l">
		<div class="easyui-panel" data-options="title:'分去世时长统计'"  >
			<div id="chart" style="height: 600px; margin: 0 auto"></div>
	
		</div>
	</div>
	  <div class="top-center-b-r">
			<div class="easyui-panel" data-options="title:'分地区分类别统计'"  >
				<div id="change" style="height: 600px;">
				</div>
			</div>
		</div>
  </div>
</div>
</body>
</html>
