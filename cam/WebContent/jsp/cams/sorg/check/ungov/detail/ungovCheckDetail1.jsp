<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="java.util.*"%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民办非企业单位</title>
<%
	//String username = ExtBspInfo.getUserInfo(request).getUserName();
	//String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
	//String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
	String taskCode = (String)request.getParameter("taskCode");
	String taskFlag = (String)request.getParameter("taskFlag");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
	String method=(String)request.getParameter("method");
%>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=taskCode%>';
var taskFlag='<%=taskFlag%>';
var taskId='<%=request.getParameter("taskId")%>';
var batch='<%=request.getParameter("batch")%>';
var batchYear='<%=request.getParameter("batchYear")%>';
var method='<%=method%>';
var flag = "break";
	//初始化
function init(){
	if(method=="INSERT"){
		var date='<%=DateUtil.getDay()%>';
		var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';
		
	}else{
		somCheckDataSet.setParameter("TASK_CODE", taskCode);
		somCheckDataSet.load();
	}
	//创建页面导航下拉框
	createUngovDetailSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	if(checkRecord.get('cnName').trim() == ''||checkRecord.get('cnName').trim() == '请输入民办非企业单位名称'){
		L5.Msg.alert("提示","民办非企业单位名称不能为空！");
		return "break";
		
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("checkRecord", checkRecord);
	command.execute("savePage1");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function clearValue(nameObj){
	if(nameObj.value == '请输入民办非企业单位名称'){
		var checkRecord=somCheckDataSet.getCurrent();
		checkRecord.set("cnName","");
	}
}
function fillBackValue(nameObj){
	if(nameObj.value == ''){
		var checkRecord=somCheckDataSet.getCurrent();
		checkRecord.set("cnName","请输入民办非企业单位名称");
	}
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
label {
	text-align:left;
	font-size: 14.0pt;
	font-family: 仿宋_GB2312;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM1('2')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="back1();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div align=center>
<div align=center style=" margin-top: 20px;width: 610px">

<p class=MsoNormal align=right style='margin-right:5.0pt;text-align:right;
line-height:19.0pt'><b><span style='font-size:14.0pt;font-family:宋体'>编号：10<span
lang=EN-US></span></span></b></p>

<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:34.0pt'><b><span
style='font-size:22.0pt;font-family:宋体'>民办非企业单位年度检查报告书</span></b></p>

<p class=MsoNormal align=center style='margin-top:7.8pt;text-align:center;
line-height:34.0pt'><b><span style='font-size:15.0pt;font-family:宋体'>（<span
lang=EN-US><label style='font-size:18.0pt;font-family:宋体; width:60pt' field="batchYear"></label></span>年度）</span></b></p>

<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>

<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
	
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>单位名称
<label title='单位名称' field="cnName" name='"单位名称"' style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" ></label>（盖章）</span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>登记证号
<label  title='登记证号' name='"民非登记证号"' field="sorgCode" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>单位形式
<label  title='单位性质' name='"单位性质"' field="sorgKind" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" dataset="sorgKindSelect" ></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>法定代表人
<label title='法定代表人' name='"法定代表人"' field="legalPeople" style="width:310;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label>（本人签章）</span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>代<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>码
<label  title='代码' name='"代码"' field="organCode" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>业务主管单位
<label  name="业务主管单位" field="borgName" title="业务主管单位" style="width:300;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" dataset="borgDataSet"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>所属行（事）业
<label  title='所属行（事）业' name='"所属行（事）业"' field="businessType" style="width:270;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" dataset="busScopeSelect"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>报告日期
<label id='reportDate'  name='"报告日期"' field="reportDate" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label></span></b></p>



<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal align=center style='text-align:center;line-height:34.0pt'><span
style='text-fit:240.0pt'><span style='font-size:15.0pt;font-family:黑体;
letter-spacing:2.7pt'>山东省民间组织管理局监制</span></span></p>

</div>
</form>
</body>
</html>
