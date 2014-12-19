<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
	//初始化
	function init15(){
		//createGroupDetailSelect();
		somCheckDonateDetailDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDonateDetailDataSet.load();
		somCheckDonateDetailDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckDonateDetailDataSet.newRecord({"taskCode":taskCode});
			}
		});
	}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
textarea {
	overflow: hidden;
}
</style>

<model:datasets>
	<!-- 本年度举办研讨、展览、培训、评比达标表彰等活动的情况 -->
	<model:dataset id="somCheckDonateDetailDataSet" cmd="com.inspur.cams.sorg.check.checkdonatedetail.cmd.SomCheckDonateDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail"></model:record>
	</model:dataset>
	<!-- 本年度举办活动类型 -->
	<model:dataset id="eventTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_EVENT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center style='page-break-after:always'>
<div align=center style="margin-top: 20px; width: 610px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left
	style='text-align: left; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（三）本年度接受捐赠资助情况和使用情况</span></b><span
	style='font-size: 14.0pt; font-family: 宋体'>（单位：人民币元）<b
	style='mso-bidi-font-weight: normal'><span lang=EN-US><o:p></o:p></span></b></span></p>
<form method="post" dataset=somCheckDonateDetailDataSet onsubmit="return false">
	<table cellspacing=0 cellpadding=0 width="610px" style="margin-top:15px;">
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>项<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>目<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>现<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>金<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>非现金折合<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>合<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>计<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>一、本年度捐赠收入<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="本年度捐赠收入-现金" field="cashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="本年度捐赠收入-非现金折合" field="convertCash" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="本年度捐赠收入-合计" field="total" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>（一）来自境内的捐赠<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内的捐赠-现金" field="onCashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内的捐赠-非现金折合" field="onConvertCash" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内的捐赠-合计" field="onTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>其中：来自境内自然人<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内自然人-现金" field="onPerCashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内自然人-非现金折合" field="onPerConvert" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内自然人-合计" field="onPerTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>来自境内组织<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内组织-现金" field="onOrgCashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内组织-非现金折合" field="onOrgConvert" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境内组织-合计" field="onOrgTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>（二）来自境外的捐赠<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外的捐赠-现金" field="offCashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外的捐赠-非现金折合" field="offConvertCash" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外的捐赠-合计" field="offTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>其中：来自境外自然人<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外自然人-现金" field="offPerCashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外自然人-非现金折合" field="offPerConvert" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外自然人-合计" field="offPerTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>来自境外组织<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外组织-现金" field="offOrgCashTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外组织-非现金折合" field="offOrgConvert" style="width: 98%;text-align:right" /></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label name="来自境外组织-合计" field="offOrgTotal" style="width: 98%;text-align:right" /></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-lastrow: yes; height: 374.2pt'>
			<td width="7%"
				style='width: 7.22%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 374.2pt'>
			<p class=MsoNormal align=center
				style='text-align: center; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>主要用途和<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='text-align: center; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>使用情况<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="92%" colspan=4
				style='width: 92.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 374.2pt'>
			<p class=MsoNormal style='tab-stops: 248.15pt'><span> 
				<textarea name='主要用途和使用情况' field="useDetail" style="width: 564px;height: 374.2pt" readonly="readonly"></textarea></span></p>
			</td>
		</tr>
		<![if !supportMisalignedColumns]>
		<tr height=0>
			<td width=54 style='border: none'></td>
			<td width=262 style='border: none'></td>
			<td width=146 style='border: none'></td>
			<td width=146 style='border: none'></td>
			<td width=137 style='border: none'></td>
		</tr>
		<![endif]>
	</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>