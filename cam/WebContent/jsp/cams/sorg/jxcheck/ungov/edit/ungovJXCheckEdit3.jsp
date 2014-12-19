<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
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
	var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
	for(var i = 0;i<2;i++){
		addTr();
	}
	for(var i=0;i<5;i++){
		addSuborganTr();
	}
}
function save(){
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return;
	}
	var checkRecord=somCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkRecord", checkRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage18");
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
	var url='jsp/cams/sorg/jxcheck/ungov/edit/ungovJXCheckEdit4.jsp';
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
	 var tab=document.getElementById("activities");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:变更事项
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:变更前情况
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:变更后情况
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:批准时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312' format='Y-m-d' onclick='LoushangDate(this)' readonly></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;'  style='font-size: 16.0pt; font-family: 仿宋_GB2312'onclick=\"deltr('" + xuhao + "')\" >删除</a></o:p></span></p>";
}
function deltr(trid){
		var tab=document.getElementById("activities");
    var row=document.getElementById(trid);    
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
    tab.deleteRow(index);  //从table中删除
}


//增加一行方法
function addSuborganTr(){
	 var tab=document.getElementById("activitiesSuborgan");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id ="suborgan"+ xuhao;
    //添加列:内设机构
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:名称
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span align='center' lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:是否有变更情况
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span align='center' lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><select style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <option  value=''>请选择...</option><option  value='1'>是</option><option  value='0'>否</option></select></span></p>";
    //添加列:变更前情况
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:变更后情况
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span align='center' lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 16.0pt; font-family: 仿宋_GB2312' format='Y-m-d' onclick='LoushangDate(this)' readonly></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;'  style='font-size: 16.0pt; font-family: 仿宋_GB2312'onclick=\"deltrSuborgan('suborgan" + xuhao + "')\" >删除</a></o:p></span></p>";
}
function deltrSuborgan(trid){
		var tab=document.getElementById("activitiesSuborgan");
    var row=document.getElementById(trid);    
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
    tab.deleteRow(index);  //从table中删除
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="otherDesc" type="string" rule="require|length{3500}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align: center'><span
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"; letter-spacing: 1.5pt'>二、本年度变更登记事项<span
	lang=EN-US><o:p></o:p></span></span></p>
<div class=MsoNormalTable style='width: 800; margin-left: 150.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addTr()">增加一行</button></div>
<table id="activities" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center width=800
	style='border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 30.0pt'>
		<td width=147
			style='width: 110.3pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>变更事项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=147
			style='width: 110.3pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>变更前情况<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=147 
			style='width: 110.3pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>变更后情况<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=147 
			style='width: 110.3pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>批准时间<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=80 
			style='width: 110.3pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>操作<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
</table>
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center border=0 width=800
	style='border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 3; mso-yfti-lastrow: yes; height: 46.45pt'>
		<td width=147
			style='width: 110.3pt; border: solid windowtext 1.0pt; border-top: none; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 46.45pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312'>章程是否修改<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td 
			style='width: 156.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 46.45pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; letter-spacing: 1.5pt'><o:p>
			<select field="" name='"章程是否修改"' style="width:140"><option dataset="comm_haveorno"/></select>
			</o:p></span></p>
		</td>
		<td width=147 
			style='width: 65.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 46.45pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>核准时间<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=80
			style='width: 109.9pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 46.45pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; letter-spacing: 1.5pt'><o:p>
			<input name='"核准时间"' field="" format="Y-m-d" onclick="LoushangDate(this)" style="width:98%" readonly/>
			</o:p></span></p>
		</td>
	</tr>
</table>

<p class=MsoNormal><span lang=EN-US
	style='font-family: 黑体; mso-hansi-font-family: "Times New Roman"; letter-spacing: 1.5pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align: center'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"; letter-spacing: 1.5pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align: center'><span
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"; letter-spacing: 1.5pt'>三、本年度内设机构情况<span
	lang=EN-US><o:p></o:p></span></span></p>
<div class=MsoNormalTable style='width: 80%; margin-left: 100.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addSuborganTr()">增加一行</button></div>
<table id=activitiesSuborgan class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center
	align=left
	style='border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-table-overlap: never; mso-table-lspace: 9.1pt; margin-left: 6.85pt; mso-table-rspace: 9.1pt; margin-right: 6.85pt; mso-table-anchor-vertical: paragraph; mso-table-anchor-horizontal: margin; mso-table-left: left; mso-table-top: 1.0cm; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 62.95pt'>
		<td width=139
			style='width: 104.4pt; border: solid windowtext 1.0pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 62.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.1pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 1.0cm; mso-height-rule: exactly'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>内设机构<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=84
			style='width: 63.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 62.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.1pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 1.0cm; mso-height-rule: exactly'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>名称<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=86
			style='width: 64.7pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 62.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.1pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 1.0cm; mso-height-rule: exactly'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>负责人<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=94
			style='width: 70.3pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 62.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.1pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 1.0cm; mso-height-rule: exactly'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>是否有变更情况<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=108
			style='width: 81.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 62.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.1pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 1.0cm; mso-height-rule: exactly'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>变更前情况<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=108
			style='width: 81.0pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 62.95pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.1pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 1.0cm; mso-height-rule: exactly'><span
			style='mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>变更后情况<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=80
			style='width: 110.3pt; border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>操作<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
