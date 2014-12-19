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
	somJxCheckDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckDataSet.load();
	somJxCheckDataSet.on('load',function (){
		if(somJxCheckDataSet.getCount() == 0){
			somJxCheckDataSet.newRecord();
		}
	});	
	//创建页面导航下拉框
	createUngovDetailSelect();
	
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
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋_GB2312 ';
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
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
	<model:dataset id="dutySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_UNGOV_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessTypeSelect" enumName="JXSOM.UNGOV.BUSINESS_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('4')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM1('2')"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>

</div>
<div align=center>
<div align=left style="margin-top: 60px; width: 800px">

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><b><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>一、基本情况<span lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somJxCheckDataSet" onsubmit="return false">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>单位名称
<label field="cnName" style="width:400" ></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u><b><span lang=EN-US><o:p></o:p></span></b></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>业务主管单位
<label field="borgName" style="width:400" ></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>登记日期
<label field="downDate" style="width:150"></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u>证书有效期
<label field="certUsefulDate" style="width:150"></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span><span lang=EN-US><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>*</span><span
style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>凡证书有效期已过期的，请速来我局办理相关手续。</span><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:黑体'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>开办资金
<label field="initialFund" style="width:300"  ></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'></span></span></u>万元人民币<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>行业类型
<label field="businessType" style="width:150" dataset="businessTypeSelect"></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>单位性质
<label field="businessType" style="width:150" dataset='sorgKindSelect' ></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>住所
<label field="residence" style="width:400"></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>*</span><span
style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>未办理住所变更手续的，请速来我局办理相关手续</span><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:黑体'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>邮编
<label  field="sorgPost" style="width:300" ></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u></span><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
10.5pt;font-family:仿宋_GB2312;mso-hansi-font-family:仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>联系人
<label field="linkmanName" style="width:150"  ></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;</span></span>职务
<label field="linkmanDuty" style="width:150" dataset="dutySelect"></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>手机
<label  field="linkmanMobile" style="width:150"  ></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>电子邮件
<label field="sorgEmail" style="width:400" ></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>
联系电话
<label field="sorgPhone" style="width:150" ></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位传真
<label field="sorgFax" style="width:150"  ></label>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span><o:p></o:p></span></u></span>
</p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:仿宋_GB2312'>单位网址
<label field="sorgWeb" style="width:400"  ></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'></span><o:p></o:p></span></u></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
