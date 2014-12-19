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
	String username = ExtBspInfo.getUserInfo(request).getUserName();
	String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
	String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
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
			var username='<%=username%>';
		 	//初始化
			function init(){
				if(method=="INSERT"){
					var date='<%=DateUtil.getDay()%>';
					var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';
					somCheckDataSet.newRecord({"taskCode":taskCode,"reportDate":date,"checkYear":year,"cnName":username,"sorgType":'M',"status":"0","fillPeopleName":'<%=username%>',"fillPeopleId":'<%=peopleId%>',"fillPeopleArea":'<%=peopleArea%>',"currentActivity":'0'});
					
				}else{
					somCheckDataSet.setParameter("TASK_CODE", taskCode);
					somCheckDataSet.load();
				}
				//创建页面导航下拉框
				createUngovEditSelect();
			}
			function save(){
				var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
				if(somCheckDataSetIsValidate != true){
					L5.Msg.alert("提示",somCheckDataSetIsValidate);
					return "break";
				}	
				var checkRecord=somCheckDataSet.getCurrent();
				if(checkRecord.get('cnName').trim() == ''||checkRecord.get('cnName').trim() == '请输入民办非企业单位名称'){
					L5.Msg.alert("提示","民办非企业单位名称不能为空！");
					return "break";					
				}
				
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("checkRecord", checkRecord);
				command.execute("savePage1");
				if (!command.error) {
					alert("保存成功！");		
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
			
		</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck">
			<model:field name="cnName" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="organCode" type="string" rule="require" />
			<model:field name="reportDate" type="string" rule="require" />
		</model:record>
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
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('2')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
</div>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div align=center>
<div align=center style="margin-top: 60px; width: 800px">

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
<input type="text" title='单位名称'style='' field="cnName" name='"单位名称"' onblur="fillBackValue(this)" onclick="clearValue(this)"  style="width:400"  maxlength="50"/>	
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
<input type="text"style='' title='登记证号' name='"登记证号"' field="sorgCode" style="width:400"  maxlength="20"/>
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
<input style='' title='组织代码' name='"组织代码"' field="organCode" style="width:400" maxlength="12"/>
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
<input type="text"style='' id='reportDate' title='报告日期' name='"报告日期"' field="reportDate" style="width:400"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>	
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


<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>
</form>
</body>
</html>
