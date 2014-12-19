<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//初始化
function init9(){
	var somJxCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somJxCheckBusinessActivityDataSet");
	somJxCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBusinessActivityDataSet.load();
	somJxCheckBusinessActivityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBusinessActivityDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
}
</script>
<model:datasets>
	<model:dataset id="somJxCheckBusinessActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.cmd.SomJxCheckBusinessActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivity"></model:record>
	</model:dataset>
</model:datasets>
<div style='page-break-after:always'>
<div id="float_1" class="noprint">

</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='margin-left: 0cm; text-align: center; text-indent: 0cm; line-height: 150%; mso-list: l0 level1 lfo1'><![if !supportLists]><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋; mso-bidi-font-family: 仿宋'><span
	style='mso-list: Ignore'></span></span></b><![endif]><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2.业务活动表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right
	style='text-align: center; line-height: 150%'><span lang=EN-US
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位：元<span
	lang=EN-US><o:p></o:p></span></span></p>

<div align=center>
<form method="post" dataset="somJxCheckBusinessActivityDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes'>
		<td width=223 rowspan=2
			style='width: 167.6pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 rowspan=2
			style='width: 1.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=189 colspan=3
			style='width: 5.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>上年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=197 colspan=3
			style='width: 147.9pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: none; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>本年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1'>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中：政府购买服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3.1<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>5<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>6<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>9<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>11<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>12<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostPySun" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>13<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>14<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>15<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>税费<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>16<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>21<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostTySumlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>24<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>28<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>35<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumPyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>40<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitPyUnlimt" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitPyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitPySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; mso-yfti-lastrow: yes'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>四、净资产变动额</span><tt><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（若为净资产减少额，以“<span
			lang=EN-US>-</span>”号填列）</span></tt><span lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p></o:p></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>45<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangePyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangePyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangePySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangeTyUnlimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangeTyLimit" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=right
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangeTySum" style='font-size: 10.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>