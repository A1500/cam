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
	for(var i = 0;i<10;i++){
		addTr();
	}
	for(var i=0;i<5;i++){
		addPublishDetailTr();
	}
	for(var i=0;i<3;i++){
		addInterProjectTr();
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
	var url='jsp/cams/sorg/jxcheck/fund/edit/fundJXCheckEdit21.jsp';
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
    //添加列:姓名
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:政治面貌
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 仿宋_GB2312'><select name='' style='width: 100%;font-size:12.0pt;'><option  value=''>请选择...</option><option  value='01'>中国共产党党员</option><option  value='02'>中国共产党预备党员</option><option  value='03'>中国共产主义青年团团员</option><option  value='04'>中国国民党革命委员会会员</option><option  value='05'>中国民主同盟盟员</option><option  value='06'>中国民主建国会会员</option><option  value='07'>中国民主促进会会员</option><option  value='08'>中国农工民主党党员</option><option  value='09'>中国致公党党员</option><option  value='10'>九三学社社员</option><option  value='11'>台湾民主自治同盟盟员</option><option  value='12'>无党派民主人士</option><option  value='13'>群众</option></select></span></p>";
    //添加列:所在部门
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' ></span></p>";
	//添加列:职务
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' ></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(4);
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
}

//增加一行方法
function addPublishDetailTr(){
	 var tab=document.getElementById("activitiesPublishDetail");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id ="publishDetail"+ xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:公布事项
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:刊载的报刊或网站名称
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:刊载日期
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' format='Y-m-d' onclick='LoushangDate(this)' readonly></span></p>";
	//添加列:操作
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;'  style='font-size: 12.0pt; font-family: 仿宋_GB2312'onclick=\"delPublishDetailTr('publishDetail" + xuhao + "')\" >删除</a></o:p></span></p>";
}
function delPublishDetailTr(trid){
	var tab=document.getElementById("activitiesPublishDetail");
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
function addInterProjectTr(){
	 var tab=document.getElementById("activitiesInterProject");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id ="interProject"+ xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = (parseInt(xuhao)-1);
    //添加列:项目名称
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>"
    //添加列:境外合作单位名称
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:所属国家或地区
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' ></span></p>";
	//添加列:境外
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312' ></span></p>"
    //添加列:境内
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:项目类别
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋_GB2312'><input type='text' style='width: 100%; font-size: 12.0pt; font-family: 仿宋_GB2312'></span></p>";
    //添加列:合作项目内容简介
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
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;'  style='font-size: 12.0pt; font-family: 仿宋_GB2312'onclick=\"delInterProjectTr('interProject" + xuhao + "')\" >删除</a></o:p></span></p>";
}
function delInterProjectTr(trid){
	var tab=document.getElementById("activitiesInterProject");
    var row=document.getElementById(trid);    
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
    tab.deleteRow(index);  //从table中删除
    //重新排列序号
    var nextid;
    for(i=index;i<tab.rows.length;i++){
        tab.rows[i].cells[0].innerHTML = i.toString()-1;
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
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'>3</span><span style='font-size:14.0pt;
font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>、工作人员名单</span><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>

<div class=MsoNormalTable style='width: 80%; margin-left: 100.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addTr()">增加一行</button></div>
<table id=activities class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center width=800
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-prop-change:" " 20100120T1033;
 border-collapse:collapse !msorm;border:none !msorm;mso-border-alt:solid windowtext .5pt !msorm;
 mso-yfti-tbllook:480 !msorm;mso-padding-alt:0cm 5.4pt 0cm 5.4pt !msorm'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-prop-change:" " 20100120T1033'
  style='mso-yfti-irow:0 !msorm;mso-yfti-firstrow:yes !msorm'>
  <td width=80  style='border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;border:solid windowtext 1.0pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 5.4pt 0cm 5.4pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>姓</span><span lang=EN-US
  style='font-size:14.0pt'><span style='mso-spacerun:yes'>&nbsp; </span></span><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>名</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=260  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 5.4pt 0cm 5.4pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>政治面貌</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=260  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 5.4pt 0cm 5.4pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>所在部门</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
    <td width=130  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;border:solid windowtext 1.0pt !msorm;
  border-left:none !msorm;mso-border-left-alt:solid windowtext .5pt !msorm;
  mso-border-alt:solid windowtext .5pt !msorm;padding:0cm 5.4pt 0cm 5.4pt !msorm'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>职务</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
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

<p class=MsoNormal style='margin-bottom:15.6pt;mso-para-margin-bottom:1.0gd;
text-indent:28.0pt;mso-char-indent-count:2.0;line-height:150%'><span
lang=EN-US style='font-size:14.0pt;line-height:150%'>(</span><span
style='font-size:14.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:
"Times New Roman";mso-hansi-font-family:"Times New Roman"'>二</span><span
lang=EN-US style='font-size:14.0pt;line-height:150%'>)</span><span
style='font-size:14.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:
"Times New Roman";mso-hansi-font-family:"Times New Roman"'>信息公布情况</span><span
lang=EN-US style='font-size:14.0pt;line-height:150%'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:15.6pt;mso-para-margin-bottom:1.0gd;
text-indent:28.0pt;mso-char-indent-count:2.0;line-height:150%'><span
style='font-size:14.0pt;line-height:150%;font-family:宋体;mso-ascii-font-family:
"Times New Roman";mso-hansi-font-family:"Times New Roman"'>是否在登记管理机关指定的媒体上公布上年度工作报告摘要</span><span
lang=EN-US style='font-size:14.0pt;line-height:150%'><o:p></o:p></span></p>

<div class=MsoNormalTable style='width: 80%; margin-left: 100.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addPublishDetailTr()">增加一行</button></div>
<table id=activitiesPublishDetail class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center width=900
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:25.5pt'>
  <td width=30  style='border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>序号</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=164  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>公布事项</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=164  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>刊载的报刊或网站名称</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
  <td width=139  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.5pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>刊载日期</span><span lang=EN-US
  style='font-size:14.0pt'><o:p></o:p></span></p>
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
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><span
lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><strong><span
style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'>（三）涉外活动情况</span></strong><strong><span lang=EN-US style='font-size:14.0pt;
font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>

<p class=MsoNormal align=center style='margin-top:7.8pt;margin-right:0cm;
margin-bottom:7.8pt;margin-left:0cm;mso-para-margin-top:.5gd;mso-para-margin-right:
0cm;mso-para-margin-bottom:.5gd;mso-para-margin-left:0cm;text-align:center;
text-indent:28.0pt;mso-char-indent-count:2.0'><strong><span lang=EN-US
style='font-size:14.0pt;font-weight:normal;mso-bidi-font-weight:bold'>1</span></strong><strong><span
style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'>．涉外合作项目</span></strong><strong><span lang=EN-US style='font-size:14.0pt;
font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>

<div class=MsoNormalTable style='width: 80%; margin-left: 100.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
<button onclick="addInterProjectTr()">增加一行</button></div>
<table id=activitiesInterProject class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=center width=900
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:23.25pt'>
  <td width=30 rowspan=2  style='border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><strong><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>序号</span></strong><strong><span lang=EN-US style='font-size:14.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=150 rowspan=2  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><strong><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>项目名称</span></strong><strong><span lang=EN-US style='font-size:14.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=150 rowspan=2  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><strong><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>境外合作单位名称</span></strong><strong><span lang=EN-US style='font-size:14.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=150 rowspan=2  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><strong><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>所属国家或地区</span></strong><strong><span lang=EN-US style='font-size:14.0pt;
  font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=89 colspan=2  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><strong><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
  bold'>项目经费（人民币元）</span></strong><strong><span lang=EN-US style='font-size:
  14.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=95 rowspan=2  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>项目类别</span><strong><span lang=EN-US
  style='font-size:14.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=192 rowspan=2  style='border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>合作项目内容简介</span><strong><span
  lang=EN-US style='font-size:14.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
		<td width=50 rowspan=2
			style=' border: solid windowtext 1.0pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 30.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size:12.0pt;font-family: 仿宋_GB2312; letter-spacing: 1.5pt'>操作<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
 </tr>
 <tr style='mso-yfti-irow:1;height:23.25pt'>
  <td width=95  style='border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'>境外</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=94  style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman";
  font-weight:normal;mso-bidi-font-weight:bold'>境内</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
