<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init24(){
	var somJxOverseeDataSet = L5.DatasetMgr.lookup("somJxOverseeDataSet");
	somJxOverseeDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxOverseeDataSet.load();
	somJxOverseeDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxOverseeDataSet.newRecord({"taskCode":taskCode});
			somCheckDataSet_24.setParameter("TASK_CODE@=", taskCode);
			somCheckDataSet_24.load();
			somCheckDataSet_24.on("load",function(ds){
				if(taskCode == 'null'){
					return;
				}
				var checkYear_24=ds.get("checkYear");
				for(i=1;i<=4;i++){
					document.getElementById("checkYear_24"+i).innerHTML=checkYear_24-i;
				}
				PROGRESS_BAR++;
			});			
			for(i=1;i<=ds.getCount();i++){
				document.getElementById("resultType"+i).value=ds.getAt(i-1).get("resultType");
			}
		}else{		
			somCheckDataSet_24.setParameter("TASK_CODE@=", taskCode);
			somCheckDataSet_24.load();
			somCheckDataSet_24.on("load",function(ds){
				var checkYear_24=ds.get("checkYear");
				for(i=1;i<=4;i++){
					document.getElementById("checkYear_24"+i).innerHTML=checkYear_24-i;
				}
				PROGRESS_BAR++;
			});			
			for(i=1;i<=ds.getCount();i++){
				document.getElementById("resultType"+i).value=ds.getAt(i-1).get("resultType");
			}
		}
		PROGRESS_BAR++;
	});
	var somJxCheckEvaluateDataSet = L5.DatasetMgr.lookup("somJxCheckEvaluateDataSet");
	somJxCheckEvaluateDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckEvaluateDataSet.load();
	somJxCheckEvaluateDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckEvaluateDataSet.newRecord({"taskCode":taskCode});
		}else{
			var favorableType=ds.get("favorableType");
			if(favorableType!="" && favorableType.indexOf(",")>-1){
				document.getElementById("favorableType1").checked=true;
				document.getElementById("favorableType2").checked=true;
			}else if(favorableType!=""){
				document.getElementById("favorableType"+favorableType).checked=true;
			}
			var noLevel=ds.get("noLevel");
			if( noLevel == '1'){
				document.getElementById("noLevel").checked=true;
			}
		}
		PROGRESS_BAR++;
	});
	//行政处罚情况
	var somJxCheckPunnishDataSet = L5.DatasetMgr.lookup("somJxCheckPunnishDataSet");
	somJxCheckPunnishDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckPunnishDataSet.load();
	somJxCheckPunnishDataSet.on('load',function(ds){
		if(ds.getCount()!=0){
			for(i=1;i<=ds.getCount();i++){
				document.getElementById("punnishType"+i).innerHTML=ds.getAt(i-1).get("punnishType");
				document.getElementById("punnishOrgan"+i).innerHTML=ds.getAt(i-1).get("punnishOrgan");
				document.getElementById("punnishDate"+i).innerHTML=ds.getAt(i-1).get("punnishDate");
				document.getElementById("unlawfulactDesc"+i).innerHTML=ds.getAt(i-1).get("unlawfulactDesc");
			}
		}
		PROGRESS_BAR++;
	});	
	//创建页面导航下拉框
	//createFundDetailSelect();
}
function save(){
	somJxOverseeDataSet.removeAll();
	for(i=1;i<=4;i++){
		var jxOverseeRecord= somJxOverseeDataSet.newRecord();
		jxOverseeRecord.set("taskCode",taskCode);
		jxOverseeRecord.set("checkYear",document.getElementById("checkYear_24"+i).innerHTML);
		jxOverseeRecord.set("resultType",document.getElementById("resultType"+i).value);
	}
	var jxOverseeRecords=somJxOverseeDataSet.getAllRecords();
	var jxCheckEvaluateRecord=somJxCheckEvaluateDataSet.getCurrent();
	var somJxCheckPunnishDataSet = getSomJxCheckPunnishDataSetDataSet();
	var jxCheckPunnishRecords = somJxCheckPunnishDataSet.getAllRecords();
	var favorableType=getFavorableType();
	jxCheckEvaluateRecord.set("favorableType",favorableType);
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("jxOverseeRecords", jxOverseeRecords);
	command.setParameter("jxCheckEvaluateRecord", jxCheckEvaluateRecord);
	command.setParameter("jxCheckPunnishRecords", jxCheckPunnishRecords);
	command.execute("savePageJ24");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function getSomJxCheckPunnishDataSetDataSet(){
	var somJxCheckPunnishDataSet = L5.DatasetMgr.lookup("somJxCheckPunnishDataSet");
	somJxCheckPunnishDataSet.removeAll();
	for(i=1;i<=3;i++){
		var somJxCheckPunnishRecord= somJxCheckPunnishDataSet.newRecord();
		somJxCheckPunnishRecord.set("punnishType",document.getElementById("punnishType"+i).innerHTML);
		somJxCheckPunnishRecord.set("punnishOrgan",document.getElementById("punnishOrgan"+i).innerHTML);
		somJxCheckPunnishRecord.set("punnishDate",document.getElementById("punnishDate"+i).innerHTML);
		somJxCheckPunnishRecord.set("unlawfulactDesc",document.getElementById("unlawfulactDesc"+i).innerHTML);
	}
	return somJxCheckPunnishDataSet;
}
function getFavorableType(){
	var favorableType1 = document.getElementById("favorableType1");
	var favorableType2 = document.getElementById("favorableType2");
	var favorableType="";
	if(favorableType1.checked&&favorableType2.checked){
		favorableType=favorableType1.innerHTML+","+favorableType2.innerHTML;		
	}else if(favorableType1.checked){
		favorableType=favorableType1.innerHTML;
	}else if(favorableType2.checked){
		favorableType=favorableType2.innerHTML;
	}
	return favorableType;
}
</script>
<style media="print">
	.noprint     { display: none }
</style>
<script>
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
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

#table1 td {
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
	<model:dataset id="somJxOverseeDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxoversee.cmd.SomJxOverseeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxoversee.dao.SomJxOversee">
		</model:record>
	</model:dataset>		
	<model:dataset id="somJxCheckEvaluateDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.cmd.SomJxCheckEvaluateQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckevaluate.dao.SomJxCheckEvaluate">
		</model:record>
	</model:dataset>		
	<model:dataset id="somJxCheckPunnishDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.cmd.SomJxCheckPunnishQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckpunnish.dao.SomJxCheckPunnish">
		</model:record>
	</model:dataset>	
	<model:dataset id="somCheckDataSet_24" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 年检结论 -->
	<model:dataset id="resultTypeSelect" enumName="JXSOM.CHECK.RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<div align=center style='page-break-after:always'>
<div align=center style="width: 700px">
<form dataset="somJxCheckEvaluateDataSet" name="myform" method="post" onsubmit="return false">

<TABLE cellSpacing=0 cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=38><STRONG class=word>五、接受监督管理的情况</STRONG></TD>
		</TR>
		<TR>
			<TD height=38 class=word-st-14><STRONG>年检情况： </STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE class='word-st-14 border-tl' id=table1 cellSpacing=0
	cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD align=middle width=0 height=36>年度</TD>
			<TD align=middle width=0><label id='checkYear_244' ></label>年</TD>
			<TD align=middle width=0><label id='checkYear_243' ></label>年</TD>
			<TD align=middle width=0><label id='checkYear_242' ></label>年</TD>
			<TD align=middle width=0><label id='checkYear_241' ></label>年</TD>
		</TR>
		<TR>
			<TD align=middle width=0 height=32>年检结论</TD>
			<TD align=middle width=0 height=32>
				<select id='resultType4' style='width:100%' disabled="disabled"><option dataset='resultTypeSelect'/></select>
			</TD>
			<TD align=middle width=0>
				<select id='resultType3' style='width:100%' disabled="disabled"><option dataset='resultTypeSelect'/></select>
			</TD>
			<TD align=middle width=0>
				<select id='resultType2' style='width:100%' disabled="disabled"><option dataset='resultTypeSelect'/></select>
			</TD>
			<TD align=middle width=0>
				<select id='resultType1' style='width:100%' disabled="disabled"><option dataset='resultTypeSelect'/></select>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE height=400 cellSpacing=0 cellPadding=0 width=645 align=center
	border=0>
	<TBODY>
		<TR>
		</TR>
		<TR>
			<TD class=word-st-14 height=40><STRONG>评估情况： </STRONG></TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>A、尚未参加评估<input type="checkbox" id="noLevel" value='1' disabled="disabled"/>
				
			</TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>B、本基金会通过社会组织评估，评估等级为 <label
				name='query$form$0$JJHNJ_JSHJDGLTAB$dengji' field='evalLevel' ID='等级'
				CLASS='input-01' style='border-bottom: solid 1px;width:80;font-size: 16.0pt; font-family: 仿宋'></label> ，有效期 自 <label
				name='query$form$0$JJHNJ_JSHJDGLTAB$youxiaoqikaishi' field='startDate'
				ID='有效期开始' CLASS='input-01' 
				 style='text-align:center;border-bottom: solid 1px;width:50;font-size: 16.0pt; font-family: 仿宋'></label>
			年至 <label name='query$form$0$JJHNJ_JSHJDGLTAB$youxiaoqijieshu'
				field='endDate' ID='有效期结束' CLASS='input-01' 
				style='text-align:center;border-bottom: solid 1px;width:50;font-size: 16.0pt; font-family: 仿宋'></label>
			年。</TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40><STRONG>税收优惠资格取得情况： </STRONG></TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>本基金会是否取得过税收优惠资格 
				<label field='ifRevenueFavorable' style='text-align:center;border-bottom: solid 1px;width:50;font-size: 16.0pt; font-family: 仿宋' dataset='comm_haveorno'></label>
			</TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>取得的优惠资格的类型（可多选）： 
			<input id=favorableType1 type=checkbox value='1'CLASS='input-01' disabled="disabled">公益性捐赠税前扣除资格 
			<input id=favorableType2 type=checkbox value='2'CLASS='input-01' disabled="disabled">非营利组织免税资格</TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>取得以上两种税收优惠资格的时间及批准部门、批准文号： 
			<textarea name='query$form$0$JJHNJ_JSHJDGLTAB$shijianjipizhunbumen' readonly="readonly"
	ID='时间及批准部门' CLASS='input-01' ROWS='3' COLS='80' limit='256' field=favorableDateOrganDoc></textarea>
				</TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40><STRONG>行政处罚情况： </STRONG></TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>本基金会是否受到过行政处罚 
				<label field='ifPunnish' style='width:100' dataset='comm_haveorno' style='text-align:center;border-bottom: solid 1px;width:50;font-size: 16.0pt; font-family: 仿宋'></label>
			</TD>
		</TR>
		<TR>
			<TD class=word-st-14 height=40>如选“是”，请看下表：</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE class='word-st-14 border-tl' id=table1 cellSpacing=0
	cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD align=middle width=112 height=35>行政处罚的种类</TD>
			<TD align=middle width=193 height=35>行政处罚的实施机关</TD>
			<TD align=middle width=169 height=35>行政处罚时间</TD>
			<TD align=middle width=170 height=35>违法行为</TD>
		</TR>
		<TR>
			<TD align=middle width=112 height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufazhonglei$1' value=''
				ID='punnishType1' CLASS='input-01' SIZE='8'  style='width:98%'></label></TD>
			<TD align=middle width=193 height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufashishijiguan$1' value=''
				ID='punnishOrgan1' CLASS='input-01' SIZE='24'  style='width:98%'></label></TD>
			<TD align=middle width=169 height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufashijian$1' value=''
				ID='punnishDate1' CLASS='input-01' SIZE='24'  style='width:98%'
				style='text-align:center'
				></label></TD>
			<TD align=middle width=170 height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$weifaxingwei$1' value=''
				ID='unlawfulactDesc1' CLASS='input-01' SIZE='24'  style='width:98%'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufazhonglei$2' value=''
				ID='punnishType2' CLASS='input-01' SIZE='8' style='width:98%'></label></TD>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufashishijiguan$2' value=''
				ID='punnishOrgan2' CLASS='input-01' SIZE='24' style='width:98%'></label></TD>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufashijian$2' value=''
				ID='punnishDate2' CLASS='input-01' SIZE='24' style='width:98%'
				 style='text-align:center'
				></label></TD>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$weifaxingwei$2' value=''
				ID='unlawfulactDesc2' CLASS='input-01' SIZE='24' style='width:98%'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufazhonglei$3' value=''
				ID='punnishType3' CLASS='input-01' SIZE='8' style='width:98%'></label></TD>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufashishijiguan$3' value=''
				ID='punnishOrgan3' CLASS='input-01' SIZE='24' style='width:98%'></label></TD>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$chufashijian$3' value=''
				ID='punnishDate3' CLASS='input-01' SIZE='24' style='width:98%'
				style='text-align:center'
				></label></TD>
			<TD align=middle height=35><label
				name='query$form$0$JJHNJ_JSHJDGL_SUB$weifaxingwei$3' value=''
				ID='unlawfulactDesc3' CLASS='input-01' SIZE='24' style='width:98%'></label></TD>
		</TR>
	</TBODY>
</TABLE>
<br>
<br>
<TABLE class='word-st-14 border-tl' id=table1 cellSpacing=0
	cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD align=middle height=35>
			<DIV align=left><strong>整改情况：</strong></DIV>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=35>
			<DIV align=left>登记管理机关在年度检查工作中是否向本基金会发出改进建议书？<SPAN
				class=word-st-14> 
					<label field='ifCorrect' style='width:100' dataset='comm_haveorno' 
					style='text-align:center;border-bottom: solid 1px;width:50;font-size: 16.0pt; font-family: 仿宋'></label>
				</SPAN></DIV>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=35>
			<DIV align=left>如选“是”，以下为针对改进建议书中提出的问题都采取了哪些整改措施：</DIV>
			</TD>
		</TR>
		<TR>
			<TD class=word-st-14 align=middle height=35>
			<DIV align=left><label
				name='query$form$0$JJHNJ_JSHJDGLTAB$zhenggaicuoshi' field='correctDesc'
				ID='整改措施' CLASS='input-01' SIZE='80' ></label></DIV>
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
</form>
</div>
</div>
				