<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init7(){
	var somJxCheckFinanceDataSet = L5.DatasetMgr.lookup("somJxCheckFinanceDataSet");
	somJxCheckFinanceDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckFinanceDataSet.load();
	somJxCheckFinanceDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckFinanceDataSet.newRecord();
		}
	});
	/*somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();*/
	//创建页面导航下拉框
	//createUngovDetailSelect();
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
<style>
.label7 {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋_GB2312 ;
}
</style>
<model:datasets>
	<model:dataset id="somJxCheckFinanceDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.cmd.SomJxCheckFinanceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinance"></model:record>
	</model:dataset>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<div align='center' style='page-break-after:always'>
<div class=Section1 align="left" style=' width: 800px; '>
<form method="post" dataset="somJxCheckFinanceDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 24.0pt; '><b
	style=''><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>五、资产及财务情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal
	style='line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>（一）财务情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>上年度净资产合计：<span
	lang=EN-US>
<label style='width:100;' field="lastTotal" id="lastTotal" class='label7'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt; line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>本年度收入合计：<span
	lang=EN-US>
<label style='width:100;' id="earningTotal" field="earningTotal" class='label7'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;   line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>其中，1、提供服务收入：
<label id='earningTotal1' style='width:100;' field="serviceEarning"  class='label7'></label>
	元（其中，政府购买服务收入：
<label  style='width:100;' field="organEarning"  class='label7'></label>
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>2</span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>、接受社会捐赠：
<label  id='earningTotal2' onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" style='width:100;'  field="acceptEarning"  class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>3</span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>、政府补助收入：
<label  id='earningTotal3'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;' field="assistanceEarning"   class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>4</span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>、其他收入：
<label  id='earningTotal4'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;' field="otherEarning"   class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>本年度费用合计：
<label field="chargeTotal" id="chargeTotal" style='width:100;' class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>其中，<span
	lang=EN-US></span>1、业务活动成本：
<label  id='chargeTotal1'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;'  field="applyCharge"  class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>2</span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>、公益事业支出：
<label  id='chargeTotal2'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"style='width:100;' field="comwealCharge"   class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>3</span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>、管理费用：
<label  id='chargeTotal3'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" style='width:100;'field="manageCharge"   class='label7'></label>
	元（其中工资福利
<label   onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;' field="payCharge"   class='label7'></label>
	元，办公开支
<label   onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;' field="officeCharge"   class='label7'></label>
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 73.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>4</span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>、其他费用：
<label  id='chargeTotal4'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" style='width:100;'field="manageOtherCharge"   class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>本年度净资产合计：
<label id="netTotal"  field="netTotal" style='width:100;' class='label7'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 21.0pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体'><span
	style='mso-spacerun: yes'>&nbsp;</span>*</span><span
	style='font-size: 14.0pt;  font-family: 黑体'>（上年度净资产合计<span
	lang=EN-US>+</span>本年度收入合计<span lang=EN-US>-</span>本年度费用合计<span
	lang=EN-US>=</span>本年度净资产合计）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; '><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '></span><span
	style='font-size: 14.0pt;  font-family: 仿宋_GB2312; '>年度缴税总额
<label  onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;'  field="taxTotal"   class='label7'></label>
	元（其中缴营业税
<label   onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;' field="salesTax"   class='label7'></label>
	元，缴所得税
<label  onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;'  field="incomeTax"   class='label7'></label>
	元，缴其他税费
<label  onkeyup="value=value.replace(/[^\d.]/g,'')"style='width:100;'  field="otherTax"  class='label7'></label>
	元。）<span lang=EN-US><o:p></o:p></span></span></p>

	</form>


<p class=MsoNormal
	style='margin-left: 31.5pt;  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体; color: black'></span><span
	style='font-size: 14.0pt;  font-family: 黑体; color: black'>2013年未缴税的可填0<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='  line-height: 24.0pt; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体; color: black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='margin-left: 0cm; text-indent: 0cm; line-height: 24.0pt; ; '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体; mso-bidi-font-family: 黑体; color: black'><span
	style='mso-list: Ignore'></span></span><span
	style='font-size: 14.0pt;  font-family: 黑体; color: black'>六、服务内容<span
	lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 24.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋_GB2312;  color: black'>本年度在校学生人数<span
	lang=EN-US>(</span>教育类填写<span lang=EN-US>)
<label   field="inSchoolNum"  style='width:100;'   class='label7'></label>
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋_GB2312;  color: black'>本年度共培训人数<span
	lang=EN-US>(</span>劳动类填写<span lang=EN-US>)
<label   field="trainNum"  style='width:100;'   class='label7'></label>
	</span>人数<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋_GB2312;  color: black'>本年度共举行医疗服务人数<span
	lang=EN-US>(</span>卫生类填写<span lang=EN-US>)
<label   field="medicalNum"style='width:100;'  class='label7'></label>
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; '><span
	style='font-size: 15.0pt;  font-family: 仿宋_GB2312;  color: black'>本年度共举行文化服务活动<span
	lang=EN-US>(</span>文化类填写<span lang=EN-US>)
<label   field="cultureActivityNum" style='width:100;' class='label7'></label>
	</span>次<span
	lang=EN-US><o:p></o:p></span></span></p>
</form>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>

</div>