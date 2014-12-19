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
<script type="text/javascript" src="page_total.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.CapitalQueryCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="organ_code" type="string" />
			<model:field name="organ_name" type="string" />
			<model:field name="mon_count" type="string" />
			<model:field name="people_num" type="string" />
			<model:field name="capital_num" type="string" />
			<model:field name="capital_mon" type="string" />
			<model:field name="capital_avg_mon" type="string" />
			<model:field name="compulsory_num" type="string" />
			<model:field name="compulsory_mon" type="string" />
			<model:field name="compulsory_avg_mon" type="string" />
			<model:field name="help_num" type="string" />
			<model:field name="help_mon" type="string" />
			<model:field name="help_avg_mon" type="string" />
			<model:field name="grant_num" type="string" />
			<model:field name="grant_mon" type="string" />
			<model:field name="grant_avg_mon" type="string" />
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
	<next:Panel  width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >
			
				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">优抚资金情况统计总表</span></div>
					<div align="right" class="L5form" ><button    onclick="printBill()">打印</button></div>
					<br />
					<div align="right"><span style="font-size: small;">单位：人&bull;元</span></div>
				</div>
				<table width="90%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="10%" rowspan="2">单位</td>
					<td class="tdTitle" width="7%" rowspan="2">补助总额</td>
					<td class="tdTitle" width="7%" rowspan="2">发放<br/>总人数</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">定期抚恤金</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">生活补助金</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">优待金</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">临时救助</td>
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

					<td class="tdTitle" width="5%" align="center">人数</td>
					<td class="tdTitle" width="5%" align="center">金额</td>
					<td class="tdTitle" width="5%" align="center">人均</td>
				</tr>
				<tr repeat="true">
					<td style="display: none" class="td">
								<label readonly="true" field="organ_code" /></label>
							</td>
					<td nowrap align="left" class="td">
						<a href="#">
						<label id="test" field="organ_name"  onclick="test(this)" size="6" readonly="true" style="line-height:20px;"></label>
						<label id="code" field="organ_code"  style="display:none" size="6" readonly="true" ></label>
						</a>
					</td>
					<td nowrap align="right" class="td"><input type="text" field="mon_count"
						size="6" readonly="true" /></td>
					<td align="right" nowrap="nowrap" class="td"><input type="text" field="people_num"
						size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'1')" field="capital_num" ></label></a></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="capital_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="capital_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'2')" field="grant_num" ></label></a></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="grant_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="grant_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><a href="#" style="cursor:hand"><label 
						onclick="redirect(this,'3')" field="compulsory_num"></label></a></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="compulsory_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="compulsory_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'4')" field="help_num"></label></a></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="help_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="help_avg_mon" size="6" readonly="true" /></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>