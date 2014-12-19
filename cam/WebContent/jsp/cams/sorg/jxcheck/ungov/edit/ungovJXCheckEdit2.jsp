<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民 办 非 企 业 单 位 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager/>
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
				//创建页面导航下拉框
				createGroupEditSelect();
			}
			function save(){
				try{
					checkData();
				}catch(e){
					  if (e=="break")
					  return "break";
				}
				var checkRecord=somCheckDataSet.getCurrent();
				var checkCouncilRecord=somCheckCouncilDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("checkRecord", checkRecord);
				command.setParameter("checkCouncilRecord", checkCouncilRecord);
				command.execute("savePage1");
				if (!command.error) {
					L5.Msg.alert("提示","保存成功！",function(){
					});		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
				//return "true";
			}
			function nextPage(){
			
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/ungov/edit/ungovJXCheckEdit3.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/somchecktask/somjxchecktask_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function checkData(){
				var checkRecord=somCheckDataSet.getCurrent();
				if(checkRecord.get('cnName').trim() == ''){
					L5.Msg.alert("提示","社会团体名称不能为空！");
					throw flag;
				}
				if(checkRecord.get('sorgCode').trim() == ''){
					L5.Msg.alert("提示","登记证号不能为空！");
					throw flag;
				}
			}
		</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
</div>
<div class=Section1 style='layout-grid:15.6pt'>
<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:16.0pt;mso-bidi-font-size:10.0pt;font-family:黑体;mso-hansi-font-family:
"Times New Roman";letter-spacing:1.5pt'>一、基本情况<span lang=EN-US><o:p></o:p></span></span></p>

<table class=MsoNormalTable  align="center" border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;
 mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;page-break-inside:avoid;
  height:48.25pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>单位名称<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=276 colspan=7 style='width:207.0pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.25pt'>
  <p class=MsoNormal style='text-indent:81.0pt;mso-char-indent-count:6.0'>
  <input lang=EN-US style='width:99%;height:40.25pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=130 colspan=6 style='width:97.15pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>联系电话<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=105 colspan=2 style='width:78.65pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.25pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:40.25pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;page-break-inside:avoid;height:34.75pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>住<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>所<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal>
  <input lang=EN-US style='width:99%;height:30.75pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=130 colspan=6 style='width:97.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span class=GramE><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>邮</span></span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:
  1.5pt'><span style='mso-spacerun:yes'>&nbsp; </span></span><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>编<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=105 colspan=2 style='width:78.65pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:30.75pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;page-break-inside:avoid;height:58.7pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:58.7pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>电子邮箱<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=173 colspan=5 style='width:130.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.7pt'>
  <p class=MsoNormal>
  <input lang=EN-US style='width:99%;height:58.7pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=103 colspan=2 style='width:76.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.7pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>网址<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=234 colspan=8 style='width:175.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.7pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:58.7pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;page-break-inside:avoid;height:47.95pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>法定代表人<span
  lang=EN-US>(</span>单位负责人<span lang=EN-US>)<o:p></o:p></span></span></p>
  </td>
  <td width=125 colspan=3 style='width:94.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:47.95pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=48 colspan=2 style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.5pt'>性别<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=36 style='width:27.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><select id = "" style="mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.5pt" >
  <option dataset="SexDataset"></option></select></p>
  </td>
  <td width=67 style='width:49.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.5pt'>年龄<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=48 style='width:36.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'>
	<input lang=EN-US style='width:99%;height:47.95pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=48 colspan=2 style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.8pt'>手机<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=138 colspan=5 style='width:103.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.95pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:47.95pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;page-break-inside:avoid;height:59.2pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:59.2pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>单位类别<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:59.2pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:59.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=119 colspan=5 style='width:89.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:59.2pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312'>登记日期<span lang=EN-US
  style='letter-spacing:1.5pt'><o:p></o:p></span></span></p>
  </td>
  <td width=115 colspan=3 style='width:86.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:59.2pt'>
  <p class=MsoNormal align=center style='text-align:center'>
	<input lang=EN-US style='width:99%;height:59.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;page-break-inside:avoid;height:58.0pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:58.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>开办资金<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=75 colspan=2 style='width:56.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.0pt'>
  <p class=MsoNormal align=center style='text-align:center'>
   <input lang=EN-US style='width:99%;height:58.0pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=75 colspan=2 style='width:56.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>本年净资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=127 colspan=3 style='width:94.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.0pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:58.0pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' /></p>
  </td>
  <td width=117 colspan=4 style='width:87.9pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.0pt'>
  <p class=MsoNormal><span style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;
  letter-spacing:1.5pt'>本年总资产<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=117 colspan=4 style='width:87.9pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:58.0pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:58.0pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;page-break-inside:avoid;height:48.95pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:48.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>开户银行<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=149 colspan=4 style='width:112.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.95pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  <input lang=EN-US style='width:99%;height:48.95pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=127 colspan=3 style='width:94.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>职工人员数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=60 colspan=2 style='width:45.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.95pt'>
  <p class=MsoNormal align=center style='text-align:center'>
	<input lang=EN-US style='width:99%;height:48.95pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=96 colspan=5 style='width:72.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312'>女职工数<span lang=EN-US
  style='letter-spacing:1.5pt'><o:p></o:p></span></span></p>
  </td>
  <td width=78 style='width:58.8pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:48.95pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  	<input lang=EN-US style='width:99%;height:48.95pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;page-break-inside:avoid;height:41.2pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:41.2pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>帐<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>号<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.2pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  	<input lang=EN-US style='width:99%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=96 colspan=3 style='width:72.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.2pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.6pt'>章程核准时间<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.6pt'>和机关<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=138 colspan=5 style='width:103.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.2pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  	<input lang=EN-US style='width:99%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8;page-break-inside:avoid;height:47.45pt'>
  <td width=127 style='width:95.4pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:47.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>党员人数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=53 style='width:40.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.45pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  	<input lang=EN-US style='width:99%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
  <td width=120 colspan=4 style='width:90.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312'>是否建立党组织<span
  lang=EN-US style='letter-spacing:1.5pt'><o:p></o:p></span></span></p>
  </td>
  <td width=36 style='width:27.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.45pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  	<select id = "" style="mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:-.5pt" >
  <option dataset="YorNDataset"></option></select>
  </p>
  </td>
  <td width=115 colspan=2 style='width:85.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312'>党组织全称<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=186 colspan=7 style='width:139.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:47.45pt'>
  <p class=MsoNormal align=center style='text-align:center'>
  	<input lang=EN-US style='width:99%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />
  </p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9;page-break-inside:avoid;height:36.4pt'>
  <td width=127 rowspan=4 style='width:95.4pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:36.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>服务内容<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:36.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>目前在校学生人数（学校类填写）<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=234 colspan=8 style='width:175.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:36.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'><input lang=EN-US 
  style='width:80%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />人数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10;page-break-inside:avoid;height:38.35pt'>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:38.35pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>本年度共培训人数（劳动类填写）<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=234 colspan=8 style='width:175.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:38.35pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'><input lang=EN-US 
  style='width:80%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />人数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11;page-break-inside:avoid;height:54.4pt'>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:54.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>本年度医疗服务人数（卫生类填写）<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=234 colspan=8 style='width:175.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:54.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'><input lang=EN-US 
  style='width:80%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />人数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;mso-yfti-lastrow:yes;page-break-inside:avoid;
  height:54.4pt'>
  <td width=276 colspan=7 style='width:207.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:54.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'>本年度共举行文化服务活动（文化类填写）<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=234 colspan=8 style='width:175.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:54.4pt'>
  <p class=MsoNormal  align=center style='text-align:center'><span
  style='mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt'><input lang=EN-US 
  style='width:80%;height:41.2pt ; mso-bidi-font-size:10.5pt;font-family:仿宋_GB2312;letter-spacing:1.5pt' />次数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=127 style='border:none'></td>
  <td width=53 style='border:none'></td>
  <td width=21 style='border:none'></td>
  <td width=51 style='border:none'></td>
  <td width=24 style='border:none'></td>
  <td width=24 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=67 style='border:none'></td>
  <td width=48 style='border:none'></td>
  <td width=12 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=21 style='border:none'></td>
  <td width=2 style='border:none'></td>
  <td width=10 style='border:none'></td>
  <td width=26 style='border:none'></td>
  <td width=78 style='border:none'></td>
 </tr>
 <![endif]>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>
</html>
