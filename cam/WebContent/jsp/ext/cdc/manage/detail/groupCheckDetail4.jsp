<%@ page contentType="text/html; charset=UTF-8" %>
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
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
function nextPage(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail5.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function back(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckSystemsDataSet" cmd="com.inspur.cams.sorg.check.checksystems.cmd.SomCheckSystemsQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems"></model:record>
	</model:dataset>
	<!-- 税务登记情况 -->
	<model:dataset id="taxRegTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_TAX_REG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 使用票据种类 -->
	<model:dataset id="billTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BILL_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 财务软件 -->
	<model:dataset id="ifDesignatedSoftSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_DESIGNATED_SOFT'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float">
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="下一页"	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="返回"	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="back();" />
</div>

<div align=center style="margin-top:60px;">
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
  	<label field="ifBranchSys" dataset="comm_haveorno"/>
  </span></p>
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
  	<label field="ifCertSys" dataset="comm_haveorno"/>
  </span></p>
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
  	<label field="certSysManager" />
  </span></p>
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
  	<label field="ifStampSys" dataset="comm_haveorno"/>
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
  	<label field="stampSysManager" />
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
  	<label field="ifPersonnalSys" dataset="comm_haveorno"/>
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
  	<label field="contractPersonNum" />
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
  	<label field="unemploymentInsNum" />
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
  	<label field="endowmentInsNum" />
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
  	<label field="medicalInsNum" />
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
  	<label field="injuryInsNum" />
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
  	<label field="birthInsNum" />
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
  	<label field="rmbDepositBank" />
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
  	<label field="rmbBankAccounts" />
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
  	<label field="wbDepositBank" />
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
  	<label field="wbBankAccounts" />
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
  	<label field="ifFinancialReg" dataset="comm_haveorno"/>
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
  	<label field="taxRegType" dataset="taxRegTypeSelect"/>
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
  	<label field="accountantNum"/>
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
  	<label field="qualificationNum"/>
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
  	<label field="billType" dataset="billTypeSelect"/>
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
  	<label field="ifDesignatedSoft" dataset="ifDesignatedSoftSelect"/>
  </span></p>
  </td>
 </tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
