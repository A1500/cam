<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
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
	var funeralName=decodeURIComponent('<%=request.getParameter("funeralName")%>');//馆名称
	var newWorkId = '<%=IdHelp.getUUID32()%>';//新增服务项目ID
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var time = '<%=DateUtil.getTime()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisPriceGoodsServiceDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceQueryCommand"  pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceGoodsService">
		</model:record>
	</model:dataset>
	<!-- 服务类型 -->
	<model:dataset id="workTypeDS" enumName="FIS.WORK_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 收费性质 -->
	<model:dataset id="shoufeiDS" enumName="FIS.INVOICE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 定价形式 -->
	<model:dataset id="dingjiaDS" enumName="FIS.PRICE_STANDARD" autoLoad="true" global="true"></model:dataset>
	<!-- 费用类型 -->
	<model:dataset id="feeTypeDS1" enumName="FIS.FEE_TYPE1" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="feeTypeDS2" enumName="FIS.FEE_TYPE2" autoLoad="true" global="true"></model:dataset>
<%-- 	<model:dataset id="feeTypeDS3" enumName="FIS.FEE_TYPE3" autoLoad="true" global="true"></model:dataset> --%>
	<!-- 物价局定价形式 -->
	<model:dataset id="priceTypeDS" enumName="FIS.PRICE_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="98%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save" id="save"/>
	<next:ToolBarItem id="conBtn" iconCls="save" text="保存并继续" handler="saveClickContinue" />
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
	
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fisPriceGoodsServiceDS" onsubmit="return false" class="L5form">
<fieldset>
	<legend>殡葬收费标准价格表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:20%">服务类型：</td>
			<td class="FieldInput" style="width:40%">
			<select id="workType" style="width:45%" field="workType" title="服务类型" onchange="selectFeeType(this.value)">
				<option dataset="workTypeDS"/>
			</select>
			<select id="feeType1" style="width:45%;display:none"  title="费用类型" onchange="changeFeeType(this.value)">
				<option dataset="feeTypeDS1"/>
			</select>
			<select id="feeType2" style="width:45%;display:none" title="费用类型" onchange="changeFeeType(this.value)">
				<option dataset="feeTypeDS2"/>
			</select>
<!-- 			<select id="feeType3" style="width:45%" title="费用类型" > -->
<!-- 				<option dataset="feeTypeDS3"/> -->
<!-- 			</select> -->
			</td>
			<td class="FieldLabel"  style="text-align:left"><font color="red">说明：选择“基本服务”或“延伸（选择）服务”。“基本服务”主要包括遗体接运（含抬尸、消毒）、存放（含冷藏）、火化和骨灰寄存等服务，“延伸（选择）服务”是指基本服务以外、供群众选择的特殊服务项目，包括遗体整容、遗体防腐、吊唁设施及设备租赁、丧葬用品费和骨灰盒费等。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">项目名称：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="项目名称" id="serviceName" field="serviceName" maxlength="50"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写殡仪服务项目名称</font></td>
		</tr>
		<tr id="priceType" style="display:none">
			<td class="FieldLabel" style="width:15%">物价局定价形式：</td>
			<td class="FieldInput" style="width:15%">
			<input id="priceType0" name="物价局定价形式" field="priceType" type="radio" value="0" onclick="selectPriceType()"/><label>定额</label>
			<input id="priceType1" name="物价局定价形式" field="priceType" type="radio" value="1" onclick="selectPriceType()"/><label>浮动</label>
			</td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr id="a1" style="display:none">
			<td class="FieldLabel" style="width:15%">定价金额：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="定价金额" id="price" field="price" maxlength="50" onchange="checkPriceDesc();CheckTxt('price','定价金额');"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">请输入数字</font></td>
		</tr>
		<tr id="a3" style="display:none">	
			<td class="FieldLabel" style="width:15%">浮动区间：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:20%" name="浮动区间" id="range" field="range" maxlength="50"  onchange="checkPriceDesc1();CheckTxt('range','浮动区间');"/>%
			&nbsp;&nbsp;&nbsp;&nbsp;价格区间：<input type="text" style="width:20%" name="最低价" id="priceMin" field="priceMin" maxlength="50"  onchange="checkPriceDesc2();CheckTxt('priceMin','最低价');"/> -
			<input type="text" style="width:20%" name="最高价" id="priceMax" field="priceMax" maxlength="50"  onchange="checkPriceDesc2();CheckTxt('priceMax','最高价');"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明 ：浮动百分比、价格区间选择其中一项输入，输入数字</font></td>
		</tr>
		<tr id="a2" style="display:none">	
			<td class="FieldLabel" style="width:15%">定价单位：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="定价单位" id="units" field="units" maxlength="50"  onchange="checkPriceDesc();"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">如：元/具，元/人次，元/次，元/年等</font></td>
		</tr>
		<tr id="a8" style="display:none">	
			<td class="FieldLabel" style="width:15%">加收比率：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="加收比率" id="range1" field="range" maxlength="50"  onchange="checkPriceDesc3();CheckTxt('range1','加收比率');"/>%</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">一级馆加收30%,二级馆加收20%,三级馆加收10%,请按照实际情况填写！</font></td>
		</tr>
		<tr id="a5" style="display:none">	
			<td class="FieldLabel" style="width:15%">初始里程数：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name="初始里程数" id="initiateMile" field="initiateMile" style="width:90%"/>公里</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：接运服务初始里程数,没有请填0</font></td>
		</tr>
		<tr id="a6" style="display:none">	
			<td class="FieldLabel" style="width:15%">初始价格：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name="初始价格" id="initiatePrice" field="initiatePrice" style="width:90%"/>元</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：初始里程数内的价格（定价）</font></td>
		</tr>
		<tr id="a7" style="display:none">	
			<td class="FieldLabel" style="width:15%">超出价格：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name="超出价格" id="overinitiatePrice" field="overinitiatePrice" style="width:90%" onchange="changeNote()"/>元/公里</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：超出初始里程数的价格,没有请填0</font></td>
		</tr>
		<tr id="a4" style="display:none">	
			<td class="FieldLabel" style="width:15%">收费标准：</td>
			<td class="FieldInput" style="width:15%"><label name="收费标准" id="priceDesc" field="priceDesc" ></label></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">收费性质：</td>
			<td class="FieldInput" style="width:15%">
			<input id="invoiceCodeType0" name="收费性质" field="invoiceCodeType" type="radio" value="0"/><label>行政事业性收费</label>
			<input id="invoiceCodeType1" name="收费性质" field="invoiceCodeType" type="radio" value="1"/><label>经营服务性收费</label>
			</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：选择行政事业性收费或经营服务性收费。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">定价形式：</td>
			<td class="FieldInput" style="width:15%">
			<input id="priceStandard0" name="定价形式" field="priceStandard" type="radio" value="0"/><label>政府定价</label>
			<input id="priceStandard1" name="定价形式" field="priceStandard" type="radio" value="1"/><label>政府指导价</label>
			<input id="priceStandard2" name="定价形式" field="priceStandard" type="radio" value="2"/><label>市场调节价</label>
			</td>
		<td class="FieldLabel" style="text-align:left"><font color="red">说明：选择政府定价 或 政府指导价 或 市场调节价</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">收费依据：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="收费依据" id="priceFileNum" field="priceFileNum" maxlength="50"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写物价局批准文件文号</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">执行时间：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="执行时间" id="priceExeTime" field="priceExeTime" 
													format="Y-m-d" onclick="LoushangDate(this)" /></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写该项收费标准的起始执行时间</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免对象：</td>
			<td class="FieldInput" style="width:15%">
			<input type="checkbox" name="remissionTarget" value="城市低保" field="remissionTarget"/>城市低保<br>
			<input type="checkbox" name="remissionTarget" value="农村低保" field="remissionTarget"/>农村低保<br>
			<input type="checkbox" name="remissionTarget" value="农村五保" field="remissionTarget"/>农村五保<br>
			<input type="checkbox" name="remissionTarget" value="优抚对象" field="remissionTarget" onclick="showRemiss(this)" id="remiss"/>优抚对象<br>
			<fieldset style="display:none" id="remissShow">
			     <input type="checkbox" name="remissionDetail" value="伤残" field="remissionDetail"/>伤残
			     <input type="checkbox" name="remissionDetail" value="三属" field="remissionDetail"/>三属
			     <input type="checkbox" name="remissionDetail" value="在乡复员" field="remissionDetail"/>在乡复员
			     <input type="checkbox" name="remissionDetail" value="带病回乡" field="remissionDetail"/>带病回乡
			     <br>
			     <input type="checkbox" name="remissionDetail" value="参战" field="remissionDetail"/>参战
			     <input type="checkbox" name="remissionDetail" value="参核" field="remissionDetail"/>参核
			     <input type="checkbox" name="remissionDetail" value="老兵" field="remissionDetail"/>老兵<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			     <input type="checkbox" name="remissionDetail" value="老烈子女" field="remissionDetail"/>老烈子女
			</fieldset>
			<input type="checkbox" name="remissionTarget" value="90以上老人" field="remissionTarget"/>90以上老人<br>
			<input type="checkbox" name="remissionTarget" value="全民" field="remissionTarget"/>全民</td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写城市低保、农村低保、农村五保、优抚对象、90以上老人、全民等，可多选。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免金额：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="减免金额" id="remissionMoney" field="remissionMoney" maxlength="50"  onchange="checkRemissionDesc();CheckTxt('remissionMoney','减免金额');"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明 : 填写最大减免金额，格式为数字</font></td>
		</tr>
		<tr>	
			<td class="FieldLabel" style="width:15%">减免单位：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="减免单位" id="remissionUnits" field="remissionUnits" maxlength="50"  onchange="checkRemissionDesc();"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">如：元/具，元/人次，元/次，元/年等</font></td>
		</tr>
		<tr>	
			<td class="FieldLabel" style="width:15%">政府减免标准：</td>
			<td class="FieldInput" style="width:15%"><label name="减免标准" id="remissionDesc" field="remissionDesc"></label></td>
			<td class="FieldLabel" style="text-align:left"><font color="red"></font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免依据：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="减免依据" id="remissionFileNum" field="remissionFileNum" maxlength="50" /></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写当地政府实行收费减免文件的名称及文号。</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">减免执行时间：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="减免执行时间"
								id="remissionExeTime" field="remissionExeTime" readonly="readonly"
								format="Y-m-d" onclick="LoushangDate(this)" /></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写该项目收费减免的起始执行时间</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">备注描述：</td>
			<td class="FieldInput" style="width:15%">
			<textarea id="note" name="note" field="note" onpropertychange="if(value.length>100) value=value.substr(0,100)" rows="5" style="width:90%"></textarea></td>
			<td class="FieldLabel" style="text-align:left"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">序号：</td>
			<td class="FieldInput" style="width:15%"><input type="text" style="width:90%" name="收费依据" id="scq" field="scq" maxlength="3" onblur="_isNum(this.value)"/></td>
			<td class="FieldLabel" style="text-align:left"><font color="red">说明：填写每项服务的顺序，输入阿拉伯数字整数，系统默认+5，可修改。</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>