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
	createUngovDetailSelect();
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
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<style>
label {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋 ;
}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="somJxCheckFinanceDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.cmd.SomJxCheckFinanceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinance"></model:record>
	</model:dataset>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM1('6')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('8')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div style="width:800;position:absolute;left:expression((body.clientWidth-800)/2);">
<div class=Section1 style=''>
<form method="post" dataset="somJxCheckFinanceDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 12.0pt; '><b
	style=''><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>五、资产及财务情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal
	style='line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>（一）财务情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>上年度净资产合计：<span
	lang=EN-US>
<label style='width:100;' field="lastTotal" id="lastTotal"></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt; line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>本年度收入合计：<span
	lang=EN-US>
<label style='width:100;' id="earningTotal" field="earningTotal"></label>
	</span>元<span lang=EN-US><o:p></o:p></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;   line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>其中，1、提供服务收入：
<label id='earningTotal1' style='width:100;' field="serviceEarning" ></label>
	元（其中，政府购买服务收入：
<label  style='width:100;' field="organEarning" ></label>
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '>2</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>、接受社会捐赠：
<label  id='earningTotal2' onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" style='width:100;'  field="acceptEarning" ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '>3</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>、政府补助收入：
<label  id='earningTotal3'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;' field="assistanceEarning"  ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '>4</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>、其他收入：
<label  id='earningTotal4'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;' field="otherEarning"  ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>本年度费用合计：
<label field="chargeTotal" id="chargeTotal" style='width:100;'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>其中，<span
	lang=EN-US></span>1、业务活动成本：
<label  id='chargeTotal1'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;'  field="applyCharge" ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '>2</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>、公益事业支出：
<label  id='chargeTotal2'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;' field="comwealCharge"  ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '>3</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>、管理费用：
<label  id='chargeTotal3'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" style='width:100;'field="manageCharge"  ></label>
	元（其中工资福利
<label   onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;' field="payCharge"  ></label>
	元，办公开支
<label   onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;' field="officeCharge"  ></label>
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '>4</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>、其他费用：
<label  id='chargeTotal4'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" style='width:100;'field="manageOtherCharge"  ></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>本年度净资产合计：
<label id="netTotal"  field="netTotal" style='width:100;'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 21.0pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体'><span
	style='mso-spacerun: yes'>&nbsp;</span>*</span><span
	style='font-size: 14.0pt;  font-family: 黑体'>（上年度净资产合计<span
	lang=EN-US>+</span>本年度收入合计<span lang=EN-US>-</span>本年度费用合计<span
	lang=EN-US>=</span>本年度净资产合计）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 12.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '></span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>年度缴税总额
<label  onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;'  field="taxTotal"  ></label>
	元（其中缴营业税
<label   onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;' field="salesTax"  ></label>
	元，缴所得税
<label  onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;'  field="incomeTax"  ></label>
	元，缴其他税费
<label  onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;'  field="otherTax" ></label>
	元。）<span lang=EN-US><o:p></o:p></span></span></p>

	</form>


<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体; color: black'></span><span
	style='font-size: 14.0pt;  font-family: 黑体; color: black'>2013年未缴税的可填0<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='  line-height: 12.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体; color: black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='margin-left: 0cm; text-indent: 0cm; line-height: 12.0pt; ; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体; mso-bidi-font-family: 黑体; color: black'><span
	style='mso-list: Ignore'></span></span><span
	style='font-size: 14.0pt;  font-family: 黑体; color: black'>六、服务内容<span
	lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 12.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋;  color: black'>本年度在校学生人数<span
	lang=EN-US>(</span>教育类填写<span lang=EN-US>)
<label   field="inSchoolNum"  style='width:100;'  ></label>
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 12.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋;  color: black'>本年度共培训人数<span
	lang=EN-US>(</span>劳动类填写<span lang=EN-US>)
<label   field="trainNum"  style='width:100;'  ></label>
	</span>人数<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 12.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋;  color: black'>本年度共举行医疗服务人数<span
	lang=EN-US>(</span>卫生类填写<span lang=EN-US>)
<label   field="medicalNum"style='width:100;' ></label>
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 12.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋;  color: black'>本年度共举行文化服务活动<span
	lang=EN-US>(</span>文化类填写<span lang=EN-US>)
<label   field="cultureActivityNum" style='width:100;'></label>
	</span>次<span
	lang=EN-US><o:p></o:p></span></span></p>
</form>
</div>

</div>
</body>
</html>