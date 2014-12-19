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
	createGroupDetailSelect();
}
function nextPage(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail19.jsp';
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
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="下一页"	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="返回"	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="back();" />
</div>
<div align=center>
<div align=center style="margin-top: 60px; width: 800px">

<p class=MsoNormal align=center
	style='margin-top: 7.8pt; mso-para-margin-top: .5gd; text-align: center'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>六、其它需要说明的情况<span
	lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	width="100%"
	style='width: 100.0%; border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-lastrow: yes; height: 601.0pt'>
		<td width="100%" valign=top
			style='width: 100.0%; border: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 601.0pt'>
		<p class=MsoNormal align=center
			style='margin-top: 7.8pt; mso-para-margin-top: .5gd; text-align: center'><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><o:p>
			<textarea field="otherDesc" name="其它需要说明的情况" style="width:730" rows="50" readonly></textarea>
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

