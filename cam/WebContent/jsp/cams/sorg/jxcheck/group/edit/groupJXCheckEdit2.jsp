<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager/>
		<script type="text/javascript" src="../../js/float.js"></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
			
			var flag = "break";
		 	//初始化
			function init(){
				//创建页面导航下拉框
				createGroupEditSelect();
			}
			function save(){
				try{
					checkData();
				}catch(e){
					  if (e=="break")
					  return "break";
				}
				var checkRecord=somCheckDataSet.getCurrent();
				var checkCouncilRecord=somCheckCouncilDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("checkRecord", checkRecord);
				command.setParameter("checkCouncilRecord", checkCouncilRecord);
				command.execute("savePage1");
				if (!command.error) {
					L5.Msg.alert("提示","保存成功！",function(){
					});		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
				//return "true";
			}
			function nextPage(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit3.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/somchecktask/somchecktask_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function checkData(){
				var checkRecord=somCheckDataSet.getCurrent();
				if(checkRecord.get('cnName').trim() == ''){
					L5.Msg.alert("提示","社会团体名称不能为空！");
					throw flag;
				}
				if(checkRecord.get('sorgCode').trim() == ''){
					L5.Msg.alert("提示","登记证号不能为空！");
					throw flag;
				}
			}
		</script>
<style>

</style>
</head>

<body>
<model:datasets>

</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="back();"/>
</div>
<div class=Section1>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><span
lang=EN-US style='font-size:18.0pt;mso-bidi-font-size:10.5pt;line-height:150%;
font-family:仿宋_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><span
lang=EN-US style='font-size:18.0pt;mso-bidi-font-size:10.5pt;line-height:150%;
font-family:仿宋_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><span
style='font-size:22.0pt;line-height:150%;font-family:黑体;mso-hansi-font-family:
华文中宋'>填 表 说 明<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:18.0pt;
mso-bidi-font-size:10.5pt;line-height:150%;font-family:仿宋_GB2312'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoBodyTextIndent2 style='text-indent:34.9pt;mso-char-indent-count:
2.18;line-height:36.0pt;mso-line-height-rule:exactly'><span style='font-size:
16.0pt'>一、本报告书务必填写真实情况。可打印或用钢笔、签字笔填写。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoBodyTextIndent2 style='text-indent:34.9pt;mso-char-indent-count:
2.18;line-height:36.0pt;mso-line-height-rule:exactly'><span style='font-size:
16.0pt'>二、表中的数据、时间、电话号码一律用阿拉伯数字填写。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoBodyTextIndent2 style='text-indent:34.9pt;mso-char-indent-count:
2.18;line-height:36.0pt;mso-line-height-rule:exactly'><span style='font-size:
16.0pt'>三、本报告书填写不下的内容可以另附<span lang=EN-US>A4</span>纸填写。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoBodyTextIndent2 style='text-indent:34.9pt;mso-char-indent-count:
2.18;line-height:36.0pt;mso-line-height-rule:exactly'><span style='font-size:
16.0pt'>四、本报告书要求签名之处，应当由本人用钢笔或签字笔签署，代签或复印无效。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoBodyTextIndent2 style='text-indent:34.9pt;mso-char-indent-count:
2.18;line-height:36.0pt;mso-line-height-rule:exactly'><span style='font-size:
16.0pt'>五、本报告书一式<span lang=EN-US>3</span>份（附电子文档）。本报告书必须经法定代表人本人签字，同时加盖本单位印章，方为有效。<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoBodyTextIndent2 style='text-indent:0cm'><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:305.9pt;mso-char-indent-count:19.12;
line-height:23.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</body>
</html>
