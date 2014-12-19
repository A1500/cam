<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
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
<script type="text/javascript" src="query_Decrease.js"></script>
<script type="text/javascript" src="../querycomm.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript">
	queryPage = true;
	if(cxsjq != null && cxsjq != "") {
		timeType = "1";
		startTime = cxsjq;
	}
	endTime = cxsjz;
	urlPage = "../query_decreaseList.jsp";
</script>
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

</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.YouFuTongJi_DecreaseCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="DISABLED_SOLDIER" type="string" />
			<model:field name="DISABLED_OFFICER" type="string" />
			<model:field name="DISABLED_POLICE" type="string" />
			<model:field name="DISABLED_WAR_OFFICIAL" type="string" />
			<model:field name="DISABLED_MILITIA_MIGRANT" type="string" />
			<model:field name="COUNT_DISABLED" type="string" />

			<model:field name="MARTYR_DEPENDANT" type="string" />
			<model:field name="DUTY_DEPENDANT" type="string" />
			<model:field name="ILLSOLDIER_DEPENDANT" type="string" />
			<model:field name="COUNT_DEPENDANT" type="string" />

			<model:field name="RESERVIST" type="string" />
			<model:field name="ILLNESS_RESERVIST" type="string" />
			<model:field name="COUNT_RESERVIST" type="string" />

			<model:field name="COUNT_TOTAL_TEMP" type="string" />

			<model:field name="CZ_RETIRED" type="string" />
			<model:field name="RETIRED_8023" type="string" />
			<model:field name="CS_RETIRED" type="string" />
			<model:field name="CS_EXPLOIT" type="string" />
			<model:field name="COUNT_RETIRED" type="string" />
			
			<model:field name="SOLDIER" type="string" />
			<model:field name="OFFSPRINGL" type="string" />
			<model:field name="OFFSPRINGP" type="string" />
			<model:field name="COUNT_SOLDIER_OFFSPRING" type="string" />

			<model:field name="COUNT_TOTAL" type="string" />
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
				style="font-size: large;">优抚对象减员人数统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table width="1350" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
						<tr>
							<td class="tdTitle" width="10%" align="center" rowspan="2">单位</td>
							<td class="tdTitle" align="center" colspan="6">伤残人员</td>
							<td class="tdTitle" align="center" colspan="4">享受定期抚恤金人员</td>
							<td class="tdTitle" align="center" colspan="3">享受定期补助人员</td>
							<td class="tdTitle" width="96" align="center" rowspan="2">小计</br>
							(不含两参人员)</td>
							<td class="tdTitle" align="center" colspan="5">两参人员</td>
							<td class="tdTitle" align="center" colspan="4">60周岁退役士兵及老烈子女</td>
							<td class="tdTitle" width="60" align="center" rowspan="2">合计</td>
						</tr>
						<tr>
							<td class="tdTitle" width="60" align="center">小计</td>
							<td class="tdTitle" width="60" align="center">残疾军人</td>
							<td width="60" class="tdTitle" align="center">伤残</br>
							国家机关</br>
							人员</td>
							<td class="tdTitle" width="60" align="center">伤残</br>
							人民警察</td>
							<td class="tdTitle" width="60" align="center">因战因公</br>
							伤残人员</td>
							<td class="tdTitle" width="60" align="center">伤残</br>
							民兵民工</td>
							<td class="tdTitle" width="60" align="center">合计</td>
							<td class="tdTitle" width="60" align="center">烈士遗属</td>
							<td class="tdTitle" width="60" align="center">因公牺牲</br>
							军人遗属</td>
							<td class="tdTitle" width="60" align="center">病故军人</br>
							遗属</td>
							<td class="tdTitle" width="60" align="center">小计</td>
							<td class="tdTitle" width="60" align="center">在乡复员</br>
							军人</td>
							<td class="tdTitle" width="60" align="center">带病回乡</br>
							退伍军人</td>
							<td class="tdTitle" width="60" align="center">小计</td>
							<td class="tdTitle" width="60" align="center">参战</br>
							退役人员</td>
							<td class="tdTitle" width="60" align="center">原8023部队</br>
							退役人员</td>
							<td class="tdTitle" width="60" align="center">其他参加<br/>核试验</br>
							退役人员</td>
							<td class="tdTitle" width="60" align="center">铀矿<br/>开采军队</br>
							退役人员</td>
							<td class="tdTitle" width="60" align="center">小计</td>
							<td class="tdTitle" width="60" align="center">60周岁以上</br>农村退役士兵
							</td>
							<td class="tdTitle" width="60" align="center">部分</br>烈士子女</td>
							<td class="tdTitle" width="60" align="center">部分</br>平反人员子女</td>
						</tr>
						<tr repeat="true">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true" onclick="redirectQuery(this.parentNode.parentNode,'1')" field="COUNT_DISABLED" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="DISABLED_SOLDIER" onclick="redirectQuery(this.parentNode.parentNode,'11')" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="DISABLED_OFFICER" onclick="redirectQuery(this.parentNode.parentNode,'12')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="DISABLED_POLICE" onclick="redirectQuery(this.parentNode.parentNode,'13')" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="DISABLED_WAR_OFFICIAL" onclick="redirectQuery(this.parentNode.parentNode,'15')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="DISABLED_MILITIA_MIGRANT" onclick="redirectQuery(this.parentNode.parentNode,'14')"></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label   
								readonly="true" field="COUNT_DEPENDANT" onclick="redirectQuery(this.parentNode.parentNode,'2')" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label   
								readonly="true" field="MARTYR_DEPENDANT" onclick="redirectQuery(this.parentNode.parentNode,'21')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label 
								readonly="true" field="DUTY_DEPENDANT" onclick="redirectQuery(this.parentNode.parentNode,'22')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label 
								readonly="true" field="ILLSOLDIER_DEPENDANT" onclick="redirectQuery(this.parentNode.parentNode,'23')"></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label   
								readonly="true" field="COUNT_RESERVIST" onclick="redirectQuery(this.parentNode.parentNode,'41,42')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="RESERVIST" onclick="redirectQuery(this.parentNode.parentNode,'41')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="ILLNESS_RESERVIST" onclick="redirectQuery(this.parentNode.parentNode,'42')"></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="COUNT_TOTAL_TEMP" onclick="redirectQuery(this.parentNode.parentNode,'1,2,41,42')"></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="COUNT_RETIRED" onclick="redirectQuery(this.parentNode.parentNode,'5,6')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label 
								readonly="true" field="CZ_RETIRED" onclick="redirectQuery(this.parentNode.parentNode,'5')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="RETIRED_8023" onclick="redirectQuery(this.parentNode.parentNode,'6','1')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="CS_RETIRED" onclick="redirectQuery(this.parentNode.parentNode,'6','2')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="CS_EXPLOIT" onclick="redirectQuery(this.parentNode.parentNode,'6','3')"></label></a></td>
									
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="COUNT_SOLDIER_OFFSPRING" onclick="redirectQuery(this.parentNode.parentNode,'8,B')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label 
								readonly="true" field="SOLDIER" onclick="redirectQuery(this.parentNode.parentNode,'8')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="OFFSPRINGL" onclick="redirectQuery(this.parentNode.parentNode,'B','1')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="OFFSPRINGP" onclick="redirectQuery(this.parentNode.parentNode,'B','2')"></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="COUNT_TOTAL" onclick="redirectQuery(this.parentNode.parentNode,'1,2,41,42,5,6,8,B')"></label></a></td>
						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>