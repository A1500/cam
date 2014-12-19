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
	function init(){
		var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
		somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckDataSet.newRecord();
			}
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
function back(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/query/somGroupCheckQueryList.jsp';
	var text = '年检查询';
	L5.forward(url,text,data);
}		
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

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="操作说明" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="operDesc()"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="docPrint();"/>
</div>
<div align=center style='page-break-after:always'>
<div align=left style='width:800;margin-top:60;'>
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
lang=EN-US><span style='mso-spacerun:yes'><label class='label01'  style='width:60pt;text-align:center;font-size:18.0pt;font-family:仿宋_GB2312' field="batchYear" ></label>
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

<p class=MsoNormal align=left style='margin-left:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>社团名称:
<label class='label01'  field="cnName" style='width:400;'></label>
</span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left style='margin-left:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>登记证号:
<label class='label01'   field="sorgCode" style='width:400;'></label>
</span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left style='margin-left:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>报告日期:
<label class='label01'   id='reportDate'   field="reportDate" style="width:400" ></label>	
</span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><b><span style='font-size:22.0pt;mso-bidi-font-size:16.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>中华人民共和国民政部制<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</form>
</div>
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