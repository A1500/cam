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
	var somJxCheckFinanceDataSetIsValidate = somJxCheckFinanceDataSet.isValidate();
	if(somJxCheckFinanceDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckFinanceDataSetIsValidate);
		return;
	}
	var JxCheckFinanceRecord=somJxCheckFinanceDataSet.getCurrent();
	JxCheckFinanceRecord.set('netTotal',document.getElementById('netTotal').innerHTML);
	JxCheckFinanceRecord.set('earningTotal',document.getElementById('earningTotal').innerHTML);
	JxCheckFinanceRecord.set('chargeTotal',document.getElementById('chargeTotal').innerHTML);
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("JxCheckFinanceRecord", JxCheckFinanceRecord);
	command.setParameter("checkRecord", somCheckDataSet.getCurrent());
	command.setParameter("taskCode", taskCode);
	command.execute("savePageM7");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
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

	document.getElementById('netTotal').innerHTML =num.toFixed(2);

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
	document.getElementById('earningTotal').innerHTML =num.toFixed(2);

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
	document.getElementById('chargeTotal').innerHTML =num1.toFixed(2);
}
</script>
<style>

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
<div id="float" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('6')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('8')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>

<div style="width:800;position:absolute;left:expression((body.clientWidth-800)/2);">
<div class=Section1 style='layout-grid: 15.6pt'>
<form method="post" dataset="somJxCheckFinanceDataSet" onsubmit="return false">
<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>五、资产及财务情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（一）财务情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>上年度净资产合计：<span
	lang=EN-US>
<input  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"  field="lastTotal" id="lastTotal" type="text" maxlength="10" name='"上年度净资产合计"' />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>本年度收入合计：<span
	lang=EN-US>
<label id="earningTotal" field="earningTotal" name='"本年度收入合计"'style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中，1、提供服务收入：
<input id='earningTotal1'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"  maxlength="10" field="serviceEarning" name='"提供服务收入"'/>
	元（其中，政府购买服务收入：
<input  onkeyup="value=value.replace(/[^\d.]/g,'')"  maxlength="10" field="organEarning" name='"政府购买服务收入"' />
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、接受社会捐赠：
<input  id='earningTotal2' onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();"  maxlength="10" field="acceptEarning" name='"接受社会捐赠"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、政府补助收入：
<input  id='earningTotal3'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="assistanceEarning" maxlength="10" name='"政府补助收入"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>4</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、其他收入：
<input  id='earningTotal4'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="otherEarning" maxlength="10" name='"其他收入"'/>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>本年度费用合计：
<label field="chargeTotal" id="chargeTotal" name='"本年度费用合计"'style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'></label>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中，<span
	lang=EN-US></span>1、业务活动成本：
<input  id='chargeTotal1'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" maxlength="10" field="applyCharge" name='"业务活动成本"'/>
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、公益事业支出：
<input  id='chargeTotal2'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="comwealCharge" maxlength="10" name='"公益事业支出"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、管理费用：
<input  id='chargeTotal3'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="manageCharge" maxlength="10" name='"管理费用"'/>
	元（其中工资福利
<input   onkeyup="value=value.replace(/[^\d.]/g,'')" field="payCharge" maxlength="10" name='"工资福利"'/>
	元，办公开支
<input   onkeyup="value=value.replace(/[^\d.]/g,'')" field="officeCharge" maxlength="10" name='"办公开支"'/>
	元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 84.0pt; mso-char-indent-count: 6.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>4</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、其他费用：
<input  id='chargeTotal4'  onkeyup="value=value.replace(/[^\d.]/g,'');countTotle();" field="manageOtherCharge" maxlength="10" name='"其他费用"' />
	元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>本年度净资产合计：
<label id="netTotal" maxlength="10" field="netTotal" name='"本年度净资产合计"'style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312' ></label>
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
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 31.5pt; mso-para-margin-left: 3.0gd; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>年度缴税总额
<input  onkeyup="value=value.replace(/[^\d.]/g,'')"  field="taxTotal" maxlength="10" name='"年度缴税总额"' />
	元（其中缴营业税
<input   onkeyup="value=value.replace(/[^\d.]/g,'')" field="salesTax" maxlength="10" name='"缴营业税"'/>
	元，缴所得税
<input  onkeyup="value=value.replace(/[^\d.]/g,'')"  field="incomeTax" maxlength="10" name='"缴所得税"'/>
	元，缴其他税费
<input  onkeyup="value=value.replace(/[^\d.]/g,'')"  field="otherTax" name='"缴其他税费"' maxlength="10"/>
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
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; color: black'>本年度在校学生人数<span
	lang=EN-US>(</span>教育类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="inSchoolNum" name="本年度在校学生人数"  maxlength="6" />
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; color: black'>本年度共培训人数<span
	lang=EN-US>(</span>劳动类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="trainNum" name="本年度共培训人数"  maxlength="6" />
	</span>人数<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; color: black'>本年度共举行医疗服务人数<span
	lang=EN-US>(</span>卫生类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="medicalNum" name="本年度共举行医疗服务人数"  maxlength="6" />
	</span>人数<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 15.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; color: black'>本年度共举行文化服务活动<span
	lang=EN-US>(</span>文化类填写<span lang=EN-US>)
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" field="cultureActivityNum" name="本年度共举行文化服务活动"  maxlength="6" />
	</span>次<span
	lang=EN-US><o:p></o:p></span></span></p>
</form>
</div>

</div>
</body>
</html>