<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp;"%>
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
				var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit4.jsp';
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
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
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
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
<form method="post"onsubmit="return false">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 48.2pt; mso-char-indent-count: 3.0; mso-line-height-alt: 12.0pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>一、基本情况</span></b><b><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>
	登记证号：
<input type="text"style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' title='登记证号' name='"登记证号"' field="" style="width:10%"  maxlength="50"/>	
	单位名称：
<input type="text"style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' title='单位名称' name='"单位名称"' field="" style="width:30%"  maxlength="50"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>业务主管单位：
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' title="业务主管单位" name='"业务主管单位"' field="borgName" style="width:30%" ><option dataset="businessOrganSelect"></option></select>
	<u>
</u></span><u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>登记日期：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='登记日期' name='"登记日期"' field="buildDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>证书有效期：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='证书有效期' name='"证书有效期"' field="buildDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>（证书已过期）</span></u><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red'>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>凡证书有效期已过期的，请速来我局办理相关手续。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>注册资金：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='注册资金' name='"注册资金"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>万元人民币</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>住所地址：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='住所地址' name='"住所地址"' field="" style="width:25%"  maxlength="50"/>
	（邮编：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='邮编'name='"邮编"' field="" style="width:10%"  maxlength="6"/>
	<span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>所在地街道、镇：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='所在地街道、镇' name='"所在地街道、镇"' field="" style="width:20%"  maxlength="50"/>
	</span><i
	style='mso-bidi-font-style: normal'><u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u></i><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>）<i
	style='mso-bidi-font-style: normal'><u><span lang=EN-US><o:p></o:p></span></u></i></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>联系地址：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='联系地址' name='"联系地址"' field="" style="width:25%"  maxlength="50"/>
	（邮编：
<input type="text" title='邮编' name='"邮编"' field="" style="width:10%"  maxlength="6"/>
	<span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>所在地街道、镇：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='所在地街道、镇' name='"所在地街道、镇"' field="" style="width:20%"  maxlength="50"/>	
	</span><i
	style='mso-bidi-font-style: normal'><u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u></i><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>）<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red''>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>未办理住所变更手续的，请速来我局办理相关手续。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>联系人：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='联系人' name='"联系人"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>职务：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='职务' name='"联系人职务"' field="" style="width:15%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>手机：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='手机' name='"联系人手机"' field="" style="width:15%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>电子邮件：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='电子邮件' name='"电子邮件"' field="" style="width:15%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>联系电话：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='联系电话' name='"联系电话"' field="" style="width:15%"  maxlength="50"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span></u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>单位传真：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体' type="text" title='单位传真' name='"单位传真"' field="" style="width:15%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; color: black'>单位网址：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='单位网址' name='"单位网址"' field="" style="width:15%"  maxlength="50"/>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <u><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.15pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 新宋体'>二、会员和机构设置情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>（一）单位会员数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='单位会员数' name='"单位会员数"' field="" style="width:10%"  maxlength="50"/>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>个人会员数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='个人会员数' name='"个人会员数"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>（二）本届理事会起始日期：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='本届理事会起始日期' name='"本届理事会起始日期"' field="buildDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>，任期：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='任期' name='"任期"' field="" style="width:10%"  maxlength="50"/>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>年，理事人数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='理事人数' name='"理事人数"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><u><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>人，</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='margin-left: .05pt; text-indent: 90.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>常务理事人数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='常务理事人数' name='"常务理事人数"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>人，监事会或监事：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='监事会或监事' name='"监事会或监事"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>人；秘书处工作人员：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='秘书处工作人员' name='"秘书处工作人员"' field="" style="width:10%"  maxlength="50"/>
	<u>
</u>人</span><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'>（三）日常办事机构数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='日常办事机构数' name='"日常办事机构数"' field="" style="width:10%"  maxlength="50"/>	
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><span
	style='mso-spacerun: yes'>&nbsp; </span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>个，分支（代表）机构数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='分支（代表）机构数' name='"分支（代表）机构数"' field="" style="width:10%"  maxlength="50"/>个，
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal style='margin-left: .05pt; text-indent: 90.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>专项基金机构数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='专项基金机构数' name='"专项基金机构数"' field="" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>个，实体机构数：
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体'type="text" title='实体机构数' name='"实体机构数"' field="" style="width:10%"  maxlength="50"/>个
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>

</body>
</html>
