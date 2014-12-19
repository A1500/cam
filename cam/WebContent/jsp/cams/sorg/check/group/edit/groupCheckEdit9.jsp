<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somCheckOrgDetailDataSet = L5.DatasetMgr.lookup("somCheckOrgDetailDataSet");
	somCheckOrgDetailDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckOrgDetailDataSet.load();
	somCheckOrgDetailDataSet.on('load',function(){
		var count = somCheckOrgDetailDataSet.getCount();
		if(count == 0){
			somCheckOrgDetailDataSet.newRecord({"taskCode":taskCode});
		}
	});
	var somCheckSuborganDataSet = L5.DatasetMgr.lookup("somCheckSuborganDataSet");
	somCheckSuborganDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckSuborganDataSet.setParameter("ORGAN_TYPE@=", "F");//分支机构
	somCheckSuborganDataSet.load();
	somCheckSuborganDataSet.on('load',function(ds){
		var count = ds.getCount();
		if(count == 0){
			somCheckSuborganDataSet.newRecord({"taskCode":taskCode});
			for(i=0;i<15;i++){
				addTr();
			}
		}else{
			for(i=1;i<=ds.getCount();i++){
				addTr();
				var sequence = ds.getAt(i-1).get("sequence");
				document.getElementById("organName"+sequence).value=ds.getAt(i-1).get("organName");
				document.getElementById("manager"+sequence).value=ds.getAt(i-1).get("manager");
				document.getElementById("regTime"+sequence).value=ds.getAt(i-1).get("regTime");
				document.getElementById("regNumber"+sequence).value=ds.getAt(i-1).get("regNumber");
				document.getElementById("accounts"+sequence).value=ds.getAt(i-1).get("accounts");
				document.getElementById("address"+sequence).value=ds.getAt(i-1).get("address");
			}
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var tab=document.getElementById("table");
	somCheckSuborganDataSet.removeAll();
	for(i=1;i<tab.rows.length;i++){
		var num=tab.rows[i].id;
		var checkSuborganRecord = somCheckSuborganDataSet.newRecord();
		checkSuborganRecord.set("taskCode",taskCode);
		checkSuborganRecord.set("organType","F");
		checkSuborganRecord.set("sequence",i);
		checkSuborganRecord.set("organName",document.getElementById("organName"+num).value);
		checkSuborganRecord.set("manager",document.getElementById("manager"+num).value);
		checkSuborganRecord.set("regTime",document.getElementById("regTime"+num).value);
		checkSuborganRecord.set("regNumber",document.getElementById("regNumber"+num).value);
		checkSuborganRecord.set("accounts",document.getElementById("accounts"+num).value);
		checkSuborganRecord.set("address",document.getElementById("address"+num).value);
	}
	var checkSuborganRecords=somCheckSuborganDataSet.getAllRecords();
	var checkOrgDetailRecord=somCheckOrgDetailDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkSuborganRecords", checkSuborganRecords);
	command.setParameter("checkOrgDetailRecord", checkOrgDetailRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage9");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function nextPage(){
	save();
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/edit/groupCheckEdit10.jsp';
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
//增加一行方法
function addTr(){
	 var tab=document.getElementById("table");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.borderLeft="solid windowtext 1.5pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:名称
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='名称' id='organName"+xuhao+"' style='width:98%'  maxlength='100'/></o:p></span></p>";
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='负责人' id='manager"+xuhao+"' style='width:98%'  maxlength='72'/></o:p></span></p>";
    //添加列:登记时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='登记时间' id='regTime"+xuhao+"' style='width:98%' format='Y-m-d' onclick='WdatePicker()'/></o:p></span></p>";
    //添加列:登记证号
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='登记证号' id='regNumber"+xuhao+"' style='width:98%' maxlength='30'/></o:p></span></p>";
 	//添加列:账户
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><select name='账户' id='accounts"+xuhao+"' style='width:98%'><option  value=''>请选择...</option><option  value='1'>基本账户</option><option  value='2'>普通账户</option><option  value='3'>无</option></select></o:p></span></p>";
	//添加列:住所
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='住所' id='address"+xuhao+"' style='width:98%'  maxlength='100'/></o:p></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.5pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;' onclick=\"deltr('" + xuhao + "')\">删除</a></o:p></span></p>";
}
function deltr(trid){
 	var tab=document.getElementById("table");
    var row=document.getElementById(trid);
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始
    tab.deleteRow(index);  //从table中删除
    //重新排列序号
    var nextid;
    for(i=index;i<tab.rows.length;i++){
        tab.rows[i].cells[0].innerHTML = i.toString();
    }
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
	<model:dataset id="accountsSelect" enumName="SOM.CHECK.ACCOUNTS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float"><!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> <input type="button"
	value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="save();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="back();" />
</div>
<div align=center>
<div align=center style="margin-top: 60px; width: 800px">
<span lang=EN-US
	style='width:800px;font-size: 14.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA'><br
	clear=all style='page-break-before: always'>
</span>

<p class=MsoNormal align=center width=800px
	style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>四、分支机构、代表机构、专项基金管理机构、<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center width=800px
	style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>办事机构基本情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='line-height: 15.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 27.55pt; mso-char-indent-count: 1.96; line-height: 25.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（一）分支机构情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somCheckOrgDetailDataSet" onsubmit="return false">
<p class=MsoNormal align=left width=800px
	style='text-indent: 26.0pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>1</span><span
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>．本年度新设立分支机构（
	<input name='分支机构新设数' field="branchBuildNum" style="width:30" maxlength="10"/>
	）个，其中已办理成立登记手续的（
	<input name='分支机构办理成立登记手续的个数' field="branchBuildedNum" style="width:30" maxlength="10"/>
	）个；<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 26.0pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>2</span><span
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>．本年度注销分支机构（
	<input name='分支机构注销数' field="branchCancelNum" style="width:30" maxlength="10"/>
	）个，其中已办理注销登记手续的（
	<input name='分支机构办理注销手续个数' field="branchCanceledNum" style="width:30" maxlength="10"/>
	）个；<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 26.4pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.4pt'>3</span><span
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.4pt'>．目前本社团分支机构设置情况如下：<span
	lang=EN-US><o:p></o:p></span></span></p>
</form>

<div id="addButton" align="left" >
	<input type="button" value="增加一行" style="height: 25px; width: 100px; position: absolute; " onclick="addTr()"/>
</div>

<form method="post"onsubmit="return false">
<table id="table" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	width="800px"
	style='width:800px; border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='height: 19.3pt'>
		<td width="5%"
			style='width: 5.02%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='margin-top: 0cm; margin-right: -5.35pt; margin-bottom: 0cm; margin-left: -5.25pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.51gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.5gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>序号</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="19%"
			style='width: 19.34%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>名</span><span
			lang=EN-US style='font-size: 12.0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>称</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.32%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='margin-top: 0cm; margin-right: -5.35pt; margin-bottom: 0cm; margin-left: -6.3pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.51gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.6gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>负责人</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="14%"
			style='width: 14.48%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>登记时间</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="13%"
			style='width: 13.74%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>登记证号</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.8%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>账</span><span
			style='font-size: 12.0pt'> </span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>户</span><span
			lang=EN-US style='font-size: 12.0pt; color: red'><o:p></o:p></span></p>
		</td>
		<td width="20%"
			style='width: 20.3%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.0pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>住</span><span
			lang=EN-US style='font-size: 12.0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>所</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<!-- 增加删除操作 -->
		<td width="11%"
			style='width: 9.02%; border-top: 1.5pt; border-left: 1.0pt; border-bottom: 1.0pt; border-right: 1.5pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.0pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
			操作
		</td>

	</tr>
</table>
</form>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
