<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<next:ScriptManager />
<LINK rel=stylesheet type=text/css
	href="<%=request.getContextPath()%>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../../../../../jsp/cams/adm/summary/externalInterface.js"></script>

<script type="text/javascript"
	src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js"></script>
<style type="text/css">
body { font-family:Verdana; font-size:14px; margin:0;}
.container {margin:0 auto; width:100%;}
.top{margin-bottom:5px;}

.top-center-top { height:400px; }
.top-center-t-l { float:right; width:30%; height:400px;}
.top-center-t-r { width:100%;}
	
.top-center-bottom { height:300px;}
.top-center-b-l { float:right; width:30%; height:300px;}
.top-center-b-r { width:100%;}
</style>
</head>
<body>
	<div class="container">
		<div class="top">
				<div class="top-center-top">
					<div class="top-center-t-l">
						<div class="easyui-panel" data-options="title:'上2'"
							style="height: 400px;">
							<div id="m2"></div>
						</div>
					</div>
					<div class="top-center-t-r">
						<div class="easyui-panel" data-options="title:'地图'"
							style="height: 400px;">
							<div id="shf3">
								<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
									id="main" width="100%" height="369"
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
						</div>
					</div>
				</div>
				
				<div class="top-center-bottom">
					<div class="top-center-b-l">
						<div class="easyui-panel" data-options="title:'1'"
							style="height: 300px;">
							<div id="marryDiv"></div>
						</div>
					</div>
					<div class="top-center-b-l">
						<div class="easyui-panel" data-options="title:'2'"
							style="height: 300px;">
							<div id="shflDiv"></div>
						</div>
					</div>
					<div class="top-center-b-r">
						<div class="easyui-panel" data-options="title:'3'"
							style="height: 300px;">
							<div id="shflDiv2"></div>
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
</html>