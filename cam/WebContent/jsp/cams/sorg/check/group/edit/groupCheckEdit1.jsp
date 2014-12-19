<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String username = ExtBspInfo.getUserInfo(request).getUserName();
	String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
	String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager/>
		<script type="text/javascript" src="../../js/float.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';

			var flag = "break";
		 	//初始化
			function init(){
				var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
				somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
				somCheckDataSet.load();
				somCheckDataSet.on("load",function(ds){
					if(ds.getCount()==0){
						somCheckDataSet.newRecord({"batchYear":batchYear,"batch":batch,"taskId":taskId,"taskCode":taskCode,"fillPeopleName":'<%=username%>',"fillPeopleId":'<%=peopleId%>',"fillPeopleArea":'<%=peopleArea%>'});
					}
				});
				var somCheckCouncilDataSet = L5.DatasetMgr.lookup("somCheckCouncilDataSet");
				somCheckCouncilDataSet.setParameter("TASK_CODE@=", taskCode);
				somCheckCouncilDataSet.load();
				somCheckCouncilDataSet.on("load",function(ds){
					if(ds.getCount()==0){
						somCheckCouncilDataSet.newRecord();
					}
				});
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
				if(save() == "break"){
					return;
				}
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/group/edit/groupCheckEdit2.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
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
<div style="margin-top:60px;">
<p  align=center style='text-align:center'><span
style='font-size:16.0pt;font-family:黑体;'>一、基本信息</></p>

<div align=center>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table   cellspacing=0 cellpadding=0 width="800">
  <tr>
  <td width="16%" style='width:16.88%;border-top:1.5pt;border-left:1.5pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;'>
	  <p align=center>
	  <span style='font-size:14.0pt;font-family:宋体'>名&nbsp;&nbsp;&nbsp; 称</span></p>
  </td>
  <td width="83%" colspan=10 valign=middle style='width:83.12%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:  0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p  align=center style='line-height:24.0pt;'>
	  	<span>
	  		<input type="text" name='社会团体名称' field="cnName" style="width:98%"  maxlength="50"/>
	  	</span>
	  </p>
  </td>
 </tr>
 <tr style='height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>业务主管</span></p>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>单&nbsp;&nbsp;&nbsp; 位</span></p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
  		<!--<select name="业务主管单位" field="borgName" style="width:98%" ><option dataset="businessOrganSelect"></option></select>
  	-->
  		<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位" style="width:85%"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
		<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
						<ul></ul>
		</div>
		<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
  	</span>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>行业分类</p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.22%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  style='line-height:48.0pt;'>
  <span>
	<select field="businessType" name='行业分类' style="width:98%"><option  dataset="busScopeSelect"></option></select>
</span></p>
  </td>
 </tr>
<tr style='height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>业务范围<span>
  </p>
  </td>
  <td width="83%" colspan=10 valign=middle style='width:83.12%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
		<textarea rows="5" name='业务范围' field="business" style="width:98%;overflow:auto"></textarea>
	</span>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>登记证号<span><o:p></o:p></span></span></p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p style='line-height:28.0pt;'>
  	<span>
		<input type="text" name='登记证号' field="sorgCode" style="width:98%" maxlength="20"/>
	</span>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>组织机构代码
  </span></p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
		<input type="text" name='组织机构代码' field="organCode" style="width:98%" maxlength="9"/>
	</span>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt; height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>成立时间</span></p>
  </td>
  <td width="29%" valign=middle colspan=4 style='width:29.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=middle style='line-height:28.0pt;'>
	  <span style='font-size:14.0pt;font-family:宋体'>
	  	<input type="text" name='成立日期' field="buildDate" format="Y-m-d" onclick="WdatePicker()" style="width:98%"/>
	  </span>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>注册资金
  </span>
  </p>
  </td>
  <td width="32%" colspan=4 style='width:32.2%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  <span><input type="text" style="text-align:right" id="regMon" name='注册资金' field="regMon" maxlength="10" style="width:90%"/>万元</span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>住&nbsp;&nbsp;&nbsp; 所</span>
  </p>
  </td>
  <td valign=middle width="50%" colspan=6 style='width:50.92%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	 	 <input type="text" name='住所' field="residence" style="width:98%" maxlength="50"/>
	  </p>
  </td>
  <td width="15%" colspan=2 valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>邮政编码</span>
	  </p>
  </td>
  <td valign=middle width="16%" colspan=2 style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  	<input type="text" name='邮政编码' field="sorgPost" style="width:98%" maxlength="6"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  <span style='font-size:14.0pt;font-family:宋体'>联系电话
	  </span>
	  </p>
  </td>
  <td valign=middle width="29%" colspan=4  style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  	<input type="text" name='联系电话' field="sorgPhone" style="width:98%" maxlength="30"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>传&nbsp;&nbsp;&nbsp; 真</span></p>
  </td>
  <td valign=middle width="32%" colspan=4 style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
		<input type="text" name='传真' field="sorgFax" style="width:98%" maxlength="30"/>
  </p>
  </td>
 </tr>
  <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>联&nbsp;系&nbsp;人</span>
  </p>
  </td>
  <td valign=middle width="50%" colspan=2 style='width:50.92%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	 	 <input type="text" name='联系人' field="linkmanName" style="width:98%" maxlength="50"/>
	  </p>
  </td>
  <td width="15%" colspan=2 valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>电话</span>
	  </p>
  </td>
  <td valign=middle width="16%" colspan=2 style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  	<input type="text" name='电话' field="linkmanPhone" style="width:98%" maxlength="30"/>
	  </p>
  </td>
  <td width="15%" colspan=2 valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>手机</span>
	  </p>
  </td>
  <td valign=middle width="16%" colspan=2 style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  	<input type="text" name='手机' field="linkmanMobile" style="width:98%" maxlength="30"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>网站地址</span>
  </p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  	<input type="text" name='网站地址' field="sorgWeb" style="width:98%" maxlength="100"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>电子邮箱</span>
  </p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  	<input type="text" name='电子邮箱' field="sorgEmail" style="width:98%" maxlength="100"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>单位会员数</span>
  </p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  	<input type="text" name='单位会员数' field="unitsNum" style="width:98%" maxlength="6"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>个人会员数</span>
  </p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  	<input type="text" name='个人会员数' field="peopleNum" style="width:98%" maxlength="6"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>法定代表人</span>
  </p>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>姓&nbsp;名</span>
  </p>
  </td>
  <td width="29%" colspan=4 valign=middle style='width:29.46%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  	<input type="text" name='法定代表人姓名' field="legalPeople" style="width:98%" maxlength="36"/>
  </p>
  </td>
  <td width="21%" colspan=2 style='width:21.46%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>法定代表人<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>担任职务<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="32%" colspan=4 valign=middle style='width:32.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
		<select field="legalPeopleDuty" name='法定代表人担任职务' style="width:98%"><option  dataset="sorgDutiesSelect"></option></select>
  </p>
  </td>
 </tr>
 </table>
</form>
<form method="post" dataset="somCheckCouncilDataSet" onsubmit="return false">
 <table   cellspacing=0 cellpadding=0 width="800">
 <tr style='height:27.0pt;' >
  <td width="16%" rowspan=4 style='width:16%;border-top:none;border-left:
  solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;border-right:
  solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>理事会情况</span>
	  </p>
  </td>
  <td width="11%" valign=top style='width:11.44%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>理事长</span></p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>姓&nbsp; 名</span>
	  </p>
  </td>
  <td width="16%" colspan=2 valign=middle style='width:16.04%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  		<input type="text" name='理事长姓名' field="chairmanName" style="width:98%" maxlength="36"/>
  </p>
  </td>
  <td width="13%" colspan=2 style='width:13.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	 	 <span style='font-size:14.0pt;font-family:宋体'>理事人数</span>
	  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.32%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  	<input type="text" name='理事人数' field="councilNum" style="width:98%" maxlength="10"/>
	  </p>
  </td>
  <td width="17%" colspan=2 style='width:17.1%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>秘书长以上负责人人数</span>
	  </p>
  </td>
  <td width="12%" style='width:12.5%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  		<input type="text" name='秘书长以上负责人人数' field="secretarygeneralNum" style="width:98%" maxlength="10"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="11%" style='width:11.44%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>秘书长</span></p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>姓&nbsp; 名</span></p>
  </td>
  <td width="16%" colspan=2 style='width:16.04%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p>
	  		<input type="text" name='秘书长姓名' field="secretarygeneralName" style="width:98%" maxlength="36"/>
	  </p>
  </td>
  <td width="13%" colspan=2 style='width:13.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>常务理事</span>
	  </p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>人&nbsp;&nbsp;&nbsp; 数</span>
	  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.32%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p>
  		<input type="text" name='常务理事人数' field="executiveDirectorNum" style="width:98%" maxlength="10"/>
  </p>
  </td>
  <td width="17%" colspan=2 style='width:17.1%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>秘书长为</span>
  </p>
  </td>
  <td width="12%" valign=top style='width:12.5%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p class=MsoNormal style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体;color:red'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="25%" colspan=2 style='width:25.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-right:-5.4pt;text-align:center;
  line-height:28.0pt;'><span style='font-size:14.0pt;
  font-family:宋体'>现职公务员兼任</p>
  <p align=center style='margin-right:-5.4pt;text-align:center;
  line-height:28.0pt;'><span style='font-size:14.0pt;
  font-family:宋体'>负责人情况</span></p>
  </td>
  <td width="57%" colspan=8 style='width:57.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p style='line-height:28.0pt;'>
		  <span style='font-size:14.0pt;font-family:宋体'>
		  省部级及以上(<input type="text" name='省部级及以上人数' field="servantProNum" style="width:30" maxlength="10"/>)人；
		  地厅级(<input type="text" name='地厅级以上人数' field="servantCityNum" style="width:30" maxlength="10"/>)人；
		  县处级(<input type="text" name='县处级以上人数' field="servantTownNum" style="width:30" maxlength="10"/>)人
		  </span>
	  </p>
  </td>
 </tr>
 <tr style='mso-yfti-lastrow:yes;page-break-inside:avoid;height:27.0pt'>
  <td width="25%" colspan=2 style='width:25.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>离退休人员担任</span>
	  </p>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>负责人情况</span>
	  </p>
  </td>
  <td width="57%" colspan=8 style='width:57.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p style='margin-right:-.7pt;line-height:28.0pt;'>
		  <span style='font-size:14.0pt;font-family:宋体'>
		  总数(<input type="text" name='总数' field="retiredSumNum" style="width:30" maxlength="10"/>)人，
		  其中地厅级及以上(<input type="text" name='地厅级以上人数' field="retiredCityNum" style="width:30" maxlength="10"/>)人；
		  70岁以上(<input type="text" name='70岁以上人数' field="retiredOldNum" style="width:30" maxlength="10"/>)人
		  </span>
	  </p>
  </td>
 </tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>


</div>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>
