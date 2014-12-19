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
var taskFlag='<%=request.getParameter("taskFlag")%>';
//初始化
function init(){
	var somCheckOrgChangeDataSet = L5.DatasetMgr.lookup("somCheckOrgChangeDataSet");
	somCheckOrgChangeDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckOrgChangeDataSet.load();
	somCheckOrgChangeDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			for(i=0;i<7;i++){
				addOrgChangeTr();
			}
		}else{
			for(i=1;i<=ds.getCount();i++){
				for(j=0;j<ds.getCount();j++){
					var record = ds.getAt(j);
					if( record.get('sequence') == i ){
						var tab = document.getElementById("activitiesOrgChange");
						addOrgChangeTr();
						var rowLength = tab.rows.length;
						tab.rows[rowLength-1].cells[0].getElementsByTagName("label")[0].innerHTML=getDicText(record.get("changeType"));
						tab.rows[rowLength-1].cells[1].getElementsByTagName("label")[0].innerHTML=record.get("orgName");
						tab.rows[rowLength-1].cells[2].getElementsByTagName("label")[0].innerHTML=record.get("orgCharger");
						tab.rows[rowLength-1].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("recordDate");
					}					
				}
			}
		}
	});
	
	//创建页面导航下拉框
	createUngovDetailSelect();
}
function getDicText(value){
	var temp;
	if(value==""){
		temp= "";
	}
	if(value=="1"){
		temp= "增加"
	}
	if(value=="2"){
		temp= "减少"
	}
	return temp;
}
function save(){
}
//增加一行方法
function addOrgChangeTr(){
	var tab=document.getElementById("activitiesOrgChange");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:增加   减少
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 2.25pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt'><span lang=EN-US style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体'><label style='width:132'></label></span></p>"
    //添加列:机 构 名 称
    var newNameTD=newTR.insertCell(1);
   newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt'><span lang=EN-US style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体'><label  style='width:132' readonly></label></span></p>"
    //添加列:负 责 人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt'><span lang=EN-US style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体'><label style='width:132' maxlength='30' ></label></span></p>"
    //添加列:备案时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
   newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 2.25pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt'><span lang=EN-US style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体'><label style='width:132' ></label></span></p>"
}
function docPrint(){
    document.execCommand("Print", false);
}			
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<STYLE>
label {
	text-align:center;
	font-size: 13px;
	font-family: 宋体;
}
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckOrgChangeDataSet" cmd="com.inspur.cams.sorg.check.checkorgchange.cmd.SomCheckOrgChangeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkorgchange.data.SomCheckOrgChange"></model:record>
	</model:dataset>
	<model:dataset id="somCheckPublicBenefitDataSet" cmd="com.inspur.cams.sorg.check.checkpublicbenefit.cmd.SomCheckPublicBenefitQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkpublicbenefit.data.SomCheckPublicBenefit"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM1('4')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('6')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back1();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center;line-height:20.0pt;mso-line-height-rule:exactly'><span
style='font-size:22.0pt;mso-bidi-font-size:12.0pt;font-family:黑体;mso-hansi-font-family:
"Times New Roman"'>本年度内设机构增减情况<span lang=EN-US><o:p></o:p></span></span></p>

<div align=center>

<table id=activitiesOrgChange class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=610
 style='width:610;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 2.25pt;
 mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.75pt solid windowtext;
 mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:53.85pt'>
  <td width=100 style='width:62.35pt;border-top:2.25pt;border-left:2.25pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:2.25pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:
  .75pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>增（减）<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=200 style='width:155.95pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>机构名称<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=100 style='width:62.35pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>负责人<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=200 style='width:155.95pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-top-alt:2.25pt;
  mso-border-left-alt:.75pt;mso-border-bottom-alt:.75pt;mso-border-right-alt:
  2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>批准时间<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  </tr>
</table>

</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>
</body>
</html>
