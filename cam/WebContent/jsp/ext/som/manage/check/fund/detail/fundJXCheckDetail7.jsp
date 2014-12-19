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
	createFundDetailSelect();
}
function save(){
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxOrganBasicDataSet",somJxOrganBasicDataSet.getCurrent());
	command.execute("savePageJ7");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<style media="print">
	.noprint     { display: none }
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxOrganBasicDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxorganbasic.cmd.SomJxOrganBasicQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxorganbasic.dao.SomJxOrganBasic"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input field='' type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ1('12')" />
	<input field='' type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ1('6')" />
	<input field='' type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="backJ();" />
	<input  type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
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
						<TD class=font12size2 align="center" width='19%' rowSpan=2>分支机构总数</TD>
						<TD class=font12size2 align="center" width='11%' rowSpan=2><label field='ramusNum' style="width: 65"></label>
						个</TD>
						<TD class=font12size2 align="center" width='15%' height=40>本年度新设</TD>
						<TD class=font12size2 align="center" width='13%'><label field='ramusNewNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" width='25%' height=40>其中已办理成立登记手续的</TD>
						<TD class=font12size3 align="center" width='17%'><label field='ramusBuildedNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size2  align="center">本年度注销</TD>
						<TD class=font12size2 align="center" width='13%'><label field='ramusCancelNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" width='25%' height=40>其中已办理注销手续的</TD>
						<TD class=font12size3 align="center" width='17%'><label field='ramusCanceledNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 align="center" rowSpan=2>代表机构总数</TD>
						<TD class=font12size2 align="center" rowSpan=2><label field='delegateNum' style="width: 65"></label>
						个</TD>
						<TD class=font12size2 align="center" width='15%'>本年度新设</TD>
						<TD class=font12size2 align="center"><label field='delegateNewNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理登记手续的</TD>
						<TD class=font12size3 align="center"><label field='delegateBuildedNum' style="width: 75"></label>个</TD>
					</TR>
					<TR>
						<TD class=font12size2 align="center">本年度注销</TD>
						<TD class=font12size2 align="center"><label field='delegateCancelNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理注销手续的</TD>
						<TD class=font12size3 align="center"><label field='delegateCanceledNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 align="center" rowSpan=2>专项基金总数</TD>
						<TD class=font12size2 align="center" rowSpan=2><label field='specialNum' style="width: 65"></label> 个</TD>
						<TD class=font12size2 align="center" width='15%'>本年度新设</TD>
						<TD class=font12size2 align="center"><label field='specialNewNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理设立备案手续的</TD>
						<TD class=font12size3 align="center"><label field='specialBuildedNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 align="center">本年度注销</TD>
						<TD class=font12size2 align="center"><label field='specialCancelNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理注销手续的</TD>
						<TD class=font12size3 align="center"><label field='specialCanceledNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 align="center" rowSpan=2>办事机构总数</TD>
						<TD class=font12size2 align="center" rowSpan=2><label field='officeNum' style="width: 65"></label>
						个</TD>
						<TD class=font12size2 align="center" width='15%'>本年度新设</TD>
						<TD class=font12size2 align="center"><label field='officeNewNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理登记手续的</TD>
						<TD class=font12size3 align="center"><label field='officeBuildedNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size2 align="center">本年度注销</TD>
						<TD class=font12size2 align="center"><label field='officeCancelNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理注销手续的</TD>
						<TD class=font12size3 align="center"><label field='officeCanceledNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD rowspan='2' align="center" class=font12size4>实体机构总数</TD>
						<TD rowspan='2' align="center" class=font12size4><label field='entityNum' style="width: 65"></label>
						个</TD>
						<TD class=font12size2 align="center">本年度新设立</TD>
						<TD class=font12size2 align="center"><label field='entityNewNum' style="width: 75"></label> 个</TD>
						<TD class=font12size2 align="center" height=40>其中已办理成立登记手续的</TD>
						<TD class=font12size3 align="center"><label field='entityBuildedNum' style="width: 75"></label> 个</TD>
					</TR>
					<TR>
						<TD class=font12size4 align="center">本年度注销</TD>
						<TD class=font12size4 align="center"><label field='entityCancelNum' style="width: 75"></label> 个</TD>
						<TD class=font12size4 align="center" height=40>其中已办理注销手续的</TD>
						<TD class=font12s align="center"><label field='entityCanceledNum' style="width: 75"></label> 个</TD>
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
		</td>
	</tr>
</TABLE>
</form>
</body>
</html>
