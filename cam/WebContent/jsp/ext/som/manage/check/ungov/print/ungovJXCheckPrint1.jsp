<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民办非企业单位</title>
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
			var flag = "break";
			var progressId;//进度条标示ID
			var PROGRESS_BAR = 0;//进度条总数
			function processBar(){
					L5.Msg.progress("加载数据","进度条","正在加载数据，请等待...");
					progressId = setInterval(function(){
							if(PROGRESS_BAR==10){
								clearInterval(progressId);
								L5.Msg.hide();
								document.getElementById("printBtn").disabled=false;
							}else{
								L5.Msg.updateProgress(PROGRESS_BAR/10);
							}
					},100);
			}
		 	//初始化
			function init(){
					somCheckDataSet.setParameter("TASK_CODE", taskCode);
					somCheckDataSet.load();
					somCheckDataSet.on('load',function (){
						if(somCheckDataSet.getCount() == 0){
							somCheckDataSet.newRecord();
							PROGRESS_BAR++;
							return ;
						}
						if(somCheckDataSet.getCount() != 0){
							var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
							command.setParameter("checkYear",somCheckDataSet.get('checkYear'));
							command.setParameter("fillPeopleId",somCheckDataSet.get('fillPeopleId'));
							command.execute("queryLastYearCheckResult");
							document.getElementById("lastYearCheckResult").innerHTML = command.getReturn("lastYearCheckResult");
						}
						PROGRESS_BAR++;
					});
				init4();
				init5();
				init6();
				init7();
				init8();
				init9();
				init10();
				//创建页面导航下拉框
				//createUngovDetailSelect();
			}
			function save(){
				var checkRecord=somCheckDataSet.getCurrent();
				if(checkRecord.get('cnName').trim() == ''){
					L5.Msg.alert("提示","民办非企业单位名称不能为空！");
					return;
				}
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("checkRecord", checkRecord);
				command.execute("savePage1");
				if (!command.error) {
					L5.Msg.alert("提示","保存成功！",function(){
					});		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
			
		</script>
<style media="print">
.noprint {
	display: none
}
</style>
<style>
.label1 {
	text-align:left;
	font-size: 14.0pt;
	font-family: 仿宋;
}
</style>
</head>

<body onload="processBar()">
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
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
</model:datasets>
<div style='page-break-after:always'>
<div id="float" class="noprint">
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="backM();"/>
	<input  id="printBtn" type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:120px;" disabled=true  onclick="docPrint();"/>	
	<input type="button" value="操作说明" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="operDesc()"/>
</div>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div align=center>
<div align=center style="margin-top: 60px; width: 700px">

<p class=MsoNormal align=center style='text-align: center'><span
	lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 华文中宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center style='text-align: center'><span
	lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 华文中宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center style='text-align: center'><span
	lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 华文中宋'><o:p>&nbsp;</o:p></span></p>		

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:22.0pt;font-family:宋体'>江西省民办非企业单位年度检查报告书<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center style='text-align: center'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal align=center style='text-align: center'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>
	
<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>（
<label style='font-size:18.0pt;font-family:仿宋; width:60pt' field="checkYear"></label>	
	年度）<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal><span lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 华文中宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US
	style='font-size: 22.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 华文中宋'><o:p>&nbsp;</o:p></span></p>	

<p class=MsoNormal align=center
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; font-family: 仿宋; mso-ascii-font-family: "Times New Roman"'>单  位  名  称：
<label field="cnName" style="width:400"  class=label1></label>	
	</span></p>
	
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
	<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-ascii-font-family: "Times New Roman"'>登  记  证  号：
<label field="sorgCode" style="width:400" class=label1></label>
	</span></p>

<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
	<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-ascii-font-family: "Times New Roman"'>组  织  代  码：
<label field="organCode" style="width:400" class=label1></label>
	</span></p>

<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
	<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-ascii-font-family: "Times New Roman"'>报  告  日  期：
<label field="reportDate" style="width:400" class=label1></label>	
	</span></p>


<p class=MsoNormal
	style='margin-left: 8.9pt; mso-para-margin-left: .85gd'><span
	lang=EN-US style='mso-fareast-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;</span></span><u><span lang=EN-US
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 仿宋'><o:p></o:p></span></u></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></p>
	<p class=MsoNormal
	style='margin-left: 8.9pt; mso-para-margin-left: .85gd'><span
	lang=EN-US style='mso-fareast-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;</span></span><u><span lang=EN-US
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 仿宋'><o:p></o:p></span></u></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></p>
	<p class=MsoNormal
	style='margin-left: 8.9pt; mso-para-margin-left: .85gd'><span
	lang=EN-US style='mso-fareast-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;</span></span><u><span lang=EN-US
	style='font-size: 16.0pt; mso-bidi-font-size: 10.0pt; mso-fareast-font-family: 仿宋'><o:p></o:p></span></u></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US
	style='font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align: center'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size:18.0pt;mso-bidi-font-size:
14.0pt;line-height:200%;font-family:仿宋;mso-hansi-font-family:仿宋'>江西省民政厅制<span
	lang=EN-US><o:p></o:p></span></span></b></p>



</div>
</div>
</form>
</div>
<next:Window id="winOperDesc" closeAction="hide" title="操作说明" width="700"  autoScroll="true" modal="true">
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
<jsp:include page="ungovJXCheckPrint2.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint3.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint4.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint5.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint6.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint7.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint8.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint9.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint10.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint11.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint12.jsp" flush='true' />
<jsp:include page="ungovJXCheckPrint13.jsp" flush='true' />
</body>
</html>
