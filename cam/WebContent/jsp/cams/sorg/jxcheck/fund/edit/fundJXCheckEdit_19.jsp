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
	for(var i = 0;i<18;i++){
		addTr();
	}
	for(var i=0;i<9;i++){
		addJianTr();
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
	var data = new L5.Map();
	var url='jsp/cams/sorg/jxcheck/fund/edit/fundJXCheckEdit20.jsp';
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
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:姓名
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:性别
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 仿宋_GB2312'><select name='' style='width: 100%;font-size:14.0pt;'><option  value=''>请选择...</option><option  value='1'>男</option><option  value='2'>女</option></select></span></p>";
    //添加列:出生日期
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' format='Y-m' onclick='LoushangDate(this)' readonly></span></p>";
    //添加列:理事会职务
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><select name='' style='width: 100%;font-size:12.0pt;'><option  value=''>请选择...</option><option  value='00001'>理事长</option><option  value='00003'>副理事长</option><option  value='00005'>理事</option></select></span></p>";
	//添加列:在登记管理机关备案时间
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' format='Y-m-d' onclick='LoushangDate(this)' readonly></span></p>"
    //添加列:本年度出席理事会会议次数
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:本年度在基金会领取的报酬(人民币元)
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:本年度在基金会领取的津贴(人民币元)
    var newNameTD=newTR.insertCell(8);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' ></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(9);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;'  style='font-size: 12.0pt; font-family: 仿宋_GB2312'onclick=\"deltr('" + xuhao + "')\" >删除</a></o:p></span></p>";
}
function deltr(trid){
		var tab=document.getElementById("activities");
    var row=document.getElementById(trid);    
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
    tab.deleteRow(index);  //从table中删除
    //重新排列序号
    var nextid;
    for(i=index;i<tab.rows.length;i++){
        tab.rows[i].cells[0].innerHTML = i.toString();
    }
}


//增加一行方法
function addJianTr(){
	 var tab=document.getElementById("activitiesJian");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id ="jian"+ xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:姓名
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:性别
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><select name='' style='width: 100%;font-size:12.0pt;'><option  value=''>请选择...</option><option  value='1'>男</option><option  value='2'>女</option></select></span></p>";
    //添加列:出生日期
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' format='Y-m' onclick='LoushangDate(this)' readonly></span></p>";
	//添加列:在登记管理机关备案时间
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' format='Y-m-d' onclick='LoushangDate(this)' readonly></span></p>"
    //添加列:本年度列席理事会会议次数
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:任期起止时间
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:本年度在基金会领取的津贴(人民币元)
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' ></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(8);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;'  style='font-size: 12.0pt; font-family: 仿宋_GB2312'onclick=\"delJianTr('jian" + xuhao + "')\" >删除</a></o:p></span></p>";
}
function delJianTr(trid){
		var tab=document.getElementById("activitiesJian");
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
<div style="margin-left:100">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span style='font-size:14.0pt;font-family:黑体;mso-hansi-font-family:
宋体'>九、其他信息<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'>(</span><span style='font-size:14.0pt;
font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>一</span><span lang=EN-US style='font-size:14.0pt'>)</span><span
style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman"'>人员情况</span><span lang=EN-US
style='font-size:14.0pt'> <o:p></o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'>1.</span><span style='font-size:14.0pt;
font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>理事会成员情况</span><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
<div class=MsoNormalTable style='width: 80%; margin-left: 100.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addTr()">增加一行</button></div>
<table id=activities class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=900
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 2.55pt 0cm 2.55pt;mso-prop-change:
 " " 20100120T1029;border-collapse:collapse !msorm;border:none !msorm;
 mso-border-alt:solid windowtext .5pt !msorm;mso-yfti-tbllook:480 !msorm;
 mso-padding-alt:0cm 2.55pt 0cm 2.55pt !msorm'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-prop-change:" " 20100120T1029'
  style='mso-yfti-irow:0 !msorm;mso-yfti-firstrow:yes !msorm'>
  <td width=20 style='border:solid windowtext 1.0pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>序号</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=90 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>姓</span><span style='font-size:14.0pt'>
  </span><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>名</span><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>性别</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>出生日期</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>理事会</span><span style='font-size:
  14.0pt'> </span><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>职</span><span
  lang=EN-US style='font-size:14.0pt'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>务</span><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal style='line-height:11.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>在登记管理机关备案时间</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=69  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal style='line-height:11.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>本年度出席理事会会议次数</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p align=center style='text-align:center;line-height:11.0pt;mso-line-height-rule:
  exactly'><span style='font-size:14.0pt'>本年度在基金会领取的报酬<span lang=EN-US>(</span>人民币元<span
  lang=EN-US>)<o:p></o:p></span></span></p>
  </td>
  <td width=135  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 2.55pt 0cm 2.55pt !msorm'>
  <p class=MsoNormal style='line-height:11.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>本年度在基金会领取的津贴</span><span lang=EN-US
  style='font-size:14.0pt'>(</span><span style='font-size:14.0pt;font-family:
  宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>人民币元</span><span
  lang=EN-US style='font-size:14.0pt'>)<o:p></o:p></span></p>
  </td>
		<td width=50 
			style=' border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size:12.0pt;font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>操作<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
 </tr>
</table>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'>2.</span><span style='font-size:14.0pt;
font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>监事情况</span><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
<div class=MsoNormalTable style='width: 80%; margin-left: 100.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addJianTr()">增加一行</button></div>
<table id=activitiesJian class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=900
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 2.55pt 0cm 2.55pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=20 style='border:solid windowtext 1.0pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>序号</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=90 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>姓名</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>性别</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>出生日期</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=100 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>在登记管理机关备案时间</span><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=69 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>本年度列席理事会会议次数</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=175 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p align=center style='text-align:center;line-height:11.0pt;mso-line-height-rule:
  exactly'><span style='font-size:14.0pt'>任期起止时间<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=135 style='border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 2.55pt 0cm 2.55pt'>
  <p class=MsoNormal style='line-height:11.0pt;mso-line-height-rule:exactly'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>本年度在基金会领取的津贴</span><span lang=EN-US
  style='font-size:14.0pt'>(</span><span style='font-size:14.0pt;font-family:
  宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>人民币元</span><span
  lang=EN-US style='font-size:14.0pt'>)<o:p></o:p></span></p>
  </td>
		<td width=50 
			style='border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size:12.0pt;font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>操作<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
 </tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
