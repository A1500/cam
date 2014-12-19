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
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="page_dependant.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src="../querycomm.js"></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.DependantCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="MARTYR_TOWN" type="string" />
			<model:field name="MARTYR_COUNTRY" type="string" />
			<model:field name="COUNT_MARTYR" type="string" />
			
			<model:field name="DUTY_TOWN" type="string" />
			<model:field name="DUTY_COUNTRY" type="string" />
			<model:field name="COUNT_DUTY" type="string" />

			<model:field name="ILLSOLDIER_TOWN" type="string" />
			<model:field name="ILLSOLDIER_COUNTRY" type="string" />
			<model:field name="COUNT_ILLSOLDIER" type="string" />

			<model:field name="COUNT_DEPENDANT" type="string" />
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
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td  style="background-color: #f5fafa;text-align: center;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="timeType" onchange="showTime()">
					<option value="2">批准截止日期</option>
					<option value="1">批准起止日期</option>
					</select> </td>
					<td class="FieldInput"  colspan="3" id ="times"  style="display: none;" ><input type="text" id="cxsj_qs"
						format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_zs" format="Y-m-d"
						style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					
					<td class="FieldInput" colspan="3"  id = "time"><input type="text" id="cxsj_z"
						format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					<td>
					<button id="queryButton" onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="set()">重 置</button>
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
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">享受定期抚恤的“三属”人数统计表</span></div>
				<div align="right" class="L5form" ><button onclick="printBill()">打印</button></div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
			<table width="80%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="10%" align="center" rowspan="2">单位</td>
					<td class="tdTitle" align="center" colspan="3">烈士遗属</td>
					<td class="tdTitle" align="center" colspan="3">因公牺牲军人遗属</td>
					<td class="tdTitle" align="center" colspan="3">病故军人遗属</td>
					<td class="tdTitle" width="6%" align="center" rowspan="2">合计</td>
				</tr>
				<tr>
					<td class="tdTitle" width="6%" align="center">城镇</td>
					<td class="tdTitle" width="6%" align="center">农村</td>
					<td width="6%" class="tdTitle" align="center">小计</td>
					
					<td class="tdTitle" width="6%" align="center">城镇</td>
					<td class="tdTitle" width="6%" align="center">农村</td>
					<td width="6%" class="tdTitle" align="center">小计</td>
					
					<td class="tdTitle" width="6%" align="center">城镇</td>
					<td class="tdTitle" width="6%" align="center">农村</td>
					<td width="6%" class="tdTitle" align="center">小计</td>
				</tr>
				<tr repeat="true">
					<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
					</td>
					<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
						onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
						style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
						
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="MARTYR_TOWN"  onclick="redirectQuery(this.parentNode.parentNode,'21','dependantDomicileType=2')"></label></a></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="MARTYR_COUNTRY" onclick="redirectQuery(this.parentNode.parentNode,'21','dependantDomicileType=1')"  ></label></a></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="COUNT_MARTYR" onclick="redirectQuery(this.parentNode.parentNode,'21')" ></label></a></td>
						
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="DUTY_TOWN" onclick="redirectQuery(this.parentNode.parentNode,'22','dependantDomicileType=2')" ></label></a></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="DUTY_COUNTRY" onclick="redirectQuery(this.parentNode.parentNode,'22','dependantDomicileType=1')"  ></label></a></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="COUNT_DUTY" onclick="redirectQuery(this.parentNode.parentNode,'22')" ></label></a></td>

					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="ILLSOLDIER_TOWN" onclick="redirectQuery(this.parentNode.parentNode,'23','dependantDomicileType=2')" ></label></a></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="ILLSOLDIER_COUNTRY" onclick="redirectQuery(this.parentNode.parentNode,'23','dependantDomicileType=1')" ></label></a></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="COUNT_ILLSOLDIER" onclick="redirectQuery(this.parentNode.parentNode,'23')" ></label></a></td>
						
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
						field="COUNT_DEPENDANT"  onclick="redirectQuery(this.parentNode.parentNode,'2')"></label></a></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>