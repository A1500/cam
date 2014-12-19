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
	somCheckDataSet.setParameter("TASK_CODE",taskCode);
	somCheckDataSet.load();
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	var somOrganIsValidate = somCheckDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		return "break";
	}	
	if(checkRecord.get('cnName').trim() == ''){
		L5.Msg.alert("提示","基金会名称不能为空！");
		return "break";
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("checkRecord", checkRecord);
	command.execute("savePage1");
	if (!command.error) {
		alert("保存成功！");		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="cnName" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="organCode" type="string" rule="require" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="buildDate" type="string" rule="require" />
			<model:field name="initialFund" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="require" />
			<model:field name="residence" type="string" rule="require" />
			<model:field name="secretaryName" type="string" rule="require" />
			<model:field name="secretaryPhone" type="string" rule="require" />
			<model:field name="secretaryMobile" type="string" rule="require" />
			<model:field name="linkmanName" type="string" rule="require|length{1000}" />
			<model:field name="linkmanPhone" type="string" rule="require" />
			<model:field name="linkmanMobile" type="string" rule="require" />
			<model:field name="sorgEmail" type="string" rule="require" />
			<model:field name="sorgFax" type="string" rule="require" />
			<model:field name="sorgWebName" type="string" rule="require" />
			<model:field name="sorgWeb" type="string" rule="require" />
			<model:field name="presidentName" type="string" rule="require" />
			<model:field name="sorgPost" type="string" rule="require" />
			<model:field name="syndicNum" type="string" rule="require" />
			<model:field name="auditorNum" type="string" rule="require" />
			<model:field name="principalNum" type="string" rule="require" />
			<model:field name="principalGovNum" type="string" rule="require" />
			<model:field name="principalProvinceNum" type="string" rule="require" />
			<model:field name="ramusNum" type="string" rule="require" />
			<model:field name="delegateNum" type="string" rule="require" />
			<model:field name="specialFund" type="string" rule="require" />
			<model:field name="fulltimeNum" type="string" rule="require" />
			<model:field name="postulandNum" type="string" rule="require" />
			<model:field name="publication" type="string" rule="require" />
			<model:field name="taxRegNum" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_FUND_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('3')"/>
	<input field="" type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('1')"/>
	<input field="" type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input field="" type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>

</div>
<style type='text/css'>
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
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
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 14px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 14px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.unnamed4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed5 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed6 {
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f16ps-size1 {
	border: 1 solid #000000;
	font-size: 16pt;
}

.f16ps-size2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.f16ps-size3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16pt;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f16ps-size4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.boder1 {
	border: 1 solid #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.table {
	font-size: 14px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16pt-0 {
	font-size: 16pt;
	border: 0px none;
	vertical-align: middle;
}

.boderbgh-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	color: #000000;
	background-color: #CCCCCC;
}

.boder0-color {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	background-color: #D8D8D8;
}

.table-text16 {
	font-size: 16px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16-0 {
	font-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	text-align: right;
}

.title1 {
	font-family: '宋体';
	font-size: 18px;
	font-weight: bold;
	color: #000000;
}

.text-12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	line-height: 21px;
	word-spacing: 120em;
}

.title2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: '宋体';
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-size: 18px;
	font-weight: bold;
	color: #000000;
	text-align: right;
}

.biaoti {
	font-family: '宋体';
	font-size: 15px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt {
	font-family: '黑体';
	font-size: 32px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt1 {
	font-family: '宋体';
	font-size: 22px;
	color: #000000;
}

.minfei-bt2 {
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	letter-spacing: 4pt;
}

.npo-bt {
	font-size: 42px;
	line-height: 25px;
	font-weight: bold;
	color: #000000;
	font-family: '宋体';
	text-indent: 10pt;
}

.npo-zi {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.npo-font {
	font-family: '黑体';
	font-size: 22px;
	font-weight: normal;
	color: #000000;
}

.npo-bottomtext {
	font-family: '宋体';
	font-size: 28px;
	line-height: 15px;
	font-weight: bolder;
	color: #000000;
}

.font12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
}

.font12size {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	letter-spacing: 4px;
}

.font16pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.table-text12 {
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.font12size1 {
	border: 1 solid #000000;
	font-size: 12px;
	line-height: 22px;
}

.font12size2 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font12size3 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font12size4 {
	line-height: 22px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.boder12-0 {
	font-size: 12px;
	border: 0px none;
	vertical-align: middle;
}

.input-line16 {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-family: '宋体';
	color: #000000;
}

.font16fpt {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.font18pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 45px;
}

.input-line16f {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋';
}

.input-line16zc {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋';
	background-position: center center;
	text-align: center;
}

.input-line18 {
	font-size: 18pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '宋体';
	line-height: 40pt;
}

.stb-bt {
	font-family: '黑体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.stb-bt1 {
	font-family: '宋体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.boder18-0 {
	font-size: 18pt;
	border: 0px none;
	vertical-align: middle;
}

.select {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	width: 80px;
}

.font16fpt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.font16pt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.hw-bt {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
}

.kt-text {
	font-family: '楷体_GB2312';
	font-size: 16pt;
	color: #000000;
	font-weight: normal;
}

.hw-bt2 {
	font-family: '华文中宋';
	font-size: 18pt;
	font-weight: bold;
	color: #000000;
}

.fs-text {
	font-family: '仿宋';
	font-size: 16pt;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
	line-height: 160%;
}

.ht-text {
	font-family: '黑体';
	font-size: 16pt;
	line-height: 110%;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
}

.red {
	font-family: '仿宋';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}

.txt_ {
	text-align: center; ;
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}
</STYLE>
<form method="post" onsubmit="return false" dataset="somCheckDataSet">
<TABLE height=629 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		<TR>
			<TD align=left height=40>一、基本信息<br>
			<br>
			</TD>
		</TR>
		<TR vAlign=top>
			<TD vAlign=top height=522>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=800 border=0>
				<TBODY>
					<TR>
						<TD class=unnamed2 align=middle width=110 height=30>基金会名称</TD>
						<TD class=unnamed3 colSpan=5 height=30><input field="cnName"
							name='基金会名称' value='' ID='本基金会'
							MAXLENGTH='80' CLASS='boder-0' SIZE='72' ></TD>
					</TR>
					<!-- <TR><TD class=unnamed2 align=middle width=177 height=30>基金会英文名称</TD><TD class=unnamed3 colSpan=3 height=30><FONT color=red>基金会年检基本信息表.英文名称</FONT></TD></TR><TR> -->
					<tr>
						<TD class=unnamed2 align=middle width=100 height=30>登记证号</TD>
						<TD height=30 colspan='2' class=unnamed2><input field="sorgCode"
							name='登记证号' value=''
							CLASS='boder-0' SIZE='30' MAXLENGTH='20' onkeyup="value=value.replace(/[^\-\w\.\/]/ig,'').toUpperCase()"></TD>
						<TD class=unnamed2 align=middle width=122 height=30>组织机构代码</TD>
						<TD height=30 colspan='2' class=unnamed3><input field="organCode"
							name='组织机构代码' value='' ID='机构代码'
							CLASS='boder-0' SIZE='26' MAXLENGTH='12'></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>宗旨</TD>
						<TD class=unnamed3 colSpan=5 height=30><textarea field='purpose'
							name='宗旨' COLS='76' rows='4'
							CLASS='boder-0'
							 onkeyup='this.value = this.value.slice(0,1000)'
							 ></textarea></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>业务范围</TD>
						<TD class=unnamed3 colSpan=5 height=30><textarea field='business'
							name='业务范围'
							 onkeyup='this.value = this.value.slice(0,1000)'
							 COLS='76' rows='4'
							CLASS='boder-0' ></textarea></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>基金会类型</TD>
						<TD height=30 colspan='5' class=unnamed3><select field='sorgKind'name='基金会类型'><option dataset="sorgKindSelect"></option></select></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>成立时间</TD>
						<TD height=30 colspan='2' class=unnamed2><input field="buildDate"
							name='成立时间' value=''
							CLASS='boder-0' SIZE='30' MAXLENGTH='20'format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"  ></TD>
						<TD class=unnamed2 align=middle height=30>原始基金数额</TD>
						<TD height=30 colspan='2' class=unnamed3><input field="initialFund"
							name='原始基金数额'  onKeyUp="value=value.replace(/[^\d.]/g,'')" 
							onblur='checkFloat(this);'
							CLASS='boder-0' SIZE='30' MAXLENGTH='15' >(人民币<span
							class='style1'>万</span>元)</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>业务主管单位</TD>
						<TD class=unnamed3 colSpan=5 height=30>
						<input field="borgName"
							name='业务主管单位'  
							CLASS='boder-0' SIZE='60' MAXLENGTH='200' >
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>基金会住所</TD>
						<TD class=unnamed3 colSpan=5 height=30><input field="residence"
							name='基金会住所' value=''
							MAXLENGTH='80' CLASS='boder-0' SIZE='75' ></TD>
					</TR>
					<TR>
						<TD height=30 colspan='3' align=middle class=unnamed2>
						<div align='center'>秘书长</div>
						</TD>
						<TD height=30 colspan='3' align=middle class=unnamed3>
						<div align='center'>工作联系人</div>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>
						<div align='center'>姓名</div>
						</TD>
						<TD width='85' height=30 class=unnamed2>
						<div align='center'>固定电话</div>
						</TD>
						<TD width='73' class=unnamed2>
						<div align='center'>移动电话</div>
						</TD>
						<TD class=unnamed2 align=middle height=0>
						<div align='center'>姓名及职务</div>
						</TD>
						<TD width='109' height=30 class=unnamed2>
						<div align='center'>固定电话</div>
						</TD>
						<TD width='149' class=unnamed3>
						<div align='center'>移动电话</div>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left><input field="secretaryName"
										name='秘书长姓名' value=''
										CLASS='boder-0' size='8' > <BR>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD height=30 class=unnamed2><input field="secretaryPhone"
							name='秘书长固定电话' value=''
							ID='秘书长固定电话' CLASS='boder-0' SIZE='16' MAXLENGTH='20' >
						</TD>
						<TD height=30 class=unnamed2><input field="secretaryMobile"
							name='秘书长移动电话'
							value='' ID='秘书长移动电话' CLASS='boder-0' SIZE='11' MAXLENGTH='20'
							></TD>
						<TD class=unnamed2 align=middle height=0><textarea field='linkmanName'
							name='联系人姓名及职务'
							 onkeyup='this.value = this.value.slice(0,200)'
							ID='联系人姓名' CLASS='boder-0' ROWS='2' COLS='14' ></textarea>
						</TD>
						<TD height=30 class=unnamed2><input field="linkmanPhone"
							name='联系人固定电话' value='' ID='区号一'
							CLASS='boder-0' SIZE='18' maxlength='30' /> 
						</TD>
						<TD height=30 class=unnamed3><input field="linkmanMobile"
							name='联系人移动电话' value=''
							ID='移动电话' CLASS='boder-0' SIZE='11' MAXLENGTH='20' >
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>电子邮箱</TD>
						<TD height=30 colspan='2' class=unnamed2><input field="sorgEmail"
							name='电子邮箱' value=''
							MAXLENGTH='50' CLASS='boder-0' SIZE='30' ></TD>
						<TD class=unnamed2 align=middle height=30>传真</TD>
						<TD height=30 colspan='2' class=unnamed3><input field="sorgFax"
							name='传真' value='' ID='区号二'
							CLASS='boder-0' SIZE='24' maxlength='30' > </TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>及时通讯工具联系方式（QQ号码等）</TD>
						<TD height=30 colspan='2' class=unnamed2><input field="sorgWebName"
							name='及时通讯工具联系方式'
							value='' MAXLENGTH='40' CLASS='boder-0' SIZE='33' >
						</TD>
						<TD class=unnamed2 align=middle height=30>网址</TD>
						<TD height=30 colspan='2' class=unnamed3><input field="sorgWeb"
							name='网址' value=''
							CLASS='boder-0' SIZE='26' MAXLENGTH='30' ></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>理事长</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD><input field="presidentName"
										name='理事长' value=''
										CLASS='boder-0' ></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>邮政编码</TD>
						<TD height=30 colspan='2' class=unnamed3><input field="sorgPost"
							name='邮政编码' value=''
							MAXLENGTH='6' CLASS='boder-0' SIZE='8' ></TD>
					</TR>
					<!-------->
					<TR>
						<TD class=unnamed2 align=middle height=30>理事数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD><input field="syndicNum" name='理事数'
										value=''  onKeyUp="value=value.replace(/[^\d]/g,'')"  CLASS='boder-0' SIZE='16' maxlength='20' >
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>监事数</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD><input field="auditorNum"
										name='监事数' value=''
										CLASS='boder-0' onKeyUp="value=value.replace(/[^\d]/g,'')" SIZE='8' maxlength='8' ></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>负责人数（理事长、副理事长、秘书长）</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD class=unnamed4 width='55%'><input field="principalNum"
										name='负责人数' value=''
										CLASS='boder-0' onKeyUp="value=value.replace(/[^\d]/g,'')" SIZE='10' maxlength='10' ></TD>
									<TD align=middle width='45%'>
									<div align='center'>负责人中现任<br>
									国家工作人员数</div>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30><input field="principalGovNum"
							name='负责人中现任	国家工作人员数' value=''
							CLASS='boder-0' SIZE='10' maxlength='10' ></TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='70%' height='31' align=middle class=unnamed4>负责人中担任过省部级及以上领导职务的人数</TD>
									<TD align=middle><input field="principalProvinceNum"  onKeyUp="value=value.replace(/[^\d]/g,'')"
										name='负责人中担任过省部级及以上领导职务的人数' value=''
										CLASS='boder-0' SIZE='6' maxlength='6' ></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<!-------->
					<TR>
						<TD class=unnamed2 align=middle height=30>分支机构数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD><input field="ramusNum"
										name='分支机构数' value=''
										CLASS='boder-0' onKeyUp="value=value.replace(/[^\d]/g,'')" SIZE='10' maxlength='10' ></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>代表机构数</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left><input field="delegateNum"
										name='代表机构数' value=''
										CLASS='boder-0' onKeyUp="value=value.replace(/[^\d]/g,'')" SIZE='8' maxlength='8' ></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>专项基金数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD><input field="specialFund"
										name='专项基金数' value=''
										 size='8' onKeyUp="value=value.replace(/[^\d.]/g,'')"
										 onblur='checkFloat(this);' maxlength='8' CLASS='boder-0' >万元</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>专职工作人员数</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left><input field="fulltimeNum"
										name='专职工作人员数' value=''
										ID='专职人数' onKeyUp="value=value.replace(/[^\d]/g,'')" size='8' maxlength='8' CLASS='boder-0' >
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>志愿者数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD><input field="postulandNum"
										name='志愿者数' value=''
										CLASS='boder-0' onKeyUp="value=value.replace(/[^\d]/g,'')" SIZE='10' maxlength='10' ></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>举办刊物情况</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left><input field="publication"
										name='举办刊物情况' value=''
										CLASS='boder-0' SIZE='10' maxlength='50' ><BR>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD width='110' height=30 align=middle class=unnamed4>税务登记证号码</TD>
						<TD colSpan=5 height=30><input field="taxRegNum"
							name='税务登记证号码' value=''
							COLS='70' CLASS='boder-0' ></TD>
					</TR>
			</TABLE>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>第2页</td>
		</tr>
</TABLE>
</form>
</body>
</html>
