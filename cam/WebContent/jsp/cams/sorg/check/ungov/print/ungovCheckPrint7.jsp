<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init7(){
	var somCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somCheckBusinessActivityDataSet");
	somCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckBusinessActivityDataSet.load();
	somCheckBusinessActivityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckBusinessActivityDataSet.newRecord({"taskCode":taskCode});
		}
	});
	//创建页面导航下拉框
	//createUngovEditSelect();
}
function save(){
}
function docPrint(){
    document.execCommand("Print", false);
}			
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<style>
.label6 {
	text-align:right;
	font-size: 13px;
	font-family: 宋体;
}
</style>

<model:datasets>
	<model:dataset id="somCheckBusinessActivityDataSet" cmd="com.inspur.cams.sorg.check.businessactivity.cmd.SomCheckBusinessActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center style='page-break-after:always'>
<div align=center style=" margin-top: 20px;width: 610px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post" dataset="somCheckBusinessActivityDataSet" onsubmit="return false">

<p class=MsoNormal align=center
	style='text-align: center; line-height: 20.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; color: black'>（二）业务活动表<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 20.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>（截止到本年度<span
	lang=EN-US>12</span>月<span lang=EN-US>31</span>日）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='line-height:20.0pt;mso-line-height-rule:exactly'><span
style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
color:black'>编制单位：<label class='label6' field="organizationUnit" style="width: 260;text-align:left" ></label><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span><span lang=EN-US><span
style='mso-spacerun:yes'></span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>　　　单位：元<span
lang=EN-US><o:p></o:p></span></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center
	width="610"
	style='width: 610; border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 24.0pt'>
		<td width="28%" rowspan=2
			style='width: 28.84%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="35%" colspan=3
			style='width: 35.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>上年度年末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="35%" colspan=3
			style='width: 35.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>本年度累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 24.0pt'>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 10.5pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="donationIncomePyUnlimit" id="捐赠收入1" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="donationIncomePyLimit" id="捐赠收入2" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="donationIncomePySum" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="donationIncomeTyUnlimit" id="捐赠收入3" name='"其中：捐赠收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="donationIncomeTyLimit" id="捐赠收入4" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="donationIncomeTySum" name='"其中：捐赠收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="duesIncomePyUnlimit" id="会费收入1" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="duesIncomePyLimit" id="会费收入2" name='"会费收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="duesIncomePySum" name='"会费收入"' style="width:98%" maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="duesIncomeTyUnlimit" id="会费收入3" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="duesIncomeTyLimit" id="会费收入4" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="duesIncomeTySum" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="serviceIncomePyUnlimit" id="提供服务收入1" name='"提供服务收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="serviceIncomePyLimit" id="提供服务收入2" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="serviceIncomePySum" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="serviceIncomeTyUnlimit" id="提供服务收入3" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="serviceIncomeTyLimit" id="提供服务收入4" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="serviceIncomeTySum" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="productIncomePyUnlimit" id="商品销售收入1" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="productIncomePyLimit" id="商品销售收入2" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="productIncomePySum" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="productIncomeTyUnlimit" id="商品销售收入3" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="productIncomeTyLimit" id="商品销售收入4" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="productIncomeTySum" name='"商品销售收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="govGrantsPyUnlimit" id="政府补助收入1" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="govGrantsPyLimit" id="政府补助收入2" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="govGrantsPySum" name='"政府补助收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="govGrantsTyUnlimit" id="政府补助收入3" name='"政府补助收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="govGrantsTyLimit" id="政府补助收入4" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="govGrantsTySum" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="invIncomePyUnlimit" id="投资收益1" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="invIncomePyLimit" id="投资收益2" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="invIncomePySum" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="invIncomeTyUnlimit" id="投资收益3" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="invIncomeTyLimit" id="投资收益4" name='"投资收益"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="invIncomeTySum" name='"投资收益"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherIncomePyUnlimit" id="其他收入1" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherIncomePyLimit" id="其他收入2" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherIncomePySum" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherIncomeTyUnlimit" id="其他收入3" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherIncomeTyLimit" id="其他收入4" name='"其他收入"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherIncomeTySum" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="incomeSumPyUnlimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="incomeSumPyLimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="incomeSumPySum" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="incomeSumTyUnlimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="incomeSumTyLimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="incomeSumTySum" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="businessCostPyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="businessCostPyLimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="businessCostPySum" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="businessCostTyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="businessCostTyLimit" name='"业务活动成本"' style="width:98%" maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="businessCostTySum" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 10.5pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="staffCostPyUnlimit" id="人员费用1" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="staffCostPyLimit" id="人员费用2" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="staffCostPySum" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="staffCostTyUnlimit" id="人员费用3" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="staffCostTyLimit" id="人员费用4" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="staffCostTySum" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="runningCostPyUnlimit" id="日常费用1" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="runningCostPyLimit" id="日常费用2" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="runningCostPySum" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="runningCostTyUnlimit" id="日常费用3" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="runningCostTyLimit" id="日常费用4" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="runningCostTySum" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 4.0; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="depreciationAssetsPyUnlimit" id="固定资产折旧1" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="depreciationAssetsPyLimit" id="固定资产折旧2" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="depreciationAssetsPySum" id="" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="depreciationAssetsTyUnlimit" id="固定资产折旧3" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="depreciationAssetsTyLimit" id="固定资产折旧4" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="depreciationAssetsTySum" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; tab-stops: 40.5pt; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>税费<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="taxesPyUnlimit" id="税费1" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="taxesPyLimit" id="税费2" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>			
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="taxesPySum" id="" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="taxesTyUnlimit" id="税费3" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="taxesTyLimit" id="税费4" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="taxesTySum" id="" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="manageCostPyUnlimit" id="管理费用1" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="manageCostPyLimit" id="管理费用2" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="manageCostPySum" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="manageCostTyUnlimit" id="管理费用3" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="manageCostTyLimit" id="管理费用4" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="manageCostTySum" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="raisingCostPyUnlimit" id="筹资费用1" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="raisingCostPyLimit" id="筹资费用2" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="raisingCostPySum" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="raisingCostTyUnlimit" id="筹资费用3" name='"筹资费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="raisingCostTyLimit" id="筹资费用4" name='"筹资费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="raisingCostTySum" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherCostPyUnlimit" id="其他费用1" name='"其他费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherCostPyLimit" id="其他费用2" name='"其他费用"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherCostPySum" name='"其他费用"' style="width:98%;text-align:right"  ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherCostTyUnlimit" id="其他费用3" name='"其他费用"' style="width:98%;text-align:right" onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherCostTyLimit" id="其他费用4" name='"其他费用"' style="width:98%;text-align:right"  onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="otherCostTySum" name='"其他费用"' style="width:98%;text-align:right"  ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20; height: 24.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="costSumPyUnlimit" name='"费用合计"' style="width:98%;text-align:right"  ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="costSumPyLimit" name='"费用合计"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="costSumPySum"  name='"费用合计"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="costSumTyUnlimit"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="costSumTyLimit"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 24.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="costSumTySum"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21; height: 17.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="limitToUnlimitPyUnlimt" id="限定性净资产转为非限定性净资产1" name='"限定性净资产转为非限定性净资产"' style="width:98%" maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="limitToUnlimitPyLimit" id="限定性净资产转为非限定性净资产2" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="limitToUnlimitPySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="limitToUnlimitTyUnlimit" id="限定性净资产转为非限定性净资产3" name='"限定性净资产转为非限定性净资产"' style="width:98%;text-align:right"  onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="limitToUnlimitTyLimit" id="限定性净资产转为非限定性净资产4" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="limitToUnlimitTySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22; height: 55.85pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>四、净资产变动额</span></b><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312'>（若为净资产减少额，以“<span
			lang=EN-US>-</span>”号填列）</span></b><b style='mso-bidi-font-weight: normal'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p></o:p></span></b></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="assetsChangePyUnlimit" name='"净资产变动额"' style="width:98%"  style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="assetsChangePyLimit" name='"净资产变动额"' style="width:98%" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="assetsChangePySum" name='"净资产变动额"' style="width:98%"  style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="assetsChangeTyUnlimit" name='"净资产变动额"' style="width:98%" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="assetsChangeTyLimit" name='"净资产变动额"' style="width:98%" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 55.85pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
		<label class='label6' field="assetsChangeTySum" name='"净资产变动额"' style="width:98%" maxlength="15" style='text-align:right'  ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; mso-yfti-lastrow: yes; height: 17.4pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>本年度年末资金余额<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'>（万元）<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		</td>
		<td width="71%" colspan=6 valign=middle
			style='width: 71.16%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 17.4pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; text-autospace: none'><span
			lang=EN-US
			style='font-size: 10.5pt; font-family: 楷体_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<label class='label6' type="text" name='本年度年末资金余额' field="remainingBalanceTy" style="width: 98%; text-align: center" maxlength="10" />
			</o:p></span></p>
		</td>
	</tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
