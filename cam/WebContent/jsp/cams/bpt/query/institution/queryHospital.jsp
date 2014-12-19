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
</script>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="queryHospital.js"></script>
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
		cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalQueryCommand"
		global="true" method="getHospitalTotal">
		<model:record
			fromBean="com.inspur.cams.bpt.bptinstitution.data.BptHospitalDetail">
			<model:field name="domicileName" type="string" />
			<model:field name="years" type="string" />
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
					<td class="FieldLabel" nowrap>查询年份:</td>
					<td class="FieldInput"><input type="text"
						id="year" format="Y" style="width: 100px;" maxlength="10"   /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font
						color="red">*</font></td>
					<td class="FieldLabel" style="width: 150px;">
					<button id="queryButton" onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="reset()">重 置</button>
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
			<div align="center" id="reDiv"  style="display: none;">

				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">优抚医院发展情况工作统计表</span></div>
						<div align="right" class="L5form" >
						<button    onclick="printBill()">打印</button>
						<button    onclick="toExcel()">导出Excel</button>
						</div>
					<br/>
				</div>
				<table width="130%" dataset="ds" align="center" id="tablePension" style="margin-left:40px;margin-right:40px;">
				 <tr>
				    <td class="tdTitle" width="7%" rowspan="3" align="center">地市</td>
				    <td class="tdTitle" width="10%" rowspan="3" align="center">医 院 名 称</td>
				    <td class="tdTitle" width="5%" rowspan="3" align="center">行政级别</td>
				    <td class="tdTitle" width="5%" rowspan="2" align="center">全年<br/>资金投入</td>
				    <td class="tdTitle" colspan="4" align="center">自身建设情况</td>
				    <td class="tdTitle" colspan="2" align="center">服务人员情况</td>
				    <td class="tdTitle" colspan="4" align="center">康复疗养情况</td>
				    <td class="tdTitle" colspan="6" align="center">精神病防治情况</td>
				    <td class="tdTitle" width="5%" rowspan="2" align="center">年纯收入</td>
				  </tr>
				  <tr>
				    <td class="tdTitle" width="5%" align="center">新建<br/>改建扩建</td>
				    <td class="tdTitle" width="5%" align="center">新增<br/>大型设备</td>
				    <td class="tdTitle" width="5%" align="center">现有床位</td>
				    <td class="tdTitle" width="5%" align="center">其中<br/>新增床位</td>
				    <td class="tdTitle" width="5%" align="center">医护人员</td>
				    <td class="tdTitle" width="5%" align="center">管理和<br/>后勤保障<br/>人员</td>
				    <td class="tdTitle" width="5%" align="center">床位</td>
				    <td class="tdTitle" width="5%" align="center">优抚对象</td>
				    <td class="tdTitle" width="5%" align="center">社会人员</td>
				    <td class="tdTitle" width="5%" align="center">轮养</td>
				    <td class="tdTitle" width="5%" align="center">全市<br/>复退军人<br/>精神病患者</td>
				    <td class="tdTitle" width="5%" rowspan="2" align="center">是否建立<br/>防治网络</td>
				    <td class="tdTitle" width="5%" align="center">住院治疗</td>
				    <td class="tdTitle" width="5%" align="center">巡回医疗</td>
				    <td class="tdTitle" width="5%" align="center">电话咨询</td>
				    <td class="tdTitle" width="5%" align="center">社会<br/>精神病患者<br/>治疗</td>
				  </tr>
				  
				  <tr>
				    <td class="tdTitle" width="5%" align="center">万元</td>
				    <td class="tdTitle" width="5%" align="center">平方米</td>
				    <td class="tdTitle" width="5%" align="center">台</td>
				    <td class="tdTitle" width="5%" align="center">张</td>
				    <td class="tdTitle" width="5%" align="center">张</td>
				    <td class="tdTitle" width="5%" align="center">人</td>
				    <td class="tdTitle" width="5%" align="center">人</td>
				    <td class="tdTitle" width="5%" align="center">张</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">人</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">人次</td>
				    <td class="tdTitle" width="5%" align="center">万元</td>
				  </tr>
				  <tr repeat="true">
					<td class="td" align="center" nowrap="nowrap"><input type="text" field="NAME"
						size="2" readonly="true" /></td>
					<td align="center" width="10%" class="td"><label field="UNIT_FULLNAME"/></td>
					<td align="center" nowrap="nowrap" class="td"><label field="ADMINISTRATIVE_LEVEL"/></td>
					<td align="right" nowrap="nowrap" class="td"><label field="PUTFUNDS" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="NEWEXPANSION" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="NEWEQUIPMENT" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="YEAR_ACTUAL_BED" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="ADD_BED" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="SERVICE" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="REAR_SERVICE_NUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="RESORT" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="YEAR_BPT_NUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="SOCIETY_NUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="NUMINYEAR" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="MENTALNUM" /></td>
					<td align="center" nowrap="nowrap" class="td"><label field="IFPREVENTIONNET"/></td>
					<td align="right" nowrap="nowrap" class="td"><label field="HOSPITALIZATION" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="MOBILEMEDICAL" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="TELCONSULTATION" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="TREATMENTALNUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="INCOME" /></td>
				</tr>
				<form dataset="ds">	
				<tr id="trPension">
					<td class="tdTitle" align="right" nowrap="nowrap"><label>合计:</label></td>
					<td class="tdTitle" align="right"  nowrap="nowrap"><label class="tdTotal">共计:</br>正县:</br>副县:</br>正科:</br>副科:</br></label></td>
					<td align="right" nowrap="nowrap" class="td">
						
						<input type="text" field="ADMINISTRATIVE_LEVEL_SUM1" size="6" readonly="true" /></br>
						<input type="text" field="ADMINISTRATIVE_LEVEL_SUM2" size="6" readonly="true" /></br>
						<input type="text" field="ADMINISTRATIVE_LEVEL_SUM3" size="6" readonly="true" /></br>
						<input type="text" field="ADMINISTRATIVE_LEVEL_SUM4" size="6" readonly="true" /></br>
						<input type="text" field="ADMINISTRATIVE_LEVEL_SUM5" size="6" readonly="true" /></br>
					</td>
					<td align="right" nowrap="nowrap" class="td"><label field="PUTFUNDS_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="NEWEXPANSION_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="NEWEQUIPMENT_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="YEAR_ACTUAL_BED_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="ADD_BED_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="SERVICE_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="REAR_SERVICE_NUM_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="RESORT_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="YEAR_BPT_NUM_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="SOCIETY_NUM_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="NUMINYEAR_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="MENTALNUM_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="IFPREVENTIONNET_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="HOSPITALIZATION_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="MOBILEMEDICAL_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="TELCONSULTATION_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="TREATMENTALNUM_SUM" /></td>
					<td align="right" nowrap="nowrap" class="td"><label field="INCOME_SUM" /></td>
					</tr>
					</form>
				</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>