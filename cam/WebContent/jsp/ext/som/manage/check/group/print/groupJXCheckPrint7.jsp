<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//初始化
function init7(){
	var somJxCheckFinanceDataSet = L5.DatasetMgr.lookup("somJxCheckFinanceDataSet");
	somJxCheckFinanceDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckFinanceDataSet.load();
	somJxCheckFinanceDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckFinanceDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
	//党建14、15项显示在该页
	/*somJxCheckPartyDataSet.setParameter("TASK_CODE", taskCode);
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
	});*/
}
</script>
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
<div id="float_1" class="noprint">

</div>

<div style="text-align: center">
<form method="post" onsubmit="return false"
	dataset="somJxCheckPartyDataSet">
	<div align='center'>
<div id="partyDiv" class=Section1 align="left"
	 style='layout-grid:10.6pt;width: 700px;'>
<p>&nbsp;</p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>14</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度开展党建活动情况（不少于150字）</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partyActivityDetail' style='width:700' rows='8'readonly></textarea>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>15</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、对于加强社会组织党组织建设工作有何思路或建议：</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partySuggest' style='width:700' rows='8'readonly></textarea>
</span></p>
</div>
</div>
</form>
<form method="post" dataset="somJxCheckFinanceDataSet" onsubmit="return false">
<table border=0 align="center"  style='layout-grid:10.6pt;width: 700px;'>
<tr>
<td>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><b><span
	style='font-size: 14.0pt; font-family: 黑体; '>六、财务情况</span></b><b><span lang=EN-US
	style='font-size: 14.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>
	<p>&nbsp;</p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>（一）财务情况<b><span
	lang=EN-US><o:p></o:p></span></b></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>上年度净资产合计：<span
	lang=EN-US>
	<label field="lastTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>本年度收入合计：<span
	lang=EN-US>
	&nbsp&nbsp&nbsp&nbsp<label field="earningTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>其中，1、提供服务收入：<span lang=EN-US><span>
	<label field="serviceEarning"  style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span></span>元（其中，政府购买服务收入:</span></p>
	
<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><span
	lang=EN-US>
	<label field="organEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>2</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、会费收入：<span
	lang=EN-US>
	<label field="feeEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>3</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、接受社会捐赠：<span
	lang=EN-US>
	<label field="acceptEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>4</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、政府补助收入：<span
	lang=EN-US>
	<label field="assistanceEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>5</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、其他收入：<span
	lang=EN-US>
	<label field="otherEarning" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>本年度费用合计：<span
	lang=EN-US>
	<label field="chargeTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>其中，<span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>1</span>、业务活动成本：<span lang=EN-US><span>
	<label field="applyCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span></span>元<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>2</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、公益事业支出：<span
	lang=EN-US>
	<label field="comwealCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>3</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、管理费用：<span
	lang=EN-US>
	<label field="manageCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元（其中工资福利<label field="payCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	，办公开支</span></p>
	
<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><label field="officeCharge"  style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	，其它<label field="otherCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 43.5pt;text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>4</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>、其他费用：<span
	lang=EN-US>
	<label field="manageOtherCharge" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>本年度净资产合计：<span
	lang=EN-US>
	<label field="netTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 14.0pt; font-family: 仿宋'>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'></span><span
	style='font-size: 14.0pt; font-family: 仿宋'><label id=checkYear style='font-size: 14.0pt;'></label>年度缴税总额<span
	lang=EN-US>
	<label field="taxTotal" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元（其中缴营业税<span lang=EN-US>
	<label field="salesTax" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元，缴所得税</span></p>
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'></span><span
	style='font-size: 14.0pt; font-family: 仿宋'><span lang=EN-US>
	<label field="incomeTax" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元，缴其他税费<span lang=EN-US>
	<label field="otherTax" style='border-bottom: solid 1px;width:100;font-size: 14.0pt; font-family: 仿宋'></label>
	</span>元。）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋;color:red'>*</span><span
	style='font-size: 14.0pt; font-family: 仿宋'><label id=checkYear1 style='font-size: 14.0pt;'></label>年未缴税的可填0<span
	lang=EN-US><o:p></o:p></span></span></p>
</td>
</tr>
</table>
</form>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>