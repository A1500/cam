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
	somJxChangeCircsDataSet.setParameter("TASK_CODE", taskCode);
	somJxChangeCircsDataSet.load();
	somJxChangeCircsDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
		}else{
			for(var i=1;i<=ds.getCount();i++){
				document.getElementById("result"+i).value=ds.getAt(i-1).get("result");
				document.getElementById("agreeDate"+i).innerHTML=ds.getAt(i-1).get("agreeDate");
				showChange(i,ds.getAt(i-1).get("ifChange"));
			}
		}
	});
	
	somJxCheckSystemsDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckSystemsDataSet.load();
	somJxCheckSystemsDataSet.on('load',function (){
		if(somJxCheckSystemsDataSet.getCount() == 0){
			somJxCheckSystemsDataSet.newRecord();
		}
	});	
	
	somJxCheckAccountingPeopleDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckAccountingPeopleDataSet.load();
	somJxCheckAccountingPeopleDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
		}else{
			for(var i=1;i<=ds.getCount();i++){
				document.getElementById("peopleName"+i).innerHTML=ds.getAt(i-1).get("peopleName");
				document.getElementById("workName"+i).innerHTML=ds.getAt(i-1).get("workName");
				document.getElementById("ifAccountant"+i).value=ds.getAt(i-1).get("ifAccountant");
				document.getElementById("technologyQual"+i).innerHTML=ds.getAt(i-1).get("technologyQual");
			}
		}
	});
	//创建页面导航下拉框
	createFundDetailSelect();
}
function save(){
	somJxChangeCircsDataSet.removeAll();
	for(var i=1;i<15;i++){
		var record=somJxChangeCircsDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("changeItem",i);
		record.set("result",document.getElementById("result"+i).value);
		record.set("agreeDate",document.getElementById("agreeDate"+i).value);
	}
	
	somJxCheckAccountingPeopleDataSet.removeAll();
	for(var i=1;i<4;i++){
		var record=somJxCheckAccountingPeopleDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("peopleName",document.getElementById("peopleName"+i).value);
		record.set("workName",document.getElementById("workName"+i).value);
		record.set("ifAccountant",document.getElementById("ifAccountant"+i).value);
		record.set("technologyQual",document.getElementById("technologyQual"+i).value);
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxChangeCircsRecords",somJxChangeCircsDataSet.getAllRecords());
	command.setParameter("somJxCheckSystemsRecord",somJxCheckSystemsDataSet.getCurrent());
	command.setParameter("somJxCheckAccountingPeopleRecords",somJxCheckAccountingPeopleDataSet.getAllRecords());
	command.execute("savePageJ28");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}	
function LoushangDate(ele){

}
function changeChoose(id){
	if(id.length == 2){
		document.getElementById(id.substring(0,1)).checked=false;
	}else if(id.length == 4){
		document.getElementById(id.substring(0,3)).checked=false;
	}else if(id.length == 1 || id.length == 3){
		document.getElementById(id+'f').checked=false;
	}
}
function findValue(name){
	var checks=document.getElementsByName(name);
	for(i=0;i<checks.length;i++){
		if(checks[i].checked == true){
			return checks[i].value;
		}
	}
}
function showChange(i,value){
	if(i<10){
		if(value === '0'){
			document.getElementById(i+'f').checked=true;
		}else if(value === '1'){
			document.getElementById(i).checked=true;
		}
	}else{
		if(value === '0'){
			document.getElementById(i+'0f').checked=true;
		}else if(value === '1'){
			document.getElementById(i+'0').checked=true;
		}
	}
}
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	FONT-size: 12px;
	FONT-family: '宋体 ';
	FONT-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	FONT-size: 12px;
	FONT-family: '宋体 ';
	FONT-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text12 {
	FONT-family: '宋体';
	FONT-size: 12px;
	color: #000000;
	line-height: 21px;
}

.text14 {
	FONT-size: 14px;
	line-height: 25px;
}

.text14-h2 {
	FONT-size: 16px;
	letter-spacing: 1px;
	line-height: 200%;
}

.text16 {
	FONT-size: 20px;
	letter-spacing: 1px;
	line-height: 200%;
}

.text16-h30 {
	FONT-size: 16px;
	line-height: 30px;
	letter-spacing: normal;
}

.f14pt-boder1 {
	border: 1 solid #000000;
	FONT-size: 13px;
}

.f14pt-boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	FONT-size: 13px;
}

.f14pt-boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	FONT-size: 13px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f14pt-boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	FONT-size: 13px;
}

.f14pt-b1 {
	border: 2 solid #000000;
	FONT-size: 13px;
}

.f14pt-b3 {
	border-bottom-width: 2px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	FONT-size: 13px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f14pt-b2 {
	border-bottom-width: 2px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	FONT-size: 13px;
	border-top-style: none;
	border-right-style: solid;
	border-left-style: none;
	border-right-width: 1px;
	border-right-color: #000000;
}

.boder14-0 {
	FONT-size: 14px;
	border: 0px none;
	vertical-align: middle;
}

.boder16-0 {
	FONT-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title20 {
	FONT-family: '宋体';
	FONT-size: 20px;
	FONT-weight: bold;
	color: #000000;
}

.title23 {
	FONT-family: '宋体';
	FONT-size: 30px;
	FONT-weight: bold;
	color: #000000;
}

.boder13-0 {
	width：98%；
	FONT-size: 13px;
	vertical-align: middle;
}

.text14-red {
	FONT-size: 14px;
	line-height: 20px;
	color: #FF0000;
}

.border-b-20 {
	FONT-family: '宋体';
	FONT-size: 20px;
	FONT-weight: bold;
	color: #000000;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxChangeCircsDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxchangecircs.cmd.SomJxChangeCircsQueryCommand" global="true" pageSize="16">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxchangecircs.dao.SomJxChangeCircs"></model:record>
	</model:dataset>
	<model:dataset id="somJxCheckSystemsDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxchecksystems.cmd.SomJxCheckSystemsQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxchecksystems.dao.SomJxCheckSystems">
		</model:record>
	</model:dataset>	
	<model:dataset id="somJxCheckAccountingPeopleDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.cmd.SomJxCheckAccountingPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckaccountingpeople.dao.SomJxCheckAccountingPeople"></model:record>
	</model:dataset>
	<model:dataset id="changesStatusSelect"	cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CHECK_CHANGES_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 有无 -->
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO"autoLoad="true" global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"	global="true"></model:dataset>
	<!-- 税务登记情况 -->
	<model:dataset id="taxRegTypeSelect" enumName="SOM.CHECK.TAX_REG_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 使用票据种类 -->
	<model:dataset id="billTypeSelect" enumName="SOM.CHECK.BILL_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ1('29')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageJ1('27')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backJ();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=center style="width: 800px">

<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD height=22>&nbsp;</TD>
		</TR>
		<TR>
			<TD class=title20 align=middle height=38>&nbsp;</TD>
		</TR>
		<TR>
			<TD class=text14 height=24><STRONG>九、其他信息</STRONG></TD>
		</TR>
		<TR>
			<TD class=text14 height=24><STRONG>（一）年度登记、备案事项办理情况</STRONG></TD>
		</TR>
		<TR>
			<TD class=text16 vAlign=top>
			<table class=f14pt-b1 cellspacing=0 cellpadding=0 width='100%'
				border=0>
				<tbody>
					<tr align=middle>
						<td class=f14pt-boder2 width='34%' height=20>事项（点击“□”选取）</td>
						<td width='32%' height=20 align='center' class=f14pt-boder2>办理情况</td>
						<td class=f14pt-boder3 width='17%' height=20>批准时间</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="1" name="1" value="1"  onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="1f" name="1" value="0" onclick="changeChoose(this.id);"/>否
						
						变更名称</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result1"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate1" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="2" name="2" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="2f" name="2" value="0" onclick="changeChoose(this.id);"/>否
						
						变更住所</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result2"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate2" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="3" name="3" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="3f" name="3" value="0" onclick="changeChoose(this.id);"/>否
						
						变更业务范围</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result3"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate3" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="4" name="4" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="4f" name="4" value="0" onclick="changeChoose(this.id);"/>否
						
						变更原始基金</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result4"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate4" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="5" name="5" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="5f" name="5" value="0" onclick="changeChoose(this.id);"/>否
						
						变更法定代表人</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result5"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate5" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="6" name="6" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="6f" name="6" value="0" onclick="changeChoose(this.id);"/>否
						
						变更业务主管单位</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result6"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate6" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="7" name="7" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="7f" name="7" value="0" onclick="changeChoose(this.id);"/>否
						
						变更基金会类型</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result7"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate7" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="8" name="8" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="8f" name="8" value="0" onclick="changeChoose(this.id);"/>否
						
						变更宗旨</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result8"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate8" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="9" name="9" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="9f" name="9" value="0" onclick="changeChoose(this.id);"/>否
						
						修改章程</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result9"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate9" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="100" name="10" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="100f" name="10" value="0" onclick="changeChoose(this.id);"/>否
						
						负责人变更</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result10"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate10" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="110" name="11" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="110f" name="11" value="0" onclick="changeChoose(this.id);"/>否
						
						变更代表机构、分支机构名称</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result11"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate11" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="120" name="12" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="120f" name="12" value="0" onclick="changeChoose(this.id);"/>否
						
						变更代表机构、分支机构住所</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result12"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate12" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="130" name="13" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="130f" name="13" value="0" onclick="changeChoose(this.id);"/>否
						
						变更代表机构、分支机构业务范围</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result13"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate13" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 height=20>&nbsp;
						<input type="checkbox" disabled="disabled" id="140" name="14" value="1" onclick="changeChoose(this.id);">是
						<input type="checkbox" disabled="disabled" id="140f" name="14" value="0" onclick="changeChoose(this.id);"/>否
						
						变更代表机构、分支机构负责人</td>
						<td height=20 align='center' class=f14pt-boder2>
							<select	id="result14"style="width: 98%;"  disabled /><option dataset="changesStatusSelect"/></select>
						</td>
						<td class=f14pt-boder3 align=middle height=20>
							<label id="agreeDate14" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%;text-align:center"/>
						</td>
					</tr>
				</tbody>
			</table>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top>&nbsp;</TD>
		</TR>
		<TR>
			<TD class=text14 vAlign=top><STRONG>（二）内部制度建设</STRONG></TD>
		</TR>
		<TR>
			<TD class=text16 vAlign=top>
			<form method="post" dataset="somJxCheckSystemsDataSet" onsubmit="return false">
			<table class=f14pt-b1 cellspacing=0 cellpadding=0 width='100%'
				border=0>
				<tbody>
					<tr>
						<td class=f14pt-boder2 align=middle width='16%' height=22>项目管理</td>
						<td class=f14pt-boder3 width='84%' height=22>
						<table height=22 cellspacing=0 cellpadding=0 width=100% border=0>
							<tbody>
								<tr>
									<td class=f14pt-boder4 align=middle width=204>项目管理制度</td>
									<td width=335>
										<label field="ifBranchSys" style='width:98%' dataset="comm_haveorno"/>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 align=middle height=45>证书印章管理</td>
						<td class=f14pt-boder3>
						<table height=22 cellspacing=0 cellpadding=0 width='100%' border=0>
							<tbody>
								<tr>
									<td class=f14pt-boder2 align=middle height=22>法人证书保管、使用管理制度</td>
									<td class=f14pt-boder2>
										<label field="ifCertSys"style='width:98%' dataset="comm_haveorno"/>
									</td>
									<td class=f14pt-boder2 align=middle>保管在</td>
									<td class=f14pt-boder3>
										<label type="text" field="certSysManager" maxlength="25" style='width:98%'/>
									</td>
								</tr>
								<tr>
									<td class=f14pt-boder4 align=middle width='38%' height=22>印章保管、使用管理制度</td>
									<td class=f14pt-boder4 width='19%'>
										<label field="ifStampSys"style='width:98%' dataset="comm_haveorno"/>
									</td>
									<td class=f14pt-boder4 align=middle width='14%'>保管在</td>
									<td>
										<label type="text" field="stampSysManager" maxlength="25"style='width:98%'/>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 align=middle height=57>工作人员管理</td>
						<td class=f14pt-boder3>
						<table height=22 cellspacing=0 cellpadding=0 width=100% border=0>
							<tbody>
								<tr>
									<td class=f14pt-boder2 align=middle width=111 height=22>人事管理制度</td>
									<td class=f14pt-boder2 align=middle width=95>
										<label  field="ifPersonnalSys"style='width:98%' dataset="comm_haveorno"/>
									</td>
									<td class=f14pt-boder2 align=middle width=193>专职工作人员签订聘用合同人数
									</td>
									<td class=f14pt-boder3 width=140><label
										name='query$form$0$ST_NJ_INNER4$hetongrenshu' field='contractPersonNum'
										CLASS='boder13-0' SIZE='18'  onkeyup="value=value.replace(/[^\d]/g,'') "style='width:98%' style='text-align:center'></td>
								</tr>
								<tr>
									<td class=f14pt-boder4 align=middle height=22>专职工作人员参加社会保险人数</td>
									<td align=middle colspan=3 height=22>
									<table cellspacing=0 cellpadding=0 width=428 border=0>
										<tbody>
											<tr>
												<td class=f14pt-boder2 align=middle width=65 height=22>失业保险</td>
												<td class=f14pt-boder2 width=78><label
													name='query$form$0$ST_NJ_INNER4$shiyebaoxian' field='unemploymentInsNum'
													CLASS='boder13-0' SIZE='10'  onkeyup="value=value.replace(/[^\d]/g,'') "style='width:98%' style='text-align:center'></td>
												<td class=f14pt-boder2 align=middle width=65>养老保险</td>
												<td class=f14pt-boder2 width=81><label
													name='query$form$0$ST_NJ_INNER4$yanglaobaoxian' field='endowmentInsNum'
													CLASS='boder13-0' SIZE='10'  onkeyup="value=value.replace(/[^\d]/g,'') "style='width:98%' style='text-align:center'></td>
												<td class=f14pt-boder2 align=middle width=62>医疗保险</td>
												<td class=f14pt-boder3 width=77><label
													name='query$form$0$ST_NJ_INNER4$yiliaobaoxian' field='medicalInsNum'
													CLASS='boder13-0' SIZE='10'  onkeyup="value=value.replace(/[^\d]/g,'') "style='width:98%;text-align:center' ></td>
											</tr>
											<tr>
												<td class=f14pt-boder4 align=middle width=65 height=22>工伤保险</td>
												<td class=f14pt-boder4 width=78><label
													name='query$form$0$ST_NJ_INNER4$gongshangbaoxian' field='injuryInsNum'
													CLASS='boder13-0' SIZE='10' onkeyup="value=value.replace(/[^\d]/g,'') "style='width:98%;text-align:center'></td>
												<td class=f14pt-boder4 align=middle width=65>生育保险</td>
												<td colspan=3><label
													name='query$form$0$ST_NJ_INNER4$shengyubaoxian' field='birthInsNum'
													CLASS='boder13-0' SIZE='10' onkeyup="value=value.replace(/[^\d]/g,'') "style='width:98%;text-align:center'></td>
											</tr>
										</tbody>
									</table>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder2 align=middle height=60>财务管理</td>
						<td valign=top>
						<table cellspacing=0 cellpadding=0 width=100% border=0>
							<tbody>
								<tr>
									<td class=f14pt-boder2 width=210 height=22>人民币开户银行(列出全部开户行)</td>
									<td class=f14pt-boder3><textarea
										name='query$form$0$ST_NJ_INNER4$kaihuyinxing' COLS='61'
										rows='2' CLASS='boder13-0' field='rmbDepositBank' readonly></textarea></td>
								</tr>
								<tr>
									<td class=f14pt-boder2 height=22>人民币银行账号(列出全部帐号)</td>
									<td class=f14pt-boder3><textarea
										name='query$form$0$ST_NJ_INNER4$yinxingzhanghao' COLS='61'
										rows='2' CLASS='boder13-0' field='rmbBankAccounts' readonly></textarea></td>
								</tr>
								<tr>
									<td class=f14pt-boder2 height=22>外币开户银行(列出全部开户行)</td>
									<td class=f14pt-boder3><textarea
										name='query$form$0$ST_NJ_INNER4$waibikaihuyinxing' COLS='61'
										rows='2' CLASS='boder13-0' field=wbDepositBank readonly></textarea></td>
								</tr>
								<tr>
									<td class=f14pt-boder2 height=22>外币银行账号(列出全部帐号)</td>
									<td class=f14pt-boder3><textarea
										name='query$form$0$ST_NJ_INNER4$waibiyinxingzhanghao'
										COLS='61' rows='2' CLASS='boder13-0' field=wbBankAccounts readonly></textarea></td>
								</tr>
								<tr>
									<td class=f14pt-boder2 align=middle height=22>财政登记</td>
									<td class=f14pt-boder3>
									<table height=22 cellspacing=0 cellpadding=0 width='100%'
										border=0>
										<tbody>
											<tr>
												<td class=f14pt-boder4 width='22%'>
													<label field="ifFinancialReg"style='width:98%' dataset="comm_haveorno"/>
												<td class=f14pt-boder4 align=middle width='33%'>税务登记</td>
												<td width='45%'>
													<label field="taxRegType" style='width:98%' dataset="taxRegTypeSelect"/>
												</td>
											</tr>
										</tbody>
									</table>
									</td>
								</tr>
								<tr>
									<td class=f14pt-boder2 align=middle height=45>使用票据种类</td>
									<td class=f14pt-boder3>
										<label field="billType"  style='width:98%' dataset="billTypeSelect"/>
										
									</td>
								</tr>
								<tr>
									<td class=f14pt-boder2 align=middle height=130>财会人员</td>
									<td class=f14pt-boder3>
									<table height=130 cellspacing=0 cellpadding=0 width='100%'
										border=0>
										<tbody>
											<tr align='middle'>
												<td height='26' class=f14pt-boder2 width='25%'>姓名</td>
												<td class=f14pt-boder2 align=middle width='25%'>岗位</td>
												<td class=f14pt-boder2 width='25%'>是否持有会计证</td>
												<td class=f14pt-boder3 width='25%'>专业技术资格</td>
											</tr>
											<tr align='middle'>
												<td height='26' class=f14pt-boder2 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$xingmingyi' id='peopleName1'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder2 align=middle width='25%'><label
													name='query$form$0$ST_NJ_INNER4$gangweiyi' id='workName1'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder2 width='25%'>
													<select id="ifAccountant1"style='width:98%' disabled>
														<option dataset="YorNDataset"></option>
													</select>
												</td>
												<td class=f14pt-boder3 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$jishuzigeyi' id='technologyQual1'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
											</tr>
											<tr align='middle'>
												<td height='26' class=f14pt-boder2 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$xingminger' id='peopleName2'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder2 align=middle width='25%'><label
													name='query$form$0$ST_NJ_INNER4$gangweier' id='workName2'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder2 width='25%'>
													<select id="ifAccountant2"style='width:98%'disabled>
														<option dataset="YorNDataset"></option>
													</select>
												</td>
												<td class=f14pt-boder3 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$jishuzigeer' id='technologyQual2'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
											</tr>
											<tr align='middle'>
												<td height='26' class=f14pt-boder2 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$xingmingsan' id='peopleName3'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder2 align=middle width='25%'><label
													name='query$form$0$ST_NJ_INNER4$gangweisan' id='workName3'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder2 width='25%'>
													<select id="ifAccountant3"style='width:98%'disabled>
														<option dataset="YorNDataset"></option>
													</select>
												</td>
												<td class=f14pt-boder3 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$jishuzigesan' id='technologyQual3'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
											</tr>
											<tr align='middle'>
												<td height='26' class=f14pt-boder4 width='25%'><label
													name='query$form$0$ST_NJ_INNER4$xingmingsi' id='peopleName4'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder4 align=middle width='25%'><label
													name='query$form$0$ST_NJ_INNER4$gangweisi' id='workName4'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
												<td class=f14pt-boder4 width='25%'>
													<select id="ifAccountant4"style='width:98%'disabled>
														<option dataset="YorNDataset"></option>
													</select>
												</td>
												<td width='25%'><label
													name='query$form$0$ST_NJ_INNER4$jishuzigesi' id='technologyQual4'
													CLASS='boder13-0' SIZE='10' style='width:98%'></td>
											</tr>
										</tbody>
									</table>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
					<tr>
						<td class=f14pt-boder4 align=middle height=30>其他管理制度</td>
						<td valign=middle><label
							name='query$form$0$ST_NJ_INNER4$qitazhidu' field='ohtherManagement' ID='其他制度'
							SIZE='68' MAXLENGTH='100' CLASS='boder13-0' style='width:98%'></td>
					</tr>
				</tbody>
			</table>
			</form>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		</td>
	</tr>
</TABLE>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
