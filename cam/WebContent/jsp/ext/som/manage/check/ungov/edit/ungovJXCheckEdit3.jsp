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
	createUngovEditSelect();	
}
function save(){
	var somJxCheckDataSetIsValidate = somJxCheckDataSet.isValidate();
	if(somJxCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckDataSetIsValidate);
		return "break";
	}
	
	var jxCheckRecord=somJxCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("jxCheckRecord", jxCheckRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageM3");
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
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck">
			<model:field name="cnName" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="require" />
			<model:field name="downDate" type="string" rule="require" />
			<model:field name="certUsefulDate" type="string" rule="require" />
			<model:field name="initialFund" type="string" rule="require" />
			<model:field name="businessType" type="string" rule="require" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="residence" type="string" rule="require" />
			<model:field name="sorgPost" type="string" rule="require" />
			<model:field name="linkmanName" type="string" rule="require" />
			<model:field name="linkmanDuty" type="string" rule="require" />
			<model:field name="linkmanMobile" type="string" rule="require" />
			<model:field name="sorgEmail" type="string" rule="require" />
			<model:field name="sorgPhone" type="string" rule="require" />
			<model:field name="sorgFax" type="string" rule="require" />
			<model:field name="sorgWeb" type="string" rule="require" />
		</model:record>
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
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('4')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('2')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>
<div align=center>
<div align=left style="margin-top: 60px; width: 800px">

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><b><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>一、基本情况<span lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somJxCheckDataSet" onsubmit="return false">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>单位名称
<input field="cnName" name='"单位名称"' style="width:300"  maxlength="50"/>	
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u><b><span lang=EN-US><o:p></o:p></span></b></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>业务主管单位
<input field="borgName" name='"业务主管单位"'style="width:300" maxlength="100"/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>登记日期
<input field="downDate" format="Y-m-d"name='"登记日期"' onclick="LoushangDate(this)" readonly="readonly" style="width:150"/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u>证书有效期
<input field="certUsefulDate" format="Y-m-d" name='"证书有效期"' onclick="LoushangDate(this)" readonly="readonly" style="width:150"/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span><span lang=EN-US><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>*</span><span
style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>凡证书有效期已过期的，请速来我局办理相关手续。</span><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:黑体'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>开办资金（填写小写数字即可）
<input field="initialFund" style="width:300" name='"开办资金"'  maxlength="50" onKeyUp="value=value.replace(/[^\d.]/g,'')"onblur='checkFloat(this);'/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'></span></span></u>万元人民币<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>行业类型
<select field="businessType" style="width:150" name='"行业类型"'><option dataset="businessTypeSelect"></option></select>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>单位性质
<select field="sorgKind" style="width:150" name='"单位性质"'>
	<option dataset='sorgKindSelect' />
</select>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>住所
<input field="residence" style="width:300" maxlength="50" name='"住所"'/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>*</span><span
style='font-size:14.0pt;mso-bidi-font-size:10.5pt;font-family:黑体'>未办理住所变更手续的，请速来我局办理相关手续</span><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:黑体'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>邮编
<input onkeyup="value=value.replace(/[^\d]/g,'')" field="sorgPost" style="width:300" maxlength="6" name='"邮编"'/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u></span><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
10.5pt;font-family:仿宋;mso-hansi-font-family:仿宋'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>联系人
<input field="linkmanName" style="width:150"  maxlength="50" name='"联系人"'/>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;</span></span>职务
<select name='"联系人职务"' field="linkmanDuty" ><option dataset="dutySelect"><option></select>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>手机
<input onkeyup="value=value.replace(/[^\d]/g,'')" field="linkmanMobile" style="width:150"  maxlength="50"name='"手机"'/>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>电子邮件
<input field="sorgEmail" style="width:300" maxlength="50"name='"电子邮件"'/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>
联系电话
<input field="sorgPhone" style="width:150" maxlength="50"name='"联系电话"'/>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span></span></u>
<span lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位传真
<input field="sorgFax" style="width:150"  maxlength="50"name='"单位传真"'/>
<u><span lang=EN-US><span style='mso-spacerun:yes'></span><o:p></o:p></span></u></span>
</p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>单位网址
<input field="sorgWeb" style="width:300"  maxlength="50"name='"单位网址"'/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'></span><o:p></o:p></span></u></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
