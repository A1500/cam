<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<next:ScriptManager />
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath()%>/skins/js/easyui/themes/default/easyui.css">
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/chart/HighCharts/jquery.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.jsonpost.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.datagridAp.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/skins/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../../../../jsp/cams/adm/summary/externalInterface.js"></script>

<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/highcharts.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getSkinPath(request)%>/chart/HighCharts/hcommon.js"></script>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<script type="text/javascript" src="bptmain.js"></script>

<style type="text/css">
body { font-family:Verdana; font-size:14px; margin:0;}
.container {margin:0 auto; width:100%;}
.top{margin-bottom:5px; }

.top-center-top { height:400px; margin-bottom:5px; }
.top-center-t-l { float:right; width:40%; height:400px; margin-left:5px;}
.top-center-t-r { width:100%;  }
	
.top-center-bottom { height:300px; margin-left:5px;}
.top-center-b-l { float:right; width:35%; height:300px;margin-left:5px;}
.top-center-b-r { width:100%;margin-right:0px;}

table tr td { height:30px }
table tr td font{ font-size:12px}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="alldata"
		cmd="com.inspur.cams.bpt.query.cmd.CollectQueryCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="DISABILITY" type="string" />
			<model:field name="DEPENDANT" type="string" />
			<model:field name="DEMOBILIED" type="string" />
			<model:field name="DEMOBILIZEDILLNESS" type="string" />
			<model:field name="WAR" type="string" />
			<model:field name="TESTED" type="string" />
			<model:field name="SOLDIER" type="string" />
			<model:field name="MARTYR" type="string" />
			<model:field name="TYPE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="adddata"
		cmd="com.inspur.cams.bpt.query.cmd.CollectQueryCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="DISABILITY" type="string" />
			<model:field name="DEPENDANT" type="string" />
			<model:field name="DEMOBILIED" type="string" />
			<model:field name="DEMOBILIZEDILLNESS" type="string" />
			<model:field name="WAR" type="string" />
			<model:field name="TESTED" type="string" />
			<model:field name="SOLDIER" type="string" />
			<model:field name="MARTYR" type="string" />
			<model:field name="TYPE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="decreaseds"
		cmd="com.inspur.cams.bpt.query.cmd.CollectQueryCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="DISABILITY" type="string" />
			<model:field name="DEPENDANT" type="string" />
			<model:field name="DEMOBILIED" type="string" />
			<model:field name="DEMOBILIZEDILLNESS" type="string" />
			<model:field name="WAR" type="string" />
			<model:field name="TESTED" type="string" />
			<model:field name="SOLDIER" type="string" />
			<model:field name="MARTYR" type="string" />
			<model:field name="TYPE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="cityds"
		cmd="com.inspur.cams.bpt.query.cmd.CollectQueryCmd" method="queryMap"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="DISABILITY" type="string" />
			<model:field name="DEPENDANT" type="string" />
			<model:field name="DEMOBILIED" type="string" />
			<model:field name="DEMOBILIZEDILLNESS" type="string" />
			<model:field name="WAR" type="string" />
			<model:field name="TESTED" type="string" />
			<model:field name="SOLDIER" type="string" />
			<model:field name="MARTYR" type="string" />
			<model:field name="TYPE" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
	<div class="container">
		<div class="top">
				<div class="top-center-top">
					<div id="shf3t" style="display: none;">
						<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="maint"
							width="100%" height="372"
							codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">
							<param name="movie" value="Department.swf" />
							<param name="quality" value="high" />
							<param name="bgcolor" value="#869ca7" />
							<param name="allowScriptAccess" value="sameDomain" />
							<embed src="Department.swf" quality="high" bgcolor="#869ca7"
								width="100%" height="100%" name="maint" align="middle" play="true"
								loop="false" quality="high" allowScriptAccess="sameDomain"
								type="application/x-shockwave-flash"
								pluginspage="http://www.macromedia.com/go/getflashplayer">
							</embed>
						</object>
					</div>
					<div class="top-center-t-l">
					
						<div class="easyui-panel" data-options="title:'各类优抚对象比例'"
							style="height: 400px;">
							<div style="height: 40px;"></div>
							<div id="mapie" style="min-width: 250px; height: 250px; margin: 0 auto"></div>
						</div>
					</div>
					<div class="top-center-t-r">
						<div class="easyui-panel" data-options="title:'各市(区)优抚对象人数'"
							style="height: 400px;">
							<div id="bptDiv"></div>
						</div>
					</div>
				</div>
				
				<div class="top-center-bottom">
					<div class="top-center-b-l">
						<div class="easyui-panel" data-options="title:'各类优抚对象本月减员概况'"
							style="height: 300px;" >
					<div style="">
							<form id="editForm" dataset="decreaseds" onsubmit="return false"
					style="padding: 5px;" >
				<table>
					<tr>
						<td width="40">
							<img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png">
						</td>
						<td width="140"><font>伤残</font></td>
						<td width="80"><label name="DISABILITY" field="DISABILITY" title="伤残"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >三属</font></td>
						<td><label name="DEPENDANT" field="DEPENDANT" title="三属"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >参战</font></td>
						<td><label name="WAR" field="WAR" title="参战"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >参试</font></td>
						<td><label name="TESTED" field="TESTED" title="参试"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >带病回乡</font></td>
						<td><label name="DEMOBILIZEDILLNESS" field="DEMOBILIZEDILLNESS" title="带病回乡"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >在乡复员</font></td>
						<td><label name="DEMOBILIED" field="DEMOBILIED" title="在乡复员"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"/skins/js/easyui/themes/icons/tip.png"></td>
						<td><font >60岁退役士兵</font></td>
						<td><label name="SOLDIER" field="SOLDIER" title="60岁退役士兵"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >老烈子女</font></td>
						<td><label name="MARTYR" field="MARTYR" title="老烈子女"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsDecrease/page_Decrease.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
				</table>
				</form>
				</div>
						</div>
					</div>
					<div class="top-center-b-l">
						<div class="easyui-panel" data-options="title:'各类优抚对象本月增员概况'"
							style="height: 300px;">
							<form id="editForm" dataset="adddata" onsubmit="return false"
					style="padding: 5px;" >
				<table>
					<tr>
						<td width="40">
							<img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png">
						</td>
						<td width="140"><font>伤残</font></td>
						<td width="80"><label name="DISABILITY" field="DISABILITY" title="伤残"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
						
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >三属</font></td>
						<td><label name="DEPENDANT" field="DEPENDANT" title="三属"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >参战</font></td>
						<td><label name="WAR" field="WAR" title="参战"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >参试</font></td>
						<td><label name="TESTED" field="TESTED" title="参试"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >带病回乡</font></td>
						<td><label name="DEMOBILIZEDILLNESS" field="DEMOBILIZEDILLNESS" title="带病回乡"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >在乡复员</font></td>
						<td><label name="DEMOBILIED" field="DEMOBILIED" title="在乡复员"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"/skins/js/easyui/themes/icons/tip.png"></td>
						<td><font >60岁退役士兵</font></td>
						<td><label name="SOLDIER" field="SOLDIER" title="60岁退役士兵"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >老烈子女</font></td>
						<td><label name="MARTYR" field="MARTYR" title="老烈子女"></label><font>人</font></td>
						<td><font size='2'><a class="xxxx" href="../statisticsIncrease/page_Increase.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
				</table>
				</form>
						</div>
					</div>
					<div class="top-center-b-r">
						<div class="easyui-panel" data-options="title:'各类优抚对象概况'"
							style="height: 300px;">
							<form id="editForm" dataset="alldata" onsubmit="return false"
					style="padding: 5px;" >
				<table>
					<tr>
						<td width="40">
							<img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png">
						</td>
						<td width="130"><font>伤残</font></td>
						<td width="80"><label name="DISABILITY" field="DISABILITY" title="伤残"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >三属</font></td>
						<td><label name="DEPENDANT" field="DEPENDANT" title="三属"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >参战</font></td>
						<td><label name="WAR" field="WAR" title="参战"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >参试</font></td>
						<td><label name="TESTED" field="TESTED" title="参试"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >带病回乡</font></td>
						<td><label name="DEMOBILIZEDILLNESS" field="DEMOBILIZEDILLNESS" title="带病回乡"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >在乡复员</font></td>
						<td><label name="DEMOBILIED" field="DEMOBILIED" title="在乡复员"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"/skins/js/easyui/themes/icons/tip.png"></td>
						<td><font >60岁退役士兵</font></td>
						<td><label name="SOLDIER" field="SOLDIER" title="60岁退役士兵"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
					<tr>
						<td><img alt="" src="<%=request.getContextPath() %>/skins/js/easyui/themes/gray/images/tabs_rightarrow.png"></td>
						<td><font >老烈子女</font></td>
						<td><label name="MARTYR" field="MARTYR" title="老烈子女"></label><font>人</font></td>
						<td><font size='2' ><a class="xxxx" href="../statistics/page_YouFuTongJi.jsp" target="_blank">详细信息</a>&nbsp;&nbsp;</font></td>
					</tr>
				</table>
				</form>
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
</html>