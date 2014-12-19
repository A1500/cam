<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="java.util.*"%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民办非企业单位</title>
<%
	//String username = ExtBspInfo.getUserInfo(request).getUserName();
	//String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
	//String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
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
					if(PROGRESS_BAR==6){
						clearInterval(progressId);
						L5.Msg.hide();
						document.getElementById("printBtn").disabled=false;
					}else{
						L5.Msg.updateProgress(PROGRESS_BAR/12);
					}
			},100);
	}
	//初始化
function init(){
	if(method=="INSERT"){
		var date='<%=DateUtil.getDay()%>';
		var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';

	}else{
		somCheckDataSet.setParameter("TASK_CODE", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckDataSet.newRecord();
			}
			PROGRESS_BAR++;
		});
	}
	init3();
	init4();
	init5();
	init6();
	init7();
	init8();
	//创建页面导航下拉框
	//createUngovDetailSelect();
}
function save(){
	var checkRecord=somCheckDataSet.getCurrent();
	if(checkRecord.get('cnName').trim() == ''||checkRecord.get('cnName').trim() == '请输入民办非企业单位名称'){
		L5.Msg.alert("提示","民办非企业单位名称不能为空！");
		return "break";

	}
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
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
function clearValue(nameObj){
	if(nameObj.value == '请输入民办非企业单位名称'){
		var checkRecord=somCheckDataSet.getCurrent();
		checkRecord.set("cnName","");
	}
}
function fillBackValue(nameObj){
	if(nameObj.value == ''){
		var checkRecord=somCheckDataSet.getCurrent();
		checkRecord.set("cnName","请输入民办非企业单位名称");
	}
}
function docPrint(){
    document.execCommand("Print", false);
}
function operDesc(){
	L5.getCmp('winOperDesc').show();
}
function closeOperDesc(){
	L5.getCmp('winOperDesc').hide();
}
setPrint();
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
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="操作说明" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="operDesc()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="backM();"/>
	<input type="button" id="printBtn" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div align=center style='page-break-after:always'>
<div align=center style=" margin-top: 20px;width: 610px">

<p class=MsoNormal align=right style='margin-right:5.0pt;text-align:right;
line-height:19.0pt'><b><span style='font-size:14.0pt;font-family:宋体'>编号：10<span
lang=EN-US></span></span></b></p>

<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:34.0pt'><b><span
style='font-size:22.0pt;font-family:宋体'>民办非企业单位年度检查报告书</span></b></p>

<p class=MsoNormal align=center style='margin-top:7.8pt;text-align:center;
line-height:34.0pt'><b><span style='font-size:15.0pt;font-family:宋体'>（<span
lang=EN-US><label style='font-size:18.0pt;font-family:宋体; width:60pt' field="batchYear"></label></span>年度）</span></b></p>

<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>

<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>单位名称
<label title='单位名称' field="cnName" name='"单位名称"' style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" ></label>（盖章）</span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>登记证号
<label  title='登记证号' name='"民非登记证号"' field="sorgCode" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>单位形式
<label  title='单位性质' name='"单位性质"' field="sorgKind" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" dataset="sorgKindSelect" ></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>法定代表人
<label title='法定代表人' name='"法定代表人"' field="legalPeople" style="width:310;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label>（本人签章）</span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>代<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>码
<label  title='代码' name='"代码"' field="organCode" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>业务主管单位
<label  name="业务主管单位" field="borgName" title="业务主管单位" style="width:300;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" dataset="borgDataSet"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>所属行（事）业
<label  title='所属行（事）业' name='"所属行（事）业"' field="businessType" style="width:270;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体" dataset="busScopeSelect"></label></span></b></p>
<p class=MsoNormal
	style='text-indent: 16.0pt; mso-char-indent-count: 1.0'><span
	lang=EN-US
	style='font-size: 16.0pt; mso-fareast-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left style='margin-left:20.0pt;text-indent: 16.0pt'><b><span
style='font-size:15.0pt;font-family:宋体'>报告日期
<label id='reportDate'  name='"报告日期"' field="reportDate" style="width:330;text-align: center;border-bottom:1px solid;font-size:15.0pt;font-family:宋体"></label></span></b></p>



<p class=MsoNormal style='line-height:34.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal style='line-height:24.0pt'><span lang=EN-US
style='font-size:15.0pt'>&nbsp;</span></p>
<p class=MsoNormal align=center style='text-align:center;line-height:34.0pt'><span
style='text-fit:240.0pt'><span style='font-size:15.0pt;font-family:黑体;
letter-spacing:2.7pt'>山东省民间组织管理局监制</span></span></p>

</div>
</div>
</form>

<next:Window id="winOperDesc" closeAction="hide" title="操作说明" width="800"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeOperDesc"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<div>
	<span style="font-size:14px;color:red">
				操作说明：<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请使用Internet Explorer7及以上浏览器进行打印，并进行下述设置<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;先点击左上方的“文件”，出现一个下拉菜单，点击下拉菜单中的“页面设置”项（从上数第六个，IE浏览器的“页面设置”），弹出一个“页面设置”的对话框。<br>
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
<jsp:include page="ungovCheckPrint2.jsp" flush='true' />
<jsp:include page="ungovCheckPrint3.jsp" flush='true' />
<jsp:include page="ungovCheckPrint4.jsp" flush='true' />
<jsp:include page="ungovCheckPrint5.jsp" flush='true' />
<jsp:include page="ungovCheckPrint6.jsp" flush='true' />
<jsp:include page="ungovCheckPrint7.jsp" flush='true' />
<jsp:include page="ungovCheckPrint8.jsp" flush='true' />
<jsp:include page="ungovCheckPrint9.jsp" flush='true' />
<jsp:include page="ungovCheckPrint10.jsp" flush='true' />
</body>
</html>
