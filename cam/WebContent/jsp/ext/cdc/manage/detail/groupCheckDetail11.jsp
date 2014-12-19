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
	var somCheckOrgDetailDataSet = L5.DatasetMgr.lookup("somCheckOrgDetailDataSet");
	somCheckOrgDetailDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckOrgDetailDataSet.load();
	somCheckOrgDetailDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckOrgDetailDataSet.newRecord();
		}
	});
	var somCheckSuborganDataSet = L5.DatasetMgr.lookup("somCheckSuborganDataSet");
	somCheckSuborganDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckSuborganDataSet.setParameter("ORGAN_TYPE@=", "B");//办事机构
	somCheckSuborganDataSet.load();
	somCheckSuborganDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckSuborganDataSet.newRecord();
		}else{
			for(i=1;i<=ds.getCount();i++){
				var sequence = ds.getAt(i-1).get("sequence");
				document.getElementById("organName"+sequence).innerHTML=ds.getAt(i-1).get("organName");
				document.getElementById("manager"+sequence).innerHTML=ds.getAt(i-1).get("manager");
				document.getElementById("regTime"+sequence).innerHTML=ds.getAt(i-1).get("regTime");
				document.getElementById("address"+sequence).innerHTML=ds.getAt(i-1).get("address");
			}
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
function nextPage(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail12.jsp';
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
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckSuborganDataSet" cmd="com.inspur.cams.sorg.check.checksuborgan.cmd.SomCheckSuborganQueryCommand" global="true" pageSize="300">
		<model:record fromBean="com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan"></model:record>
	</model:dataset>
	<model:dataset id="somCheckOrgDetailDataSet" cmd="com.inspur.cams.sorg.check.checkorgdetail.cmd.SomCheckOrgDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail"></model:record>
	</model:dataset>
	<!-- 帐户 -->
	<model:dataset id="accountsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ACCOUNTS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float">
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="下一页"	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="返回"	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="back();" />
</div>
<div align=center>
<div align=center style="margin-top: 60px; width: 800px">
<p class=MsoNormal align=left width=800px
	style='text-indent: 27.55pt; mso-char-indent-count: 1.96; line-height: 25.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（三）办事机构情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<form method="post" dataset="somCheckOrgDetailDataSet"
	onsubmit="return false">
<p class=MsoNormal align=left width=800px
	style='margin-left: 42.05pt; mso-para-margin-left: 2.67gd; text-indent: -14.0pt; mso-char-indent-count: -1.0; line-height: 23.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 宋体'>1</span><span
	style='font-size: 14.0pt; font-family: 宋体'>．本年度新设立办事机构（<span
	lang=EN-US><span style='mso-spacerun: yes'> <label
	field="workingBuildNum" style="width: 30"></label> </span></span>）个，其中已办理设立备案手续的（<span
	lang=EN-US><span style='mso-spacerun: yes'> <label
	field="workingBuildedNum" style="width: 30"></label> </span></span>）个；<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 23.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 宋体'>2</span><span
	style='font-size: 14.0pt; font-family: 宋体'>．本年度撤销办事机构（<span
	lang=EN-US><span style='mso-spacerun: yes'><label
	field="workingCancelNum" style="width: 30"></label></span></span>）个，其中已办理撤销备案手续的（<span
	lang=EN-US><span style='mso-spacerun: yes'> <label
	field="workingCanceledNum" style="width: 30"></label> </span></span>）个；<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 23.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 宋体'>3</span><span
	style='font-size: 14.0pt; font-family: 宋体'>．目前本社团办事机构设置情况如下：<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 28.1pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></b></p>
</form>
<form method="post" dataset="somCheckSuborganDataSet"
	onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	width="800px"
	style='width: 800px; border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<thead>
		<tr style='height: 23.65pt'>
			<td width="9%"
				style='width: 9.02%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.65pt'>
			<p class=MsoNormal align=center
				style='margin-top: 0cm; margin-right: -5.35pt; margin-bottom: 0cm; margin-left: -5.25pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.51gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.5gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 26.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>序号</span><span
				lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
			</td>
			<td width="30%"
				style='width: 30.6%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.65pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 26.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>名</span><span
				lang=EN-US style='font-size: 12.0pt'><span
				style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>称</span><span
				lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
			</td>
			<td width="15%"
				style='width: 15.1%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.65pt'>
			<p class=MsoNormal align=center
				style='margin-top: 0cm; margin-right: -5.35pt; margin-bottom: 0cm; margin-left: -6.3pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.51gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.6gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 26.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>负责人</span><span
				lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
			</td>
			<td width="15%"
				style='width: 15.1%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.65pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 26.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>备案时间</span><span
				lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
			</td>
			<td width="30%"
				style='width: 30.18%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.65pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 26.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>住</span><span
				lang=EN-US style='font-size: 12.0pt'><span
				style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
				style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>所</span><span
				lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
			</td>
		</tr>
	</thead>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>1.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName1" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager1" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime1" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address1" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>2.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName2" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager2" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime2" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address2" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>3.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName3" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager3" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime3" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address3" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>4.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName4" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager4" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime4" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address4" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>5.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName5" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager5" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime5" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address5" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>6.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName6" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager6" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime6" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address6" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>7.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName7" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager7" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime7" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address7" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>8.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName8" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager8" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime8" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address8" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>9.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></span><![endif]><span lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName9" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager9" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime9" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address9" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>10.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName10" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager10" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime10" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address10" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>11.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName11" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager11" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime11" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address11" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>12.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName12" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager12" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime12" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address12" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>13.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName13" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager13" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime13" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address13" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>14.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName14" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager14" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime14" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address14" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>15.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName15" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager15" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime15" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address15" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-lastrow: yes; height: 25.5pt'>
		<td width="9%"
			style='width: 9.02%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal align=center
			style='margin-left: 21.0pt; text-align: center; text-indent: -21.0pt; line-height: 26.0pt; mso-line-height-rule: exactly; mso-list: l5 level1 lfo8; tab-stops: list 21.0pt'><![if !supportLists]><span
			lang=EN-US
			style='font-size: 12.0pt; mso-fareast-font-family: "Times New Roman"'><span
			style='mso-list: Ignore'>16.<span
			style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
			lang=EN-US style='font-size: 12.0pt'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="organName16" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="manager16" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="15%" valign=top
			style='width: 15.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="regTime16" style="width: 98%" />
		</o:p></span></p>
		</td>
		<td width="30%" valign=top
			style='width: 30.18%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 25.5pt'>
		<p class=MsoNormal
			style='line-height: 26.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US style='font-size: 12.0pt'><o:p>
			<label id="address16" style="width: 98%" />
		</o:p></span></p>
		</td>
	</tr>
</table>
</form>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

