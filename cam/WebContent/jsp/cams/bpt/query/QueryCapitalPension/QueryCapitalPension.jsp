<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="QueryCapitalPension.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src="capitalPersion.js"></script>
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

.td {
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
		cmd="com.inspur.cams.bpt.query.cmd.QueryCapitalPensionCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="organ_code" type="string" />
			<model:field name="organ_name" type="string" />
			<model:field name="disability_num" type="string" />
			<model:field name="disability_mon" type="string" />
			<model:field name="disability_avg_mon" type="string" />
			<model:field name="dependant_country_num" type="string" />
			<model:field name="dependant_country_mon" type="string" />
			<model:field name="dependant_country_avg_mon" type="string" />
			<model:field name="dependant_town_num" type="string" />
			<model:field name="dependant_town_mon" type="string" />
			<model:field name="dependant_town_avg_mon" type="string" />
			<model:field name="count_num" type="string" />
			<model:field name="people_num" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 95%; height: 100%;" id="queryform" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" nowrap>发放起止日期:</td>
					<td class="FieldInput" colspan="3" ><input type="text" id="cxsj_q"
						format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_z" format="Y-m-d"
						style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					<td>
					<button id="queryButton" onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="pageReset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >

				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">定期抚恤金发放情况</span></div>
						<div align="right" class="L5form" ><button    onclick="printBill()">打印</button></div>
					<br/>
					<div align="right"><span style="font-size: small;">单位：人&bull;元</span></div>
				</div>
				<table width="80%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="10%" rowspan="2">单位</td>
					<td class="tdTitle" width="7%" rowspan="2">抚恤总额</td>
					<td class="tdTitle" width="7%" rowspan="2">发放<br/>总人数</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">伤残人员</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">农村"三属"</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">城镇"三属"</td>

				</tr>
				<tr>
					<td class="tdTitle" width="5%" align="center">人数</td>
					<td class="tdTitle" width="5%" align="center">金额</td>
					<td class="tdTitle" width="5%" align="center">人均</td>

					<td class="tdTitle" width="5%" align="center">人数</td>
					<td class="tdTitle" width="5%" align="center">金额</td>
					<td class="tdTitle" width="5%" align="center">人均</td>

					<td class="tdTitle" width="5%" align="center">人数</td>
					<td class="tdTitle" width="5%" align="center">金额</td>
					<td class="tdTitle" width="5%" align="center">人均</td>
				</tr>
				<tr repeat="true">
					<td style="display: none" class="td">
								<label readonly="true" field="organ_code" /></label>
							</td>
					<td width="10%" align="left" nowrap="nowrap" class="td">
						<a href="#" style="cursor:hand">
						<label id="test" field="organ_name"  onclick="test(this)" size="6" readonly="true" style="line-height:20px;"></label>
						<label id="code" field="organ_code"  style="display:none" size="6" readonly="true" ></label>
						</a>
					</td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="count_num"
						size="6" readonly="true" /></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="people_num"
						size="6" readonly="true" /></td>
					<td width="4%" align="center" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirect(this,'11')" field="disability_num"
						></label></a></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="disability_mon"
						size="6" readonly="true" /></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="disability_avg_mon"
						size="6" readonly="true" /></td>
					<td width="4%" align="center" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirect(this,'1')" field="dependant_country_num"
						></label></a></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="dependant_country_mon"
						size="6" readonly="true" /></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="dependant_country_avg_mon"
						size="6" readonly="true" /></td>
					<td width="4%" align="center" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirect(this,'2')" field="dependant_town_num"
						></label></a></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="dependant_town_mon"
						size="6" readonly="true" /></td>
					<td width="4%" align="right" nowrap="nowrap" class="td"><input type="text" field="dependant_town_avg_mon"
						size="6" readonly="true" /></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>