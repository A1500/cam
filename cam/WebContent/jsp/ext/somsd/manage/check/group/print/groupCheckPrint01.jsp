<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	var flag = "break";
	var progressId;//进度条标示ID
	var PROGRESS_BAR = 0;//进度条总数
	function processBar(){
			L5.Msg.progress("加载数据","进度条","正在加载数据，请等待...");
			progressId = setInterval(function(){
					if(PROGRESS_BAR==12){
						clearInterval(progressId);
						L5.Msg.hide();
						document.getElementById("printBtn").disabled=false;
					}else{
						L5.Msg.updateProgress(PROGRESS_BAR/12);
					}
			},100);
	}
	function init(){
		operDesc();
		var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
		somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckDataSet.newRecord();
			}else{
				var reportDate=ds.get("reportDate");
				formateYMD(reportDate);//将第二面的日期转换为年月日格式
			}
			PROGRESS_BAR++;
		});
		//createGroupDetailSelect();
		init1();
		init2();
		init3();
		init4();
		init5();
		init6();
		init7();
	}
	function docPrint(){
		document.execCommand("Print", false);
	}
	setPrint();
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
.label01 {
	text-align:left;
	font-size: 14pt;
	font-family: 宋体;
}
</style>
</head>

<body  onload="processBar()">
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="打印说明" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="operDesc()"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="back();" />
	<input  id="printBtn" type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="docPrint();"/>
</div>
<div align=center style='page-break-after:always'>

<p class=MsoNormal align=right style='text-align:right;mso-outline-level:
1'><span style='font-size:15.0pt;mso-bidi-font-size:15.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>编号：15&nbsp&nbsp&nbsp&nbsp&nbsp<span lang=EN-US><o:p></o:p></span></span></p>


<div align=center style='text-align:center;width:610px;margin-top:60;'>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div class=Section1 style='layout-grid:15.6pt'>
<br><br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:38.0pt;mso-bidi-font-size:16.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>社 会 团 体<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:38.0pt;mso-bidi-font-size:16.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>年 度 检 查 报 告 书<span lang=EN-US><o:p></o:p></span></span></p>
<br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><b><span style='font-size:16.0pt;font-family:宋体;mso-hansi-font-family:华文中宋'>&nbsp;&nbsp;（<span
lang=EN-US><span style='mso-spacerun:yes'><label class='label01'  style='width:60pt;text-align:center;font-size:18.0pt;font-family:仿宋' field="batchYear" ></label>
</span></span>年度）<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center style='text-align:center'><span style='margin-left:100px;font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:
华文中宋;text-align:center'>社团名称:
<label class='label01'  field="cnName" style='width:310;'></label>（盖章）
</span></p>

<p class=MsoNormal align=center style='mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='margin-left:100px;font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:
华文中宋;text-align:center'>登记证号:
<label class='label01'   field="sorgCode" style='width:400;'></label>
</span></p>

<p class=MsoNormal align=center style='mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='margin-left:100px;font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:
华文中宋;text-align:center'>报告日期:
<label class='label01'   id='reportDate'   field="reportDate" style="width:400" ></label>
</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</form>
</div>
</div>

<next:Window id="winOperDesc" closeAction="hide" title="打印说明" width="610"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeOperDesc"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<div>
	<span style="font-size:14px;color:red">
				打印说明：<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请使用Internet Explorer7及以上浏览器进行打印，并进行下述设置<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;先点击左上方的“文件”，出现一个下拉菜单，点击下拉菜单中的“页面设置”项（从上数第六个，Internet Explorer浏览器的“页面设置”），弹出一个“页面设置”的对话框。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.请设置纸张大小为“A4”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.删除掉“页眉“中的字符“&w&b页码，&p/&P”和“页脚“中的字符“&u&b&d”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.把方向设置为”纵向”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.把页边距的“上”、“下”、“左”、“右”都设置为“10”；<br>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点击确定按钮，对话框关闭。请单击“打印”按钮进行打印。 <br>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;需要单独打印某一张的，请在列表选择年检数据后，点击明细按钮在明细页面进行打印。 <br>
	</span>
	</div>
	</next:Html>
</next:Window>
<jsp:include page="groupCheckPrint02.jsp" flush='true' />
<jsp:include page="groupCheckPrint03.jsp" flush='true' />
<jsp:include page="groupCheckPrint1.jsp" flush='true' />
<jsp:include page="groupCheckPrint2.jsp" flush='true' />
<jsp:include page="groupCheckPrint3.jsp" flush='true' />
<jsp:include page="groupCheckPrint4.jsp" flush='true' />
<jsp:include page="groupCheckPrint5.jsp" flush='true' />
<jsp:include page="groupCheckPrint6.jsp" flush='true' />
<jsp:include page="groupCheckPrint7.jsp" flush='true' />
<jsp:include page="groupCheckPrint8.jsp" flush='true' />
</body>
</html>