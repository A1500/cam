<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somJxOrganBasicDataSet.setParameter("TASK_CODE", taskCode);
	somJxOrganBasicDataSet.load();
	somJxOrganBasicDataSet.on('load',function(){
		if(somJxOrganBasicDataSet.getCount() == 0){
			somJxOrganBasicDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var somJxOrganBasicDataSetIsValidate = somJxOrganBasicDataSet.isValidate();
	if(somJxOrganBasicDataSetIsValidate != true){
		L5.Msg.alert("提示",somJxOrganBasicDataSetIsValidate);
		return "break";
	}
	var branchBuildNum=document.getElementById("新设分支数").value;
	var branchBuildedNum=document.getElementById("办理新设分支数").value;
	if(parseInt(branchBuildedNum) > (parseInt(branchBuildNum))){
		L5.Msg.alert("提示","已办理成立登记手续的分支机构数不能大于本年度新设数！");
		return "break";
	}
	var branchCancelNum=document.getElementById("注销分支数").value;
	var branchCanceledNum=document.getElementById("办理注销分支数").value;
	if(parseInt(branchCanceledNum) > (parseInt(branchCancelNum))){
		L5.Msg.alert("提示","已办理注销登记手续的分支机构数不能大于本年度注销数！");
		return "break";
	}

	var delegateBuildNum=document.getElementById("新设代表数").value;
	var delegateBuildedNum=document.getElementById("办理新设代表数").value;
	if(parseInt(delegateBuildedNum) > (parseInt(delegateBuildNum))){
		L5.Msg.alert("提示","已办理成立登记手续的代表机构数不能大于本年度新设数！");
		return "break";
	}
	var delegateCancelNum=document.getElementById("注销代表数").value;
	var delegateCanceledNum=document.getElementById("办理注销代表数").value;
	if(parseInt(delegateCanceledNum) > (parseInt(delegateCancelNum))){
		L5.Msg.alert("提示","已办理注销登记手续的代表机构数不能大于本年度注销数！");
		return "break";
	}

	var specialFundBuildNum=document.getElementById("新设基金数").value;
	var specialFundBuildedNum=document.getElementById("办理新设基金数").value;
	if(parseInt(specialFundBuildedNum) > (parseInt(specialFundBuildNum))){
		L5.Msg.alert("提示","已办理设立备案手续的专项基金管理机构数不能大于本年度新设数！");
		return "break";
	}
	var specialFundCancelNum=document.getElementById("注销基金数").value;
	var specialFundCanceledNum=document.getElementById("办理注销基金数").value;
	if(parseInt(specialFundCanceledNum) > (parseInt(specialFundCancelNum))){
		L5.Msg.alert("提示","已办理注销登记手续的专项基金管理机构数不能大于本年度注销数！");
		return "break";
	}

	var officeBuildNum=document.getElementById("新设办事数").value;
	var officeBuildedNum=document.getElementById("办理新设办事数").value;
	if(parseInt(officeBuildedNum) > (parseInt(officeBuildNum))){
		L5.Msg.alert("提示","已办理成立登记手续的办事机构数不能大于本年度新设数！");
		return "break";
	}
	var officeCancelNum=document.getElementById("注销办事数").value;
	var officeCanceledNum=document.getElementById("办理注销办事数").value;
	if(parseInt(officeCanceledNum) > (parseInt(officeCancelNum))){
		L5.Msg.alert("提示","已办理注销登记手续的办事机构数不能大于本年度注销数！");
		return "break";
	}

	var entityBuildNum=document.getElementById("新设实体数").value;
	var entityBuildedNum=document.getElementById("办理新设实体数").value;
	if(parseInt(entityBuildedNum) > (parseInt(entityBuildNum))){
		L5.Msg.alert("提示","已办理成立登记手续的实体机构数不能大于本年度新设数！");
		return "break";
	}
	var entityCancelNum=document.getElementById("注销实体数").value;
	var entityCanceledNum=document.getElementById("办理注销实体数").value;
	if(parseInt(entityCanceledNum) > (parseInt(entityCancelNum))){
		L5.Msg.alert("提示","已办理注销登记手续的实体机构数不能大于本年度注销数！");
		return "break";
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxOrganBasicDataSet",somJxOrganBasicDataSet.getCurrent());
	command.execute("savePageJ7");
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
	<model:dataset id="somJxOrganBasicDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxorganbasic.cmd.SomJxOrganBasicQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasic">
			<model:field name="ramusNum" type="string" rule="require" />
			<model:field name="ramusNewNum" type="string" rule="require" />
			<model:field name="ramusBuildedNum" type="string" rule="require" />
			<model:field name="ramusCancelNum" type="string" rule="require" />
			<model:field name="ramusCanceledNum" type="string" rule="require" />
			<model:field name="delegateNum" type="string" rule="require" />
			<model:field name="delegateNewNum" type="string" rule="require" />
			<model:field name="delegateBuildedNum" type="string" rule="require" />
			<model:field name="delegateCancelNum" type="string" rule="require" />
			<model:field name="delegateCanceledNum" type="string" rule="require" />
			<model:field name="specialNum" type="string" rule="require" />
			<model:field name="specialNewNum" type="string" rule="require" />
			<model:field name="specialBuildedNum" type="string" rule="require" />
			<model:field name="specialCancelNum" type="string" rule="require" />
			<model:field name="specialCanceledNum" type="string" rule="require" />
			<model:field name="officeNum" type="string" rule="require" />
			<model:field name="officeNewNum" type="string" rule="require" />
			<model:field name="officeBuildedNum" type="string" rule="require" />
			<model:field name="officeCancelNum" type="string" rule="require" />
			<model:field name="officeCanceledNum" type="string" rule="require" />
			<model:field name="entityNum" type="string" rule="require" />
			<model:field name="entityNewNum" type="string" rule="require" />
			<model:field name="entityBuildedNum" type="string" rule="require" />
			<model:field name="entityCancelNum" type="string" rule="require" />
			<model:field name="entityCanceledNum" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input field='' type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('12')" />
	<input field='' type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('6')" />
	<input field='' type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input field='' type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
</div>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 14px;
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
	font-size: 16px;
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
}

.title1 {
	font-family: '宋体';
	font-size: 23px;
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

.title14 {
	font-family: '宋体';
	font-size: 14px;
	font-weight: bold;
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
</STYLE>
<form method="post" dataset="somJxOrganBasicDataSet" onsubmit="return false">
<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD class=title14 align=left height=36>（六）分支机构、代表机构、专项基金、办事机构、经营性实体基本情况
			</TD>
		</TR>
		<TR>
			<TD>
			<TABLE class=f16ps-size1 cellSpacing=0 cellPadding=0 width='100%'
				border=0>
				<TBODY>
					<TR>
						<TD class=font12size2 width='19%' rowSpan=2>分支机构总数</TD>
						<TD class=font12size2 width='11%' rowSpan=2><input field='ramusNum'
							name='分支机构总数' value='' ID='分支数' onKeyUp="value=value.replace(/[^\d]/g,'');"
							 STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6">
						个</TD>
						<TD class=font12size2 width='15%' height=40>本年度新设</TD>
						<TD class=font12size2 width='13%'><input field='ramusNewNum'
							name='新设分支数' value=''
							ID='新设分支数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 width='25%' height=40>其中已办理成立登记手续的</TD>
						<TD class=font12size3 width='17%'><input field='ramusBuildedNum'
							name='办理新设分支数'
							value='' ID='办理新设分支数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2>本年度注销</TD>
						<TD class=font12size2 width='13%'><input field='ramusCancelNum'
							name='注销分支数' value=''
							ID='注销分支数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 width='25%' height=40>其中已办理注销手续的</TD>
						<TD class=font12size3 width='17%'><input field='ramusCanceledNum'
							name='办理注销分支数'
							value='' ID='办理注销分支数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 rowSpan=2>代表机构总数</TD>
						<TD class=font12size2 rowSpan=2><input field='delegateNum'
							name='代表机构总数' value='' onKeyUp="value=value.replace(/[^\d]/g,'');"
							ID='代表数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6">
						个</TD>
						<TD class=font12size2 width='15%'>本年度新设</TD>
						<TD class=font12size2><input field='delegateNewNum'
							name='新设代表数' value=''
							ID='新设代表数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理登记手续的</TD>
						<TD class=font12size3><input field='delegateBuildedNum'
							name='办理新设代表数'
							value='' ID='办理新设代表数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2>本年度注销</TD>
						<TD class=font12size2><input field='delegateCancelNum'
							name='注销代表数' value=''
							ID='注销代表数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理注销手续的</TD>
						<TD class=font12size3><input field='delegateCanceledNum'
							name='办理注销代表数'
							value='' ID='办理注销代表数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 rowSpan=2>专项基金总数</TD>
						<TD class=font12size2 rowSpan=2><input field='specialNum'
							name='专项基金总数' value='' ID='基金数' onKeyUp="value=value.replace(/[^\d]/g,'');"
							 STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6"

							> 个</TD>
						<TD class=font12size2 width='15%'>本年度新设</TD>
						<TD class=font12size2><input field='specialNewNum'
							name='新设基金数' value=''
							ID='新设基金数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理设立备案手续的</TD>
						<TD class=font12size3><input field='specialBuildedNum'
							name='办理新设基金数' onKeyUp="value=value.replace(/[^\d]/g,'');"
							value='' ID='办理新设基金数'  STYLE='text-align:right;padding-right:2px;'
							SIZE='6' maxlength="6" > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2>本年度注销</TD>
						<TD class=font12size2><input field='specialCancelNum'
							name='注销基金数' value=''
							ID='注销基金数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理注销手续的</TD>
						<TD class=font12size3><input field='specialCanceledNum'
							name='办理注销基金数'
							value='' ID='办理注销基金数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 rowSpan=2>办事机构总数</TD>
						<TD class=font12size2 rowSpan=2><input field='officeNum'
							name='办事机构总数' value='' ID='办事数' onKeyUp="value=value.replace(/[^\d]/g,'');"
							 STYLE='text-align:right;padding-right:2px;' SIZE='6'  maxlength="6">
						个</TD>
						<TD class=font12size2 width='15%'>本年度新设</TD>
						<TD class=font12size2><input field='officeNewNum'
							name='新设办事数' value=''
							ID='新设办事数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理登记手续的</TD>
						<TD class=font12size3><input field='officeBuildedNum'
							name='办理新设办事数'
							value='' ID='办理新设办事数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD class=font12size2>本年度注销</TD>
						<TD class=font12size2><input field='officeCancelNum'
							name='注销办事数' value=''
							ID='注销办事数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理注销手续的</TD>
						<TD class=font12size3><input field='officeCanceledNum'
							name='办理注销办事数'
							value='' ID='办理注销办事数'  STYLE='text-align:right;padding-right:2px;' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' > 个</TD>
					</TR>
					<TR>
						<TD rowspan='2' class=font12size4>实体机构总数</TD>
						<TD rowspan='2' class=font12size4><input field='entityNum'
							name='实体机构总数' value='' ID='实体数' onKeyUp="value=value.replace(/[^\d]/g,'');"
							 STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" >
						个</TD>
						<TD class=font12size2>本年度新设立</TD>
						<TD class=font12size2><input field='entityNewNum'
							name='新设实体数' value=''
							ID='新设实体数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size2 height=40>其中已办理成立登记手续的</TD>
						<TD class=font12size3><input field='entityBuildedNum'
							name='办理新设实体数'
							value='' ID='办理新设实体数'  STYLE='text-align:right;padding-right:2px;' onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' maxlength="6" > 个</TD>
					</TR>
					<TR>
						<TD class=font12size4>本年度注销</TD>
						<TD class=font12size4><input field='entityCancelNum'
							name='注销实体数' value=''
							ID='注销实体数'  STYLE='text-align:right;padding-right:2px;' SIZE='6' maxlength="6" onKeyUp="value=value.replace(/[^\d]/g,'');"
							> 个</TD>
						<TD class=font12size4 height=40>其中已办理注销手续的</TD>
						<TD class=font12s><input field='entityCanceledNum'
							name='办理注销实体数'
							value='' ID='办理注销实体数'  STYLE='text-align:right;padding-right:2px;' onKeyUp="value=value.replace(/[^\d]/g,'');"
							SIZE='6' maxlength="6"> 个</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第7页</td>
	</tr>
</TABLE>
</form>
</body>
</html>
