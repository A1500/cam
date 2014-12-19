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
				var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit2.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/somchecktask/somjxchecktask_list.jsp';
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
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
</div>
<div class=Section1>

<p class=MsoNormal style='margin-right:11.95pt;text-indent:21.0pt'><span
style='font-family:仿宋_GB2312;color:red'>★请各社会团体于每年<span lang=EN-US>3</span>月下旬登陆江西社会组织网（<span
lang=EN-US>http://www.jxmjzz.cn</span>）下载《社会团体年度检查报告书》，当年<span lang=EN-US>6</span>月<span
lang=EN-US>30</span>日前按要求接受年度检查。</span></p>

<p class=MsoNormal><span lang=EN-US style='font-family:仿宋_GB2312'>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center'><b><span lang=EN-US
style='font-size:12.0pt;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:26.0pt;font-family:宋体'>社会团体年度检查报告书</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:18.0pt;font-family:仿宋_GB2312'>（<%=DateUtil.getYear()%>年度）</span></p>

<p class=MsoNormal><b><span lang=EN-US style='font-size:16.0pt;font-family:
仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal><span lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312'>&nbsp;</span></p>

<p class=MsoNormal style='text-indent: 100.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>江西省民政厅</span></u><span
style='font-size:16.0pt;font-family:仿宋_GB2312'>：</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 150.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本社会团体根据《社会团体登记管理条例》、《民间非营利组织会计制度》等有关规定编制<%=DateUtil.getYear()%>年度
	</span></p>
<p class=MsoNormal style='text-indent: 100.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>	
	工作报告书，并保证本报告书内容真实、准确、完整。</span></p>
<p class=MsoNormal style='text-indent: 150.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>请予审查。</span></p>

<p class=MsoNormal style='text-indent:32.0pt;line-height:23.0pt'><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312'>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:600pt;line-height:23.0pt'><span
style='font-size:16.0pt;font-family:仿宋_GB2312'>（社会团体印章）</span></p>

<p class=MsoNormal style='text-indent:600pt;line-height:23.0pt'><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style='font-size:16.0pt;font-family:仿宋_GB2312'><%=DateUtil.getDay()%></span></p>

<p class=MsoNormal style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal style='line-height:18.0pt;text-autospace:none'><b><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋_GB2312'>&nbsp;</span></b></p>


<p class=MsoNormal align=center style='text-align:center;text-autospace:none'><span
style='font-size:18.0pt;font-family:仿宋_GB2312'>法定代表人申明</span></p>

<p class=MsoNormal align=center style='text-align:center;text-autospace:none'><b><span
lang=EN-US style='font-size:18.0pt;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal align=center><span style='font-size:16.0pt;
font-family:仿宋_GB2312'>本报告书情况属实，本人愿意承担由此引起的一切法律责任。</span></p>

<p class=MsoNormal style='text-indent:180.0pt;line-height:18.0pt;text-autospace:
none'><span lang=EN-US style='font-size:12.0pt;font-family:仿宋_GB2312;
color:black'>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:180.0pt;line-height:18.0pt;text-autospace:
none'><span lang=EN-US style='font-size:12.0pt;font-family:仿宋_GB2312;
color:black'>&nbsp;</span></p>

<p class=MsoNormal style='margin-left:500pt;text-indent:32.0pt'><span
style='font-size:16.0pt;font-family:仿宋_GB2312'>法定代表人签字：<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></p>

<p class=MsoNormal style='text-indent:600pt;line-height:23.0pt'><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style='font-size:16.0pt;font-family:仿宋_GB2312'><%=DateUtil.getDay()%></span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><b><span
lang=EN-US style='font-size:18.0pt;line-height:150%;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><b><span
lang=EN-US style='font-size:18.0pt;line-height:150%;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:150%'><b><span
lang=EN-US style='font-size:18.0pt;line-height:150%;font-family:仿宋_GB2312'>&nbsp;</span></b></p>

<p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

</div>

</body>
</html>
