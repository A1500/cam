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
<script type="text/javascript" src="query_temporary_help.js"></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.TemporaryHelpQueryCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="organ_code" type="string" />
			<model:field name="organ_name" type="string" />
			<model:field name="mon_count" type="string" />
			<model:field name="people_num" type="string" />
			<model:field name="disablity_num" type="string" />
			<model:field name="disablity_mon" type="string" />
			<model:field name="disablity_avg_mon" type="string" />
			<model:field name="dependant_num" type="string" />
			<model:field name="dependant_mon" type="string" />
			<model:field name="dependant_avg_mon" type="string" />
			<model:field name="demobilized_num" type="string" />
			<model:field name="demobilized_mon" type="string" />
			<model:field name="demobilized_avg_mon" type="string" />
			<model:field name="demobilized_illness_num" type="string" />
			<model:field name="demobilized_illness_mon" type="string" />
			<model:field name="demobilized_illness_avg_mon" type="string" />
			<model:field name="war_num" type="string" />
			<model:field name="war_mon" type="string" />
			<model:field name="war_avg_mon" type="string" />
			<model:field name="tested_num" type="string" />
			<model:field name="tested_mon" type="string" />
			<model:field name="tested_avg_mon" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>

	<next:Panel   width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >
			
				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">临时救助统计情况</span></div>
					<div align="right" class="L5form" ><button    onclick="printBill()">打印</button></div>
					<br />
					<div align="right"><span style="font-size: small;">单位：人&bull;元</span></div>
				</div>
				<table width="114%" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
				<tr>
					<td class="tdTitle" width="10%" rowspan="2">单位</td>
					<td class="tdTitle" width="7%" rowspan="2">补助总额</td>
					<td class="tdTitle" width="7%" rowspan="2">发放<br/>总人数</td>
					<td class="tdTitle" align="center"  colspan="3">伤残军人</td>
					<td class="tdTitle" align="center"  colspan="3">三属人员</td>
					<td class="tdTitle" align="center"   colspan="3">复员军人</td>
					<td class="tdTitle" align="center"  colspan="3">带病回乡退伍军人</td>
					<td class="tdTitle" align="center"   colspan="3">参战人员</td>
					<td class="tdTitle" align="center"   colspan="3">参试人员</td>
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
						<label id="test" field="organ_name"  onclick="test(this)" size="6" readonly="true" style="line-height:20px;"></label>
						<label id="code" field="organ_code"  style="display:none" size="6" readonly="true" ></label>
						</a>
					</td>
					<td nowrap align="right" class="td"><input type="text" field="mon_count"
						size="6" readonly="true" /></td>
					<td align="right" nowrap="nowrap" class="td"><input type="text" field="people_num"
						size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'1')" field="disablity_num" ></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						field="disablity_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						field="disablity_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'2')" field="dependant_num" ></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						field="dependant_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						field="dependant_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label 
						onclick="redirect(this,'41')" field="demobilized_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						field="demobilized_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						field="demobilized_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'42')" field="demobilized_illness_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						field="demobilized_illness_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						field="demobilized_illness_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'51')" field="war_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						field="war_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						field="war_avg_mon" size="6" readonly="true" /></td>
					<td nowrap align="center" class="td"><a href="#" style="cursor:hand"><label  
						onclick="redirect(this,'61')" field="tested_num"></label></a></td>
					<td nowrap align="right" class="td"><input type="text"
						field="tested_mon" size="6" readonly="true" /></td>
					<td nowrap align="right" class="td"><input type="text"
						field="tested_avg_mon" size="6" readonly="true" /></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>