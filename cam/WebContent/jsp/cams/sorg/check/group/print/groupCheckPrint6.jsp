<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
			//var taskCode='<%=request.getParameter("taskCode")%>';
		 	//初始化
			function init6(){
				var somCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somCheckBusinessActivityDataSet");
				somCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
				somCheckBusinessActivityDataSet.load();
				somCheckBusinessActivityDataSet.on("load",function(ds){
					if(ds.getCount()==0){
						somCheckBusinessActivityDataSet.newRecord();
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
<style>
.label6 {
	text-align:right;
}
</style>

<model:datasets>
	<model:dataset id="somCheckBusinessActivityDataSet"
		cmd="com.inspur.cams.sorg.check.businessactivity.cmd.SomCheckBusinessActivityQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center width="800" style='page-break-after:always'>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center
	style='text-align: center; line-height: 21.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（二）业务活动表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 21.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（截止到本年度12月31日）<span
	lang=EN-US></span><span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset="somCheckBusinessActivityDataSet" onsubmit="return false">
<p style='margin: 0 auto; line-height: 20.0pt;'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>编制单位： 
	<label class='label6'   field="organizationUnit" style="width:240;text-align:left;"></label>
	<span lang=EN-US><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位：元<span lang=EN-US><o:p></o:p></span></span></p>

<table border=1 cellspacing=0 cellpadding=0 width="800"
	style='border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='page-break-inside: avoid; height: 20.35pt'>
		<td width="28%" rowspan=2
			style='width: 28.84%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.35pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="35%" colspan=3
			style='width: 35.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.35pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>上年度年末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="35%" colspan=3
			style='width: 35.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.35pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>本年度累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='page-break-inside: avoid; height: 22.3pt'>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="donationIncomePyUnlimit"style="width:98%" ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="donationIncomePyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="donationIncomePySum" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="donationIncomeTyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="donationIncomeTyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="donationIncomeTySum" style="width:98%"></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="duesIncomePyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="duesIncomePyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="duesIncomePySum" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="duesIncomeTyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="duesIncomeTyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="duesIncomeTySum" style="width:98%"></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="serviceIncomePyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="serviceIncomePyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="serviceIncomePySum" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="serviceIncomeTyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="serviceIncomeTyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="serviceIncomeTySum" style="width:98%"></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="productIncomePyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="productIncomePyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="productIncomePySum" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="productIncomeTyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="productIncomeTyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="productIncomeTySum" style="width:98%"></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="govGrantsPyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="govGrantsPyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="govGrantsPySum" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="govGrantsTyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="govGrantsTyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="govGrantsTySum" style="width:98%"></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="invIncomePyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="invIncomePyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="invIncomePySum" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="invIncomeTyUnlimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label class='label6'   field="invIncomeTyLimit" style="width:98%"></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="invIncomeTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
			<label class='label6'   field="otherIncomePyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherIncomePyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherIncomePySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherIncomeTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherIncomeTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherIncomeTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 24.0pt; mso-char-indent-count: 2.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="incomeSumPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="incomeSumPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="incomeSumPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="incomeSumTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="incomeSumTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="incomeSumTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="businessCostPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="businessCostPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="businessCostPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="businessCostTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="businessCostTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="businessCostTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="staffCostPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="staffCostPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="staffCostPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="staffCostTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="staffCostTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="staffCostTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="runningCostPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="runningCostPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="runningCostPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="runningCostTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="runningCostTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="runningCostTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 24.0pt; mso-char-indent-count: 2.0'><span
			style='font-size: 12.0pt; font-family: 宋体'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="depreciationAssetsPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="depreciationAssetsPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="depreciationAssetsPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="depreciationAssetsTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="depreciationAssetsTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="depreciationAssetsTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 48.0pt; mso-char-indent-count: 4.0'><span
			style='font-size: 12.0pt; font-family: 宋体'>税费<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="taxesPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="taxesPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="taxesPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="taxesTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="taxesTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="taxesTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="manageCostPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="manageCostPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="manageCostPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="manageCostTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="manageCostTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="manageCostTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="raisingCostPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="raisingCostPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="raisingCostPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="raisingCostTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="raisingCostTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="raisingCostTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherCostPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherCostPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherCostPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherCostTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherCostTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="otherCostTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 24.0pt; mso-char-indent-count: 2.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="costSumPyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="costSumPyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="costSumPySum" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="costSumTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="costSumTyLimit" style="width:98%"></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label class='label6'   field="costSumTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 34.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<p class=MsoNormal><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="limitToUnlimitPyUnlimt" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="limitToUnlimitPyLimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="limitToUnlimitPySum" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="limitToUnlimitTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="limitToUnlimitTyLimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="limitToUnlimitTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='height: 51.05pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<p class=MsoNormal><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>四、净资产变动额</span><tt><span
			style='font-size: 12.0pt; color: black'>（若为净资产减少额，以<span
			lang=EN-US>“-”</span>号填列）</span></tt><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p></o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label class='label6'   field="assetsChangePyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label class='label6'   field="assetsChangePyLimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label class='label6'   field="assetsChangePySum" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label class='label6'   field="assetsChangeTyUnlimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label class='label6'   field="assetsChangeTyLimit" style="width:98%"></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label class='label6'   field="assetsChangeTySum" style="width:98%"></label>
		</td>
	</tr>
	<tr style='mso-yfti-lastrow: yes; height: 34.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>本年度年末资金余额<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（万元）<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="71%" colspan=6 valign=middle
			style='width: 71.16%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label class='label6'   field="remainingBalanceTy" style="width:98%;text-align:center;"></label>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
