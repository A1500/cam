<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
			
		 	//初始化
	function init(){
		somJxCheckPartyDataSet.setParameter("TASK_CODE", taskCode);
		somJxCheckPartyDataSet.load();
		somJxCheckPartyDataSet.on('load',function (){
			if(somJxCheckPartyDataSet.getCount() == 0){
				somJxCheckPartyDataSet.newRecord();
			}else{
			
			}
		});
		//创建页面导航下拉框
		createFundEditSelect();
		
	}
	function save(){
		var somJxCheckPartyRecord=somJxCheckPartyDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
		command.setParameter("taskCode",taskCode);
		command.setParameter("somJxCheckPartyRecord",somJxCheckPartyRecord);
		command.execute("savePage6");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
			});		
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}	
	}			
	function changeType(num){
		if(num == '8'){
			document.getElementById('other').style.display='block';
		}else{
			document.getElementById('other').style.display='none';
		}
	}
	function changeParty(yesorno){
		if(yesorno=='0'){
			document.getElementById('noPartyReason').style.display='block';
			document.getElementById('PartyReason').style.display='none';
		}else if(yesorno=='1'){
			document.getElementById('PartyReason').style.display='block';
			document.getElementById('noPartyReason').style.display='none';
		}else{
			document.getElementById('PartyReason').style.display='none';
			document.getElementById('noPartyReason').style.display='none';
		}
	}
	</script>
<style>
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckPartyDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckparty.cmd.SomJxCheckPartyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckParty"></model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 党建形式 -->
	<model:dataset id="partyBuildTypeDataset" enumName="SORG.PARTY.BUILDTYPE.CODE" global="true" 
	autoLoad="true">
	</model:dataset>
	<!-- 党组织（党建联络员）隶属关系 -->
	<model:dataset id="partyRelationDataset" enumName="SORG.PARTY.RELATION.CODE" global="true" 
	autoLoad="true">
	</model:dataset>
	<!-- 党组织负责人（党建联络员） -->
	<model:dataset id="partyResponsibleDataset" enumName="SORG.PARTY.RESPONSIBLE.CODE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 未建党组织 -->
	<model:dataset id="noPartyReasonDataset" enumName="SORG.PARTY.NOREASON.CODE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('7')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('5')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>

</div>
<STYLE>
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
<form method="post"onsubmit="return false" dataset="somJxCheckPartyDataSet">	
<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=51><STRONG class=word-st-14>（五）党组织建设情况
			</STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE class=f14pt-boder1 cellSpacing=0 cellPadding=0 width=800
	align=center border=0>
	<TBODY>
		<TR>
			<TD class=f14pt-boder2 align=middle width=94 rowSpan=3><STRONG
				class=word-st-14>党员情况</STRONG></TD>
			<TD class=f14pt-boder2 align=middle height=70>党员数</TD>
			<TD class=f14pt-boder3><input field="partyMemberTotal"
				name='query$form$0$JJHNJ_JGJSDJTAB$dangyuanshu' value='' ID='党员数'
				 SIZE='8' MAXLENGTH='6' ></TD>
		</TR>
		<TR>
			<TD class=f14pt-boder2 align=middle height=70>党员组织关系<BR>
			在本基金会的人数</TD>
			<TD class=f14pt-boder3><input field="insideMemberNum"
				name='query$form$0$JJHNJ_JGJSDJTAB$benjijinhuirenshu' value=''
				ID='本基金会人数'  SIZE='8' MAXLENGTH='6'>
			</TD>
		</TR>
		<TR>
			<TD class=f14pt-boder2 align=middle width=176 height=70>党员中专职工作人员数</TD>
			<TD class=f14pt-boder3 width=373><input field="fullTimeNum"
				name='query$form$0$JJHNJ_JGJSDJTAB$zhongzhuanzhigongzuorenyuanshu'
				value='' ID='中专职工作人员数'  SIZE='8' MAXLENGTH='6'
				></TD>
		</TR>
		<TR>
			<TD class=f14pt-boder4 align=middle width=94 rowSpan=2><STRONG
				class=word-st-14>党组织<BR>
			建设情况</STRONG></TD>
			<TD class=f14pt-boder4 align=middle width=176 rowSpan=2>是否建立党组织<br>
			<select field="ifBuildParty" onchange="changeParty(this.value);"><option dataset="YorNDataset"></option></select>
			</TD>
			<TD class=f14pt-boder3>
			<TABLE cellSpacing=0 cellPadding=0 width='95%' align=center border=0>
				<TBODY>
					<TR>
						<TD class=word-st-14 height=39>
					<div id="PartyReason" style="display:none">
						<P>已建立党组织类型：
						<select field="partyType" onchange="changeType(this.value);"><option dataset="partyBuildTypeDataset"></option></select>
						<br><br><div id="other" style="display:none">
								其他类型：<input field="partyTypeOther" name='query$form$0$JJHNJ_JGJSDJTAB$qitadangzuleixing'
							 ID='其他党组类型' MAXLENGTH='100'  SIZE='20'
							></div>
							</div>
						</TD>
					</TR>
					<TR>
						<TD class=word-st-14 height=60>
						<P>
						</P>
						</TD>
						
					</TR>
					<TR>
						<TD class=word-st-14 height=15></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top width=373>
			<TABLE cellSpacing=0 cellPadding=0 width='95%' align=center border=0>
				<TBODY>
					<TR>
						<TD class=word-st-14 height=70>
						<div id="noPartyReason" style="display:none">
						<P>未建立党组织原因：
						<select field="reason"><option dataset="noPartyReasonDataset"></option></select>
						</div>
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
		第6页</td>
	</tr>
</TABLE>
</form>
</body>
</html>
