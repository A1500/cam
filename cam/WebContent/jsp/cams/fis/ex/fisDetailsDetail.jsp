<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>殡葬收费标准价格表明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisDetailsList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var workId='<%=request.getParameter("workId")%>';//服务项目ID
	var feeID='<%=request.getParameter("feeID")%>';//业务批次ID
	var funeralCode='<%=request.getParameter("funeralCode")%>';//馆编号
	var funeralName='<%=request.getParameter("funeralName")%>';//馆名称
	var newWorkId = '<%=IdHelp.getUUID32()%>';//新增服务项目ID
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisPriceGoodsServiceDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceQueryCommand"  pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceGoodsService">
			<model:field name="workType" type="string" rule="require" />
			<model:field name="invoiceCodeType" type="string" rule="require" />
			<model:field name="priceStandard" type="string" rule="require" />
			<model:field name="serviceName" type="string" rule="require" />
			<model:field name="price" type="float" rule="require" />
			<model:field name="units" type="string" rule="require" />
			<model:field name="priceExeTime" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 服务类型 -->
	<model:dataset id="workTypeDS" enumName="FIS.WORK_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 收费性质 -->
	<model:dataset id="shoufeiDS" enumName="FIS.INVOICE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 定价形式 -->
	<model:dataset id="dingjiaDS" enumName="FIS.PRICE_STANDARD" autoLoad="true" global="true"></model:dataset>
	<!-- 费用类型 -->
	<model:dataset id="feeTypeDS" enumName="FIS.FEE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 物价局定价形式 -->
	<model:dataset id="priceTypeDS" enumName="FIS.PRICE_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="98%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fisPriceGoodsServiceDS" onsubmit="return false" class="L5form">
<fieldset>
	<legend>殡葬收费标准价格表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:20%">服务类型：</td>
			<td class="FieldInput" style="width:30%">
			<label id="workType" dataset="workTypeDS" field="workType" ></label>&nbsp;&nbsp;&nbsp;&nbsp;
			<label id="feeType1" dataset="feeTypeDS" field="feeType" ></label></td>
			<td class="FieldLabel"  style="text-align:left"><font color="red">说明：选择“基本服务”或“延伸（选择）服务”。“基本服务”主要包括遗体接运（含抬尸、消毒）、存放（含冷藏）、火化和骨灰寄存等服务，“延伸（选择）服务”是指基本服务以外、供群众选择的特殊服务项目，包括遗体整容、遗体防腐、吊唁设施及设备租赁等。“延伸（选择）服务2”是指丧葬用品费和骨灰盒费。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">项目名称：</td>
			<td class="FieldInput" style="width:15%"><label name="项目名称" id="serviceName" field="serviceName" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写殡仪服务项目名称</font></td>
		</tr>
		<tr id="a9" style="display:none">
			<td class="FieldLabel" style="width:15%">物价局定价形式：</td>
			<td class="FieldInput" style="width:15%">
			<label id="priceType" dataset="priceTypeDS" field="priceType"></label></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr id="a1" style="display:none">
			<td class="FieldLabel" style="width:15%">定价金额：</td>
			<td class="FieldInput" style="width:15%"><label name="定价金额" id="price" field="price"></label></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr id="a2" style="display:none">	
			<td class="FieldLabel" style="width:15%">定价单位：</td>
			<td class="FieldInput" style="width:15%"><label name="定价单位" id="units" field="units"></label></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr id="a3" style="display:none">	
			<td class="FieldLabel" style="width:15%">浮动区间：</td>
			<td class="FieldInput" style="width:15%"><label name="浮动区间" id="range" field="range"></label>%</td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr id="a8" style="display:none">	
			<td class="FieldLabel" style="width:15%">加收比率：</td>
			<td class="FieldInput" style="width:15%"><label  name="加收比率" id="range1"  field="range" maxlength="50" ></label>%</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">一级馆加收30%,二级馆加收20%,三级馆加收10%,请按照实际情况填写！</font></td>
		</tr>
		<tr id="a4" style="display:none">	
			<td class="FieldLabel" style="width:15%">收费标准：</td>
			<td class="FieldInput" style="width:15%"><label name="收费标准" id="priceDesc" field="priceDesc"></label></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr id="a5" style="display:none">	
			<td class="FieldLabel" style="width:15%">初始里程数：</td>
			<td class="FieldInput" style="width:15%"><label name="初始里程数" id="initiateMile" field="initiateMile" ></label>公里</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：接运服务初始里程数,没有请填0</font></td>
		</tr>
		<tr id="a6" style="display:none">	
			<td class="FieldLabel" style="width:15%">初始价格：</td>
			<td class="FieldInput" style="width:15%"><label name="初始价格" id="initiatePrice" field="initiatePrice" ></label>元</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：初始里程数内的价格（定价）</font></td>
		</tr>
		<tr id="a7" style="display:none">	
			<td class="FieldLabel" style="width:15%">超出价格：</td>
			<td class="FieldInput" style="width:15%"><label name="超出价格" id="overinitiatePrice" field="overinitiatePrice" onchange="changeNote()"></label>元/公里</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：超出初始里程数的价格,没有请填0</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">收费性质：</td>
			<td class="FieldInput" style="width:15%"><label id="invoiceCodeType" dataset="shoufeiDS" field="invoiceCodeType"></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：选择行政事业性收费 或 经营服务性收费（根据上面所选服务类型默认选择）</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">定价形式：</td>
			<td class="FieldInput" style="width:15%"><label id="priceStandard" dataset="dingjiaDS" field="priceStandard" ></label></td>
		<td class="FieldLabel" style="text-align:left"><font color="red">说明：选择政府定价 或 政府指导价 或 市场调节价</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">收费依据：</td>
			<td class="FieldInput" style="width:15%"><label name="收费依据" id="priceFileNum" field="priceFileNum" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写物价局批准文件文号</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">执行时间：</td>
			<td class="FieldInput" style="width:15%"><label name="执行时间" id="priceExeTime" field="priceExeTime" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写该项收费标准的起始执行时间</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免对象：</td>
			<td class="FieldInput" style="width:15%"><label name="减免对象" id="remissionTarget" field="remissionTarget" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写城市低保、农村低保、农村五保、优抚对象、90以上老人、全民等，可多选。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">优抚对象：</td>
			<td class="FieldInput" style="width:15%"><label name="优抚对象" id="remissionDetail" field="remissionDetail" ></label></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免金额：</td>
			<td class="FieldInput" style="width:15%"><label name="减免金额" id="remissionMoney" field="remissionMoney"></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red"></font></td>
		</tr>
		<tr>	
			<td class="FieldLabel" style="width:15%">减免单位：</td>
			<td class="FieldInput" style="width:15%"><label name="减免单位" id="remissionUnits" field="remissionUnits" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red"></font></td>
		</tr>
		<tr>	
			<td class="FieldLabel" style="width:15%">政府减免标准：</td>
			<td class="FieldInput" style="width:15%"><label name="减免标准" id="remissionDesc" field="remissionDesc"></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red"></font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免依据：</td>
			<td class="FieldInput" style="width:15%"><label name="减免依据" id="remissionFileNum" field="remissionFileNum" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写当地政府实行收费减免文件的名称及文号。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免执行时间：</td>
			<td class="FieldInput" style="width:15%"><label name="减免执行时间"
								id="remissionExeTime" field="remissionExeTime" ></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写该项目收费减免的起始执行时间</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">备注描述：</td>
			<td class="FieldInput" style="width:15%">
			<textarea id="note" name="note" field="note" onpropertychange="if(value.length>100) value=value.substr(0,100)" rows="5" style="width:100%" readonly="readonly"></textarea></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>