<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民 办 非 企 业 单 位 </title>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
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
						tab.rows[rowLength-1].cells[0].getElementsByTagName("select")[0].value=record.get("changeType");
						tab.rows[rowLength-1].cells[1].getElementsByTagName("textarea")[0].value=record.get("orgName");
						tab.rows[rowLength-1].cells[2].getElementsByTagName("input")[0].value=record.get("orgCharger");
						tab.rows[rowLength-1].cells[3].getElementsByTagName("input")[0].value=record.get("recordDate");
					}					
				}
			}
		}
	});
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somCheckOrgChangeDataSet=getSomCheckOrgChangeDataSet();
	if(somCheckOrgChangeDataSet=="break"){
		return "break";
	}
	var somCheckOrgChangeRecords=somCheckOrgChangeDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somCheckOrgChangeRecords",somCheckOrgChangeRecords);
	command.execute("savePageM4");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function getSomCheckOrgChangeDataSet(){
	somCheckOrgChangeDataSet.removeAll();
	var tab=document.getElementById("activitiesOrgChange");
	for(i=1;i<tab.rows.length;i++){
		var record = somCheckOrgChangeDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("sequence",i);
		record.set("changeType",tab.rows[i].cells[0].getElementsByTagName("select")[0].value);
		record.set("orgName",tab.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("orgCharger",tab.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("recordDate",tab.rows[i].cells[3].getElementsByTagName("input")[0].value);
		var changeType=tab.rows[i].cells[0].getElementsByTagName("select")[0].value;
		var orgName=tab.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var orgCharger=tab.rows[i].cells[2].getElementsByTagName("input")[0].value;
		var recordDate=tab.rows[i].cells[3].getElementsByTagName("input")[0].value;
		if(changeType==""||orgName==""||orgCharger==""||recordDate==""){
			if(i==1){
				if(orgName!='无'){
					L5.Msg.alert("提示","请至少输入一条本年度内设机构增减情况！没有的请填无！");
					return "break";
				}
			}else{
				if(!(changeType==""&&orgName==""&&orgCharger==""&&recordDate=="")){
					L5.Msg.alert("提示","请输入完整的本年度内设机构增减情况！");
					return "break";
				}			
			}
		}
	}
	return somCheckOrgChangeDataSet;
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
    newNameTD.style.borderTop="none";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><select style='width:132'><option value=''>请选择...</option><option  value='1'>增加</option><option  value='2'>减少</option></select></span></p>"
    //添加列:机 构 名 称
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 2.25pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="none";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><textarea rows='2' style='width:98%' ></textarea></span></p>"
    //添加列:负 责 人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 2.25pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="none";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><input style='width:132' maxlength='30'/></span></p>"
    //添加列:备案时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderLeft="solid windowtext 2.25pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="none";
    newNameTD.style.height="79.4pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><input type='text'  onClick='WdatePicker()' style='width:98%'/></span></p>"
}
</script>
<style>
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}
</style>
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
<div id="float" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('4')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('6')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：4</span>
</div>
<div align=center>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center;line-height:20.0pt;mso-line-height-rule:exactly'><span
style='font-size:22.0pt;mso-bidi-font-size:12.0pt;font-family:黑体;mso-hansi-font-family:
"Times New Roman"'>本年度内设机构增减情况<span lang=EN-US><o:p></o:p></span></span></p>

<div align=center>

<table id=activitiesOrgChange class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=646
 style='width:484.8pt;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 2.25pt;
 mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.75pt solid windowtext;
 mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:53.85pt'>
  <td width=83 style='width:62.35pt;border-top:2.25pt;border-left:2.25pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:2.25pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:
  .75pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>增（减）<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=208 style='width:155.95pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>机构名称<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=83 style='width:62.35pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>负责人<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=208 style='width:155.95pt;border-top:solid windowtext 2.25pt;
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
