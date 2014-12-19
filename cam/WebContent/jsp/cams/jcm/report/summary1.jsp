<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<next:ScriptManager />
<script type="text/javascript">
	var organCode = '<%=request.getParameter("organCode")%>';
	var year='<%=request.getParameter("year")%>';
	var companyType='<%=request.getParameter("companyType")%>';
</script>
<title>年度工作经费</title>
<%
	Calendar calendar = Calendar.getInstance();
	calendar.add(Calendar.DATE, -1);    //得到前一天
	String  yestedayDate = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy");
	String year=sdf.format(new Date());
	
%>
<link href="demo.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="summary1.js"></script>
</head>

<body>

<model:datasets>
	<!-- 该单位年度经费统计表 -->
	<model:dataset id="analysisDs" cmd="com.inspur.cams.jcm.cmd.JcmCompanyMoneyQueryCmd" method="analysisMoney1" global="true" ></model:dataset>
</model:datasets>
<div class="container">
	
  <div class="top" >
  	    <div class="top-right">
			  <div class="easyui-panel top-left-t" data-options="title:'该年度工作经费柱形图'" style="width:1140px;height:300px; margin: 0 auto">
				<div id="MarryChart"></div>
			  </div>
		</div>
  </div>
</div>

</body>
</html>
