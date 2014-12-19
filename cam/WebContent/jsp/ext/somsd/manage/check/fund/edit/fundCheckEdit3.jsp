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
	somJxCouncilMeetingDataSet.setParameter("TASK_CODE",taskCode);
	somJxCouncilMeetingDataSet.setParameter("SEQ",'1');
	somJxCouncilMeetingDataSet.load();
	somJxCouncilMeetingDataSet.on('load',function(){
		if(somJxCouncilMeetingDataSet.getCount() == 0){
			somJxCouncilMeetingDataSet.newRecord({"taskCode":taskCode,"seq":'1'});
		}
	});
	
	somJxCouncilMeetingDataSet1.setParameter("TASK_CODE",taskCode);
	somJxCouncilMeetingDataSet1.setParameter("SEQ",'2');
	somJxCouncilMeetingDataSet1.load();
	somJxCouncilMeetingDataSet1.on('load',function(){
		if(somJxCouncilMeetingDataSet1.getCount() == 0){
			somJxCouncilMeetingDataSet1.newRecord({"taskCode":taskCode,"seq":'2'});
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var meetingYear=somJxCouncilMeetingDataSet.get("meetingYear");
	if(meetingYear==""){
		L5.Msg.alert("提示","请输入理事会召开情况，没有的填无！");
		return "break";
	}
	var somOrganIsValidate = somJxCouncilMeetingDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		return "break";
	}	
	var checkRecord=somJxCouncilMeetingDataSet.getCurrent();
	
	var somOrganIsValidate1 = somJxCouncilMeetingDataSet1.isValidate();
	if(somOrganIsValidate1 != true){
		L5.Msg.alert("提示",somOrganIsValidate1);
		return "break";
	}	
	var checkRecord1=somJxCouncilMeetingDataSet1.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("checkRecord", checkRecord);
	command.setParameter("checkRecord1", checkRecord1);
	command.execute("savePageJ3");
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
	<model:dataset id="somJxCouncilMeetingDataSet" cmd="com.inspur.cams.sorg.check.somcheckcouncilmeeting.cmd.SomCheckCouncilMeetingQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeeting">
			<model:field name="meetingYear" type="string" rule="require" />
			<model:field name="meetingMonth" type="string" rule="require" />
			<model:field name="meetingDay" type="string" rule="require" />
			<model:field name="meetingNumber" type="string" rule="require" />
			<model:field name="meetingTimes" type="string" rule="require" />
			<model:field name="meetingPlace" type="string" rule="require" />
			<model:field name="meetingTheme" type="string" rule="require|length{100}" />
			<model:field name="peopleList" type="string" rule="require|length{500}" />
			<model:field name="noPeopleList" type="string" rule="require|length{500}" />
			<model:field name="superList" type="string" rule="require|length{500}" />
			<model:field name="noSuperList" type="string" rule="require|length{500}" />
			<model:field name="meetingResult" type="string" rule="require|length{500}" />
			<model:field name="note" type="string" rule="require|length{500}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somJxCouncilMeetingDataSet1" cmd="com.inspur.cams.sorg.check.somcheckcouncilmeeting.cmd.SomCheckCouncilMeetingQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheckcouncilmeeting.dao.SomCheckCouncilMeeting">
			<model:field name="meetingYear" type="string" rule="require" />
			<model:field name="meetingMonth" type="string" rule="require" />
			<model:field name="meetingDay" type="string" rule="require" />
			<model:field name="meetingNumber" type="string" rule="require" />
			<model:field name="meetingTimes" type="string" rule="require" />
			<model:field name="meetingPlace" type="string" rule="require" />
			<model:field name="meetingTheme" type="string" rule="require|length{100}" />
			<model:field name="peopleList" type="string" rule="require|length{500}" />
			<model:field name="noPeopleList" type="string" rule="require|length{500}" />
			<model:field name="superList" type="string" rule="require|length{500}" />
			<model:field name="noSuperList" type="string" rule="require|length{500}" />
			<model:field name="meetingResult" type="string" rule="require|length{500}" />
			<model:field name="note" type="string" rule="require|length{500}" />
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
	<!-- 行业分类 -->
	<model:dataset id="businessTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('4')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('2')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>
</div>
<STYLE>
textarea{
	overflow:hidden;
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

<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD class=word height=56>二、机构建设情况</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=30><STRONG class=word-st-14>（一）理事会召开情况
			</STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<form method="post" onsubmit="return false" dataset="somJxCouncilMeetingDataSet">
<TABLE class=f14pt-boder1 cellSpacing=0 cellPadding=0 width=800
	align=center border=0>
	<TBODY>
		<TR>
			<TD class=f14pt-boder3 vAlign=top width=800>
			<TABLE height=245 cellSpacing=0 cellPadding=0 width='97%'
				align=center border=0>
				<TBODY>
					<TR>
						<TD height=24 colspan='2' class=word-st-14>1、本基金会于（ <input field='meetingYear'
							name='年份' value=''
							ID='子表1.年$1'  SIZE='4' MAXLENGTH='4' >
						）年（ <input field='meetingMonth' name='月份' value=''
							ID='子表1.月$1'  SIZE='2' MAXLENGTH='2' >
						）月（ <input field='meetingDay' name='日期' value=''
							ID='子表1.日$1'  SIZE='2' MAXLENGTH='2' >
						）日召开（ <input  field='meetingNumber' name='届数'
							value='' ID='子表1.届$1'  SIZE='3' MAXLENGTH='3'
							> ）届（ <input  field='meetingTimes'
							name='次数' value=''
							ID='子表1.次$1'  SIZE='3' MAXLENGTH='3' >
						）次理事会议</TD>
					</TR>
					<!--<TR><TD height=24 colspan='2' class=word-st-14>会议时间： &nbsp; </TD></TR>-->
					<TR>
						<TD height=24 colspan='2' class=word-st-14>会议地点： <input  field='meetingPlace'
							name='会议地点' value=''
							ID='子表1.会议地点$1'  SIZE='60' MAXLENGTH='100'
							></TD>
					</TR>
					<TR>
						<TD width='13%' height=24 valign='top' class=word-st-14>会议议题：
						</TD>
						<TD width='87%' class=word-st-14><textarea  field='meetingTheme'
							name='会议议题' ID='子表1.会议主题$1'  ROWS='4' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>出席理事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='peopleList'
							name='出席理事名单'
							  ROWS='3' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>未出席理事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='noPeopleList'
							name='未出席理事名单'
							 ROWS='3' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>出席监事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='superList'
							name='出席监事名单'
							 ROWS='2' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>未出席监事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='noSuperList'
							name='未出席监事名单'
							 ROWS='2' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD height=24 colspan='2' class=word-st-14>会议决议：</TD>
					</TR>
					<TR>
						<TD height=31 colspan='2' align=middle class=word-st-14><textarea  field='meetingResult'
							name='会议决议'ID='子表1.会议决议$1' ROWS='12' COLS='84'
							></textarea></TD>
					</TR>
					<TR>
						<TD height=14 colspan='2' class=word-st-14>备注：</TD>
					</TR>
					<TR>
						<TD height=31 colspan='2' align=middle class=word-st-14><textarea  field='note'
							name='备注'
							ID='子表1.备注$1' ROWS='3' COLS='84' 
							></textarea></TD>
					</TR>
					<TR>
						<TD height=13 colspan='2'>&nbsp;</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
</form>
<form method="post" onsubmit="return false" dataset="somJxCouncilMeetingDataSet1">
<TABLE class=f14pt-boder1 cellSpacing=0 cellPadding=0 width=800
	align=center border=0>
	<TBODY>
		<TR>
			<TD class=f14pt-boder3 vAlign=top width=800>
			<TABLE height=245 cellSpacing=0 cellPadding=0 width='97%'
				align=center border=0>
				<TBODY>
					<TR>
						<TD height=24 colspan='2' class=word-st-14>1、本基金会于（ <input field='meetingYear'
							name='年份' value=''
							   SIZE='4' MAXLENGTH='4' >
						）年（ <input field='meetingMonth'   value=''name='月份'
							   SIZE='2' MAXLENGTH='2' >
						）月（ <input field='meetingDay' value=''name='日期'
							  SIZE='2' MAXLENGTH='2' >
						）日召开（ <input  field='meetingNumber'  name='届数'
							value=''   SIZE='3' MAXLENGTH='3'
							> ）届（ <input  field='meetingTimes'name='次数'
							  value=''
							   SIZE='3' MAXLENGTH='3' >
						）次理事会议</TD>
					</TR>
					<!--<TR><TD height=24 colspan='2' class=word-st-14>会议时间： &nbsp; </TD></TR>-->
					<TR>
						<TD height=24 colspan='2' class=word-st-14>会议地点： <input  field='meetingPlace'
							  value=''  SIZE='60' MAXLENGTH='100'name='会议地点'
							></TD>
					</TR>
					<TR>
						<TD width='13%' height=24 valign='top' class=word-st-14>会议议题：
						</TD>
						<TD width='87%' class=word-st-14><textarea  field='meetingTheme'
							   ROWS='4' COLS='60' name='会议议题'
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>出席理事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='peopleList'
							name='出席理事名单'
							  ROWS='3' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>未出席理事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='noPeopleList'
							name='未出席理事名单'
							 ROWS='3' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>出席监事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='superList'
							name='出席监事名单'
							 ROWS='2' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD width='17%' height=24 valign='top' class=word-st-14>未出席监事名单：
						</TD>
						<TD width='83%' class=word-st-14><textarea  field='noSuperList'
							name='未出席监事名单'
							 ROWS='2' COLS='60' 
							></textarea></TD>
					</TR>
					<TR>
						<TD height=24 colspan='2' class=word-st-14>会议决议：</TD>
					</TR>
					<TR>
						<TD height=31 colspan='2' align=middle class=word-st-14><textarea  field='meetingResult'
							name='会议决议'ID='子表1.会议决议$1' ROWS='12' COLS='84'
							></textarea></TD>
					</TR>
					<TR>
						<TD height=14 colspan='2' class=word-st-14>备注：</TD>
					</TR>
					<TR>
						<TD height=31 colspan='2' align=middle class=word-st-14><textarea  field='note'
							name='备注'
							ID='子表1.备注$1' ROWS='3' COLS='84' 
							></textarea></TD>
					</TR>
					<TR>
						<TD height=13 colspan='2'>&nbsp;</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
</form>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第3页</td>
	</tr>
</TABLE>

</body>
</html>
