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
	var somJxCheckSupervisorOpinDataSet = L5.DatasetMgr.lookup("somJxCheckSupervisorOpinDataSet");
	somJxCheckSupervisorOpinDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckSupervisorOpinDataSet.load();
	somJxCheckSupervisorOpinDataSet.on("load",function(ds){
		if(ds.getCount()==0){

		}else{
			for(i=1;i<=ds.getCount();i++){
				document.getElementById("name"+i).value=ds.getAt(i-1).get("name");
				document.getElementById("opinion"+i).value=ds.getAt(i-1).get("opinion");
			}
		}
	});
	//创建页面导航下拉框
	createFundDetailSelect();
}
function save(){
	somJxCheckSupervisorOpinDataSet.removeAll();
	for(i=1;i<=2;i++){
		var somJxCheckSupervisorOpinRecord= somJxCheckSupervisorOpinDataSet.newRecord();
		somJxCheckSupervisorOpinRecord.set("taskCode",taskCode);
		somJxCheckSupervisorOpinRecord.set("name",document.getElementById("name"+i).value);
		somJxCheckSupervisorOpinRecord.set("opinion",document.getElementById("opinion"+i).value);
	}
	var somJxCheckSupervisorOpinRecords=somJxCheckSupervisorOpinDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("somJxCheckSupervisorOpinRecords", somJxCheckSupervisorOpinRecords);
	command.execute("savePageJ26");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function LoushangDate(ele){

}
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<script type="text/javascript">
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
}
</script>
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

.title2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: '宋体';
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-size: 23px;
	font-weight: bold;
	color: #000000;
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

.hw-bt1 {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	padding-bottom: 0px;
	vertical-align: bottom;
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

.textarea02 {
	font-family: '仿宋';
	font-size: 12pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 25px;
}

.textarea03 {
	width:98%;
	font-size: 12pt;
	color: #000000;
	letter-spacing: 1pt;
	line-height: 20px;
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckSupervisorOpinDataSet" cmd="com.inspur.cams.sorg.check.somchecksupervisoropinion.cmd.SomCheckSupervisorOpinionQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somchecksupervisoropinion.dao.SomCheckSupervisorOpinion">
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ1('27')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageJ1('25')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backJ();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="" name="myform" method="post" onsubmit="return false">

<TABLE cellSpacing=0 cellPadding=0 width=659 align=center border=0>
	<TBODY>
		<TR>
			<TD width='100%' height=48 colspan='2'>&nbsp;</TD>
		</TR>
		<TR>
			<TD height=33 colspan='2' align=left vAlign=center><STRONG>七、监事意见（签名由本人手签）</STRONG></TD>
		</TR>
		<TR>
			<TD height=14 colspan='2' align=left vAlign=center>&nbsp;</TD>
		</TR>
		<TR>
			<TD height=33 colspan='2' align=left vAlign=center
				class='font12size1'>
			<TABLE cellSpacing=0 cellPadding=0 width=644 align=center border=0>
				<TBODY>
					<TR>
						<TD vAlign=top align=left>监事<input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$jianshixuhao$1'
							id='name1' MAXLENGTH='20' CLASS='unnamed3'
							SIZE='10' style='text-align:center' readonly> :</TD>
					</TR>
					<TR>
						<TD vAlign=top align=left>意见： <textarea
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$yijian$1'
							onKeyDown="textCounter(query$form$0$JJH_NJ_REPORT_IDEA_SUB$yijian$1,1500);"
							onKeyUp="textCounter(query$form$0$JJH_NJ_REPORT_IDEA_SUB$yijian$1,1500);"
							ID='opinion1' ROWS='18' COLS='80' limit='1500' CLASS='textarea03'
							readonly></textarea></TD>
					</TR>
					<TR>
						<TD vAlign=top align=left>签名：<input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$qianzi$1' value=''
							ID='子表1.签字$1' MAXLENGTH='40' size='35' CLASS='unnamed3' >
						</TD>
					</TR>
					<TR>
						<TD vAlign=top align=left>日期： <input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$nian$1' value=''
							ID='子表1.年$1' MAXLENGTH='4' CLASS='unnamed3' SIZE='4' >
						</STRONG>年<STRONG> <input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$yue$1' value=''
							ID='子表1.月$1' MAXLENGTH='4' CLASS='unnamed3' SIZE='2' >
						</STRONG>月<STRONG> <input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$ri$1' value=''
							ID='子表1.日$1' MAXLENGTH='4' CLASS='unnamed3' SIZE='2' >
						</STRONG>日</TD>
					</TR>
				</TBODY>
			</TABLE>
			<br>
			<table width='100%' border='0' cellpadding='0' cellspacing='0'>
				<tr>
					<td height='2' class='unnamed3'>&nbsp;</td>
				</tr>
			</table>
			<TABLE cellSpacing=0 cellPadding=0 width=644 align=center border=0>
				<TBODY>
					<TR>
						<TD vAlign=top align=left>监事<input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$jianshixuhao$2'
							value='' ID='name2' MAXLENGTH='20' CLASS='unnamed3'
							SIZE='10' style='text-align:center'readonly> :</TD>
					</TR>
					<TR>
						<TD vAlign=top align=left>意见： <textarea
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$yijian$2'
							onKeyDown="textCounter(query$form$0$JJH_NJ_REPORT_IDEA_SUB$yijian$2,1500);"
							onKeyUp="textCounter(query$form$0$JJH_NJ_REPORT_IDEA_SUB$yijian$2,1500);"
							ID='opinion2' ROWS='18' COLS='80' limit='1500' CLASS='textarea03'
							readonly></textarea></TD>
					</TR>
					<TR>
						<TD vAlign=top align=left>签名：<input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$qianzi$2' value=''
							ID='子表1.签字$2' MAXLENGTH='40' size='35' CLASS='unnamed3' >
						</TD>
					</TR>
					<TR>
						<TD vAlign=top align=left>日期： <input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$nian$2' value=''
							ID='子表1.年$2' MAXLENGTH='4' CLASS='unnamed3' SIZE='4' >
						年<STRONG> <input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$yue$2' value=''
							ID='子表1.月$2' MAXLENGTH='4' CLASS='unnamed3' SIZE='2' >
						</STRONG>月<STRONG> <input
							name='query$form$0$JJH_NJ_REPORT_IDEA_SUB$ri$2' value=''
							ID='子表2.日$2' MAXLENGTH='4' CLASS='unnamed3' SIZE='2' >
						</STRONG>日</TD>
					</TR>
				</TBODY>
			</TABLE>
			<br>
			</TD>
		</TR>
		<TR>
			<TD height=14 colspan='2' vAlign=top>&nbsp;</TD>
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
</form>
</div>
</div>
</body>
</html>
