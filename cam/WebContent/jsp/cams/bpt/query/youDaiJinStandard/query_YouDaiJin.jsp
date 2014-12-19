<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_YouDaiJin.js"></script>
<style>
body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.YouDaiJinStandardCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="SOLDIER_TOWN" type="string" />
			<model:field name="SOLDIER_COUNTRY" type="string" />
			<model:field name="SANSHU_TOWN" type="string" />
			<model:field name="SANSHU_COUNTRY" type="string" />
			<model:field name="DEMOBILIIZED_SOLDIER" type="string" />
			<model:field name="DISABLED_SOLDIER" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel title="优抚工作统计表（3-1）" width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">优待金标准</span></div>
				<div id="backbutton" align="right" class="L5form" ><button    onclick="back()">返回</button></div>
			<br />
			<div align="right"><span style="font-size: small;">单位：元&frasl;人</span></div>
			</div>
			<table width="80%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="20%" align="center" rowspan="2">单位</td>
					<td class="tdTitle" align="center" width="30%" colspan="2">义务兵优待标准</td>
					<td class="tdTitle" align="center" width="30%" colspan="2">三属优待标准</td>
					<td class="tdTitle" width="20%" align="center" rowspan="2">复员军人优待标准</td>
					<td class="tdTitle" width="20%" align="center" rowspan="2">残疾军人优待标准</td>
				</tr>
				<tr>
					<td class="tdTitle" width="15%" align="center">城镇</td>
					<td class="tdTitle" width="15%" align="center">农村</td>

					<td class="tdTitle" width="15%" align="center">城镇</td>
					<td class="tdTitle" width="15%" align="center">农村</td>
				</tr>
				<tr repeat="true">
					<td width="20%" align="left"><a href="#"><label id="test"
						field="ORGAN_NAME" onclick="test(this)" size="6" readonly="true" /></label>
					<label id="code" field="ORGAN_CODE" style="display: none" size="6"
						readonly="true" /></label></a></td>
					<td width="4%" align="right"><input type="text"
						field="SOLDIER_TOWN" size="6" readonly="true" /></td>
					<td width="4%" align="right"><input type="text"
						field="SOLDIER_COUNTRY" size="6" readonly="true" /></td>
					<td width="4%" align="right"><input type="text"
						field="SANSHU_TOWN" size="6" readonly="true" /></td>
					<td width="4%" align="right"><input type="text"
						field="SANSHU_COUNTRY" size="6" readonly="true" /></td>
					<td width="4%" align="right"><input type="text"
						field="DEMOBILIIZED_SOLDIER" size="6" readonly="true" /></td>
					<td width="4%" align="right"><input type="text"
						field="DISABLED_SOLDIER" size="6" readonly="true" /></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>