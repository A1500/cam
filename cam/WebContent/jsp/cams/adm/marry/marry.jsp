<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<head>
<next:ScriptManager />
<title>辅助决策</title>
<link href="demo.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="externalInterface.js"></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath() %>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js" ></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js" ></script>
<script type="text/javascript" src="summaryCharts.js"></script>
</head>

<body  style="margin:0 auto;text-align:center" >
<div class="container" style="width:1666px">
	
  <div class="top">
  	  <div class="top-left">
  	  		  <div style="display: none;">
  	  		  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/60num.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/60num.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" play="true"
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
  	  		  </div>
			  <div class="easyui-panel top-left-t " data-options="title:'60岁以上老人结婚登记数量趋势分析'" style="height:278px;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/60num.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/60num.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" play="true"
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
			  </div>
			  <div class="easyui-panel top-left-c"  data-options="title:'60岁以上老人结婚登记地区对比分析'"  style="height:278px;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/60area.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/60area.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
			  </div>
			  <div class="easyui-panel top-left-b"  data-options="title:'结婚年龄段分析'" style="height:278px;">
				 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/marryAge.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/marryAge.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>
			   <div class="easyui-panel top-left-b"  data-options="title:'离婚年龄段分析'" style="height:278px;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/liAge.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/liAge.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>
  	  </div>
		  <div class="top-right">
			  <div class="easyui-panel top-left-t" data-options="title:'女性结婚年龄趋势分析'" style="height:278px;">
			  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/girlAge.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/girlAge.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
					
			  </div>
			  <div class="easyui-panel top-left-c" data-options="title:'女性结婚年龄地区对比分析'" style="height:278px;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/girlArea.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/girlArea.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>
			  <div class="easyui-panel top-left-b" data-options="title:'结婚年龄差分析'" style="height:278px;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/marryAgeCha.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/marryAgeCha.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>	
			  <div class="easyui-panel top-left-b" data-options="title:'离婚原因统计分析'" style="height:278px;">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="250"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/liReason.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/liReason.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>	
		  </div>
		  <div class="top-center">	
			  <div class="easyui-panel top-center-top " data-options="title:'结婚登记日峰值分析'">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="325"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/marryTop.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/marryTop.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>
			  </div>
			   <div class="easyui-panel  top-center-bottom"  data-options="title:'离婚登记数量趋势分析'">
			 	 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="320"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/liNum.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/liNum.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>
			  <div class="easyui-panel  top-center-bottom"  data-options="title:'离婚率趋势分析'">
			 	 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					width="100%" height="325"
					codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
					<param name="movie" value="../swf/liPie.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#869ca7" />
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="../swf/liPie.swf" quality="high" bgcolor="#869ca7"
						width="100%" height="100%" name="main" align="middle" 
						loop="false" quality="high" allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer">
					</embed>
				</object>	
			  </div>
		  </div>
  </div>
</div>
</body>
</html>
