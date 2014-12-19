<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//初始化
function init19(){
	var somJxCheckMajorDataSet = L5.DatasetMgr.lookup("somJxCheckMajorDataSet");
	somJxCheckMajorDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckMajorDataSet.load();
	somJxCheckMajorDataSet.on('load',function(ds){
		if(ds.getCount()==0){
			return;
		}
		if(ds.getCount()!=0){
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				var tab1 = document.getElementById("table1_19");
				tab1.rows[i+1].cells[0].getElementsByTagName("label")[0].innerHTML=record.get("projectName");
				tab1.rows[i+1].cells[1].getElementsByTagName("textarea")[0].value=record.get("zahlungsziel");
				tab1.rows[i+1].cells[2].getElementsByTagName("label")[0].innerHTML=record.get("expenditureCash");
				tab1.rows[i+1].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("ratio");
				tab1.rows[i+1].cells[4].getElementsByTagName("textarea")[0].value=record.get("purpose");
			}
		}
		setSum_19();
		PROGRESS_BAR++;
	});

	//创建页面导航下拉框
	//createFundDetailSelect();
}
function save(){
	somJxCheckMajorDataSet.removeAll();
	var tab1 = document.getElementById("table1_19");
	for(i=1;i<=20;i++){
		var record = somJxCheckMajorDataSet.newRecord();
		record.set("projectName",tab1.rows[i].cells[0].getElementsByTagName("input")[0].value);
		record.set("zahlungsziel",tab1.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("expenditureCash",tab1.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("ratio",tab1.rows[i].cells[3].getElementsByTagName("input")[0].value);
		record.set("purpose",tab1.rows[i].cells[4].getElementsByTagName("textarea")[0].value);
	}
	var somJxCheckMajorRecords = somJxCheckMajorDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("somJxCheckMajorRecords", somJxCheckMajorRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ19");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	for(var i=1;i<=20;i++){
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMDEZHFDX$zhifujine")[0].innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMDEZHFDX$zhifujine","query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$"+i);
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMDEZHFDX$bili")[0].innerHTML
		=setParseFloat1("query$form$0$JJHNJ_ZHDGYXMDEZHFDX$bili","query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$"+i);
	}
}
function setParseFloat(id1,id2){
	var value1 = document.getElementsByName(id1)[0].innerHTML;
	var value2 = document.getElementsByName(id2)[0].innerHTML;
	if(!value1){
		value1 = 0;
	}else{
		value1 = parseFloat(value1);
	}
	if(!value2){
		value2 = 0;
	}else{
		value2 = parseFloat(value2);
	}
	return (value1+value2);
}

function setParseFloat1(id1,id2){
	var value1 = document.getElementsByName(id1)[0].innerHTML;
	var value2 = document.getElementsByName(id2)[0].innerHTML;
	if(!value1){
		value1 = 0;
	}else{
		value1 = parseFloat(value1);
	}
	if(!value2){
		value2 = 0;
	}else{
		value2 = parseFloat(value2);
	}
	return (value1+value2).toFixed(5);
}
</script>
<script>
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
}
function setSum_19(){

  //列的求和。
  var preName = "query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$";
    var preName1 = "query$form$0$JJHNJ_ZHDGYXMDEZHFDX$";

    var totalsum1 = 0;
    var bilisum =0;
    for(i=1;i<=20;i++){
       var obj =  document.getElementById(preName + "zhifujine" +"$" +i);
       var obj1 =  document.getElementById(preName + "bili" +"$" +i);
         if(obj.innerHTML != ""){
            totalsum1 += parseFloat(obj.innerHTML);
         }
         if(obj1.innerHTML != ""){
            bilisum += parseFloat(obj1.innerHTML);
         }
      }
    document.getElementById(preName1 + "zhifujine" ).innerHTML = (Math.round(totalsum1*1000000))/1000000 ;
    document.getElementById(preName1 + "bili" ).innerHTML =    (Math.round(bilisum*1000000))/1000000;
}
</script>
<STYLE>
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.margin-0 {
	margin: 0px;
}

.word-zhx {
	text-decoration: line-through;
}

.word {
	font-family: '黑体', '宋体';
	font-size: 20px;
}

.word-1 {
	font-family: '黑体', '宋体';
	font-size: 32px;
}

.word-2 {
	font-family: '黑体', '宋体';
	font-size: 26px;
}

.word-fs-bt {
	font-size: 24px;
	font-family: '楷体_GB2312', '宋体', '黑体';
	font-weight: bold;
}

.word-fs {
	font-size: 16px;
	font-family: '楷体_GB2312', '宋体', '黑体';
}

.word-fs-14 {
	font-size: 15px;
	font-family: '楷体_GB2312', '宋体', '黑体';
}

.word-fs-13 {
	font-size: 14px;
	font-family: '宋体', '黑体';
}

.word-st-14 {
	font-size: 14px;
	font-family: '宋体';
}

.word-st-12 {
	font-size: 12px;
	font-family: '宋体';
}

.pad-t-b-7 {
	padding-top: 7px;
	padding-bottom: 7px;
}

.pad-t-25 {
	padding-top: 25px;
}

.pad-t-30 {
	padding-top: 10px;
}

.pad-t-10 {
	padding-top: 10px;
}

.pad-l-15 {
	padding-left: 15px;
}

.pad-r-100 {
	padding-right: 100px;
}

.pad-b {
	padding-bottom: 10px;
}

.pad-l-10 {
	padding-left: 10px;
}

.div-b-line {
	border-bottom: 1px solid #000;
}

.input-b-trl {
	border-top: 0px;
	border-left: 0px;
	border-right: 0px;
}

.border-lrb {
	border: 1px solid #000;
	border-top: 0px;
}

.border-r {
	border-right: 1px solid #000;
}

.border-q {
	border: 1px solid #000;
}

.border-tl {
	border-top: 1px solid #000;
	border-left: 1px solid #000;
}

.backcolor {
	background-color: #000;
}

.input-d {
	width: 90%;
	height: 35px;
	line-height: 23px;
	border: 0px;
	overflow: hidden;
}

.input-x {
	border: 0px;
	width: 96%;
	text-align: center
}

.input-t {
	border: 0px;
	width: 96%;
	text-align: left;
}

.input-c-b {
	border: 0px;
	text-align: center;
}

#table1_19 td {
	border-right: 1px solid #000;
	border-bottom: 1px solid #000
}

.input-01 {
	font-family: '宋体';
	font-size: 14px;
	color: #000000;
}

.input-02 {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
}  /*14号字体 表格样式*/
.f14pt-boder1 { /*整体边框*/
	border: 1px solid #000000;
	font-size: 14px;
}

.f14pt-boder2 { /*右底边框*/
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f14pt-boder3 { /*底边框*/
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f14pt-boder4 { /*右边框*/
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}
</STYLE>
<model:datasets>
	<model:dataset id="somJxCheckMajorDataSet"
		cmd="com.inspur.cams.sorg.jxcheck.somjxcheckmajor.cmd.SomJxCheckMajorQueryCommand"
		global="true" method="queryNoPage">
		<model:record
			fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckmajor.dao.SomJxCheckMajor"></model:record>
	</model:dataset>
</model:datasets>
<div id="float_1"class="noprint">

</div>
<div align=center style='page-break-after:always'>
<div align=center style="width: 700px">
<form dataset="" name="myform" method="post" onsubmit="return false">
<TABLE cellSpacing=0 cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=51><STRONG class=word-st-14>（七）重大公益项目大额支付对象</STRONG></TD>
		</TR>
	</TBODY>
</TABLE>

<TABLE class='word-st-14 border-tl' id=table1_19 cellSpacing=0
	cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD align=middle width=203 height=36>项目名称</TD>
			<TD align=middle width=94>大额支付对象</TD>
			<TD align=middle width=111>支付金额（<span style="color:red">元</span>）</TD>
			<TD align=middle width=76>占年度公益总支出比例</TD>
			<TD align=middle width=160>用途</TD>
		</TR>
		<TR>
			<TD align=left width=203 height=32>1、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$1'
				value='' CLASS='input-01'></TD>
			<TD align=middle width=94 height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$1'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$1,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$1,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle width=111>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$1' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle width=76>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$1' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle width=160><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$1'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$1,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$1,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>2、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$2'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$2'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$2,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$2,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$2' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$2' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$2'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$2,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$2,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>3、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$3'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$3'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$3,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$3,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$3' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$3' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$3'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$3,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$3,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>4、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$4'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$4'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$4,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$4,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$4' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$4' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$4'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$4,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$4,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>5、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$5'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$5'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$5,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$5,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$5' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$5' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$5'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$5,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$5,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>6、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$6'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$6'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$6,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$6,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$6' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$6' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$6'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$6,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$6,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>7、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$7'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$7'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$7,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$7,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$7' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$7' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$7'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$7,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$7,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>8、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$8'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$8'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$8,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$8,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$8' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$8' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$8'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$8,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$8,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>9、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$9'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$9'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$9,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$9,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$9' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$9' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$9'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$9,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$9,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>10、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$10'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$10'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$10,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$10,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$10' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$10' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$10'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$10,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$10,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<tr>
			<TD align=left width=203 height=32>11、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$11'
				value='' CLASS='input-01'></TD>
			<TD align=middle width=94 height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$11'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$11,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$11,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle width=111>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$11' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle width=76>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$11' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle width=160><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$11'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$11,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$11,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>12、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$12'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$12'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$12,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$12,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$12' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$12' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$12'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$12,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$12,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>13、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$13'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$13'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$13,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$13,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$13' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$13' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$13'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$13,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$13,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>14、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$14'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$14'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$14,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$14,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$14' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$14' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$14'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$14,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$14,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>15、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$15'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$15'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$15,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$15,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$15' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$15' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$15'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$15,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$15,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>16、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$16'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$16'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$16,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$16,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$16' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$16' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$16'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$16,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$16,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>17、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$17'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$17'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$17,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$17,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$17' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$17' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$17'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$17,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$17,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>18、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$18'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$18'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$18,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$18,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$18' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$18' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$18'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$18,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$18,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>19、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$19'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$19'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$19,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$19,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$19' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$19' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$19'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$19,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$19,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</TR>
		<TR>
			<TD align=left height=32>20、<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$xiangmumingcheng$20'
				value='' CLASS='input-01'></TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$20'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$20,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$daezhifuduixiang$20,46);"
				CLASS='input-01' ROWS='2' COLS='18' limit='46' readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$zhifujine$20' value=''
				CLASS='input-01' SIZE='12' MAXLENGTH='15' onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum_19();" style='text-align:right'>
			</TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$bili$20' value=''
				CLASS='input-01' SIZE='5' MAXLENGTH='5' onKeyUp="value=value.replace(/[^\d.]/g,'');setSum_19();" style='text-align:center'></label>
			%</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$20'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$20,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX_SUB$yongtu$20,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' readonly></textarea></TD>
		</tr>
		<TR>
			<TD align=middle height=32>合 计</TD>
			<TD align=middle height=32><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX$daezhifuduixiang'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX$daezhifuduixiang,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX$daezhifuduixiang,46);"
				CLASS='input-01' ROWS='2' COLS='15' limit='46' style='text-align:right' readonly readonly></textarea></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX$zhifujine' value=''
				CLASS='input-01' SIZE='14' style='text-align:right' readonly></TD>
			<TD align=middle>&nbsp;<label
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX$bili' value='' ID='子表.比例'
				CLASS='input-01' SIZE='5' MAXLENGTH='5'style='text-align:center' readonly></label> %</TD>
			<TD align=middle><textarea
				id='query$form$0$JJHNJ_ZHDGYXMDEZHFDX$yongtu'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX$yongtu,46);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYXMDEZHFDX$yongtu,46);"
				CLASS='input-01' ROWS='2' COLS='22' limit='46' style='text-align:right' readonly readonly></textarea></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=645 align=center border=0>
	<tr align='left'>
		<td class='word-st-14'>说明：<BR>
		基金会向某交易方支付金额占一个重大公益项目支出5%以上的，该交易方为该项目的大额支付对象。</td>
	</tr>
</table>
<TABLE align='center'>
	<tr align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		</td>
	</tr>
</TABLE>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
