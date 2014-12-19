<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init12(){
	//创建页面导航下拉框
	//createUngovDetailSelect();
	/*somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on('load',function (){
		if(somCheckDataSet.getCount() != 0){
			var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
			command.setParameter("checkYear",somCheckDataSet.get('checkYear'));
			command.setParameter("fillPeopleId",somCheckDataSet.get('fillPeopleId'));
			command.execute("queryLastYearCheckResult");
			document.getElementById("lastYearCheckResult").innerHTML = command.getReturn("lastYearCheckResult");
		}
	});*/
}
function save(){}
</script>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>

<div id="float_1"class="noprint">	

</div>
<div align=center>
<div align=left style=" width: 565px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;mso-para-margin-bottom:.5gd'><b><span
style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>十、审批意见<span lang=EN-US><o:p></o:p></span></span></b></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 0cm 0cm 0cm; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: 1.5pt double windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 31.65pt'>
		<td width=565 colspan=2
			style='width: 424.05pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 31.65pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><b><span
			style='font-size: 16.0pt; mso-bidi-font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>去年年检结果</span></b><span
			lang=EN-US
			style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 206.25pt'>
		<td width=565 colspan=2 valign=center align="center"
			style='width: 424.05pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 66.25pt'>
		<label id="lastYearCheckResult"style='font-size: 16.0pt; mso-bidi-font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'></label>	
		</td>
	</tr>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 31.65pt'>
		<td width=565 colspan=2
			style='width: 424.05pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 31.65pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><b><span
			style='font-size: 16.0pt; mso-bidi-font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>业务主管单位初审意见</span></b><span
			lang=EN-US
			style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 206.25pt'>
		<td width=565 colspan=2 valign=bottom
			style='width: 424.05pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 206.25pt'>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='margin-left: 6.0pt; mso-para-margin-left: .57gd; line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>(</span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>公章<span
			lang=EN-US>)<o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>日</span><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 40.85pt'>
		<td width=565 colspan=2 valign=bottom
			style='width: 424.05pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 40.85pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><b><span
			lang=EN-US
			style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></b><b><span lang=EN-US
			style='font-size: 16.0pt; mso-bidi-font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;</span></span></b><b><span
			style='font-size: 16.0pt; mso-bidi-font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>登记管理机关审核意见</span></b></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 174.75pt'>
		<td width=283 valign=bottom
			style='width: 212.05pt; border-top: none; border-left: solid windowtext 1.0pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 174.75pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan; tab-stops: 52.0pt'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>经办人：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan; tab-stops: 52.0pt'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=283 valign=bottom
			style='width: 212.05pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 174.75pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan; tab-stops: 52.0pt'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>负责人：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan; tab-stops: 52.0pt'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly; mso-pagination: widow-orphan; tab-stops: 52.0pt'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 68.2pt'>
		<td width=565 colspan=2
			style='width: 424.05pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 68.2pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><b><span
			style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 宋体; mso-font-kerning: 0pt'>备<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>注<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; mso-yfti-lastrow: yes; height: 115.35pt'>
		<td width=565 colspan=2 valign=top
			style='width: 424.05pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0cm 0cm 0cm; height: 115.35pt'>
		<p class=MsoNormal
			style='mso-pagination: widow-orphan; tab-stops: 60.55pt'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-font-kerning: 0pt'>年检联系人姓名：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='mso-pagination: widow-orphan; tab-stops: 60.55pt'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-font-kerning: 0pt'>职务：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='mso-pagination: widow-orphan; tab-stops: 60.55pt'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-font-kerning: 0pt'>手机：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='mso-pagination: widow-orphan; tab-stops: 60.55pt'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-font-kerning: 0pt'><span
			style='mso-spacerun: yes'>&nbsp;</span><o:p></o:p></span></p>
		</td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
