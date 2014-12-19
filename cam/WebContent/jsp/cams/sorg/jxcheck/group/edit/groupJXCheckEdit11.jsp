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
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return;
	}
	var checkRecord=somCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkRecord", checkRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage18");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function nextPage(){
	save();
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/edit/groupCheckEdit19.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
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
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="otherDesc" type="string" rule="require|length{3500}"/>
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">	
<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="save()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
<!--[if lte IE 7]><div></div><![endif]--> 
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="back();" />
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center
	style='text-align:center; text-indent: 32.15pt; mso-char-indent-count: 2.0; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; color: black'>八、<span
	lang=EN-US>2010</span>年年度工作总结及<span lang=EN-US>2011</span>年工作计划<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center width=800
	style='text-align:center;border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 354.4pt'>
		<td width=800 valign=top
			style='width: 500.4pt; border: solid windowtext 1.5pt; border-bottom: none; padding: 0cm 5.4pt 0cm 5.4pt; height: 354.4pt'>
		<p class=MsoNormal align=left
			style='margin-left: 5.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>1</span><span
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>、<span
			lang=EN-US>2010</span>年年度工作总结（<span lang=EN-US>500-1000</span>）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea fiel="" name='"年度工作总结"' style="width:750;overflow:auto" rows="30" ></textarea>
			</o:p></span></p>
			<br>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; mso-yfti-lastrow: yes; height: 354.35pt'>
		<td width=800 valign=top
			style='width: 500.4pt; border: solid windowtext 1.5pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt; height: 354.35pt'>
		<p class=MsoNormal align=left
			style='margin-left: 5.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>2</span><span
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>、<span
			lang=EN-US>2011</span>年年度工作计划（<span lang=EN-US>200-500</span>字）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea fiel="" name='"年度工作计划"' style="width:750;;overflow:auto" rows="25" ></textarea>
			</o:p></span></p>	
			<br>		
		</td>
	</tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
