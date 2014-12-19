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
<script type="text/javascript" src="page_disabilityDevice.js"></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.DisabilityDeviceTongJiCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="Y1" type="string" />
			<model:field name="Y2" type="string" />
			<model:field name="Y3" type="string" />
			<model:field name="Y4" type="string" />
			<model:field name="Y5" type="string" />
			<model:field name="Y6" type="string" />
			<model:field name="Y7" type="string" />
			<model:field name="Y8" type="string" />
			<model:field name="Y9" type="string" />
			<model:field name="Y10" type="string" />
			<model:field name="Y11" type="string" />
			<model:field name="Y12" type="string" />
			<model:field name="Y13" type="string" />
			<model:field name="Y14" type="string" />
			<model:field name="Y15" type="string" />
			<model:field name="Y16" type="string" />
			<model:field name="Y17" type="string" />
			<model:field name="Y18" type="string" />
			<model:field name="Y19" type="string" />
			<model:field name="Y20" type="string" />
			<model:field name="Y21" type="string" />
			<model:field name="Y22" type="string" />
			<model:field name="Y23" type="string" />
			<model:field name="Y24" type="string" />
			<model:field name="Y25" type="string" />
			<model:field name="Y26" type="string" />
			<model:field name="Y27" type="string" />
			<model:field name="Y28" type="string" />
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
				style="font-size: large;">全省革命伤残军人假肢用品配备情况表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table width="1350" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
						<tr>
							<td class="tdTitle" width="60" align="center">单位</td>
							<td class="tdTitle" width="60" align="center">人数</td>
							<td class="tdTitle" width="60" align="center">上臂装饰手</td>
							<td class="tdTitle" width="61" align="center">上臂机械手</td>
							<td class="tdTitle" width="62" align="center">前臂机动手</td>
							<td class="tdTitle" width="63" align="center">前臂装饰手</td>
							<td class="tdTitle" width="64" align="center">木大腿</td>
							<td class="tdTitle" width="65" align="center">树脂大腿</td>
							<td class="tdTitle" width="66" align="center">木小腿</td>
							<td class="tdTitle" width="67" align="center">树脂小腿</td>
							<td class="tdTitle" width="68" align="center">半脚假肢</td>
							<td class="tdTitle" width="69" align="center">皮护腿</td>
							<td class="tdTitle" width="70" align="center">牛面单鞋</td>
							<td class="tdTitle" width="71" align="center">牛面棉鞋</td>
							<td class="tdTitle" width="72" align="center">三轮车</td>
							<td class="tdTitle" width="73" align="center">折叠轮椅</td>
							<td class="tdTitle" width="74" align="center">胸围矫形器</td>
							<td class="tdTitle" width="75" align="center">大腿矫形器</td>
							<td class="tdTitle" width="76" align="center">小腿矫形器</td>
							<td class="tdTitle" width="77" align="center">弹性围腰</td>
							<td class="tdTitle" width="78" align="center">肾托</td>
							<td class="tdTitle" width="79" align="center">凉鞋</td>
							<td class="tdTitle" width="80" align="center">上肢</td>
							<td class="tdTitle" width="81" align="center">下肢大腿</td>
							<td class="tdTitle" width="82" align="center">下肢小腿</td>
							<td class="tdTitle" width="83" align="center">大拐</td>
							<td class="tdTitle" width="84" align="center">其他</td>
						</tr>
						<tr repeat="true">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'')" field="Y1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000026')" field="Y2" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000027')" field="Y3" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000028')" field="Y4" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000029')" field="Y5" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000030')" field="Y6" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000031')" field="Y7" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000032')" field="Y8" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000033')" field="Y9" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000034')" field="Y10" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000035')" field="Y11" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000019')" field="Y12" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000036')" field="Y13" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000037')" field="Y14" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000018')" field="Y15" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000038')" field="Y16" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000039')" field="Y17" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000040')" field="Y18" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000041')" field="Y19" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000042')" field="Y20" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000020')" field="Y21" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000021')" field="Y22" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000022')" field="Y23" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000023')" field="Y24" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000024')" field="Y25" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'000025')" field="Y26" ></label></a></td>

							
						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>