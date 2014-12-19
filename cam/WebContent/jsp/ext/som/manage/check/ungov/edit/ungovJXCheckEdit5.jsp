<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民 办 非 企 业 单 位 </title>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somJxVipOrganDataSet.setParameter("TASK_CODE", taskCode);
	somJxVipOrganDataSet.load();
	somJxVipOrganDataSet.on('load',function (){
		if(somJxVipOrganDataSet.getCount() == 0){
			somJxVipOrganDataSet.newRecord();
		}
	});
	somJxActivityDataSet.setParameter("TASK_CODE", taskCode);
	somJxActivityDataSet.load();
	somJxActivityDataSet.on('load',function (){
		if(somJxActivityDataSet.getCount() == 0){
			somJxActivityDataSet.newRecord();
		}
	});
	var somJxDiscriplineIntegrityDataSet = L5.DatasetMgr.lookup("somJxDiscriplineIntegrityDataSet");
	somJxDiscriplineIntegrityDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxDiscriplineIntegrityDataSet.load();
	somJxDiscriplineIntegrityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxDiscriplineIntegrityDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somJxVipOrganDataSetIsValidate = somJxVipOrganDataSet.isValidate();
	if(somJxVipOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxVipOrganDataSetIsValidate);
		return "break";
	}
	var somJxActivityDataSetIsValidate = somJxActivityDataSet.isValidate();
	if(somJxActivityDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxActivityDataSetIsValidate);
		return "break";
	}
	var somJxDiscriplineIntegrityDataSetIsValidate = somJxDiscriplineIntegrityDataSet.isValidate();
	if(somJxDiscriplineIntegrityDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxDiscriplineIntegrityDataSetIsValidate);
		return "break";
	}

	var somJxVipOrganRecord=somJxVipOrganDataSet.getCurrent();
	var somJxActivityRecord=somJxActivityDataSet.getCurrent();
	var somJxDiscriplineIntegrityRecord=somJxDiscriplineIntegrityDataSet.getCurrent();
	var ifChargeRule=somJxDiscriplineIntegrityRecord.get("ifChargeRule");
	var ifChargeRuleSp=somJxDiscriplineIntegrityRecord.get("ifChargeRuleSp");
	if(ifChargeRule=="1"&&ifChargeRuleSp==""){
		L5.Msg.alert("提示","请选择是否公示！");
		return "break";
	}
	var ifAcceptContribute=somJxDiscriplineIntegrityRecord.get("ifAcceptContribute");
	var ifReportFund=somJxDiscriplineIntegrityRecord.get("ifReportFund");
	if(ifAcceptContribute=="1"&&ifReportFund==""){
		L5.Msg.alert("提示","请选择是否向捐赠、资助单位报告资金使用情况！");
		return "break";
	}

	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("somJxVipOrganRecord", somJxVipOrganRecord);
	command.setParameter("somJxActivityRecord",somJxActivityRecord);
	command.setParameter("somJxDiscriplineIntegrityRecord",somJxDiscriplineIntegrityRecord);
	command.execute("savePageM5");
	if (!command.error) {
		alert("保存成功！");
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
	<model:dataset id="somJxVipOrganDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxviporgan.cmd.SomJxVipOrganQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrgan">
			<model:field name="councilNum" type="string" rule="require" />
			<model:field name="auditorNum" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somJxActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxactivity.cmd.SomJxActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivity">
			<model:field name="councilTimes" type="string" rule="require" />
			<model:field name="auditingTimes" type="string" rule="require" />
			<model:field name="commonwealNum" type="string" rule="require" />
			<model:field name="commonwealTimes" type="string" rule="require" />
			<model:field name="commonwealOut" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somJxDiscriplineIntegrityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.cmd.SomJxDiscriplineIntegrityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrity">
			<model:field name="ifCertSp" type="string" rule="require" />
			<model:field name="ifChargeRule" type="string" rule="require" />
			<model:field name="ifAcceptContribute" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('6')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('4')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>
<div align=center>
<div align=left style="margin-top: 60px; width: 800px">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>三、组织建设和活动情况<span
lang=EN-US><o:p></o:p></span></span></b></p>

<form method="post"onsubmit="return false" dataset="somJxVipOrganDataSet">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（一）内部治理结构：理事会（董事会）
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='councilNum' style='width:70' maxlength='6'name='"理事会（董事会）"'/>
<u><span lang=EN-US><span
style='mso-spacerun:yes'></span></span></u>人；监事会（监事）
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='auditorNum' style='width:70' maxlength='6'name='"监事会（监事）"'/>
<u><span
lang=EN-US><span style='mso-spacerun:yes'>
</span></span></u>人；<span lang=EN-US><o:p></o:p></span></span></p>
</form>

<form method="post"onsubmit="return false" dataset="somJxActivityDataSet">
<p class=MsoNormal style='text-indent:42.0pt;mso-char-indent-count:3.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>本年度召开理事会（董事会）
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='councilTimes' style='width:70' maxlength='6'name='"本年度召开理事会（董事会）"'/>
<u><span
lang=EN-US><span style='mso-spacerun:yes'></span></span></u>次；监事会
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='auditingTimes' style='width:70' maxlength='6'name='"监事会"'/>
<u><span
lang=EN-US><span style='mso-spacerun:yes'></span></span></u>次<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（二）公益活动情况（具体情况可在总结中予以说明）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:42.0pt;mso-char-indent-count:3.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>开展公益活动项目
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='commonwealNum' style='width:70' maxlength='6'name='"开展公益活动项目"'/>
<u><span
lang=EN-US><span style='mso-spacerun:yes'></span></span></u>个<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:42.0pt;mso-char-indent-count:3.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>公益活动
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='commonwealTimes' style='width:70' maxlength='6'name='"公益活动"'/>
<u><span
lang=EN-US><span style='mso-spacerun:yes'>
</span></span></u>次<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:42.0pt;mso-char-indent-count:3.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>公益活动支出
<input onkeyup="value=value.replace(/[^\d.]/g,'')"onblur='checkFloat(this);' field='commonwealOut' style='width:70' maxlength='15'name='"公益活动支出"'/>
<u><span
lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u>元<span lang=EN-US><o:p></o:p></span></span></p>
</form>

<form method="post"onsubmit="return false" dataset="somJxDiscriplineIntegrityDataSet">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（三）信息公开情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
line-height:24.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>1</span><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>、民办非企业单位登记证书、税务登记证书、许可证等是否公示
<select field="ifCertSp" style='width:100'name='"民办非企业单位登记证书、税务登记证书、许可证等是否公示"'><option dataset="yesornoDataSet"></option></select>
<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
line-height:24.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>2</span><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>、是否有收费标准
<select field="ifChargeRule" style='width:100'name='"是否有收费标准"'><option dataset="yesornoDataSet"></option></select>
<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
line-height:24.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><span style='mso-spacerun:yes'>&nbsp;&nbsp;
</span></span><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:仿宋'>如有：是否公示
<select field="ifChargeRuleSp" style='width:100'><option dataset="yesornoDataSet"></option></select>
<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
line-height:24.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>3</span><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>、<span
lang=EN-US></span>2013年度是否接受过捐赠、资助
<select field="ifAcceptContribute" style='width:100'name='"是否接受过捐赠、资助"'><option dataset="yesornoDataSet"></option></select>
<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
line-height:24.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><span style='mso-spacerun:yes'>&nbsp;&nbsp;
</span></span><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:仿宋'>如有：是否向捐赠、资助单位报告资金使用情况
<select field="ifReportFund" style='width:100'><option dataset="yesornoDataSet"></option></select>
<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><o:p></o:p></span></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>


</form>

<form method="post"onsubmit="return false" dataset="somJxActivityDataSet">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（四）其他活动情况<span lang=EN-US><o:p></o:p></span></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、本组织承接政府转移职能和购买服务情况（填写承接内容）：</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>
	 <textarea field="undertakeCont"  title='本组织承接政府转移职能和购买服务情况' name='"本组织承接政府转移职能和购买服务情况"'  style="width:600;margin-left: 100"  rows="7" ></textarea>
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资金（填写年度所获资金）:
<input title='资金' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="capital"  title="年度所获资金" maxlength="6" />
；</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、中央及省级党委、政府对本组织工作批示内容（填写批示内容）：</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="instructions"  title='中央及省级党委、政府对本组织工作批示内容' name='"中央及省级党委、政府对本组织工作批示内容"'   style="width:600;margin-left: 100"  rows="7" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>



<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、中央及省级党委、政府对本组织在有关简报、通报情况:</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="bulletin"  title='中央及省级党委、政府对本组织在有关简报、通报情况' name='"中央及省级党委、政府对本组织在有关简报、通报情况"'   style="width:600;margin-left: 100"  rows="7" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、本组织在全国及省级党委、政府部门召开会议上的典型发言情况:</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="statement"  title='本组织在全国及省级党委、政府部门召开会议上的典型发言情况' name='"本组织在全国及省级党委、政府部门召开会议上的典型发言情况"'  style="width:600;margin-left: 100"  rows="7" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
</form>
</div>
</div>
</body>
</html>
