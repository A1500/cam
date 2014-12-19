<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var pageflag = '<%=request.getParameter("pageflag")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="query_LivingSubsidyPayment.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.LivingSubsidyPaymentCmd"
		global="true" autoLoad="true">
		<model:record>
			<model:field name="organ_code" type="string" />
			<model:field name="organ_name" type="string" />
			<model:field name="count" type="string" />
			<model:field name="people_num" type="string" />
			<model:field name="demobilized_num" type="string" />
			<model:field name="demobilized_mon" type="string" />
			<model:field name="demobilized_avg_mon" type="string" />
			<model:field name="demobilized_iliness_num" type="string" />
			<model:field name="demobilized_iliness_mon" type="string" />
			<model:field name="demobilized_iliness_avg_mon" type="string" />
			<model:field name="war_num" type="string" />
			<model:field name="war_town_mon" type="string" />
			<model:field name="war_town_avg_mon" type="string" />
			<model:field name="tested_num" type="string" />
			<model:field name="tested_town_mon" type="string" />
			<model:field name="tested_town_avg_mon" type="string" />
			<model:field name="martyr_num" type="string" />
			<model:field name="martyr_town_mon" type="string" />
			<model:field name="martyr_town_avg_mon" type="string" />
			<model:field name="soldier_num" type="string" />
			<model:field name="soldier_town_mon" type="string" />
			<model:field name="soldier_town_avg_mon" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>

	<next:Panel   width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">生活补助金发放情况</span></div>
				<div align="right" class="L5form" ><button    onclick="printBill()">打印</button></div>
			<br />
			<div align="right"><span style="font-size: small;">单位：人&bull;万元</span></div>
			</div>
				<table width="90%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="10%" rowspan="2">单位</td>
					<td class="tdTitle" width="7%" rowspan="2">补助总额</td>
					<td class="tdTitle" width="7%" rowspan="2">发放<br/>总人数</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">复员军人</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">带病回乡退伍军人</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">参战退役人员</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">参加核试验退役人员</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">60周岁退役士兵</td>
					<td class="tdTitle" align="center" width="15%" colspan="3">老烈子女</td>
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
						<label id="test" field="organ_name"  onclick="test(this)"  readonly="true" style='line-height:20px;'></label>
						<label id="code" field="organ_code"  style="display:none"  readonly="true" ></label>
						</a>
					</td>
					<td nowrap align="right" class="td"><input type="text" field="count"
						size="6" readonly="true" /></td>
					<td align="right" nowrap="nowrap" class="td"><input type="text" field="people_num"
						size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'41')" field="demobilized_num" ></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="demobilized_mon"  readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="demobilized_avg_mon" size="7" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'42')" field="demobilized_iliness_num" ></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="demobilized_iliness_mon"  readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="demobilized_iliness_avg_mon" size="7" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label 
						onclick="redirect(this,'51')" field="war_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="war_town_mon"  readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="war_town_avg_mon" size="7" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'61')" field="tested_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="tested_town_mon"  readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="tested_town_avg_mon" size="7" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'81')" field="soldier_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="soldier_town_mon"  readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="soldier_town_avg_mon" size="7" readonly="true" /></td>
					
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'B1')" field="martyr_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="martyr_town_mon"  readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						size="6" field="martyr_town_avg_mon" size="7" readonly="true" /></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>