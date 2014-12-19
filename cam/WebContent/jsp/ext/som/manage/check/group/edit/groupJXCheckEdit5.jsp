<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
			var flag = "break";
	//初始化
function init(){
	somJxActivityDataSet.setParameter("TASK_CODE", taskCode);
	somJxActivityDataSet.load();
	somJxActivityDataSet.on('load',function (){
		if(somJxActivityDataSet.getCount() == 0){
			somJxActivityDataSet.newRecord();
		}
	});
	somJxCheckInMarketDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckInMarketDataSet.load();
	somJxCheckInMarketDataSet.on('load',function (){
		if(somJxCheckInMarketDataSet.getCount() == 0){
			for(var i = 0;i<3;i++){
				addTr();
			}
		}else{
			for(i=1;i<=somJxCheckInMarketDataSet.getCount();i++){
				addTr();
				document.getElementById("activityName"+i).value=somJxCheckInMarketDataSet.getAt(i-1).get("activityName");
				document.getElementById("ifCharge"+i).value=somJxCheckInMarketDataSet.getAt(i-1).get("ifCharge");

			}
		}
	});
	var somJxCheckDataSet = L5.DatasetMgr.lookup("somJxCheckDataSet");
	somJxCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckDataSet.load();
	somJxCheckDataSet.on("load",function(ds){
		var checkYear=ds.get("checkYear");
		document.getElementById("checkYear").innerHTML=checkYear;
		document.getElementById("checkYear1").innerHTML=checkYear;
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var somJxActivityRecord=somJxActivityDataSet.getCurrent();
	somJxActivityRecord.set('commonwealTimes',document.getElementById('commonwealTimes').innerHTML);
	var somJxActivityDataSetIsValidate = somJxActivityDataSet.isValidate();
	if(somJxActivityDataSetIsValidate != true){
		L5.Msg.alert("提示",somJxActivityDataSetIsValidate);
		return "break";
	}
	var sendInfoNum=document.getElementById("sendInfoNum").value;
	var inceptInfoNum=document.getElementById("inceptInfoNum").value;
	if(parseInt(inceptInfoNum) > (parseInt(sendInfoNum))){
		L5.Msg.alert("提示","向有关媒体报送信息中被采用数不能大于报送数！");
		return "break";
	}
	var tab=document.getElementById("activities");
	somJxCheckInMarketDataSet.removeAll();
	for(i=1;i<tab.rows.length;i++){
		var num=tab.rows[i].id;
		var record = somJxCheckInMarketDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("activityName",document.getElementById("activityName"+num).value);
		if(document.getElementById("activityName"+num).value == ""){
			alert("请输入年度组织开展评比达标表彰活动情况中第"+num+"行的活动名称！没有的请填无！");
			return "break";
		}
		record.set("ifCharge",document.getElementById("ifCharge"+num).value);
	}

	var somJxCheckInMarketRecords=somJxCheckInMarketDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxActivityRecord",somJxActivityRecord);
	command.setParameter("somJxCheckInMarketRecords",somJxCheckInMarketRecords);
	command.execute("savePage5");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
			//增加一行方法
			function addTr(){
				 var tab=document.getElementById("activities");
			    //添加行
			    var newTR = tab.insertRow(tab.rows.length);
			    //trid++;
			    //获取序号=行索引
			    var  xuhao=newTR.rowIndex.toString();
			    newTR.id = xuhao;
			    //添加列:活动名称
			    var newNameTD=newTR.insertCell(0);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><input type='text' id='activityName"+xuhao+"' style='width: 100%;'></span></p>"
			    //添加列:是否收费
			    var newNameTD=newTR.insertCell(1);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p align=center class=MsoNormal style='mso-line-height-alt: 12.0pt;text-align:center'><span align='center' lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><select id='ifCharge"+xuhao+"' style='width: 80%;text-align:center'> <option  value=''>请选择...</option><option  value='1'>是</option><option  value='0'>否</option></select></span></p>";
			}
			function deltr(trid){
 				var tab=document.getElementById("activities");
			    var row=document.getElementById(trid);
			    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始
			    tab.deleteRow(index);  //从table中删除
			}

			function count(){
				var cwtFl=document.getElementById('cwtFl').value;
				var cwtZc=document.getElementById('cwtZc').value;
				var cwtJj=document.getElementById('cwtJj').value;
				var cwtJg=document.getElementById('cwtJg').value;
				var cwtZx=document.getElementById('cwtZx').value;
				if(cwtFl == ''){
					cwtFl=0;
				}
				if(cwtZc == ''){
					cwtZc=0;
				}
				if(cwtJj == ''){
					cwtJj=0;
				}
				if(cwtJg == ''){
					cwtJg=0;
				}
				if(cwtZx == ''){
					cwtZx=0;
				}
				document.getElementById('commonwealTimes').innerHTML=parseInt(cwtFl)+parseInt(cwtJj)+parseInt(cwtZc)+parseInt(cwtJg)+parseInt(cwtZx);
			}
		</script>
<style>
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxactivity.cmd.SomJxActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivity">
			<model:field name="generalTimes" type="string" rule="require" />
			<model:field name="councilTimes" type="string" rule="require" />
			<model:field name="learnMeetingTimes" type="string" rule="require" />
			<model:field name="trainTimes" type="string" rule="require" />
			<model:field name="trainNum" type="string" rule="require" />
			<model:field name="researchNum" type="string" rule="require" />
			<model:field name="askServeNum" type="string" rule="require" />
			<model:field name="askBorgNum" type="string" rule="require" />
			<model:field name="toAcceptNum" type="string" rule="require" />
			<model:field name="commonwealNum" type="string" rule="require" />
			<model:field name="commonwealTimes" type="string" rule="require" />
			<model:field name="commonwealOut" type="string" rule="require" />
			<model:field name="intItemNum" type="string" rule="require" />
			<model:field name="intItemMoney" type="string" rule="require" />
			<model:field name="meetingTimes" type="string" rule="require" />
			<model:field name="ifOffForm" type="string" rule="require" />
			<model:field name="outToTimes" type="string" rule="require" />
			<model:field name="outToNum" type="string" rule="require" />
			<model:field name="fromOffTimes" type="string" rule="require" />
			<model:field name="fromOffNum" type="string" rule="require" />
			<model:field name="acceptOffNum" type="string" rule="require" />
			<model:field name="acceptOffMoney" type="string" rule="require" />
			<model:field name="retainPeopleNum" type="string" rule="require" />
			<model:field name="sendInfoNum" type="string" rule="require" />
			<model:field name="inceptInfoNum" type="string" rule="require" />
			<model:field name="ifPublication" type="string" rule="require" />

			<model:field name="beneficiary" type="string" rule="require" />
			<model:field name="cwtFl" type="string" rule="require" />
			<model:field name="cwtZc" type="string" rule="require" />
			<model:field name="cwtJj" type="string" rule="require" />
			<model:field name="cwtJg" type="string" rule="require" />
			<model:field name="cwtZx" type="string" rule="require" />

			<model:field name="gencouncilTimes" type="string" rule="require" />
			<model:field name="delegateTimes" type="string" rule="require" />

			<model:field name="undertakeCont" type="string" rule="require" />
			<model:field name="capital" type="string" rule="require" />
			<model:field name="instructions" type="string" rule="require" />
			<model:field name="bulletin" type="string" rule="require" />
			<model:field name="statement" type="string" rule="require" />

		</model:record>
	</model:dataset>
	<model:dataset id="somJxCheckInMarketDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.cmd.SomJxCheckInMarketQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarket"></model:record>
	</model:dataset>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="false">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage('6')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage('4')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="back();"/>

	</div>
	<div style="text-align: center">
<div class=Section1 style='layout-grid: 15.6pt; width: 800px' >
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post"onsubmit="return false" dataset="somJxActivityDataSet">
<p class=MsoNormal
	style='text-indent: 32.15pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>四、活动情况</span></b><b><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal
	style='text-align: left'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（一）年度基本业务活动</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、会员大会：</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input title='会员大会次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="generalTimes" maxlength="6" />次，
	会员代表大会
<input title='会员代表大会次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="delegateTimes" maxlength="6" />
	次；</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、理事会：</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input title='理事会次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="councilTimes" maxlength="6" />次，
	常务理事会
	<input title='常务理事会次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="gencouncilTimes" maxlength="6" />次；
	</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、学术专业会议</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input title='学术专业会议次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="learnMeetingTimes" maxlength="6" />次；</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、培训</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input title='培训次数' type="text"
	 field="trainTimes" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'')"/>次，参加人数</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='培训参加人数' type="text"
	field="trainNum"  maxlength="6"onkeyup="value=value.replace(/[^\d]/g,'')"/>人次；</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5、开展</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='开展调研活动次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="researchNum" maxlength="6" />次调研活动；</span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6、开展</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='开展咨询服务活动次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="askServeNum" maxlength="6" />次咨询服务活动；</span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7、向政府及主管单位提出</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='向政府及主管单位提出条意见、建议条数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="askBorgNum" maxlength="6" />条意见、建议及其被采纳</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='向政府及主管单位提出条意见、建议被采纳条数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="toAcceptNum" maxlength="6" size="10"/>条；</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（二）公益活动情况<span
	lang=EN-US><span style='mso-tab-count: 1'> </span></span></span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、开展公益活动项目</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'><input  title='开展公益活动项目个数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="commonwealNum" maxlength="6" />个</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、公益活动
<label style='font-size: 16.0pt; font-family: 仿宋' title='公益活动次数' id='commonwealTimes'field="commonwealTimes"></label>

 次（扶老
<input  title='公益活动扶老次数' name='公益活动扶老次数' onkeyup="value=value.replace(/[^\d]/g,'');count()" id='cwtFl' type="text"field="cwtFl" maxlength="6" />
	 次、助残
<input  title='公益活动助残次数' name='公益活动助残次数' onkeyup="value=value.replace(/[^\d]/g,'');count()"id='cwtZc' type="text"field="cwtZc" maxlength="6" />
	 次、济困
<input  title='公益活动济困次数' name='公益活动济困次数' onkeyup="value=value.replace(/[^\d]/g,'');count()"id='cwtJj' type="text"field="cwtJj" maxlength="6" />
	 次、救孤
<input  title='公益活动救孤次数' name='公益活动救孤次数' onkeyup="value=value.replace(/[^\d]/g,'');count()"id='cwtJg' type="text"field="cwtJg" maxlength="6" />
	 次、助学
<input  title='公益活动助学次数' name='公益活动助学次数' onkeyup="value=value.replace(/[^\d]/g,'');count()" id='cwtZx'type="text"field="cwtZx" maxlength="6" />
	 次）</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、公益活动受益</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><span
	style='mso-spacerun: yes'>&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'><input onblur='checkFloat(this);'name='公益活动受益人数' title='公益活动受益人数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="beneficiary" maxlength="6" />人</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、公益活动支出</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><span
	style='mso-spacerun: yes'>&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'><input onblur='checkFloat(this);' name='公益活动支出钱数' title='公益活动支出钱数' onkeyup="value=value.replace(/[^\d.]/g,'')"
	type="text"field="commonwealOut" maxlength="10" />万元</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（三）涉外活动情况（下列具体情况请在总结中予以说明）</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、开展国际合作项目</span><span
	class=GramE><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='开展国际合作项目个数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="intItemNum" maxlength="6"/>个</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>，总计</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='开展国际合作项目总计' onkeyup="value=value.replace(/[^\d.]/g,'')"onblur='checkFloat(this);'
	type="text"field="intItemMoney" maxlength="10" />万元人民币</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、组织或参加国际会议</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='组织或参加国际会议次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="meetingTimes" maxlength="6" />次</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、是否参加境外非政府组织的活动</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp; </span></span> <select  title='是否参加境外非政府组织' field="ifOffForm">
	<option dataset="YorNDataset"></option>
</select></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、出境考察（培训）</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='出境考察（培训）批数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="outToTimes" maxlength="6"/>批</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='出境考察（培训）人次' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="outToNum" maxlength="6" />人次，接待境外来访</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  title='接待境外来访批数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="fromOffTimes" maxlength="6"/>批</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='接待境外来访人次' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="fromOffNum" maxlength="6" />人次</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>、接受境外组织捐赠或赞助</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='受境外组织捐赠或赞助次数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="acceptOffNum" maxlength="6" />次，总计</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='受境外组织捐赠或赞助总计' onkeyup="value=value.replace(/[^\d.]/g,'')"onblur='checkFloat(this);'
	type="text"field="acceptOffMoney" maxlength="10" />万元人民币</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>、聘请外籍员工</span><span
	style='font-size: 16.0pt; font-family: 仿宋'><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;</span></span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='聘请外籍员工人数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"field="retainPeopleNum" maxlength="6" />人。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（四）信息公开情况</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><label id=checkYear style='font-size: 14.0pt; '></label></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年度向</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>有关媒体</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>报送信息</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><input  title='向有关媒体报送信息条数' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"id='sendInfoNum'field="sendInfoNum" maxlength="6" />条，其中被采用<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  title='向有关媒体报送信息其中被采用' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text"id='inceptInfoNum'field="inceptInfoNum" maxlength="6" />条</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、是否举办刊物</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><select title='是否举办刊物'
	 field="ifPublication">
	<option dataset="YorNDataset"></option>
</select></span></p>


<p class=MsoNormal
	style='text-align: left'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（五）政府采购情况</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、本组织承接政府转移职能和购买服务情况（填写承接内容）：</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>
	 <textarea field="undertakeCont"  title='本组织承接政府转移职能和购买服务情况' name='"本组织承接政府转移职能和购买服务情况"'  style="width:600;margin-left: 100"  rows="10" ></textarea>
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资金（填写年度所获资金）:
<input title='资金' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="capital"  title="年度所获资金" maxlength="6" />
；</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、中央及省级党委、政府对本组织工作批示内容（填写批示内容）：</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="instructions"  title='中央及省级党委、政府对本组织工作批示内容' name='"中央及省级党委、政府对本组织工作批示内容"'   style="width:600;margin-left: 100"  rows="10" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>



<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、中央及省级党委、政府对本组织在有关简报、通报情况:</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="bulletin"  title='中央及省级党委、政府对本组织在有关简报、通报情况' name='"中央及省级党委、政府对本组织在有关简报、通报情况"'   style="width:600;margin-left: 100"  rows="10" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、本组织在全国及省级党委、政府部门召开会议上的典型发言情况:</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="statement"  title='本组织在全国及省级党委、政府部门召开会议上的典型发言情况' name='"本组织在全国及省级党委、政府部门召开会议上的典型发言情况"'  style="width:600;margin-left: 100"  rows="10" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>


</form>

<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（六）</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><label id=checkYear1 style='font-size: 14.0pt; '></label></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年度组织开展评比达标表彰活动情况</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>
<div class=MsoNormalTable style='width: 80%; margin-left: 47.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addTr()">增加一行</button></div>
<table id="activities" class=MsoNormalTable border=1 cellspacing=0
	cellpadding=0
	style='width: 80%; margin-left: 47.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 14.2pt'>
		<td width=40% valign=top
			style='border: solid black 1.0pt; mso-border-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 14.2pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-line-height-alt: 12.0pt'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>活动名称</span><span
			lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>
		</td>
		<td width=20% valign=top
			style='border: solid black 1.0pt; border-left: none; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 14.2pt'>
		<p class=MsoNormal align="center"
			style='text-align: center; mso-line-height-alt: 12.0pt'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>是否收费</span><span
			lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>
		</td>
	</tr>
</table>



<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*社会组织开展单位内部考核，或者以内设机构和工作人员为对象的评比达<br>&nbsp;&nbsp;&nbsp;&nbsp;标表彰项目，不属于社会组织评比表彰活动，不列入统计范围。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><b><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>
</body>
</html>
