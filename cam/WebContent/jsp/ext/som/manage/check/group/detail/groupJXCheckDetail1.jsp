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
		 	//初始化
			function init(){
				somCheckDataSet.setParameter("TASK_CODE", taskCode);
				somCheckDataSet.load();
				somCheckDataSet.on("load",function(ds){
					document.getElementById('year').innerHTML=ds.get("checkYear");
				});
				//创建页面导航下拉框
				createGroupDetailSelect();
			}
			function save(){
				
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
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"  class="noprint">
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage1('2')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="back();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
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
</body>
</html>
