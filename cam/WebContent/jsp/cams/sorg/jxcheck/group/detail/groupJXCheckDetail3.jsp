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
		 	//初始化
			function init(){
				somCheckDataSet.setParameter("TASK_CODE", taskCode);
				somCheckDataSet.load();
				somJxVipOrganDataSet.setParameter("TASK_CODE", taskCode);
				somJxVipOrganDataSet.load();
				somJxVipOrganDataSet.on('load',function (){
					if(somJxVipOrganDataSet.getCount() == 0){
						somJxVipOrganDataSet.newRecord();
					}
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
<style>
label {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋_GB2312 ';
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	
	<model:dataset id="somJxVipOrganDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxviporgan.cmd.SomJxVipOrganQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrgan"></model:record>
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
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
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
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="dutySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_som_duty'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<OBJECT id="WebBrowser" height="0" width="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" 
      VIEWASTEXT> 
      </OBJECT> 
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage1('4')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('2')"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="WebBrowser.ExecWB(6,1)"/>
</div>

<div align=center>
<div align=left style=" width: 800px">
<form method="post"onsubmit="return false" dataset="somCheckDataSet">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 48.2pt; mso-char-indent-count: 3.0; '><b><span
	style='font-size: 16.0pt; font-family: 黑体; '>一、基本情况</span></b><b><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>
	登记证号:<label field="sorgCode" style='border-bottom: solid 1px;width:15%;'></label>	
	单位名称:<label field="cnName" style='border-bottom: solid 1px;width:50%'></label>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>业务主管单位:
	<label field="borgName" style='border-bottom: solid 1px;width:40%; font-family: 仿宋_GB2312'></label>
	社会团体类型：
	<label field="sorgKind" style="width:150" dataset="sorgKind"></label>
	<u>
</u></span><u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>登记日期:<label field="downDate" style='border-bottom: solid 1px;width:150; font-family: 仿宋_GB2312'></label>
	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>证书有效期:<label field="certUsefulDate" style='border-bottom: solid 1px;width:150; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '></span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red'>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>凡证书有效期已过期的，请速来我局办理相关手续。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>注册资金:<label field="initialFund" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>元人民币</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>住所地址:<label field="residence" style='border-bottom: solid 1px;width:50%; font-family: 仿宋_GB2312'></label>
	<br>邮编:<label field="sorgPost" style='border-bottom: solid 1px;width:20%; font-family: 仿宋_GB2312'></label>
	</span></p>

 

<p class=MsoNormal
	style=' '><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red''>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>未办理住所变更手续的，请速来我局办理相关手续。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>联系人:<label field="linkmanName" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'></span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>职务:
	<label field="linkmanDuty" style="width:150" dataset="dutySelect"></label>
	
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'></span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>手机:<label field="linkmanMobile" style='width:200; font-family: 仿宋_GB2312; '></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>电子邮件:<label field="sorgEmail" style='width:150;border-bottom: solid 1px;width:300; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>联系电话:<label field="sorgPhone" style='border-bottom: solid 1px;width:200; font-family: 仿宋_GB2312'></label>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span></u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>单位传真:<label field="sorgFax" style='border-bottom: solid 1px;width:200; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; color: black'>单位网址:<label field="sorgWeb" style='border-bottom: solid 1px;width:300; font-family: 仿宋_GB2312'></label>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span><u><o:p></o:p></u></p>
<p class=MsoNormal style=''><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
</form>
<form method="post"onsubmit="return false" dataset="somJxVipOrganDataSet">
<p class=MsoNormal
	style='text-indent: 32.15pt; '><b><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 新宋体'>二、会员和机构设置情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>（一）单位会员数:<label field="unitsNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>个人会员数:<label field="peopleNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>（二）本届理事会起始日期:<label field="startDate" style='border-bottom: solid 1px;width:150; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>，任期:<label field="dutyLimit" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>年，理事人数:<label field="councilNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><u><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>人，常务理事人数:<label field="standCouncilNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>人，监事会或监事:<label field="auditorNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'> </span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>人；秘书处工作人员:<label field="secretaryNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	<u>
</u>人</span><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'><o:p></o:p></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>（三）日常办事机构数:<label field="dailyNum" style='width:100;  font-family: 仿宋_GB2312; '>	</label>
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><span
	style='mso-spacerun: yes'>&nbsp; </span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; ; mso-bidi-font-weight: bold'>个，分支（代表）机构数:<label field="organNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>个，
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal style=' '><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; ; mso-bidi-font-weight: bold'>专项基金机构数:<label field="specialNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; ; mso-bidi-font-weight: bold'>个，实体机构数:<label field="entityNum" style='border-bottom: solid 1px;width:100; font-family: 仿宋_GB2312'></label>个
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>

</body>
</html>
