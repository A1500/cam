<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init2(){
	//somCheckDataSet.setParameter("TASK_CODE",taskCode);
	//somCheckDataSet.load();
	somJxPeopleDataSet.setParameter("TASK_CODE", taskCode);
				somJxPeopleDataSet.load();
				somJxPeopleDataSet.on('load',function (){
					somJxPeopleDataSet.each(function(record, index){
						document.getElementById("aboveCountyNum").innerHTML = record.get("aboveCountyNum");
						document.getElementById("npcNum").innerHTML = record.get("npcNum");
						document.getElementById("cppccNum").innerHTML = record.get("cppccNum");
						document.getElementById("partyNumNation").innerHTML = record.get("partyNumNation");
						document.getElementById("partyNumProvince").innerHTML = record.get("partyNumProvince");
						document.getElementById("npcNumNation").innerHTML = record.get("npcNumNation");
						document.getElementById("npcNumProvince").innerHTML = record.get("npcNumProvince");
						document.getElementById("cppccNumNation").innerHTML = record.get("cppccNumNation");
						document.getElementById("cppccNumProvince").innerHTML = record.get("cppccNumProvince");
					});
				});
	//创建页面导航下拉框
	//createFundDetailSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	if(checkRecord.get('cnName').trim() == ''){
		L5.Msg.alert("提示","基金会名称不能为空！");
		return "break";
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("checkRecord", checkRecord);
	command.execute("savePageJ1");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="somJxPeopleDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxpeople.cmd.SomJxPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeople">
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
<div id="float_1" class="noprint">

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
<div style='page-break-after:always'>
<form method="post" onsubmit="return false" dataset="somCheckDataSet">
<TABLE height=800 cellSpacing=0 cellPadding=0 width=700 align=center
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
			<TD vAlign=top height=700>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=700 border=0>
				<TBODY>
					<TR>
						<TD class=unnamed2 align=middle width=500 height=30>基金会名称</TD>
						<TD class=unnamed3 colSpan=5 height=30>&nbsp;<label field="cnName"></label></TD>
					</TR>
					<!-- <TR><TD class=unnamed2 align=middle width=177 height=30>基金会英文名称</TD><TD class=unnamed3 colSpan=3 height=30><FONT color=red>基金会年检基本信息表.英文名称</FONT></TD></TR><TR> -->
					<tr>
						<TD class=unnamed2 align=middle width=100 height=30>登记证号</TD>
						<TD height=30 colspan='2' class=unnamed2>
							&nbsp;<label field="sorgCode"></label>
						</TD>
						<TD class=unnamed2 align=middle width=122 height=30>组织机构代码</TD>
						<TD height=30 colspan='2' class=unnamed3>&nbsp;<label field="organCode"></label></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>宗旨</TD>
						<TD class=unnamed3 colSpan=5 height=30><textarea field='purpose' readonly="readonly"
							name='query$form$0$JJH_NJ_REPORT1$zongzhi' COLS='76' rows='4'
							CLASS='boder-0' ></textarea></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>业务范围</TD>
						<TD class=unnamed3 colSpan=5 height=30><textarea field='business' readonly="readonly"
							name='query$form$0$JJH_NJ_REPORT1$yewufanwei' COLS='76' rows='4'
							CLASS='boder-0' ></textarea></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>基金会类型</TD>
						<TD height=30 colspan='5' class=unnamed3>&nbsp;<label field='sorgKind' dataset="sorgKindSelect"></label></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>成立时间</TD>
						<TD height=30 colspan='2' class=unnamed2>&nbsp;<label field="buildDate"></label></TD>
						<TD class=unnamed2 align=middle height=30>原始基金数额</TD>
						<TD height=30 colspan='2' class=unnamed3>&nbsp;<label field="initialFund"></label>&nbsp;&nbsp;(人民币<span
							class='style1'>万</span>元)</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>业务主管单位</TD>
						<TD class=unnamed3 colSpan=5 height=30>&nbsp;<label field="borgName"></label></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>基金会住所</TD>
						<TD class=unnamed3 colSpan=5 height=30>&nbsp;<label field="residence"></label></TD>
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
									<TD align=left>&nbsp;<label field="secretaryName"></label> <BR>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD height=30 class=unnamed2>&nbsp;<label field="secretaryPhone"></label>
						</TD>
						<TD height=30 class=unnamed2>&nbsp;<label field="secretaryMobile"></label></TD>
						<TD class=unnamed2 align=middle height=0>&nbsp;<label field='linkmanName'></label>
						</TD>
						<TD height=30 class=unnamed2>&nbsp;<label field="linkmanPhone"></label>
						</TD>
						<TD height=30 class=unnamed3>&nbsp;<label field="linkmanMobile"></label>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>电子邮箱</TD>
						<TD height=30 colspan='2' class=unnamed2>&nbsp;<label field="sorgEmail"></label></TD>
						<TD class=unnamed2 align=middle height=30>传真</TD>
						<TD height=30 colspan='2' class=unnamed3>&nbsp;<label field="sorgFax"></label></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>及时通讯工具联系方式（QQ号码等）</TD>
						<TD height=30 colspan='2' class=unnamed2>&nbsp;<label field="sorgWebName"></label>
						</TD>
						<TD class=unnamed2 align=middle height=30>网址</TD>
						<TD height=30 colspan='2' class=unnamed3>&nbsp;<label field="sorgWeb"></label></TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>理事长</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD>&nbsp;<label field="presidentName"></label></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>邮政编码</TD>
						<TD height=30 colspan='2' class=unnamed3>&nbsp;<label field="sorgPost"></label></TD>
					</TR>
					<!-------->
					<TR>
						<TD class=unnamed2 align=middle height=30>理事数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD>&nbsp;<label field="syndicNum"></label>
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
									<TD>&nbsp;<label field="auditorNum"></label></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 align=middle height=30>负责人数（理事长、副理事长、秘书长）</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=100% cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD class=unnamed4 width='55%'>&nbsp;<label field="principalNum"></label></TD>
									<TD align=middle width='45%'  height=30 >
									<div align='center'>负责人中现任国家工作人员数</div>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>&nbsp;<label field="principalGovNum"></label></TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=100% cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='70%' height='31' align=middle class=unnamed4>负责人中担任过省部级及以上领导职务的人数</TD>
									<TD align=middle>&nbsp;<label field="principalProvinceNum"></label></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>

					<TR>
						<TD class=unnamed2 align=middle height=30>从业人员中担任党代表人数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD class=unnamed4 width='55%'>
										<label id="aboveCountyNum"></label>
									</TD>
									<TD align=middle width='45%'>
									<div align='center'>省级及以下<br>
									党代表人数</div>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>
							<label id="partyNumProvince"></label>
						</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='70%' height='31' align=middle class=unnamed4>全国性的党代表人数</TD>
									<TD align=middle>
										<label id="partyNumNation"></label>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>

					<TR>
						<TD class=unnamed2 align=middle height=30>从业人员中担任人大代表人数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD class=unnamed4 width='55%'>
										<label id="npcNum"></label></TD>
									<TD align=middle width='45%'>
									<div align='center'>省级及以下<br>
									人大代表人数</div>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>
							<label id="npcNumProvince"></label>
						</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='70%' height='31' align=middle class=unnamed4>全国性的人大代表人数</TD>
									<TD align=middle>
										<label id="npcNumNation"></label>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>

					<TR>
						<TD class=unnamed2 align=middle height=30>从业人员中担任政协委员人数</TD>
						<TD height=30 colspan='2' class=unnamed2>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD class=unnamed4 width='55%'>
										<label id="cppccNum"></label>
									</TD>
									<TD align=middle width='45%'>
									<div align='center'>省级及以下<br>
									政协委员人数</div>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>
							<label id="cppccNumProvince"></label>
						</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=40 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='70%' height='31' align=middle class=unnamed4>全国性的政协委员人数</TD>
									<TD align=middle>
									<label id="cppccNumNation"></label>
									</TD>
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
									<TD>&nbsp;<label field="ramusNum"></label></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>代表机构数</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left>&nbsp;<label field="delegateNum"></label></TD>
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
									<TD>&nbsp;<label field="specialFunds"></label>元</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>专职工作人员数</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left>&nbsp;<label field="fulltimeNum"></label>
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
									<TD>&nbsp;<label field="postulandNum"></label></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
						<TD class=unnamed2 align=middle height=30>举办刊物情况</TD>
						<TD height=30 colspan='2' class=unnamed3>
						<TABLE height=30 cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD align=left>&nbsp;<label field="publication"></label><BR>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD width='110' height=30 align=middle class=unnamed4>税务登记证号码</TD>
						<TD colSpan=5 height=30>&nbsp;<label field="taxCode"></label></TD>
					</TR>
			</TABLE>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center></td>
		</tr>
</TABLE>
</form>
</div>