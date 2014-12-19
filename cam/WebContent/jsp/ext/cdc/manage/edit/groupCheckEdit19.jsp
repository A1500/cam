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
	var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkRecord", checkRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage19");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function back(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
<!--[if lte IE 7]><div></div><![endif]--> <input type="button"
	value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="save();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="back();" />
</div>
<div align=center>
<div style="margin-top: 60px; width: 800px">
<p class=MsoNormal align=center
	style='margin-top: 7.8pt; mso-para-margin-top: .5gd; text-align: center'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>七、年检审查意见<span
	lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	width="100%"
	style='width: 100.0%; border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 231.65pt'>
		<td width="5%" rowspan=2
			style='width: 5.8%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 231.65pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>业务主管单位初审意见</span><span
			lang=EN-US style='font-size: 14.0pt'><o:p></o:p></span></p>
		</td>
		<td width="94%" colspan=2 valign=top
			style='width: 94.2%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: none; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 231.65pt'>
		<p class=MsoNormal align=center style="margin-top: 7.8pt;"><span
			lang=EN-US style='font-size: 14.0pt'><o:p>
			<textarea field="borgOpinionDesc" name="业务主管单位初审意见" style="width: 700" rows="18"></textarea>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 33.75pt'>
		<td width="66%" valign=top
			style='width: 66.46%; border: none; border-bottom: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
		<p class=MsoNormal align=right style='text-align: right'><span
			style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>日期</span><span
			lang=EN-US style='font-size: 14.0pt'><o:p></o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
		<p class=MsoNormal><span lang=EN-US style='font-size: 14.0pt'><o:p>
			<input name='日期' field="borgCheckDate" style="width: 80%" format="Y-m-d"
				onclick="LoushangDate(this)" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 275.95pt'>
		<td width="5%" rowspan=2
			style='width: 5.8%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 275.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>登记管理机关审定意见</span><span
			lang=EN-US style='font-size: 14.0pt'><o:p></o:p></span></p>
		</td>
		<td width="94%" colspan=2 valign=top
			style='width: 94.2%; border: none; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 275.95pt'>
		<p class=MsoNormal align=center style="margin-top: 7.8pt;"><span
			lang=EN-US style='font-size: 14.0pt'><o:p>
			<textarea field="checkResultDesc" name="登记管理机关审定意见" style="width: 700" rows="22"></textarea>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; mso-yfti-lastrow: yes; height: 41.75pt'>
		<td width="66%" valign=top
			style='width: 66.46%; border: none; border-bottom: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 41.75pt'>
		<p class=MsoNormal align=right style='text-align: right'><span
			style='font-size: 14.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>日期</span><span
			lang=EN-US style='font-size: 14.0pt'><o:p></o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.74%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 41.75pt'>
		<p class=MsoNormal><span lang=EN-US style='font-size: 14.0pt'><o:p>
			<input name='日期' field="checkTime" style="width: 80%" format="Y-m-d"
				onclick="LoushangDate(this)" />
		</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
