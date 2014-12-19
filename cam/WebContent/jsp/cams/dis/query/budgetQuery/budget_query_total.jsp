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
	var pageflag ='<%=request.getParameter("pageflag")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="budget_query_total.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src="../../comm/disComm.js"></script>
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
		cmd="com.inspur.cams.dis.query.cmd.DisBudgetTongJiCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="DCNUM" type="string" />
			<model:field name="DCFOOD" type="string" />
			<model:field name="DCCLOTHES" type="string" />
			<model:field name="DCMONEY" type="string" />
			<model:field name="SWNUM" type="string" />
			<model:field name="SWMONEY" type="string" />
			<model:field name="YJNUM" type="string" />
			<model:field name="YJFOOD" type="string" />
			<model:field name="YJCLOTHES" type="string" />
			<model:field name="YJMONEY" type="string" />
			<model:field name="GDNUM" type="string" />
			<model:field name="GDFOOD" type="string" />
			<model:field name="GDCLOTHES" type="string" />
			<model:field name="GDMONEY" type="string" />
			<model:field name="CJNUM" type="string" />
			<model:field name="CJRBHOUSE" type="string" />
			<model:field name="CJRPHOUSE" type="string" />
			<model:field name="CJMONEY" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>

	<next:Panel  width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >
			
				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">救助需求统计</span></div>
					<div align="right" class="L5form" ><button    onclick="printBill()">打印</button><button    onclick="back()">返回</button></div>
					<br />
					<div align="right"><span style="font-size: small;">单位：户&bull;元&bull;间</span></div>
				</div>
				<table width="90%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="10%" rowspan="2">单位</td>
					
					<td class="tdTitle" align="center" width="15%" colspan="4">冬春生活救助</td>
					<td class="tdTitle" align="center" width="15%" colspan="2">因灾死亡人员家庭抚恤</td>
					<td class="tdTitle" align="center" width="15%" colspan="4">应急救助</td>
					<td class="tdTitle" align="center" width="15%" colspan="4">过渡救助</td>
					<td class="tdTitle" align="center" width="15%" colspan="4">灾区民房恢复重建补助</td>
				</tr>
				<tr>
					<td class="tdTitle" width="5%" align="center">救助户数</td>
					<td class="tdTitle" width="5%" align="center">救助口粮</td>
					<td class="tdTitle" width="5%" align="center">救助衣被</td>
					<td class="tdTitle" width="5%" align="center">救助金额</td>
					
					<td class="tdTitle" width="5%" align="center">救助户数</td>
					<td class="tdTitle" width="5%" align="center">救助金额</td>

					<td class="tdTitle" width="5%" align="center">救助户数</td>
					<td class="tdTitle" width="5%" align="center">救助口粮</td>
					<td class="tdTitle" width="5%" align="center">救助衣被</td>
					<td class="tdTitle" width="5%" align="center">救助金额</td>

					<td class="tdTitle" width="5%" align="center">救助户数</td>
					<td class="tdTitle" width="5%" align="center">救助口粮</td>
					<td class="tdTitle" width="5%" align="center">救助衣被</td>
					<td class="tdTitle" width="5%" align="center">救助金额</td>

					<td class="tdTitle" width="5%" align="center">救助户数</td>
					<td class="tdTitle" width="5%" align="center">重建间数</td>
					<td class="tdTitle" width="5%" align="center">修缮间数</td>
					<td class="tdTitle" width="5%" align="center">救助金额</td>
				</tr>
				<tr repeat="true">
					<td style="display: none" class="td">
								<label readonly="true" field="organ_code" /></label>
							</td>
					<td nowrap align="left" class="td">
						<a href="#">
						<label id="test" field="ORGAN_NAME"  onclick="test(this)" size="6" readonly="true" style="line-height:20px;"></label>
						<label id="code" field="ORGAN_CODE"  style="display:none" size="6" readonly="true" ></label>
						</a>
					</td>
					<td nowrap align="right" class="td"><input type="text" field="DCNUM"
						size="6" readonly="true" /></td>
					<td align="right" nowrap="nowrap" class="td"><input type="text" field="DCFOOD"
						size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><input  type="text"
						size="6" field="DCCLOTHES" readonly="true"/></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="DCMONEY" size="6" readonly="true" /></td>
						
						
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="SWNUM" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><input type="text"
						field="SWMONEY" size="6" readonly="true" /></td>
						
						
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="YJNUM" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="YJFOOD" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><input type="text"
						field="YJCLOTHES" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="YJMONEY" size="6" readonly="true" /></td>
						
						
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="GDNUM" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><input type="text"
						field="GDFOOD" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="GDCLOTHES" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="GDMONEY" size="6" readonly="true" /></td>
						
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="CJNUM" size="6" readonly="true" /></td>
					<td nowrap align="center" nowrap class="td"><input type="text"
						field="CJRBHOUSE" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="CJRPHOUSE" size="6" readonly="true" /></td>
					<td nowrap align="right" nowrap class="td"><input type="text"
						field="CJMONEY" size="6" readonly="true" /></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>