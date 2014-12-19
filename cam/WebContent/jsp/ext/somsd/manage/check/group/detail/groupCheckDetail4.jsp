﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
	//初始化
function init(){
	var somCheckSystemsDataSet = L5.DatasetMgr.lookup("somCheckSystemsDataSet");
	somCheckSystemsDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckSystemsDataSet.load();
	somCheckSystemsDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckSystemsDataSet.newRecord();
		}else{
			//处理税务登记字段为多选
			var taxRegType=somCheckSystemsDataSet.get("taxRegType");
			var taxRegTypeArr = taxRegType.split(",");
			if(taxRegTypeArr.length == 3){
				if(taxRegTypeArr[0]!=0){
					document.getElementById("regtype1").checked = true;
				}
				if(taxRegTypeArr[1]!=0){
					document.getElementById("regtype2").checked = true;
				}
				if(taxRegTypeArr[2]!=0){
					document.getElementById("regtype3").checked = true;
				}
			}else{
				//处理历史的数据，历史的数据为1位数的
				if(taxRegTypeArr.length == 1){
					if(taxRegTypeArr[0]=="1"){
						document.getElementById("regtype1").checked = true;
					}
					if(taxRegTypeArr[0]=="2"){
						document.getElementById("regtype2").checked = true;
					}
					if(taxRegTypeArr[0]=="3"){
						document.getElementById("regtype3").checked = true;
					}
				}
			}
			
			//处理票据种类
			var billType=somCheckSystemsDataSet.get("billType");
			var billTypeArr = billType.split(",");
			if(billTypeArr.length == 5){
				if(billTypeArr[0]!=0){
					document.getElementById("billType1").checked = true;
				}
				if(billTypeArr[1]!=0){
					document.getElementById("billType2").checked = true;
				}
				if(billTypeArr[2]!=0){
					document.getElementById("billType3").checked = true;
				}
				if(billTypeArr[3]!=0){
					document.getElementById("billType4").checked = true;
				}
				if(billTypeArr[4]!=0){
					document.getElementById("billType5").checked = true;
				}
			}else{
			//处理历史的数据，历史的数据为1位数的
				if(billTypeArr.length == 1){
					if(billTypeArr[0]=="1"){
						document.getElementById("billTyp1").checked = true;
					}
					if(billTypeArr[0]=="2"){
						document.getElementById("billTyp2").checked = true;
					}
					if(billTypeArr[0]=="3"){
						document.getElementById("billTyp3").checked = true;
					}
					if(billTypeArr[0]=="4"){
						document.getElementById("billTyp4").checked = true;
					}
					if(billTypeArr[0]=="5"){
						document.getElementById("billTyp5").checked = true;
					}
				}
			}
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
label {
	width:98%;
	text-align:center;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckSystemsDataSet" cmd="com.inspur.cams.sorg.check.checksystems.cmd.SomCheckSystemsQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems"></model:record>
	</model:dataset>
	<!-- 税务登记情况 -->
	<model:dataset id="taxRegTypeSelect" enumName="SOM.CHECK.TAX_REG_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 使用票据种类 -->
	<model:dataset id="billTypeSelect" enumName="SOM.CHECK.BILL_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 财务软件 -->
	<model:dataset id="ifDesignatedSoftSelect" enumName="SOM.CHECK.IF_DESIGNATED_SOFT" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage1('3');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage1('5');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="docPrint();"/>
</div>

<div align=center style="margin-top:20px;">
<p align=center style='margin:0 auto;text-align:left;tab-stops:248.15pt;width:800'><b
style='mso-bidi-font-weight:normal'><span style='font-size:16.0pt;font-family:
宋体'>（三）内部制度建设情况<span lang=EN-US><o:p></o:p></span></span></b></p>

<form method="post" dataset="somCheckSystemsDataSet" onsubmit="return false">
<table border=1 cellspacing=0 cellpadding=0 width="800"
 style='margin-top:30px;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 1.5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='page-break-inside:avoid;height:18.7pt'>
  <td width="15%" style='width:15.56%;border-top:1.5pt;border-left:1.5pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:1.5pt;mso-border-left-alt:1.5pt;mso-border-bottom-alt:
  .5pt;mso-border-right-alt:.5pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:18.7pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>机构管理<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="38%" colspan=3 style='width:38.56%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:18.7pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>分支<span lang=EN-US>(</span>代表<span
  lang=EN-US>)</span>机构管理制度<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="45%" colspan=7 style='width:45.88%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:1.5pt;
  mso-border-left-alt:.5pt;mso-border-bottom-alt:.5pt;mso-border-right-alt:
  1.5pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:18.7pt'>
  <p class=MsoNormal>
  	<label field="ifBranchSys" dataset="comm_haveorno"></label>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:22.85pt'>
  <td width="15%" rowspan=2 style='width:15.56%;border-top:none;border-left:
  solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext 1.5pt;padding:
  0cm 5.4pt 0cm 5.4pt;height:22.85pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>证书印章<span lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>管理<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="38%" colspan=3 style='width:38.56%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:22.85pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;letter-spacing:-.3pt'>法人证书保管、使用管理制度<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="14%" colspan=3 style='width:14.7%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.85pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;font-family:宋体'>
  	<label field="ifCertSys" dataset="comm_haveorno"></label>
  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.85pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;letter-spacing:-1.0pt'>保管在<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" colspan=2 style='width:18.54%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.85pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="certSysManager" ></label>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:22.45pt'>
  <td width="38%" colspan=3 style='width:38.56%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.45pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>印章保管、使用管理制度<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="14%" colspan=3 style='width:14.7%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.45pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;font-family:宋体'>
  	<label field="ifStampSys" dataset="comm_haveorno"></label>
  </span></p>
  </td>
  <td width="12%" colspan=2 style='width:12.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.45pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;letter-spacing:-1.0pt'>保管在<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" colspan=2 style='width:18.54%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.45pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="stampSysManager" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:22.0pt'>
  <td width="15%" rowspan=3 style='width:15.56%;border-top:none;border-left:
  solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext 1.5pt;padding:
  0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>工作人员<span lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>管理<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>人事管理制度<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="17%" colspan=2 style='width:17.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体'>
  	<label field="ifPersonnalSys" dataset="comm_haveorno"></label>
  </span></p>
  </td>
  <td width="27%" colspan=5 style='width:27.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>专职工作人员签订聘用合同人数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" colspan=2 style='width:18.54%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="contractPersonNum" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:17.4pt'>
  <td width="20%" rowspan=2 style='width:20.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>专职工作人员参加社会保险人数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="9%" style='width:9.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>失业<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>保险<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" colspan=2 style='width:11.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="unemploymentInsNum" ></label>
  </span></p>
  </td>
  <td width="9%" style='width:9.8%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>养老<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>保险<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" colspan=2 style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="endowmentInsNum" ></label>
  </span></p>
  </td>
  <td width="10%" colspan=2 style='width:10.08%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>医疗<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>保险<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="10%" style='width:10.26%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:17.4pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="medicalInsNum" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:16.2pt'>
  <td width="9%" style='width:9.82%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.2pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>工伤<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>保险<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" colspan=2 style='width:11.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.2pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="injuryInsNum" ></label>
  </span></p>
  </td>
  <td width="9%" style='width:9.8%;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.2pt'>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>生育<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p align=center style='text-align:center;line-height:25.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>保险<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="32%" colspan=5 style='width:32.12%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:16.2pt'>
  <p style='line-height:25.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体'>
  	<label field="birthInsNum" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:22.85pt'>
  <td width="15%" rowspan=8 style='width:15.56%;border-top:none;border-left:
  solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:
  .5pt;mso-border-left-alt:1.5pt;mso-border-bottom-alt:1.5pt;mso-border-right-alt:
  .5pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:0cm 5.4pt 0cm 5.4pt;
  height:22.85pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.51gd;mso-para-margin-bottom:.0001pt;text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>财务管理<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.85pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体;
  letter-spacing:-1.0pt'>人民币开户银行<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="63%" colspan=9 style='width:63.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.85pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'>
  	<label field="rmbDepositBank" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:23.1pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.1pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体;
  letter-spacing:-1.0pt'>人民币银行账号<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="63%" colspan=9 style='width:63.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:23.1pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'>
  	<label field="rmbBankAccounts" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:22.0pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>外币开户银行<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="63%" colspan=9 style='width:63.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'>
  	<label field="wbDepositBank" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:23.0pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>外币银行账号<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="63%" colspan=9 style='width:63.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:23.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'>
  	<label field="wbBankAccounts" ></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:23.3pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.3pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>财政登记<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="17%" colspan=2 style='width:17.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.3pt'>
  <p style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体'>
  	<label field="ifFinancialReg" dataset="comm_haveorno"></label>
  </span></p>
  </td>
  <td width="27%" colspan=5 style='width:27.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.3pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>税务登记<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" colspan=2 style='width:18.54%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:23.3pt'>
  <p style='margin-right:-5.35pt;line-height:28.0pt;mso-line-height-rule:
  exactly'><span style='font-size:14.0pt;font-family:宋体'>
<input type="checkbox" name="regtype" value="1" id="regtype1"  disabled="disabled" >国税<br>
<input type="checkbox" name="regtype" value="2" id="regtype2"  disabled="disabled" >地税<br>
<input type="checkbox" name="regtype" value="3" id="regtype3"  disabled="disabled" >未登记<br>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体;
  letter-spacing:-1.0pt'>专职财会人员数<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="17%" colspan=2 style='width:17.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'>
  	<label field="accountantNum"></label>
  </span></p>
  </td>
  <td width="27%" colspan=5 style='width:27.34%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 0cm 0cm 0cm;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体;
  letter-spacing:-1.0pt'>具有会计执业资格人数<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="18%" colspan=2 style='width:18.54%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'>
  	<label field="qualificationNum"></label>
  </span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>使用票据种类<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="63%" colspan=9 style='width:63.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体'>
  	<input type="checkbox" name="billType" value="1" id="billType1" disabled="disabled">
	 行政事业单位收费收据；
	 <input type="checkbox" name="billType" value="2" id="billType2" disabled="disabled">
	 会费收据；
	 <input type="checkbox" name="billType" value="3" id="billType3" disabled="disabled">
	 捐赠收据；
	 <input type="checkbox" name="billType" value="4" id="billType4" disabled="disabled">
	 税务发票；
	 <input type="checkbox" name="billType" value="5" id="billType5" disabled="disabled">
	 其他；<br>
  </span></p>
  </td>
 </tr>
 <tr style='mso-yfti-lastrow:yes;page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='width:20.98%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;
  mso-line-height-rule:exactly'><span style='font-size:14.0pt;font-family:宋体'>财务软件<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="63%" colspan=9 style='width:63.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体'>财政部、民政部联合监制开发的《民间非营利组织财务会计软件》：<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体'>
  	<label field="ifDesignatedSoft" dataset="ifDesignatedSoftSelect"></label>
  </span></p>
  </td>
 </tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
