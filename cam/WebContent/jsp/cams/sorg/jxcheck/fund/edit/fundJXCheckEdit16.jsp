<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somJxCheckSupervisorOpinDataSet = L5.DatasetMgr.lookup("somJxCheckSupervisorOpinDataSet");
	somJxCheckSupervisorOpinDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckSupervisorOpinDataSet.load();
	somJxCheckSupervisorOpinDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckSupervisorOpinDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var somJxCheckSupervisorOpinDataSetIsValidate = somJxCheckSupervisorOpinDataSet.isValidate();
	if(somJxCheckSupervisorOpinDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckSupervisorOpinDataSetIsValidate);
		return;
	}
	var supervisorOpinRecord=somJxCheckSupervisorOpinDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("supervisorOpinRecord", supervisorOpinRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ16");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<style>
</style>
</head>

<body>
<model:datasets>
<model:dataset id="somJxCheckSupervisorOpinDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.cmd.SomJxCheckSupervisorOpinQueryCommand" global="true">
	<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxchecksupervisoropin.dao.SomJxCheckSupervisorOpin">
		<model:field name="opinion" type="string" rule="length{200}"/>
	</model:record>
</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('17')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('15')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
</div>
<div align=center>
<div align=center style="width: 800px; text-align: center">
<p class=MsoNormal align="center"
	style='margin-top: 7.8pt; mso-para-margin-top: .5gd'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>七、监事意见</span><span
	style='font-size: 11.0pt; mso-bidi-font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>（此栏只填写审计结论，请另附审计报告纸质文本）</span><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><o:p></o:p></span></p>
<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=643
	style='border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt'>
	<tr
		style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; mso-yfti-lastrow: yes;height:210pt'>
		<td width=643 valign=top
			style='width: 482.4pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt;'>
		<p class=MsoNormal
			style='margin-top: 7.8pt; mso-para-margin-top: .5gd'><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'> <textarea rows="" cols=""
			field="opinion" style="width: 482.4pt;height:200pt; overflow: auto;"></textarea> </span><span
			style='mso-spacerun: yes'>&nbsp;</span></span><span
			style='font-size: 12.0pt; font-family: 宋体'><span lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal>
  			<span style="text-align:left;color:red">输入的内容在200个字符以内</span> 
  		</p>
		</td>
	</tr>
</table>

<p class=MsoNormal
	style='text-indent: 348.0pt; mso-char-indent-count: 29.0'><span
	lang=EN-US
	style='font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='text-indent: 305.7pt; mso-char-indent-count: 29.0'><strong><span
	style='font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>监
事：<input field="name" width='100' maxlength="30"/></span></strong><span lang=EN-US
	style='font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp; </span><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-indent: 305.7pt; mso-char-indent-count: 29.0'><strong><span
	style='font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>日
期：<input type="text" field="signDate" width='100' format="Y-m-d"
	onclick="LoushangDate(this)" readonly /></span></strong><span lang=EN-US
	style='font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp; </span><o:p></o:p></span></p>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
