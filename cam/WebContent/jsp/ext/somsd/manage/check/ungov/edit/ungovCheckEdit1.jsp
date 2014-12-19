<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="java.util.*"%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民办非企业单位</title>
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
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=taskCode%>';
var taskId='<%=request.getParameter("taskId")%>';
//var batch='<%=request.getParameter("batch")%>';
var batchYear='<%=request.getParameter("batchYear")%>';
var method='<%=method%>';
var flag = "break";
	//初始化
function init(){
	if(method=="INSERT"){
		var date='<%=DateUtil.getDay()%>';
		somCheckDataSet.newRecord({"taskCode":taskCode,"taskId":taskId,"reportDate":date,"batchYear":batchYear,"cnName":'<%=username%>',"sorgType":'M',"status":"0","fillPeopleName":'<%=username%>',"fillPeopleId":'<%=peopleId%>',"fillPeopleArea":'<%=peopleArea%>',"currentActivity":'0'});
		
	}else{
		somCheckDataSet.setParameter("TASK_CODE", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(){
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somCheckDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").value = borgCode;
				}
			}
		});
	}
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	/*if(checkRecord.get('cnName').trim() == ''||checkRecord.get('cnName').trim() == '请输入民办非企业单位名称'){
		L5.Msg.alert("提示","民办非企业单位名称不能为空！");
		return "break";		
	}	*/
	if(document.getElementById("borgName").value == ""){
			L5.Msg.alert("提示","请填写业务主管单位！");
			return "break";
		}
	checkRecord.set('borgName',document.getElementById("borgName").value);
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
		return "break";
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
</script>
<meta name=Generator content="Microsoft Word 12 (filtered)">
<style>

</style>
</head>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="cnName" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="legalPeople" type="string" rule="require" />
			<model:field name="organCode" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="require" />
			<model:field name="businessType" type="string" rule="require" />
			<model:field name="reportDate" type="string" rule="require" />
				
		</model:record>
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
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('2')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
</div>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div align=center>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=right style='margin-right:100.0pt;text-align:right;
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

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>单位名称
<input type="text" title='单位名称'style='margin-left:25.0pt' field="cnName" name='"单位名称"'  style="width:400"  maxlength="100"/>（盖章）</span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>登记证号
<input type="text"style='margin-left:25.0pt' title='登记证号' name='"民非登记证号"' field="sorgCode" style="width:400"  onkeyup="value=value.replace(/[^\-\w\.\/]/ig,'').toUpperCase()"   maxlength="20"/>只输入数字和英文</span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>单位形式<span style='font-size:10.5pt;font-family:楷体_GB2312'>
  <select field="sorgKind" style="margin-left:25.0pt;width:400" name='单位性质'>
	<option dataset='sorgKindSelect' />
</select></span>
</span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>法定代表人
<input type="text"style='margin-left:8.0pt' title='法定代表人' name='"法定代表人"' field="legalPeople" style="width:400" maxlength="72"/>（本人签章）</span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>代<span lang=EN-US>&nbsp;&nbsp;&nbsp; </span>码
<input type="text"style='margin-left:30.0pt' title='代码' name='"代码"' field="organCode" style="width:400"  maxlength="10"/></span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>业务主管单位
<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位" style="width:380"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','-20')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
	<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
					<ul></ul> 
	</div>
	<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/></span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>所属行（事）业<span style='font-size:10.5pt;font-family:楷体_GB2312'>
<select field="businessType" name='所属行（事）业' style="width:400">
<option  dataset="busScopeSelect" />
</select></span>
</span></b></p>

<p class=MsoNormal align=left style='margin-left:280.0pt;text-indent: 16.0pt;line-height:50.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>报告日期
<input type="text" id="reportDate" name='制定会费标准的时间' field="reportDate" onClick="WdatePicker()" style="margin-left:25.0pt;width:400"/>
</span></b></p>

<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US
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
