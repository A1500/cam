<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
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
	String username = ExtBspInfo.getUserInfo(request).getUserName();
%>
<next:ScriptManager/>
		<script type="text/javascript" src="../../js/float.js"></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
			var username='<%=username%>';
		 	//初始化
			function init(){
				somCheckDataSet.setParameter("TASK_CODE", taskCode);
				somCheckDataSet.load();
				somCheckDataSet.on('load',function (){
					if(somCheckDataSet.getCount() == 0){
						somCheckDataSet.newRecord();
					}
				});
				somJxVipOrganDataSet.setParameter("TASK_CODE", taskCode);
				somJxVipOrganDataSet.load();
				somJxVipOrganDataSet.on('load',function (){
					if(somJxVipOrganDataSet.getCount() == 0){
						somJxVipOrganDataSet.newRecord();
					}
				});
				//创建页面导航下拉框
				createGroupEditSelect();
			}
			function save(){
				var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
				if(somCheckDataSetIsValidate != true){
					L5.Msg.alert("提示",somCheckDataSetIsValidate);
					return "break";
				}	
				var somJxVipOrganDataSetIsValidate = somJxVipOrganDataSet.isValidate();
				if(somJxVipOrganDataSetIsValidate != true){
					L5.Msg.alert("提示",somJxVipOrganDataSetIsValidate);
					return "break";
				}
	var councilNum=document.getElementById("councilNum").value;	
	var standCouncilNum=document.getElementById("standCouncilNum").value;
	if(parseInt(standCouncilNum) > (parseInt(councilNum))){
		L5.Msg.alert("提示","常务理事人数不能大于理事人数！");
		return "break";
	}
				var checkRecord=somCheckDataSet.getCurrent();
				var somJxVipOrganRecord=somJxVipOrganDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("checkRecord", checkRecord);
				command.setParameter("somJxVipOrganRecord", somJxVipOrganRecord);
				command.execute("savePage3");
				if (!command.error) {
					alert("保存成功！");		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="require" />
			<model:field name="downDate" type="string" rule="require" />
			<model:field name="certUsefulDate" type="string" rule="require" />
			<model:field name="initialFund" type="string" rule="require" />
			<model:field name="residence" type="string" rule="require" />
			<model:field name="sorgPost" type="string" rule="require" />
			<model:field name="linkmanName" type="string" rule="require" />
			<model:field name="linkmanDuty" type="string" rule="require" />
			<model:field name="linkmanMobile" type="string" rule="require" />
			<model:field name="sorgEmail" type="string" rule="require" />
			<model:field name="sorgPhone" type="string" rule="require" />
			<model:field name="sorgFax" type="string" rule="require" />
			<model:field name="sorgWeb" type="string" rule="require" />
			<model:field name="sorgKind" type="string" rule="require" />
		</model:record>
	</model:dataset>
	
	<model:dataset id="somJxVipOrganDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxviporgan.cmd.SomJxVipOrganQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxviporgan.dao.SomJxVipOrgan">
			<model:field name="unitsNum" type="string" rule="require" />
			<model:field name="peopleNum" type="string" rule="require" />
			<model:field name="startDate" type="string" rule="require" />
			<model:field name="dutyLimit" type="string" rule="require" />
			<model:field name="councilNum" type="string" rule="require" />
			<model:field name="standCouncilNum" type="string" rule="require" />
			<model:field name="auditorNum" type="string" rule="require" />
			<model:field name="secretaryNum" type="string" rule="require" />
			<model:field name="dailyNum" type="string" rule="require" />
			<model:field name="organNum" type="string" rule="require" />
			<model:field name="specialNum" type="string" rule="require" />
			<model:field name="entityNum" type="string" rule="require" />
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
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
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
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage('4')"/>
		<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage('2')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="back();"/>
</div>
<div>
<div align=center>
<div align=left style=" width: 800px">
<form method="post"onsubmit="return false" dataset="somCheckDataSet">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 48.2pt; mso-char-indent-count: 3.0; mso-line-height-alt: 12.0pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>一、基本情况</span></b><b><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>
	登记证号：
<input  title='登记证号' name='"登记证号"' field="sorgCode" style="width:20%"  maxlength="50"/>	
	单位名称：
<input  title='单位名称' name='"单位名称"' field="cnName" style="width:40%"  maxlength="50"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'> <span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>业务主管单位：
<input  title="业务主管单位" name='"业务主管单位"' field="borgName" style="width:35%" maxlength="100"/>
社会团体类型：
<select field='sorgKind' name='社会团体类型'><option dataset='sorgKind'></option></select>
	<u>
</u></span><u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>登记日期：
<input type="text" title='登记日期' name='"登记日期"' field="downDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>证书有效期：
<input  type="text" title='证书有效期' name='"证书有效期"' field="certUsefulDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'></span></u><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋;color:red'>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>凡证书有效期已过期的，请速来我局办理相关手续。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>注册资金（填写小写数字即可）：
<input onkeyup="value=value.replace(/[^\d.]/g,'')"onblur='checkFloat(this);'  type="text" title='注册资金' name='"注册资金"' field="initialFund" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>元人民币</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋'>住所地址：
<input  type="text" title='住所地址' name='"住所地址"' field="residence" style="width:50%"  maxlength="50"/>
	</span></p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋'>邮编：
<input  type="text" title='邮编'name='"邮编"' field="sorgPost" style="width:10%"  maxlength="6"/>
	</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋;color:red''>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>未办理住所变更手续的，请速来我局办理相关手续。</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>联系人：
<input  type="text" title='联系人' name='"联系人"' field="linkmanName" style="width:10%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>职务：
<select name='"联系人职务"' field="linkmanDuty" ><option dataset="dutySelect"><option></select>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>手机：
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='手机' name='"联系人手机"' field="linkmanMobile" style="width:15%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>电子邮件：
<input  type="text" title='电子邮件' name='"电子邮件"' field="sorgEmail" style="width:40%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>联系电话：
<input onkeyup="value=value.replace(/[^\d-]/g,'')"  type="text" title='联系电话' name='"联系电话"' field="sorgPhone" style="width:15%"  maxlength="50"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'> </span></u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>单位传真：
<input  type="text" title='单位传真' name='"单位传真"' field="sorgFax" style="width:15%"  maxlength="50"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; color: black'>单位网址：
<input type="text" title='单位网址' name='"单位网址"' field="sorgWeb" style="width:40%"  maxlength="50"/>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋'> <u><o:p></o:p></span></u></span></p>

<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
</form>
<form method="post"onsubmit="return false" dataset="somJxVipOrganDataSet">
<p class=MsoNormal
	style='text-indent: 32.15pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 新宋体'>二、会员和机构设置情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>（一）单位会员数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='单位会员数' name='"单位会员数"' field="unitsNum" style="width:7%"  maxlength="6"/>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>个人会员数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='个人会员数' name='"个人会员数"' field="peopleNum" style="width:7%"  maxlength="6"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'> <span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>（二）本届理事会起始日期：
<input type="text" title='本届理事会起始日期' name='"本届理事会起始日期"' style="width:33%" field="startDate" maxlength="30"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>，任期：
<input type="text" title='任期' name='"任期"' field="dutyLimit" style="width:10%"  maxlength="50"/>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年，理事人数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='理事人数' name='"理事人数"'id='councilNum' field="councilNum" style="width:7%"  maxlength="10"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><u><span style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>人，常务理事人数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='常务理事人数' name='"常务理事人数"'id='standCouncilNum' field="standCouncilNum" style="width:7%"  maxlength="10"/>
	</span><u><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋'> </span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>人，监事会或监事：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='监事会或监事' name='"监事会或监事"' field="auditorNum" style="width:7%"  maxlength="6"/>
	</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'> </span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>人；秘书处工作人员：
	<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='秘书处工作人员' name='"秘书处工作人员"' field="secretaryNum" style="width:7%"  maxlength="6"/>
	<u>
</u>人</span><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>（三）日常办事机构数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='日常办事机构数' name='"日常办事机构数"' field="dailyNum" style="width:7%"  maxlength="6"/>	
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span></u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><span
	style='mso-spacerun: yes'>&nbsp; </span></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>个，分支（代表）机构数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='分支（代表）机构数' name='"分支（代表）机构数"' field="organNum" style="width:7%"  maxlength="6"/>个，
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal style=' mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>专项基金机构数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='专项基金机构数' name='"专项基金机构数"' field="specialNum" style="width:7%"  maxlength="6"/>
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>个，实体机构数：
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='实体机构数' name='"实体机构数"' field="entityNum" style="width:7%"  maxlength="6"/>个&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span><u><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span></u><u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><span
	lang=EN-US><o:p></o:p></span></span></u></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
