<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var timeType = '<%=request.getParameter("timeType")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_disability_assdevices.js"></script>
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
	height: 20px;
	word-break: break-all;
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
		cmd="com.inspur.cams.bpt.query.cmd.DisabilityAssDevicesCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="wheelchair_num" type="string" />
			<model:field name="single_shoe_num" type="string" />
			<model:field name="sandals_num" type="string" />
			<model:field name="upper_limb_num" type="string" />
			<model:field name="thigh_num" type="string" />
			<model:field name="lower_leg_num" type="string" />
			<model:field name="in_turn_num" type="string" />
			<model:field name="other_num" type="string" />
			<model:field name="count_num" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">残疾人员辅助器械发放情况</span></div>
			</div>
			<div align="right" class="L5form" ><button onclick="printBill()">打印</button></div>
			<br />
			 
					<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
					<table width="99%" dataset="ds" align="center">
						<tr>
							<td class="tdTitle" width="30%" align="center">单&nbsp;&nbsp;&nbsp;位</td>
							<td class="tdTitle" width="10%" align="center">轮椅</td>
							<td class="tdTitle" width="10%" align="center">单鞋</td>
							<td class="tdTitle" width="10%" align="center" >凉鞋</td>
							<td class="tdTitle" width="10%" align="center" >上肢</td>
							<td class="tdTitle" width="10%" align="center">下肢大腿</td>
							<td class="tdTitle" width="10%" align="center" >下肢小腿</td>
							<td class="tdTitle" width="10%" align="center">大拐</td>
							<td class="tdTitle" width="10%" align="center" >其他</td>
						</tr>
						<tr repeat="true">
							<td style="display: none">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" /></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" /></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label   onclick="redirectQuery_dis(this,'000011')" field="wheelchair_num"
								></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000013')" field="single_shoe_num" ></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000014')" field="sandals_num" ></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000012')" field="upper_limb_num" ></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000015')" field="thigh_num" ></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000008')" field="lower_leg_num"></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000009')" field="in_turn_num" 
								></label></a></td>
							<td align="right" nowrap="nowrap"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'000016')" field="other_num" 
								></label></a></td>
						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>