<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
%>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
 	//初始化
	function init(){
		var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
		var somCheckCouncilDataSet = L5.DatasetMgr.lookup("somCheckCouncilDataSet");
		somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckDataSet.newRecord();
			}
		});
		somCheckCouncilDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckCouncilDataSet.load();
		somCheckCouncilDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckCouncilDataSet.newRecord();
			}
		});
		//创建页面导航下拉框
		createGroupDetailSelect();
	}
	 function docPrint(){
        document.execCommand("Print", false);
    }
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
textarea {
	overflow: hidden;
}
label {
	text-align:center;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
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
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="secretarygeneralTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float"  class="noprint">
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;"  onclick="lastPage1('03');"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;"  onclick="nextPage1('2');"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=left style="width:800px;">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p  align=center style='text-align:center'><span
style='font-size:16.0pt;font-family:黑体;'>一、基本信息</></p>

<div align=center>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table   cellspacing=0 cellpadding=0 width="800">
  <tr>
  <td width="16%" style='width:16.88%;border-top:1.5pt;border-left:1.5pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;'>
	  <p align=center>
	  <span style='font-size:14.0pt;font-family:宋体'>名&nbsp;&nbsp;&nbsp; 称</span></p>
  </td>
  <td width="83%" colspan=10 valign=middle style='width:83.12%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:  0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p  align=center style='line-height:24.0pt;'>
	  	<span>
	  		<label  field="cnName" style="width:98%"/>
	  	</span>
	  </p>
  </td>
 </tr>
 <tr style='height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>业务主管</span></p>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>单&nbsp;&nbsp;&nbsp; 位</span></p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
  		<label field="borgName" dataset="businessOrganSelect" style="width:98%"/>
  	</span>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>行业分类</p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.22%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center style='line-height:48.0pt;'>
  <span>
	<label field="businessType" dataset="busScopeSelect" style="width:98%"/>
</span></p>
  </td>
 </tr>
<tr style='height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>业务范围<span>
  </p>
  </td>
  <td width="83%" colspan=10 valign=middle style='width:83.12%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
		<textarea rows="5" name='业务范围' field="business" style="width:670;" readonly="readonly"></textarea>
	</span>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>登记证号<span><o:p></o:p></span></span></p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center style='line-height:28.0pt;'>
  	<span>
		<label  field="sorgCode" style="width:98%"/>
	</span>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>组织机构代码
  </span></p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
		<label  field="organCode" style="width:98%"/>
	</span>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt; height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>成立时间</span></p>
  </td>
  <td width="29%" valign=middle colspan=4 style='width:29.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center style='line-height:28.0pt;'>
	  <span style='font-size:14.0pt;font-family:宋体'>
	  	<label  field="buildDate" style="width:98%"/>
	  </span>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>注册资金
  </span>
  </p>
  </td>
  <td width="32%" colspan=4 style='width:32.2%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center>
  <span><label  style="text-align:right" field="regMon" style="width:40%"></label>万元</span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>住&nbsp;&nbsp;&nbsp; 所</span>
  </p>
  </td>
  <td valign=middle width="50%" colspan=6 style='width:50.92%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	 	 <label  field="residence" style="width:98%"/>
	  </p>
  </td>
  <td width="15%" colspan=2 valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>邮政编码</span>
	  </p>
  </td>
  <td valign=middle width="16%" colspan=2 style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  	<label  field="sorgPost" style="width:98%"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  <span style='font-size:14.0pt;font-family:宋体'>联系电话
	  </span>
	  </p>
  </td>
  <td valign=middle width="29%" colspan=4  style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label  field="sorgPhone" style="width:98%"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>传&nbsp;&nbsp;&nbsp; 真</span></p>
  </td>
  <td valign=middle width="32%" colspan=4 style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
		<label  field="sorgFax" style="width:98%"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>联&nbsp;系&nbsp;人</span>
  </p>
  </td>
  <td valign=middle width="50%" colspan=2 style='width:50.92%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	 	 <label field="linkmanName" style="width:98%" />
	  </p>
  </td>
  <td width="15%" colspan=2 valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>电话</span>
	  </p>
  </td>
  <td valign=middle width="16%" colspan=2 style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  	<label  field="linkmanPhone" style="width:98%" />
	  </p>
  </td>
  <td width="15%" colspan=2 valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>手机</span>
	  </p>
  </td>
  <td valign=middle width="16%" colspan=2 style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  	<label field="linkmanMobile" style="width:98%" />
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>网站地址</span>
  </p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label  field="sorgWeb" style="width:98%"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>电子邮箱</span>
  </p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label  field="sorgEmail" style="width:98%"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>单位会员数</span>
  </p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label  field="unitsNum" style="width:98%"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>个人会员数</span>
  </p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label  field="peopleNum" style="width:98%"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>法定代表人</span>
  </p>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>姓&nbsp;名</span>
  </p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label  field="legalPeople" style="width:98%"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>法定代表人<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>担任职务<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
		<label field="legalPeopleDuty" dataset="sorgDutiesSelect" style="width:98%"/>
  </p>
  </td>
 </tr>
 </table>
</form>
<form method="post" dataset="somCheckCouncilDataSet" onsubmit="return false">
 <table   cellspacing=0 cellpadding=0 width="800">
 <tr style='height:27.0pt;' >
  <td width="16%" rowspan=4 style='width:16%;border-top:none;border-left:
  solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;border-right:
  solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>理事会情况</span>
	  </p>
  </td>
  <td width="11%" valign=top style='width:11.44%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>理事长</span></p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>姓&nbsp; 名</span>
	  </p>
  </td>
  <td width="16%" colspan=2 valign=middle style='width:16.04%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  		<label  field="chairmanName" style="width:98%"/>
  </p>
  </td>
  <td width="13%" colspan=2 style='width:13.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	 	 <span style='font-size:14.0pt;font-family:宋体'>理事人数</span>
	  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.32%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  	<label  field="councilNum" style="width:98%"/>
	  </p>
  </td>
  <td width="17%" colspan=2 style='width:17.1%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>秘书长以上负责人人数</span>
	  </p>
  </td>
  <td width="12%" style='width:12.5%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  		<label  field="secretarygeneralNum" style="width:98%"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="11%" style='width:11.44%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>秘书长</span></p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>姓&nbsp; 名</span></p>
  </td>
  <td width="16%" colspan=2 style='width:16.04%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  		<label  field="secretarygeneralName" style="width:98%"/>
	  </p>
  </td>
  <td width="13%" colspan=2 style='width:13.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>常务理事</span>
	  </p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>人&nbsp;&nbsp;&nbsp; 数</span>
	  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.32%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  		<label  field="executiveDirectorNum" style="width:98%"/>
	  </p>
  </td>
  <td width="17%" colspan=2 style='width:17.1%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>秘书长为</span>
  </p>
  </td>
  <td width="12%" valign=middle style='width:12.5%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p class=MsoNormal style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体;'><o:p>
    <label field='secretarygeneralType'style='width:98%' dataset='secretarygeneralTypeSelect'/>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="25%" colspan=2 style='width:25.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-right:-5.4pt;text-align:center;
  line-height:28.0pt;'><span style='font-size:14.0pt;
  font-family:宋体'>现职公务员兼任</p>
  <p align=center style='margin-right:-5.4pt;text-align:center;
  line-height:28.0pt;'><span style='font-size:14.0pt;
  font-family:宋体'>负责人情况</span></p>
  </td>
  <td width="57%" colspan=8 style='width:57.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p style='line-height:28.0pt;'>
		  <span style='font-size:14.0pt;font-family:宋体'>
		  省部级及以上(<label  field="servantProNum" style="width:50"></label>)人；
		  地厅级(<label  field="servantCityNum" style="width:50"></label>)人；
		  县处级(<label  field="servantTownNum" style="width:50"></label>)人
		  </span>
	  </p>
  </td>
 </tr>
 <tr style='mso-yfti-lastrow:yes;page-break-inside:avoid;height:27.0pt'>
  <td width="25%" colspan=2 style='width:25.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>离退休人员担任</span>
	  </p>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>负责人情况</span>
	  </p>
  </td>
  <td width="57%" colspan=8 style='width:57.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p style='margin-right:-.7pt;line-height:28.0pt;'>
		  <span style='font-size:14.0pt;font-family:宋体'>
		  总数(<label  field="retiredSumNum" style="width:50"></label>)人，
		  其中地厅级及以上(<label  field="retiredCityNum" style="width:50"></label>)人；
		  70岁以上(<label  field="retiredOldNum" style="width:50"></label>)人
		  </span>
	  </p>
  </td>
 </tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>


</div>

</body>
</html>
