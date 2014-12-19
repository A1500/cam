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
<script type="text/javascript" src="page_tested.js"></script>
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
<input type="hidden" id="state" value="2"/>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.TestedTongJiCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="T1" type="string" />
			<model:field name="T2" type="string" />
			<model:field name="T3" type="string" />
			<model:field name="T4" type="string" />
			<model:field name="T5" type="string" />
			<model:field name="T6" type="string" />
			<model:field name="T7" type="string" />
			<model:field name="T8" type="string" />
			<model:field name="T9" type="string" />
			<model:field name="T10" type="string" />
			<model:field name="T11" type="string" />
			<model:field name="T12" type="string" />
			<model:field name="T13" type="string" />
			<model:field name="T14" type="string" />
			<model:field name="T15" type="string" />
			<model:field name="T16" type="string" />
			<model:field name="T17" type="string" />
			<model:field name="T18" type="string" />
			<model:field name="T19" type="string" />
			<model:field name="T20" type="string" />
			<model:field name="T21" type="string" />
			<model:field name="T22" type="string" />
			<model:field name="T23" type="string" />
			<model:field name="T24" type="string" />
			<model:field name="T25" type="string" />
			<model:field name="T26" type="string" />
			<model:field name="T27" type="string" />
			<model:field name="T28" type="string" />
			<model:field name="T29" type="string" />
			<model:field name="T30" type="string" />
			<model:field name="T31" type="string" />
			<model:field name="T32" type="string" />
			<model:field name="T33" type="string" />
			<model:field name="T34" type="string" />
			<model:field name="T35" type="string" />
			<model:field name="T36" type="string" />
			<model:field name="T37" type="string" />
			<model:field name="T38" type="string" />
			<model:field name="T39" type="string" />
			<model:field name="T40" type="string" />
			<model:field name="T41" type="string" />
			<model:field name="T42" type="string" />
			<model:field name="T43" type="string" />
			<model:field name="T44" type="string" />
			<model:field name="T45" type="string" />
			<model:field name="T46" type="string" />
			<model:field name="T47" type="string" />
			<model:field name="T48" type="string" />
			<model:field name="T49" type="string" />
			<model:field name="T50" type="string" />
			<model:field name="T51" type="string" />
			<model:field name="T52" type="string" />
			<model:field name="T53" type="string" />
			<model:field name="T54" type="string" />
			<model:field name="T55" type="string" />
			<model:field name="T56" type="string" />
			<model:field name="T57" type="string" />
			<model:field name="T58" type="string" />
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
					<td class="FieldInput"  colspan="3" id ="times" style="display: none;" ><input type="text" id="cxsj_qs"
						format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_zs" format="Y-m-d"
						style="width: 100px;" maxlength="10"   onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					
					<td class="FieldInput" colspan="3"  id = "time" ><input type="text" id="cxsj_z"
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
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">山东参试人员统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table width="3500" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
						<tr>
							<td class="tdTitle" width="150" align="center" rowspan="4">单位</td>
							<td class="tdTitle" width="50" align="center" rowspan="4">已认定合计</td>
							<td class="tdTitle" width="1700" align="center" rowspan="2" colspan="34">评定残疾等级人员</td>
							<td class="tdTitle" width="200" align="center" rowspan="3" colspan="4">享受带病回乡补助人员</td>
							<td class="tdTitle" width="950" align="center" colspan="19">享受定期生活困难补助人员</td>
						</tr>
						<tr>
							<td class="tdTitle" width="50" align="center" rowspan="3">合计</td>
							<td class="tdTitle" width="300" align="center" colspan="6">原8023部队评残人员</td>
							<td class="tdTitle" width="300" align="center" colspan="6">其他参加核试验人员</td>
							<td class="tdTitle" width="300" align="center" colspan="6">参加铀矿开发军队人员</td>
							
						</tr>
						<tr>
							<td class="tdTitle" width="50" align="center" rowspan="2">合计</td>
							<td class="tdTitle" width="550" align="center" colspan="11">原8023部队评残人员</td>
							<td class="tdTitle" width="550" align="center" colspan="11">其他参加核试验人员</td>
							<td class="tdTitle" width="550" align="center" colspan="11">参加铀矿开发军队人员</td>
							<td class="tdTitle" width="150" align="center" colspan="3">农村</td>
							<td class="tdTitle" width="150" align="center" colspan="3">城镇无工作单位</td>
							<td class="tdTitle" width="150" align="center" colspan="3">农村</td>
							<td class="tdTitle" width="150" align="center" colspan="3">城镇无工作单位</td>
							<td class="tdTitle" width="150" align="center" colspan="3">农村</td>
							<td class="tdTitle" width="150" align="center" colspan="3">城镇无工作单位</td>
						</tr>
						<tr>
							<td class="tdTitle" width="50" align="center">一级</td>
							<td class="tdTitle" width="50" align="center">二级</td>
							<td class="tdTitle" width="50" align="center">三级</td>
							<td class="tdTitle" width="50" align="center">四级</td>
							<td class="tdTitle" width="50" align="center">五级</td>
							<td class="tdTitle" width="50" align="center">六级</td>
							<td class="tdTitle" width="50" align="center">七级</td>
							<td class="tdTitle" width="50" align="center">八级</td>
							<td class="tdTitle" width="50" align="center">九级</td>
							<td class="tdTitle" width="50" align="center">十级</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">一级</td>
							<td class="tdTitle" width="50" align="center">二级</td>
							<td class="tdTitle" width="50" align="center">三级</td>
							<td class="tdTitle" width="50" align="center">四级</td>
							<td class="tdTitle" width="50" align="center">五级</td>
							<td class="tdTitle" width="50" align="center">六级</td>
							<td class="tdTitle" width="50" align="center">七级</td>
							<td class="tdTitle" width="50" align="center">八级</td>
							<td class="tdTitle" width="50" align="center">九级</td>
							<td class="tdTitle" width="50" align="center">十级</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">一级</td>
							<td class="tdTitle" width="50" align="center">二级</td>
							<td class="tdTitle" width="50" align="center">三级</td>
							<td class="tdTitle" width="50" align="center">四级</td>
							<td class="tdTitle" width="50" align="center">五级</td>
							<td class="tdTitle" width="50" align="center">六级</td>
							<td class="tdTitle" width="50" align="center">七级</td>
							<td class="tdTitle" width="50" align="center">八级</td>
							<td class="tdTitle" width="50" align="center">九级</td>
							<td class="tdTitle" width="50" align="center">十级</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">合计</td>
							<td class="tdTitle" width="50" align="center">原8023部队评残人员</td>
							<td class="tdTitle" width="50" align="center">其他参加核试验人员</td>
							<td class="tdTitle" width="50" align="center">参加铀矿开发军队人员</td>
							<td class="tdTitle" width="50" align="center">患病</td>
							<td class="tdTitle" width="50" align="center">生活困难</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">患病</td>
							<td class="tdTitle" width="50" align="center">生活困难</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">患病</td>
							<td class="tdTitle" width="50" align="center">生活困难</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">患病</td>
							<td class="tdTitle" width="50" align="center">生活困难</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">患病</td>
							<td class="tdTitle" width="50" align="center">生活困难</td>
							<td class="tdTitle" width="50" align="center">小计</td>
							<td class="tdTitle" width="50" align="center">患病</td>
							<td class="tdTitle" width="50" align="center">生活困难</td>
							<td class="tdTitle" width="50" align="center">小计</td>
						</tr>
						<tr repeat="true">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','','all','','')" field="T1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','','','','')" field="T2" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','01','','')" field="T3" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','02','','')" field="T4" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','03','','')" field="T5" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','04','','')" field="T6" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','05','','')" field="T7" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','06','','')" field="T8" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','07','','')" field="T9" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','08','','')" field="T10" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','09','','')" field="T11" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','10','','')" field="T12" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','','','','')" field="T13" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','01','','')" field="T14" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','02','','')" field="T15" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','03','','')" field="T16" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','04','','')" field="T17" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','05','','')" field="T18" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','06','','')" field="T19" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','07','','')" field="T20" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','08','','')" field="T21" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','09','','')" field="T22" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','10','','')" field="T23" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','','','','')" field="T24" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','01','','')" field="T25" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','02','','')" field="T26" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','03','','')" field="T27" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','04','','')" field="T28" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','05','','')" field="T29" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','06','','')" field="T30" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','07','','')" field="T31" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','08','','')" field="T32" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','09','','')" field="T33" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','10','','')" field="T34" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','','','','')" field="T35" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','','','1','')" field="T36" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','1','','1','')" field="T37" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','2','','1','')" field="T38" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','3','','1','')" field="T39" ></label></a></td>
							
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','','','','3')" field="T40" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','1','','','1')" field="T41" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','1','','','2')" field="T42" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','1','','','3')" field="T43" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','2','','','1')" field="T44" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','2','','','2')" field="T45" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','2','','','3')" field="T46" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','1','','','1')" field="T47" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','1','','','2')" field="T48" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','1','','','3')" field="T49" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','2','','','1')" field="T50" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','2','','','2')" field="T51" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','2','','','3')" field="T52" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','1','','','1')" field="T53" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','1','','','2')" field="T54" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','1','','','3')" field="T55" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','2','','','1')" field="T56" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','2','','','2')" field="T57" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3','2','','','3')" field="T58" ></label></a></td>

						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>