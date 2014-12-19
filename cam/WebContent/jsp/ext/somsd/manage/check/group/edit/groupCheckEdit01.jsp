<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String username = ExtBspInfo.getUserInfo(request).getUserName();
	String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
	String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
	String method=(String)request.getParameter("method");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>

<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=taskCode%>';
var taskId='<%=request.getParameter("taskId")%>';
//var batch='<%=request.getParameter("batch")%>';
var batchYear='<%=request.getParameter("batchYear")%>';
	var method='<%=method%>';
	//初始化
function init(){
	if(method=="INSERT"){
		var date='<%=DateUtil.getDay()%>';
		somCheckDataSet.newRecord({"taskCode":taskCode,"taskId":taskId,"reportDate":date,"cnName":'<%=username%>',"batchYear":batchYear,"sorgType":'S',"status":"0","fillPeopleName":'<%=username%>',"fillPeopleId":'<%=peopleId%>',"fillPeopleArea":'<%=peopleArea%>',"currentActivity":'0'});
	}else{
		somCheckDataSet.setParameter("TASK_CODE", taskCode);
		somCheckDataSet.load();
	}
	createGroupEditSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	/*if(checkRecord.get('cnName').trim() == ''||checkRecord.get('cnName').trim() == '请输入社会团体名称'){
		L5.Msg.alert("提示","社会团体名称不能为空！");
		return "break";		
	}*/
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return "break";
	}

	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("checkRecord", checkRecord);
	command.execute("savePage1");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="cnName" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="reportDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage('02');"/>
	<input type="button" value="保存"  style="height: 25px; width: 80px; position: absolute; margin-left:120px;" onclick="save();"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
</div>
<div align=center>

<p class=MsoNormal align=right style='text-align:right;mso-outline-level:
1'><span style='font-size:15.0pt;mso-bidi-font-size:15.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>编号：15&nbsp&nbsp&nbsp&nbsp&nbsp<span lang=EN-US><o:p></o:p></span></span></p>

<div align=left style='width:800;margin-top:60;'>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div class=Section1 style='layout-grid:15.6pt'>
<br><br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:39.0pt;mso-bidi-font-size:16.0pt;font-family:黑体;
mso-hansi-font-family:黑体'>社 会 团 体<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:39.0pt;mso-bidi-font-size:16.0pt;font-family:黑体;
mso-hansi-font-family:黑体'>年 度 检 查 报 告 书<span lang=EN-US><o:p></o:p></span></span></p>
<br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><b><span style='font-size:16.0pt;font-family:宋体;mso-hansi-font-family:华文中宋'>&nbsp;&nbsp;（<span
lang=EN-US><span style='mso-spacerun:yes'><label style='width:60pt;font-size:18.0pt;font-family:仿宋' field="batchYear" ></label>
</span></span>年度）<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left style='text-indent:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>社团名称:
<input type="text" name="社团名称" field="cnName" style='width:310;'/>（盖章）
</span></p>


<p class=MsoNormal align=left style='text-indent:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>登记证号:
<input type="text" name="登记证号" field="sorgCode" onkeyup="value=value.replace(/[^\w\.\/]/ig,'').toUpperCase()"  style='width:220;'/>只输入数字和英文
</span></p>


<p class=MsoNormal align=left style='text-indent:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>报告日期:
<input type="text" id="reportDate" name='报告日期' field="reportDate" onClick="WdatePicker()" style="width:400"/>	
</span></p>


<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</form>
</body>
</html>