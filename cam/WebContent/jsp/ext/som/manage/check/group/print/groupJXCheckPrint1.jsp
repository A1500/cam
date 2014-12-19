<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
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
				somCheckDataSet.on("load",function(ds){
					if(ds.getCount() == 0){
						ds.newRecord();
						PROGRESS_BAR++;
						return ;
					}
					document.getElementById('year').innerHTML=ds.get("checkYear");
					var checkYear=ds.get("checkYear");
					document.getElementById("checkYear_5").innerHTML=checkYear;
					document.getElementById("checkYear1_5").innerHTML=checkYear;
		
					document.getElementById("checkYear_11").innerHTML=checkYear;
					document.getElementById("nextYear_11").innerHTML=parseInt(checkYear)+1;
					document.getElementById("checkYear1_11").innerHTML=checkYear;
					document.getElementById("nextYear1_11").innerHTML=parseInt(checkYear)+1;
					
					var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
					command.setParameter("checkYear",somCheckDataSet.get('checkYear'));
					command.setParameter("fillPeopleId",somCheckDataSet.get('fillPeopleId'));
					command.execute("queryLastYearCheckResult");
					document.getElementById("lastYearCheckResult").innerHTML = command.getReturn("lastYearCheckResult");
					PROGRESS_BAR++;
				});
				init3();
				init4();
				init5();
				init6();
				init7();
				init8();
				init9();
				init10();
				init11();
				init12();
				init13();
				//创建页面导航下拉框
				//createGroupDetailSelect();
			}
			function save(){
				
			}
		</script>
<style media="print">
	.noprint     { display: none }
</style>
</head>

<body onload="processBar()">
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
	</model:dataset>
</model:datasets>
<div style='page-break-after:always'>
<div id="float"  class="noprint">
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="back();"/>
	<input id="printBtn" type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:120px;" disabled=true onclick="docPrint();"/>
	<input type="button" value="操作说明" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="operDesc()"/>
</div>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div style="text-align: center">
<div class=Section1 style="width: 700px;margin-top:60px;">


<p class=MsoNormal><span lang=EN-US style='font-family:仿宋'>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center'><b><span lang=EN-US
style='font-size:12.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:26.0pt;font-family:宋体'>社会团体年度检查报告书</span></b></p>

<p>&nbsp;</p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:18.0pt;font-family:仿宋'>（
<label style='width:60pt;font-size:18.0pt;font-family:仿宋' field="checkYear"></label>
年度）</span></p>

<p class=MsoNormal><b><span lang=EN-US style='font-size:16.0pt;font-family:
仿宋'>&nbsp;</span></b></p>

<p><span lang=EN-US style='font-size:16.0pt;font-family:仿宋'>&nbsp;</span></p>

<p  style="text-align:left"><span
	style='font-size: 16.0pt; font-family: 仿宋'>江西省民政厅:</span></p>
<p ><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p   style="text-align:left;line-height:30.0pt;"><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp&nbsp&nbsp&nbsp本社会团体根据《社会团体登记管理条例》、《民间非营利组织会计制度》等有关规定编制
<label id='year'style='font-size: 16.0pt; font-family: 仿宋'></label>	
	年度工作报告书，并保证本报告书内容真实、准确、完整。<br>&nbsp&nbsp&nbsp&nbsp请予审查。</span></p>

<p  style='text-indent:32.0pt;line-height:23.0pt'><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋'>&nbsp;</span></p>
<p  style='text-indent:32.0pt;line-height:23.0pt'><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋'>&nbsp;</span></p>

<p align=left  style='margin-left:230pt;line-height:23.0pt'><span
style='font-size:16.0pt;font-family:仿宋'>社会团体：
<label field="cnName" style='font-size:14.0pt;font-family:仿宋'></label>
</span></p>
<br />
<p align=left style='margin-left:230pt;line-height:23.0pt'><span
style='font-size:16.0pt;font-family:仿宋'>日&nbsp;&nbsp;&nbsp;期：
<label field="reportDate" style='font-size:14.0pt;font-family:仿宋'></label>
</span></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>
<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋'>&nbsp;</span></b></p>


<p  align=center style='text-align:center;text-autospace:none'><span
style='font-size:18.0pt;font-family:仿宋'>法定代表人申明</span></p>

<p  align=center style='text-align:center;text-autospace:none'><b><span
lang=EN-US style='font-size:18.0pt;font-family:仿宋'>&nbsp;</span></b></p>

<p  align=center><span style='font-size:16.0pt;
font-family:仿宋'>本报告书情况属实，本人愿意承担由此引起的一切法律责任。</span></p>

<p  style='text-indent:180.0pt;line-height:18.0pt;text-autospace:
none'><span lang=EN-US style='font-size:12.0pt;font-family:仿宋;
color:black'>&nbsp;</span></p>

<p  style='text-indent:180.0pt;line-height:18.0pt;text-autospace:
none'><span lang=EN-US style='font-size:12.0pt;font-family:仿宋;
color:black'>&nbsp;</span></p>

<p align=left style='margin-left:320pt;line-height:23.0pt'><span
style='font-size:16.0pt;font-family:仿宋'>法定代表人签字：
<label field="legalPeople" style='font-size:14.0pt;font-family:仿宋'></label>	
</span></p>

<p  align=center style='text-align:center;line-height:150%'><b><span
lang=EN-US style='font-size:18.0pt;line-height:150%;font-family:仿宋'>&nbsp;</span></b></p>

<p  align=center style='text-align:center;line-height:150%'><b><span
lang=EN-US style='font-size:18.0pt;line-height:150%;font-family:仿宋'>&nbsp;</span></b></p>

<p  align=center style='text-align:center;line-height:150%'><b><span
lang=EN-US style='font-size:18.0pt;line-height:150%;font-family:仿宋'>&nbsp;</span></b></p>

<p ><span lang=EN-US>&nbsp;</span></p>

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
<jsp:include page="groupJXCheckPrint2.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint3.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint4.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint5.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint6.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint7.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint8.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint9.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint10.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint11.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint12.jsp" flush="true"/>
<jsp:include page="groupJXCheckPrint13.jsp" flush="true"/>
</body>
</html>

