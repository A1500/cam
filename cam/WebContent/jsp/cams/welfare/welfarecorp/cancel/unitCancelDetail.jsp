 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	String method = (String)request.getParameter("method");
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<link href="css/prosthesisapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	//初始化
 	 var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
 	var taskCode='<%=taskCode%>';
 	var method='<%=method%>';
	function init(){
		ds.setParameter("TASK_CODE@=", taskCode);
		ds.load();
	}
	function back(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/cancel/unitCancelList.jsp';
		L5.forward(url);
	}
	function MakeWord(){
	 	var word = new ActiveXObject("Word.Application");
	 	var doc = word .Documents.Add("",0,0);//不打开模版直接加入内容
	 	var   Range=doc.Range();
	 	var sel = document.body.createTextRange();
	 	sel.moveToElementText(form1);//此处form是页面form的id
	 	sel.select();
	 	sel.execCommand("Copy"); 
	 	Range.Paste();
	 	word .Application.Visible = true;
	 	sel.collapse(true);
		sel.select(); 
	}
</script>
</head>
<style type='text/css' >
label {
	font-size:14.0pt;
	mso-bidi-font-size:10.0pt;
  	font-family:宋体;
  	mso-hansi-font-family:"Times New Roman";
  	letter-spacing:2.0pt
}
</style>
<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitLogoffQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitLogoff">
			<model:field name="companyName" type="string" rule="require" />	
			<model:field name="linkman" type="string" rule="require" />
			<model:field name="phone" type="string" rule="require" />
			<model:field name="logoffDate" type="string" rule="require" />
			<model:field name="logoffReason" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务状态表 -->
	<model:dataset id="wealFitStatusDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="back()"/>
	<input type="button" value="word打印" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="MakeWord()"/>
</div>
<form id="form1" method="post"  onsubmit="return false" dataset="ds">
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<div class=WordSection1>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>社会福利企业<span
lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>注销</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:18.0pt;mso-bidi-font-size:
10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
2.0pt'>备案表<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt'><o:p>&nbsp;</o:p></span></b></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=544
 style='width:408.0pt;margin-left:-14.6pt;border-collapse:collapse;border:none;
 mso-border-alt:solid windowtext .5pt;mso-padding-alt:0cm 1.4pt 0cm 1.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:26.0pt'>
  <td width=117 colspan=2 style='width:88.0pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:2.0pt'>企业名称<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=188 colspan=2 style='width:140.65pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><label id="companyName" field="companyName" title="企业名称" style="width:98%;"/></o:p></span></p>
  </td>
  <td width=94 style='width:70.85pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:7.4pt;
  mso-pagination:widow-orphan;text-autospace:none;vertical-align:bottom'><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:2.0pt'>字<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;</span></span>号<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=145 style='width:150pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><label id="serialNum" field="serialNum" title="编号" style="width:100%;"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:26.0pt'>
  <td width=117 colspan=2 style='width:88.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:2.0pt'>联
  系 人<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=188 colspan=2 style='width:140.65pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><label id="linkman" field="linkman" title="联系人" style="width:98%;"/></o:p></span></p>
  </td>
  <td width=94 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:7.4pt;
  mso-pagination:widow-orphan;text-autospace:none;vertical-align:bottom'><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:2.0pt'>联系电话<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=145 style='width:108.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><label id="phone" field="phone" title="联系电话" style="width:98%;"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:30.6pt'>
  <td width=117 colspan=2 style='width:88.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:30.6pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:2.0pt'>注销时间<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=427 colspan=4 style='width:320.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:30.6pt'>
  <p class=MsoNormal style='text-autospace:none;vertical-align:bottom'><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:
  宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:6.0pt'><span
  style='mso-spacerun:yes'><label name='注销时间' field="logoffDate" id='logoffDate'	readonly="readonly" style="width:98%;"/></span><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:261.4pt'>
  <td width=43 style='width:32.0pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:261.4pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6pt'>注<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6pt'>销<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:2.8pt'>原<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6pt'>因<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=501 colspan=5 style='width:376.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:261.4pt'>
  <p class=MsoNormal align=center style='text-align:left;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6.0pt'><o:p><label id="logoffReason" field="logoffReason"  validateName="注销原因" style="width:98%;height:260pt;" /></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;mso-yfti-lastrow:yes;height:107.65pt'>
  <td width=267 colspan=4 valign=top style='width:208.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:107.65pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><span style='mso-spacerun:yes'>&nbsp;</span></span><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:3.0pt'>法定代表人<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  3.0pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:3.0pt'>签 章：</span><span lang=EN-US
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:6.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span><o:p></o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:0pt'>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:
  宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:6.0pt'><o:p></o:p></span></p>
  </td>
  <td width=267 colspan=2 valign=top style='width:200.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:107.65pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:3.0pt'>企业盖章<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=right style='text-align:right;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6.0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:1.0pt'>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:
  宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:6.0pt'><o:p></o:p></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=43 style='border:none'></td>
  <td width=75 style='border:none'></td>
  <td width=160 style='border:none'></td>
  <td width=28 style='border:none'></td>
  <td width=94 style='border:none'></td>
  <td width=145 style='border:none'></td>
 </tr>
 <![endif]>
</table>

</div>

<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>

</div>
</form>
</body>
</html>