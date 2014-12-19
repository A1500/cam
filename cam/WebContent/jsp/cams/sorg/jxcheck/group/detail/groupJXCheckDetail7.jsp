<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somJxCheckFinanceDataSet = L5.DatasetMgr.lookup("somJxCheckFinanceDataSet");
	somJxCheckFinanceDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckFinanceDataSet.load();
	somJxCheckFinanceDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckFinanceDataSet.newRecord();
		}
	});
	var somJxCheckDataSet = L5.DatasetMgr.lookup("somJxCheckDataSet");
	somJxCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckDataSet.load();
	somJxCheckDataSet.on("load",function(ds){
		var checkYear=ds.get("checkYear");
		document.getElementById("checkYear").innerHTML=checkYear;
		document.getElementById("checkYear1").innerHTML=checkYear;
	});
	//党建14、15项显示在该页
	somJxCheckPartyDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckPartyDataSet.load();
	somJxCheckPartyDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
			ds.newRecord();
			document.getElementById('partyDiv').style.display = 'none';
		}else{
			if(ds.get('ifBuildParty') != '1'){
				document.getElementById('partyDiv').style.display = 'none';
			}
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
</script>
<style media="print">
	.noprint     { display: none }
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckFinanceDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.cmd.SomJxCheckFinanceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckfinance.dao.SomJxCheckFinance"></model:record>
	</model:dataset>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="somJxCheckPartyDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckparty.cmd.SomJxCheckPartyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckParty"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage1('8')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('6')"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>

<div style="text-align: center">
<form method="post" onsubmit="return false"
	dataset="somJxCheckPartyDataSet">
	<div align='center'>
<div id="partyDiv" class=Section1 align="left"
	style=' width: 800px;display:block '>
<p>&nbsp;</p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>14</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度开展党建活动情况（不少于150字）</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partyActivityDetail' style='width:750' rows='8'readonly></textarea>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>15</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、对于加强社会组织党组织建设工作有何思路或建议：</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partySuggest' style='width:750' rows='8'readonly></textarea>
</span></p>
</div>

</form>
<form method="post" dataset="somJxCheckFinanceDataSet" onsubmit="return false">
<table border=0 align="center" style='width: 800px;'>
<tr>
<td>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.15pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt' align="center"><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>六、财务情况</span></b><b><span lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>
	<p>&nbsp;</p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（一）财务情况<b><span
	lang=EN-US><o:p></o:p></span></b></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>上年度净资产合计：<span
	lang=EN-US>
	<label field="lastTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本年度收入合计：<span
	lang=EN-US>
	<label field="earningTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>其中，1、提供服务收入：<span lang=EN-US><span>
	<label field="serviceEarning"  style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span></span>元（其中，政府购买服务收入：<span
	lang=EN-US>
	<label field="organEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、会费收入：<span
	lang=EN-US>
	<label field="feeEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、接受社会捐赠：<span
	lang=EN-US>
	<label field="acceptEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、政府补助收入：<span
	lang=EN-US>
	<label field="assistanceEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>5</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、其他收入：<span
	lang=EN-US>
	<label field="otherEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本年度费用合计：<span
	lang=EN-US>
	<label field="chargeTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>其中，<span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>1</span>、业务活动成本：<span lang=EN-US><span>
	<label field="applyCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span></span>元<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、公益事业支出：<span
	lang=EN-US>
	<label field="comwealCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、管理费用：<span
	lang=EN-US>
	<label field="manageCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元（其中工资福利<label field="payCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	，办公开支<label field="officeCharge"  style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	，其它<label field="otherCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、其他费用：<span
	lang=EN-US>
	<label field="manageOtherCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本年度净资产合计：<span
	lang=EN-US>
	<label field="netTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'><label id=checkYear style='font-size: 14.0pt;'></label>年度缴税总额<span
	lang=EN-US>
	<label field="taxTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元（其中缴营业税<span lang=EN-US>
	<label field="salesTax" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元，缴所得税<span lang=EN-US>
	<label field="incomeTax" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元，缴其他税费<span lang=EN-US>
	<label field="otherTax" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋_GB2312'></label>
	</span>元。）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red'>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'><label id=checkYear1 style='font-size: 14.0pt;'></label>年未缴税的可填0<span
	lang=EN-US><o:p></o:p></span></span></p>
</td>
</tr>
</table>
</form>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</body>
</html>
