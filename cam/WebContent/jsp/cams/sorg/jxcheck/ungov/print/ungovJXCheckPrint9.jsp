<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init9(){
	var somJxCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somJxCheckBusinessActivityDataSet");
	somJxCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBusinessActivityDataSet.load();
	somJxCheckBusinessActivityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBusinessActivityDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	//createUngovDetailSelect();
}
</script>
<style>
label {
	font-size: 13.0pt;
	font-family: 仿宋_GB2312 ';
}
</style>
<model:datasets>
	<model:dataset id="somJxCheckBusinessActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.cmd.SomJxCheckBusinessActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivity"></model:record>
	</model:dataset>
</model:datasets>
<div style='page-break-after:always'>
<div id="float_1"class="noprint">

</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='margin-left: 0cm; text-align: center; text-indent: 0cm; line-height: 150%; mso-list: l0 level1 lfo1'><![if !supportLists]><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 仿宋_GB2312'><span
	style='mso-list: Ignore'></span></span></b><![endif]><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2.业务活动表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right
	style='text-align: center; line-height: 150%'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>单位：
<span style="color:red;font-size: 15.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312">元</span>

	<span
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
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 rowspan=2
			style='width: 1.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=189 colspan=3
			style='width: 5.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>上年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=197 colspan=3
			style='width: 147.9pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: none; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>本年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1'>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>1<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomePyUnlimit" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomePyLimit" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomePySum" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomeTyUnlimit" name='"其中：捐赠收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomeTyLimit" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomeTySum" name='"其中：捐赠收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomePyUnlimit" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomePyLimit" name='"会费收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomePySum" name='"会费收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomeTyUnlimit" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomeTyLimit" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomeTySum" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomePyUnlimit" name='"提供服务收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomePyLimit" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomePySum" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomeTyUnlimit" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomeTyLimit" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomeTySum" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中：政府购买服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3.1<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyPyUnlimit" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyPyLimit" name='"其中：政府购买服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyPySum" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyTyUnlimit" name='"其中：政府购买服务收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyTyLimit" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyTySum" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>4<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomePyUnlimit" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomePyLimit" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomePySum" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomeTyUnlimit" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomeTyLimit" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomeTySum" name='"商品销售收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>5<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsPyUnlimit" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsPyLimit" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsPySum" name='"政府补助收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsTyUnlimit" name='"政府补助收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsTyLimit" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsTySum" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>6<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomePyUnlimit" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomePyLimit" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomePySum" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomeTyUnlimit" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomeTyLimit" name='"投资收益"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomeTySum" name='"投资收益"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>9<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomePyUnlimit" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomePyLimit" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomePySum" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomeTyUnlimit" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomeTyLimit" name='"其他收入"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomeTySum" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>11<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumPyUnlimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumPyLimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumPySum" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumTyUnlimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumTyLimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumTySum" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>12<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostPyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostPyLimit" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostPySun" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostTyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostTyLimit" name='"业务活动成本"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostTySum" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>13<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostPyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostPyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostPySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostTyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostTyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostTySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>14<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostPyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostPyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostPySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostTyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostTyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostTySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>15<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsPyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsPyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsPySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsTyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsTyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsTySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>税费<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>16<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesPyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
		</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesPyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesPySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesTyUnlimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesTyLimit" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesTySum" name='""' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>21<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostPyUnlimit" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostPyLimit" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostPySum" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostTyUnlimit" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostTyLimit" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostTySum" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>24<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostPyUnlimit" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostPyLimit" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostPySum" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostTyUnlimit" name='"筹资费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostTyLimit" name='"筹资费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostTySum" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>28<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostPyUnlimit" name='"其他费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostPyLimit" name='"其他费用"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostPySum" name='"其他费用"' style="width:98%;text-align:right;font-size: 8.0pt"  />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostTyUnlimit" name='"其他费用"' style="width:98%;text-align:right;font-size: 8.0pt"  />
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostTyLimit" name='"其他费用"' style="width:98%;text-align:right;font-size: 8.0pt"  />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostTySum" name='"其他费用"' style="width:98%;text-align:right;font-size: 8.0pt"  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>35<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumPyUnlimit" name='"费用合计"' style="width:98%;text-align:right;font-size: 8.0pt"  />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumPyLimit" name='"费用合计"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumPySum" name='"费用合计"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumTyUnlimit" name='"费用合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumTyLimit" name='"费用合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumTySum" name='"费用合计"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>40<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitPyUnlimt" name='"限定性净资产转为非限定性净资产"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitPyLimit" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitPySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitTyUnlimit" name='"限定性净资产转为非限定性净资产"' style="width:98%;text-align:right;font-size: 8.0pt"  />
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitTyLimit" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitTySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' onkeyup="value=value.replace(/[^\d]/g,'') "/>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; mso-yfti-lastrow: yes'>
		<td width=223
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>四、净资产变动额</span><tt><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（若为净资产减少额，以“<span
			lang=EN-US>-</span>”号填列）</span></tt><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p></o:p></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>45<o:p></o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangePyUnlimit" name='"净资产变动额"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangePyLimit" name='"净资产变动额"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' />
			</o:p></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangePySum" name='"净资产变动额"' style="width:98%"  maxlength="8" style='text-align:right;font-size: 8.0pt' />
			</o:p></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangeTyUnlimit" name='"净资产变动额"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt'  />
			</o:p></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangeTyLimit" name='"净资产变动额"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt' style='text-align:right;font-size: 8.0pt'  />
			</o:p></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangeTySum" name='"净资产变动额"' style="width:98%" maxlength="8" style='text-align:right;font-size: 8.0pt'  />
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
