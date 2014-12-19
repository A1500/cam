<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	//初始化
	function init(){
		createGroupEditSelect();
		somCheckDonateDetailDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDonateDetailDataSet.load();
		somCheckDonateDetailDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckDonateDetailDataSet.newRecord({"taskCode":taskCode});
			}
			setSumMoney();
		});
	}
	//保存
	function save(){
		var somCheckDonateDetailDataSetIsValidate = somCheckDonateDetailDataSet.isValidate();
		if(somCheckDonateDetailDataSetIsValidate!=true){
			L5.Msg.alert("提示",somCheckDonateDetailDataSetIsValidate);
			return "break";
		}	
		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
		var checkDonateDetailRecord = somCheckDonateDetailDataSet.getCurrent();
		command.setParameter("checkDonateDetailRecord", checkDonateDetailRecord);
		command.setParameter("taskCode",taskCode);
		command.execute("savePage15");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	function saveNoCheck(){
		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
		var checkDonateDetailRecord = somCheckDonateDetailDataSet.getCurrent();
		command.setParameter("checkDonateDetailRecord", checkDonateDetailRecord);
		command.setParameter("taskCode",taskCode);
		command.execute("savePage15");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}

function setSumMoney(){
	somCheckDonateDetailDataSet.set("onPerTotal",setParseFloat("现金3","实物折合3"));
	somCheckDonateDetailDataSet.set("onOrgTotal",setParseFloat("现金4","实物折合4"));
	somCheckDonateDetailDataSet.set("offPerTotal",setParseFloat("现金6","实物折合6"));
	somCheckDonateDetailDataSet.set("offOrgTotal",setParseFloat("现金7","实物折合7"));
	somCheckDonateDetailDataSet.set("onCashTotal",setParseFloat("现金3","现金4"));
	somCheckDonateDetailDataSet.set("onConvertCash",setParseFloat("实物折合3","实物折合4"));
	somCheckDonateDetailDataSet.set("offCashTotal",setParseFloat("现金6","现金7"));
	somCheckDonateDetailDataSet.set("offConvertCash",setParseFloat("实物折合6","实物折合7"));
	somCheckDonateDetailDataSet.set("onTotal",setParseFloat("合计3","合计4"));
	somCheckDonateDetailDataSet.set("offTotal",setParseFloat("合计6","合计7"));
	somCheckDonateDetailDataSet.set("cashTotal",setParseFloat("现金2","现金5"));
	somCheckDonateDetailDataSet.set("convertCash",setParseFloat("实物折合2","实物折合5"));
	somCheckDonateDetailDataSet.set("total",setParseFloat("合计2","合计5"));
}
function setParseFloat(id1,id2){
	var value1 = document.getElementById(id1).value;
	var value2 = document.getElementById(id2).value;
	if(value1==undefined){
		value1 = document.getElementById(id1).innerHTML;
	}
	if(value2==undefined){
		value2 = document.getElementById(id2).innerHTML;
	}
	if(!value1){
		value1 = 0;
	}else{
		value1 = parseFloat(value1);
	}
	if(!value2){
		value2 = 0;
	}else{
		value2 = parseFloat(value2);
	}
	return (value1+value2).toFixed(2)*1;
}	
</script>
<style>
textarea {
	overflow: hidden;
}
</style>
</head>

<body>
<model:datasets>
	<!-- 本年度举办研讨、展览、培训、评比达标表彰等活动的情况 -->
	<model:dataset id="somCheckDonateDetailDataSet" cmd="com.inspur.cams.sorg.check.checkdonatedetail.cmd.SomCheckDonateDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkdonatedetail.data.SomCheckDonateDetail">
			<model:field name="onPerCashTotal" type="string" rule="require" />
			<model:field name="onPerConvert" type="string" rule="require" />
			<model:field name="onOrgCashTotal" type="string" rule="require" />			
			<model:field name="onOrgConvert" type="string" rule="require" />
			<model:field name="offPerCashTotal" type="string" rule="require" />
			<model:field name="offPerConvert" type="string" rule="require" />
			<model:field name="offOrgCashTotal" type="string" rule="require" />
			<model:field name="offOrgConvert" type="string" rule="require" />
			<model:field name="useDetail" type="string" rule="require|length{1500}" />
		</model:record>
	</model:dataset>
	<!-- 本年度举办活动类型 -->
	<model:dataset id="eventTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_EVENT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage('14');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage('16');"/>
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="saveNoCheck();" /> 
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="back();" />
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：17</span>
</div>
<div align=center>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left
	style='text-align: center; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（三）本年度接受捐赠资助情况和使用情况</span></b><span
	style='font-size: 14.0pt; font-family: 宋体'>（单位：人民币元）<b
	style='mso-bidi-font-weight: normal'><span lang=EN-US><o:p></o:p></span></b></span></p>
<form method="post" dataset=somCheckDonateDetailDataSet onsubmit="return false">
	<table cellspacing=0 cellpadding=0 width="800">
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>项<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>目<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>现<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>金<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>非现金折合<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>合<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>计<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>一、本年度捐赠收入<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='现金1' name="本年度捐赠收入-现金" field="cashTotal" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "></label></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='实物折合1' name="本年度捐赠收入-非现金折合" field="convertCash" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "></label></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text" ID='合计1' name="本年度捐赠收入-合计" field="total" style="width: 98%;text-align:right;padding-right:2px;" ></label></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>（一）来自境内的捐赠<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='现金2'  name="来自境内的捐赠-现金" field="onCashTotal" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "></label></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='实物折合2' name="来自境内的捐赠-非现金折合" field="onConvertCash" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "></label></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text" ID='合计2' name="来自境内的捐赠-合计" field="onTotal" style="width: 98%;text-align:right;padding-right:2px;"></label></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>其中：来自境内自然人<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text"ID='现金3' name="来自境内自然人-现金" field="onPerCashTotal" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text" ID='实物折合3' name="来自境内自然人-非现金折合" field="onPerConvert" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text" ID="合计3" name="来自境内自然人-合计" field="onPerTotal" style="width: 98%;text-align:right;padding-right:2px;" ></label></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>来自境内组织<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text"ID='现金4' name="来自境内组织-现金" field="onOrgCashTotal" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text"ID='实物折合4' name="来自境内组织-非现金折合" field="onOrgConvert" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney();"/></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text" ID='合计4' name="来自境内组织-合计" field="onOrgTotal" style="width: 98%;text-align:right;padding-right:2px;" ></label></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>（二）来自境外的捐赠<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='现金5'  name="来自境外的捐赠-现金" field="offCashTotal" style="width: 98%;text-align:right;padding-right:2px;"
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') " ></label></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='实物折合5' name="来自境外的捐赠-非现金折合" field="offConvertCash" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "></label></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text" ID='合计5' name="来自境外的捐赠-合计" field="offTotal" style="width: 98%;text-align:right;padding-right:2px;" ></label></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>其中：来自境外自然人<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text"ID='现金6' name="来自境外自然人-现金" field="offPerCashTotal" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text" ID='实物折合6' name="来自境外自然人-非现金折合" field="offPerConvert" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text" ID='合计6' name="来自境外自然人-合计" field="offPerTotal" style="width: 98%;text-align:right;padding-right:2px;" ></label></span></p>
			</td>
		</tr>
		<tr style='height: 1.0cm'>
			<td width="42%" colspan=2
				style='width: 42.38%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.35pt; mso-para-margin-left: .51gd; text-align: center; line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>来自境外组织<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text"ID='现金7' name="来自境外组织-现金" field="offOrgCashTotal" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="19%"
				style='width: 19.62%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<input type="text"ID='实物折合7'  name="来自境外组织-非现金折合" field="offOrgConvert" style="width: 98%;text-align:right;padding-right:2px;" 
				onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney(); "/></span></p>
			</td>
			<td width="18%"
				style='width: 18.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 1.0cm'>
			<p class=MsoNormal
				style='line-height: 23.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span> 
				<label type="text"ID='合计7' name="来自境外组织-合计" field="offOrgTotal" style="width: 98%;text-align:right;padding-right:2px;" ></label></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-lastrow: yes; height: 374.2pt'>
			<td width="7%"
				style='width: 7.22%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 374.2pt'>
			<p class=MsoNormal align=center
				style='text-align: center; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>主要用途和<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='text-align: center; tab-stops: 248.15pt'><span
				style='font-size: 14.0pt; font-family: 宋体'>使用情况<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="92%" colspan=4
				style='width: 92.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 374.2pt'>
			<p class=MsoNormal style='tab-stops: 248.15pt'><span> 
				<textarea name='主要用途和使用情况' field="useDetail" style="width: 738;height: 374.2pt" ></textarea></span></p>
			</td>
		</tr>
		<![if !supportMisalignedColumns]>
		<tr height=0>
			<td width=54 style='border: none'></td>
			<td width=262 style='border: none'></td>
			<td width=146 style='border: none'></td>
			<td width=146 style='border: none'></td>
			<td width=137 style='border: none'></td>
		</tr>
		<![endif]>
	</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>