<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init5(){
	somJxVipOrganDataSet.setParameter("TASK_CODE", taskCode);
	somJxVipOrganDataSet.load();
	somJxVipOrganDataSet.on('load',function (){
		if(somJxVipOrganDataSet.getCount() == 0){
			somJxVipOrganDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
	somJxActivityDataSet.setParameter("TASK_CODE", taskCode);
	somJxActivityDataSet.load();
	somJxActivityDataSet.on('load',function (){
		if(somJxActivityDataSet.getCount() == 0){
			somJxActivityDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
	var somJxDiscriplineIntegrityDataSet = L5.DatasetMgr.lookup("somJxDiscriplineIntegrityDataSet");
	somJxDiscriplineIntegrityDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxDiscriplineIntegrityDataSet.load();
	somJxDiscriplineIntegrityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxDiscriplineIntegrityDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
	//创建页面导航下拉框
	//createUngovDetailSelect();
}
</script>
<style>
.label5 {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋;
}
</style>
<model:datasets>
	<model:dataset id="somJxDiscriplineIntegrityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.cmd.SomJxDiscriplineIntegrityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxdiscriplineintegrity.dao.SomJxDiscriplineIntegrity"></model:record>
	</model:dataset>
	<model:dataset id="somJxVipOrganDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxviporgan.cmd.SomJxVipOrganQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somJxActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxactivity.cmd.SomJxActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivity"></model:record>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<div align=left style="margin-top: 60px;layout-grid:10.6pt; width: 700px">
<p class=MsoNormal style='mso-line-height-rule:exactly'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>三、组织建设和活动情况<span
lang=EN-US><o:p></o:p></span></span></b></p>

<form method="post"onsubmit="return false" dataset="somJxVipOrganDataSet">
<p class=MsoNormal style='mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（一）内部治理结构：理事会（董事会）
<label field='councilNum' style='width:70' class='label5'></label>
<u><span lang=EN-US><span
style='mso-spacerun:yes'></span></span></u>人；监事会（监事）
<label field='auditorNum' style='width:70' class='label5'></label>
<u><span
lang=EN-US><span style='mso-spacerun:yes'>
</span></span></u>人；<span lang=EN-US><o:p></o:p></span></span></p>
</form>

<form method="post"onsubmit="return false" dataset="somJxActivityDataSet">
<p class=MsoNormal style='
mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>本年度召开理事会（董事会）
<label field='councilTimes' style='width:70' class='label5'></label>
<u><span
lang=EN-US><span style='mso-spacerun:yes'></span></span></u>次；监事会
<label field='auditingTimes' style='width:70' class='label5'></label>
<u><span
lang=EN-US><span style='mso-spacerun:yes'></span></span></u>次<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（二）公益活动情况（具体情况可在总结中予以说明）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='
mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>开展公益活动项目
<label field='commonwealNum' style='width:70' class='label5'></label>
<u><span
lang=EN-US><span style='mso-spacerun:yes'></span></span></u>个<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='
mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>公益活动
<label field='commonwealTimes' style='width:70' class='label5'></label>
<u><span
lang=EN-US><span style='mso-spacerun:yes'>
</span></span></u>次<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='
mso-line-height-rule:exactly'><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>公益活动支出
<label field='commonwealOut' style='width:100' class='label5'></label>
<u><span
lang=EN-US><span
style='mso-spacerun:yes'>
</span></span></u>元<span lang=EN-US><o:p></o:p></span></span></p>
</form>

<form method="post"onsubmit="return false" dataset="somJxDiscriplineIntegrityDataSet">
<p class=MsoNormal style='mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（三）信息公开情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>1</span><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>、民办非企业单位登记证书、税务登记证书、许可证等是否公示
<label field="ifCertSp" style='width:100'dataset="yesornoDataSet"class='label5'></label>
<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>2</span><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>、是否有收费标准
<label field="ifChargeRule" style='width:100' dataset="yesornoDataSet"class='label5'></label>
<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span><span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><span style='mso-spacerun:yes'>&nbsp;&nbsp;
</span></span><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:仿宋'>如有：是否公示
<label field="ifChargeRuleSp" style='width:100' dataset="yesornoDataSet"class='label5'></label>
<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>3</span><span style='font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>、<span
lang=EN-US></span>2013年度是否接受过捐赠、资助
<label field="ifAcceptContribute" style='width:100' dataset="yesornoDataSet"class='label5'></label>
<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp; </span></span><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:26.25pt;mso-para-margin-left:2.5gd;
mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><span style='mso-spacerun:yes'>&nbsp;&nbsp;
</span></span><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:仿宋'>如有：是否向捐赠、资助单位报告资金使用情况
<label field="ifReportFund" style='width:100' dataset="yesornoDataSet"class='label5'></label>
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
	 <textarea field="undertakeCont"  title='本组织承接政府转移职能和购买服务情况' name='"本组织承接政府转移职能和购买服务情况"'  style="width:600;margin-left: 100"  rows="7" readonly="readonly" ></textarea>
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


 <textarea field="instructions"  title='中央及省级党委、政府对本组织工作批示内容' name='"中央及省级党委、政府对本组织工作批示内容"'   style="width:600;margin-left: 100"  rows="7" readonly="readonly"></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>



<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、中央及省级党委、政府对本组织在有关简报、通报情况:</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="bulletin"  title='中央及省级党委、政府对本组织在有关简报、通报情况' name='"中央及省级党委、政府对本组织在有关简报、通报情况"'   style="width:600;margin-left: 100"  rows="7" readonly="readonly"></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、本组织在全国及省级党委、政府部门召开会议上的典型发言情况:</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="statement"  title='本组织在全国及省级党委、政府部门召开会议上的典型发言情况' name='"本组织在全国及省级党委、政府部门召开会议上的典型发言情况"'  style="width:600;margin-left: 100"  rows="7" readonly="readonly"></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
</form>
</div>
