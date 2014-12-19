<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
	String method=(String)request.getParameter("method");
%>
<next:ScriptManager/>
		<script type="text/javascript" src="../../js/float.js"></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
		 	var method='<%=method%>';
		 	//初始化
			function init(){
					somCheckDataSet.setParameter("TASK_CODE", taskCode);
					somCheckDataSet.load();
					somCheckDataSet.on("load",function(ds){
						changeYear();
					});
				init3();
				init4();
				init5();
				init6();
				init7();
				//init8();
				//init9();
				//init10();
				//init11();
				init12();
				init13();
				init14();
				init15();
				//创建页面导航下拉框
				//createFundDetailSelect();
			}
			function changeYear(){
				var year = document.getElementById('year').innerHTML;
				document.getElementById('checkYear').innerHTML=year;
			}
function returnList(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/jxcheck/fund/query/somFundJXCheckQueryList.jsp';
	var text = '年检查询';
	L5.forward(url,text,data);
}
		</script>
<style media="print">
	.noprint     { display: none }
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div style='page-break-after:always'>
<div id="float" class="noprint">
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="returnList();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="docPrint();"/>
	<input type="button" value="操作说明" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="operDesc()"/>
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
	font-size: 13px;
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
	font-size: 20px;
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
	font-size: 20px;
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}
</STYLE>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<TABLE height=677 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=597>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=668 align=center
				border=0>
				<TBODY>
					<TR>
						<TD width='668' height=34 align=middle class=title1><STRONG><label class=title1 id='checkYear'></label>年度工作报告
						</STRONG></TD>
					</TR>
					<TR>
						<TD class=title1 vAlign=top align=middle height=150>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15></TD>
								</TR>
							</TBODY>
						</TABLE>
						<DIV align=center></DIV>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD class=text2 height=80><STRONG>本基金会按照《基金会管理条例》及相关规定，编制
									<STRONG><STRONG><label ID='year' field="checkYear" CLASS='unnamed3'></label>
									</STRONG></STRONG>年度工作报告。本基金会理事会及理事、监事保证本年度工作报告的内容真实、准确和完整，并为此承担责任。</STRONG></TD>
								</TR>
								<TR>
									<TD height=62>
									<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
										<TBODY>
											<TR>
												<TD width='43%' height=24>&nbsp;</TD>
												<TD width='57%'><STRONG>法定代表人签字(手签)： </STRONG></TD>
											</TR>
											<TR>
												<TD height=19>&nbsp;</TD>
												<TD><br>
												<STRONG>基金会印章：</STRONG></TD>
											</TR>
											<TR>
												<TD height=25>&nbsp;</TD>
												<TD><STRONG>提交报告日期：&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日</STRONG></TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
								<TR>
									<TD height=14><span style="color:red">（说明:法定代表人签字必须由本人手签，不接受签名章、电子签章等其他非手签格式）</span></TD>
								</TR>
								<TR>
									<TD height=30><STRONG>目录</STRONG></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=13>一、基本信息</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=13></TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=bottom height=20>二、机构建设情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（一）理事会召开情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（二）理事会成员情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（三）监事情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（四）工作人员情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（五）党组织建设情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（六）分支机构、代表机构、专项基金、办事机构、经营性实体基本情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=13>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>三、业务活动情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（一）接受捐赠情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（二）募捐情况（公募基金会填写）</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（三）公益支出情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（四）大额捐赠收入情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（五）本年度业务活动情况报告</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（六）重大公益项目收支明细表</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（七）重大公益项目大额支付对象</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>四、财务会计报告</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>1.资产负债表</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>2.业务活动表</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>3.现金流量表</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>五、接受监督、管理的情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>六、审计意见</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>七、监事意见</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>八、信息公开情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>九、其他信息</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（一）年度登记、备案事项办理情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（二）内部制度建设</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（三）涉外活动情况</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>&nbsp;</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>十、年检审查意见</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（一）业务主管单位初审意见</TD>
					</TR>
					<TR vAlign=top>
						<TD vAlign=top height=14>（二）登记管理机关年检结论</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center></td>
		</tr>
	</TBODY>
</TABLE>
</form>
</div>
<next:Window id="winOperDesc" closeAction="hide" title="操作说明" width="800"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeOperDesc"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<div>
	<span style="font-size:14px;color:red">
				操作说明：<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请先点击左上方的“文件”，出现一个下拉菜单，点击下拉菜单中的“页面设置”项（从上数第六个，IE浏览器的“页面设置”），弹出一个“页面设置”的对话框。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.请设置纸张大小为“A4”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.删除掉“页眉“中的字符“&w&b页码，&p/&P”和“页脚“中的字符“&u&b&d”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.把方向设置为”纵向”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.把页边距的“上”、“下”、“左”、“右”都设置为“10”；<br>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点击确定按钮，对话框关闭。请单击“打印”按钮进行打印。 <br>
	</span>
	</div>
	</next:Html>
</next:Window>

<jsp:include page="fundJXCheckPrint2.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint3.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint4.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint5.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint6.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint7.jsp" flush="true"/>

<jsp:include page="fundJXCheckPrint12.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint13.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint14.jsp" flush="true"/>
<jsp:include page="fundJXCheckPrint15.jsp" flush="true"/>
</body>
</html>
