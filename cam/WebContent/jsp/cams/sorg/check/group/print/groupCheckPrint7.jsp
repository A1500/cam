<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init7(){
	var somCheckCashFlowDataSet = L5.DatasetMgr.lookup("somCheckCashFlowDataSet");
	somCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckCashFlowDataSet.load();
	somCheckCashFlowDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckCashFlowDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	//createGroupDetailSelect();
}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>

<model:datasets>
	<model:dataset id="somCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.check.checkcashflow.cmd.SomCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center style='page-break-after:always'>
<div align=center style="margin-top: 20px; width: 800px">

<p align=center
	style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（三）现金流量表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p align=center
	style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（截止到本年度12月31日）<span
	lang=EN-US></span><span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></p>
	
<form method="post" dataset="somCheckCashFlowDataSet" onsubmit="return false">
<p style='margin: 0 auto; line-height: 20.0pt;'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>编制单位： 
	<label  field="organizationUnit" style="width:240;text-align:left;"></label>
	<span lang=EN-US><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位：元<span lang=EN-US><o:p></o:p></span></span></p>

<div align=center width="800px">

<table border=1 cellspacing=0 cellpadding=0 width="800"
	style='width: 800px;border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid windowtext; mso-border-insidev: .75pt solid windowtext'>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .75pt; mso-border-right-alt: .75pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=center
			style='text-align: center; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .75pt; mso-border-bottom-alt: .75pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=center
			style='text-align: center; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>金<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>一、业务活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>接受捐赠收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baReceiveDonations" name='"接受捐赠收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>收取会费收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baGatherDues" name='"收取会费收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>提供服务收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baRenderServices" name='"提供服务收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>销售商品收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baSellProduct" name='"销售商品收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>政府补助收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baGovernmentGrants" name='"政府补助收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>收到的其他与业务活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baInfolwOthers" name='"收到的其他与业务活动有关的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baInflowSum" name='"现金流入小计"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>提供捐赠或者资助支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baDonatedPay" name='"提供捐赠或者资助支付的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>支付给员工以及为员工支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baPayEmployee" name='"支付给员工以及为员工支付的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp; </span><span
			style='mso-spacerun: yes'>&nbsp;</span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>购买商品、接受服务支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baProductServices" name='"购买商品、接受服务支付的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>支付的其他与业务活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baOutflowOthers" name='"支付的其他与业务活动有关的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baOutflowSum" name='"现金流出小计"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=center
			style='text-align: center; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>业务活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="baNetAmount" name='"业务活动产生的现金流量净额"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>二、投资活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>收回投资所收到的现金
		<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="iaRegoupingOutlay" name='"收回投资所收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
	<tr style='height: 18.0pt'>
		<td width="66%" valign=middle
			style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p
			style='line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; font-family: 宋体; color: black'>取得投资收益所收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="33%" valign=middle
			style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
		<p align=right
			style='text-align: right; line-height: 30.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="iaMadeIncome" name='"取得投资收益所收到的现金"' style="width: 98%; text-align: right" maxlength="10" />
			</p>
		</td>
	</tr>
</table>
</div>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
