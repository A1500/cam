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
	var somJxCheckExpenditureDataSet = L5.DatasetMgr.lookup("somJxCheckExpenditureDataSet");
	somJxCheckExpenditureDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckExpenditureDataSet.load();
	somJxCheckExpenditureDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckExpenditureDataSet.newRecord({"taskCode":taskCode});
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var somJxCheckExpenditureRecord=somJxCheckExpenditureDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("somJxCheckExpenditureRecord", somJxCheckExpenditureRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ15");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<style>
</style>
</head>

<body>
<model:datasets>
<model:dataset id="somJxCheckExpenditureDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.cmd.SomJxCheckExpenditureQueryCommand" global="true">
	<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckexpenditure.dao.SomJxCheckExpenditure">
		<model:field name="limitExplain" type="string" rule="length{1000}"/>
		<model:field name="unlimitExplain" type="string" rule="length{1000}"/>
		<model:field name="pubExplain" type="string" rule="length{1000}"/>
		<model:field name="perOffExplain" type="string" rule="length{1000}"/>
		<model:field name="otherExplain" type="string" rule="length{1000}"/>
	</model:record>
</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('16')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('14')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
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
	font-size: 14px;
	line-height: 25px;
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
	border: 1px solid #000000;
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

.boder-0 {
	font-size: 14px;
	border: 0px none;
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
	line-height: 150%;
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
<TABLE cellSpacing=0 cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD height=36>&nbsp;</TD>
		</TR>
		<TR>
			<TD class=text2624 align=middle height=39>
			<P><STRONG>计算公益支出比例、工作人员工资福利和行政办公支出比例的情况说明 </STRONG></P>
			</TD>
		</TR>
		<TR>
			<TD align=right height=5>&nbsp;</TD>
		</TR>
		<TR>
			<TD>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
				border=0>
				<TBODY>
					<TR>
						<TD vAlign=top height=229>
						<form method="post" dataset="somJxCheckExpenditureDataSet" onsubmit="return false">
						<TABLE cellSpacing=0 cellPadding=0 width='98%' align=center
							border=0>
							<TBODY>
								<TR>
									<TD height=20>上年度总收入中有时间受限为上年不得使用的限定性收入为 <input
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$xiandingshouru'
										field='limitTotal'  SIZE='8' isMoney='true' maxlength="8" onkeyup="value=value.replace(/[^\d.]/g,'')" style='text-align: right'>
									（单位：元）,</TD>
								</TR>
								<TR>
									<TD height=20>
									<P>请说明具体情况:</P>
									</TD>
								</TR>
								<TR>
									<TD><textarea
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$xiandingshourushuoming'
										ROWS='7' COLS='105' field='limitExplain' ></textarea></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<TR>
									<TD height=20>
									<P>于上年解除时间限定的净资产为 <input
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$jingzichan' field='unlimitTotal'
										 SIZE='8' isMoney='true' maxlength="8" onkeyup="value=value.replace(/[^\d.]/g,'')" style='text-align: right'>
									（单位：元），</P>
									</TD>
								</TR>
								<TR>
									<TD height=20>请说明具体情况：</TD>
								</TR>
								<TR>
									<TD><textarea
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$jingzichanshuoming'
										ROWS='7' COLS='105' field='unlimitExplain' ></textarea></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<TR>
									<TD height=20>
									<P>如果本年公益支出与业务活动表中“公益活动支出”“本年累计数”的合计不一致,请说明具体情况:</P>
									</TD>
								</TR>
								<TR>
									<TD><textarea
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$gongyizhichushuoming'
										ROWS='7' COLS='105' field='pubExplain' ></textarea></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<TR>
									<TD>
									<P>如果本年度工作人员工资福利、行政办公之和与业务活动表中“管理费用”“本年累计数”的合计不一致,请说明具体情况:</P>
									</TD>
								</TR>
								<TR>
									<TD><textarea
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$gongzifulishuoming'
										ROWS='7' COLS='105' field='perOffExplain' ></textarea></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<TR>
									<TD>其他需要说明的问题：</TD>
								</TR>
								<TR>
									<TD><textarea
										name='query$form$0$JJHNJ_ZHICHUSHUOMING$qitashuoming' ROWS='7'
										COLS='105' field='otherExplain' ></textarea></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
							</TBODY>
						</TABLE>
						</form>
						</TD>
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
		第15页</td>
	</tr>
</TABLE>
</body>
</html>
