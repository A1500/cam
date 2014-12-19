<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
String date=sdf.format(new Date());
%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民 办 非 企 业 单 位 </title>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somJxCheckFinanceDataSet = L5.DatasetMgr.lookup("somJxCheckFinanceDataSet");
	somJxCheckFinanceDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckFinanceDataSet.load();
	somJxCheckFinanceDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckFinanceDataSet.newRecord();
		}
	});
	somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var JxCheckFinanceRecord=somJxCheckFinanceDataSet.getCurrent();
	JxCheckFinanceRecord.set('netTotal',document.getElementById('netTotal').innerHTML);
	JxCheckFinanceRecord.set('earningTotal',document.getElementById('earningTotal').innerHTML);
	JxCheckFinanceRecord.set('chargeTotal',document.getElementById('chargeTotal').innerHTML);
	JxCheckFinanceRecord.set('taxTotal',document.getElementById('taxTotal').innerHTML);
	var somJxCheckFinanceDataSetIsValidate = somJxCheckFinanceDataSet.isValidate();
	if(somJxCheckFinanceDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckFinanceDataSetIsValidate);
		return "break";
	}
	var earningTotal1=document.getElementById("earningTotal1").value;
	var organEarning=document.getElementById("organEarning").value;
	if(parseInt(organEarning) > (parseInt(earningTotal1))){
		L5.Msg.alert("提示","政府购买服务收入不能大于提供服务收入！");
		return "break";
	}
	var chargeTotal3=document.getElementById("chargeTotal3").value;
	var payCharge=document.getElementById("payCharge").value;
	var officeCharge=document.getElementById("officeCharge").value;
	if(parseInt(chargeTotal3) < (parseInt(payCharge)+parseInt(officeCharge))){
		L5.Msg.alert("提示","工资福利加上办公开支不能大于管理费用！");
		return "break";
	}
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return "break";
	}


	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("JxCheckFinanceRecord", JxCheckFinanceRecord);
	command.setParameter("checkRecord", somCheckDataSet.getCurrent());
	command.setParameter("taskCode", taskCode);
	command.execute("savePageM7");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function countTotle(){
	countTotal();
	var chargeTotal=document.getElementById('chargeTotal').innerHTML;
	var lastTotal=document.getElementById('lastTotal').value;
	var earningTotal=document.getElementById('earningTotal').innerHTML;
	if(chargeTotal==""){
		chargeTotal=0;
	}
	if(lastTotal==""){
		lastTotal=0;
	}
	if(earningTotal==""){
		earningTotal=0;
	}
	var num=parseFloat(lastTotal)+parseFloat(earningTotal)-parseFloat(chargeTotal);

	document.getElementById('netTotal').innerHTML =num.toFixed(6)*1;

}
function countTotal(){
	var earningTotal1=document.getElementById('earningTotal1').value;
	var earningTotal2=document.getElementById('earningTotal2').value;
	var earningTotal3=document.getElementById('earningTotal3').value;
	var earningTotal4=document.getElementById('earningTotal4').value;
	if(earningTotal1==""){
		earningTotal1=0;
	}
	if(earningTotal2==""){
		earningTotal2=0;
	}
	if(earningTotal3==""){
		earningTotal3=0;
	}
	if(earningTotal4==""){
		earningTotal4=0;
	}
	var num=parseFloat(earningTotal1)+parseFloat(earningTotal2)+parseFloat(earningTotal3)+parseFloat(earningTotal4);
	document.getElementById('earningTotal').innerHTML =num.toFixed(6)*1;

	var chargeTotal1=document.getElementById('chargeTotal1').value;
	var chargeTotal2=document.getElementById('chargeTotal2').value;
	var chargeTotal3=document.getElementById('chargeTotal3').value;
	var chargeTotal4=document.getElementById('chargeTotal4').value;
	if(chargeTotal1==""){
		chargeTotal1=0;
	}
	if(chargeTotal2==""){
		chargeTotal2=0;
	}
	if(chargeTotal3==""){
		chargeTotal3=0;
	}
	if(chargeTotal4==""){
		chargeTotal4=0;
	}
	var num1=parseFloat(chargeTotal1)+parseFloat(chargeTotal2)+parseFloat(chargeTotal3)+parseFloat(chargeTotal4);
	document.getElementById('chargeTotal').innerHTML =num1.toFixed(6)*1;
}

function countTaxTotal(){
	var salesTax=document.getElementById("salesTax").value;
	var incomeTax=document.getElementById("incomeTax").value;
	var otherTax=document.getElementById("otherTax").value;
	if(salesTax==""){
		salesTax=0;
	}
	if(incomeTax==""){
		incomeTax=0;
	}
	if(otherTax==""){
		otherTax=0;
	}
	var num=parseFloat(salesTax)+parseFloat(incomeTax)+parseFloat(otherTax);
	document.getElementById('taxTotal').innerHTML =num.toFixed(6)*1;
}
</script>
<style>

</style>
</head>
<body>
<model:datasets>
	<model:dataset id="somJxCheckFinanceDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.cmd.SomJxCheckFinanceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinance">
			<model:field name="lastTotal" type="string" rule="require" />
			<model:field name="serviceEarning" type="string" rule="require" />
			<model:field name="organEarning" type="string" rule="require" />
			<model:field name="acceptEarning" type="string" rule="require" />
			<model:field name="assistanceEarning" type="string" rule="require" />
			<model:field name="otherEarning" type="string" rule="require" />
			<model:field name="applyCharge" type="string" rule="require" />
			<model:field name="comwealCharge" type="string" rule="require" />
			<model:field name="manageCharge" type="string" rule="require" />
			<model:field name="payCharge" type="string" rule="require" />
			<model:field name="officeCharge" type="string" rule="require" />
			<model:field name="manageOtherCharge" type="string" rule="require" />
			<model:field name="taxTotal" type="string" rule="require" />
			<model:field name="salesTax" type="string" rule="require" />
			<model:field name="incomeTax" type="string" rule="require" />
			<model:field name="otherTax" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck">
			<model:field name="inSchoolNum" type="string" rule="require" />
			<model:field name="trainNum" type="string" rule="require" />
			<model:field name="medicalNum" type="string" rule="require" />
			<model:field name="cultureActivityNum" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('6')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('8')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>

<div align=center>
<div align=left style=" width: 800px">
<div class=Section1 style='layout-grid: 15.6pt'>
<form method="post" dataset="somJxCheckFinanceDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>五、资产及财务情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（一）财务情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>上年度净资产合计：<span
	lang=EN-US>
<input  onblur='checkFloat(this);'onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]-/g,'');countTotle();"  field="lastTotal" id="lastTotal" type="text" maxlength="15" name='"上年度净资产合计"' />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>本年度收入合计：<span
	lang=EN-US>
<label id="earningTotal" field="earningTotal" name='"本年度收入合计"'style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中，1、提供服务收入：
<input id='earningTotal1'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"  maxlength="15" field="serviceEarning" name='"提供服务收入"'/>
	元（其中，政府购买服务收入：
<input  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')"  maxlength="15" id='organEarning'field="organEarning" name='"政府购买服务收入"' />
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>、接受社会捐赠：
<input  id='earningTotal2' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"  maxlength="15" field="acceptEarning" name='"接受社会捐赠"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>、政府补助收入：
<input  id='earningTotal3'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="assistanceEarning" maxlength="15" name='"政府补助收入"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>、其他收入：
<input  id='earningTotal4'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="otherEarning" maxlength="15" name='"其他收入"'/>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>本年度费用合计：
<label field="chargeTotal" id="chargeTotal" name='"本年度费用合计"'style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中，<span
	lang=EN-US></span>1、业务活动成本：
<input  id='chargeTotal1'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" maxlength="15" field="applyCharge" name='"业务活动成本"'/>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>、公益事业支出：
<input  id='chargeTotal2'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="comwealCharge" maxlength="15" name='"公益事业支出"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>、管理费用：
<input  id='chargeTotal3'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="manageCharge" maxlength="15" name='"管理费用"'/>
	元（其中工资福利
<input   onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')"id='payCharge' field="payCharge" maxlength="15" name='"工资福利"'/>
	元，办公开支
<input   onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')"id='officeCharge' field="officeCharge" maxlength="15" name='"办公开支"'/>
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>、其他费用：
<input  id='chargeTotal4'  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="manageOtherCharge" maxlength="15" name='"其他费用"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>本年度净资产合计：
<label id="netTotal" maxlength="15" field="netTotal" name='"本年度净资产合计"'style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋' ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 21.0pt; mso-char-indent-count: 1.5; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'><span
	style='mso-spacerun: yes'>&nbsp;</span>*</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'>（上年度净资产合计<span
	lang=EN-US>+</span>本年度收入合计<span lang=EN-US>-</span>本年度费用合计<span
	lang=EN-US>=</span>本年度净资产合计）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt; mso-para-margin-left: 3.0gd; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>年度缴税总额
<label  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')"id='taxTotal'  field="taxTotal" maxlength="15" name='"年度缴税总额"'
style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋' ></label>
	元（其中缴营业税
<input   onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTaxTotal();"id='salesTax' field="salesTax" maxlength="15" name='"缴营业税"'/>
	元，缴所得税
<input  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTaxTotal();"id='incomeTax'  field="incomeTax" maxlength="15" name='"缴所得税"'/>
	元，缴其他税费
<input  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countTaxTotal();" id='otherTax' field="otherTax" name='"缴其他税费"' maxlength="15"/>
	元。）<span lang=EN-US><o:p></o:p></span></span></p>

	</form>


<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; color: black'></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; color: black'>年未缴税的可填0<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; color: black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='margin-left: 0cm; text-indent: 0cm; line-height: 24.0pt; mso-line-height-rule: exactly; mso-list: l0 level1 lfo1'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; mso-bidi-font-family: 黑体; color: black'><span
	style='mso-list: Ignore'></span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; color: black'>六、服务内容<span
	lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; color: black'>本年度在校学生人数<span
	lang=EN-US>(</span>教育类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="inSchoolNum" name="本年度在校学生人数"  maxlength="6" />
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; color: black'>本年度共培训人数<span
	lang=EN-US>(</span>劳动类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="trainNum" name="本年度共培训人数"  maxlength="6" />
	</span>人数<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; color: black'>本年度共举行医疗服务人数<span
	lang=EN-US>(</span>卫生类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="medicalNum" name="本年度共举行医疗服务人数"  maxlength="6" />
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; color: black'>本年度共举行文化服务活动<span
	lang=EN-US>(</span>文化类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="cultureActivityNum" name="本年度共举行文化服务活动"  maxlength="6" />
	</span>次<span
	lang=EN-US><o:p></o:p></span></span></p>
</form>
</div>

</div>
</body>
</html>