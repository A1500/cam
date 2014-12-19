 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	String method = (String)request.getParameter("method");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<link href="css/prosthesisapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	//初始化
 	 var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
 	var taskCode='<%=taskCode%>';
 	var method='<%=method%>';
	function init(){
		if(method=="INSERT"){
			ds.setParameter("TASK_CODE@=", taskCode);
			ds.load();
			ds.on('load',function(ds){
				if(ds.getCount()==0){
					ds.newRecord({"taskCode":taskCode,"corporationType":"2","morgArea":organArea,"morgName":organName});
				}
			});
		}else{
			ds.setParameter("TASK_CODE@=", taskCode);
			ds.load();
			document.getElementById("companyName").setAttribute("disabled","true");
			document.getElementById("serialNum").setAttribute("disabled","true");
		}
	}
	function save(){
		var logoffValidate = ds.isValidate();
		if(logoffValidate != true){
			L5.Msg.alert("提示",logoffValidate);
			return "break";
		}
		var logoffRecord=ds.getCurrent();
		logoffRecord.set("regDate",'<%=DateUtil.getTime()%>');
		var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitLogoffCommand");
		command.setParameter("record", logoffRecord);
		command.execute("welfarecorpSaveCancel");
		if (!command.error) {
			alert("保存成功！");	
			method="UPDATE";
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	//回填信息
	function fillInfo(){
		var wealUnitStatusDataSet = L5.DatasetMgr.lookup("wealUnitStatusDataSet");
		wealUnitStatusDataSet.setParameter("SERIAL_NUM@=",_$("serialNum"));
		if(_$("serialNum")!=""){
			wealUnitStatusDataSet.load();
		}
		wealUnitStatusDataSet.on('load',function(ds){
			if(ds.getCount()>0){
				document.getElementById("companyName").value=ds.getAt(0).get("companyName");
				//document.getElementById("legalPeople").value=ds.getAt(0).get("legalPeople");
				ds.set("companyName",selected[0].get('companyName'));
			}else{
				document.getElementById("companyName").value="";
				document.getElementById("serialNum").value="";
			}
		});
	}
	//第一页返回按钮
	function back(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/cancel/unitCancelList.jsp';
		L5.forward(url);
	}
	//************************************弹出窗口方法开始
	//点击企业名称弹出企业列表
	function queryFitList(){
		var win=L5.getCmp('unitWin');
		win.show();
		dsWin.setParameter("WEAL_UNIT_STATUS.STATUS@=","1");//加载状态正常
		dsWin.load();
	}
	function getParam(ElementId){
		var value=document.getElementById(ElementId).value;
		if(value=="") value=undefined;
		return value;
	}
	function cancel(){
		var record=ds.getCurrent();
		if(record.get("ifConfirm")=="1"){
			alert("此记录已经注销,不可重复注销!");
			return false;
		}
		L5.MessageBox.confirm('确定', '确定要注销选中的记录吗?注销后数据无法恢复!',function(state){
			if(state=="yes"){
				var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitLogoffCommand");
				command.setParameter("record", record);
				command.execute("wealfarecorpCancel");
				if (!command.error) {
					alert("注销成功！");	
				}else{
					L5.Msg.alert('提示',"注销时出现错误！"+command.error);
				}
			}else{
				return false;
			}
		});
	}
	function query(){
		dsWin.setParameter("WEAL_UNIT_STATUS.STATUS@=","1");//加载状态正常
		dsWin.setParameter("WEAL_UNIT_STATUS.SERIAL_NUM@=",getParam("serialNumQuery"));		
		dsWin.setParameter("WEAL_UNIT_STATUS.COMPANY_NAME@LIKE",getParam("companyNameQuery"));		
		//dsWin.setParameter("WEAL_UNIT_STATUS.LEGAL_PEOPLE@=",getParam("legalPeopleQuery"));
		dsWin.load();
	}
	function confirmWin(){
		var editGrid=L5.getCmp('editGridPanel');
		var selected=editGrid.getSelectionModel().getSelections();
		if(selected.length!=1){
			L5.Msg.alert('提示',"请选择一条企业记录进行注销备案!");
			return false;
		}else{
			document.getElementById("companyName").value=selected[0].get('companyName');
			document.getElementById("serialNum").value=selected[0].get('serialNum');
			ds.set("companyName",selected[0].get('companyName'));
			ds.set("serialNum",selected[0].get('serialNum'));
			closeWin();
		}
	}
	function closeWin(){
		var win = L5.getCmp("unitWin");
		win.hide();
	}
</script>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitLogoffQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitLogoff">
			<model:field name="companyName" type="string" rule="require" />	
			<model:field name="linkman" type="string" rule="require" />
			<model:field name="phone" type="string" rule="require" />
			<model:field name="logoffDate" type="string" rule="require" />
			<model:field name="logoffReason" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务状态表 -->
	<model:dataset id="wealUnitStatusDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="dsWin" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:20px;"  onclick="save()"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="back()"/>
	<input type="button" value="确认注销" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="cancel()"/>
</div>
<form method="post"  onsubmit="return false" dataset="ds">
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<div class=WordSection1>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>社会福利企业<span
lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>注销</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:18.0pt;mso-bidi-font-size:
10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
2.0pt'>备案表<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt'><o:p>&nbsp;</o:p></span></b></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=544
 style='width:408.0pt;margin-left:-14.6pt;border-collapse:collapse;border:none;
 mso-border-alt:solid windowtext .5pt;mso-padding-alt:0cm 1.4pt 0cm 1.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:26.0pt'>
  <td width=117 colspan=2 style='width:88.0pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:2.0pt'>企业名称<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=188 colspan=2 style='width:140.65pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><input id="companyName" field="companyName" title="企业名称" style="width:98%;" onclick="queryFitList()"/></o:p></span></p>
  </td>
  <td width=94 style='width:70.85pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:7.4pt;
  mso-pagination:widow-orphan;text-autospace:none;vertical-align:bottom'><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:2.0pt'>字<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;</span></span>号<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=145 style='width:108.5pt;border:solid windowtext 1.0pt;border-left:
  none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><input id="serialNum" field="serialNum" title="编号" style="width:98%;" onblur="fillInfo();"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:26.0pt'>
  <td width=117 colspan=2 style='width:88.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:2.0pt'>联
  系 人<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=188 colspan=2 style='width:140.65pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><input id="linkman" field="linkman" title="联系人" style="width:98%;"/></o:p></span></p>
  </td>
  <td width=94 style='width:70.85pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal align=center style='text-align:center;text-indent:7.4pt;
  mso-pagination:widow-orphan;text-autospace:none;vertical-align:bottom'><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:2.0pt'>联系电话<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=145 style='width:108.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:26.0pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'><o:p><input id="phone" field="phone" title="联系电话" style="width:98%;"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:30.6pt'>
  <td width=117 colspan=2 style='width:88.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:30.6pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:2.0pt'>注销时间<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width=427 colspan=4 style='width:320.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:30.6pt'>
  <p class=MsoNormal style='text-autospace:none;vertical-align:bottom'><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:
  宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:6.0pt'><span
  style='mso-spacerun:yes'><input name='注销时间' field="logoffDate" id='logoffDate'	readonly="readonly" format="Y-m-d" onclick="LoushangDate(this)" style="width:98%;"/></span><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:261.4pt'>
  <td width=43 style='width:32.0pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:261.4pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6pt'>注<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6pt'>销<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:2.8pt'>原<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal align=right style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span style='font-size:14.0pt;
  mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6pt'>因<span lang=EN-US><o:p></o:p></span></span></p>

  </td>
  <td width=501 colspan=5 style='width:376.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:261.4pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6.0pt'><o:p><textarea id="logoffReason" field="logoffReason"  validateName="注销原因" style="width:98%;height:260pt;font-size:12	pt;"></textarea></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;mso-yfti-lastrow:yes;height:107.65pt'>
  <td width=277 colspan=3 valign=top style='width:208.0pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:107.65pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><span style='mso-spacerun:yes'>&nbsp;</span></span><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:3.0pt'>法定代表人<span lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  3.0pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span><span
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:3.0pt'>签 章：</span><span lang=EN-US
  style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
  "Times New Roman";letter-spacing:6.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span><o:p></o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:1.0pt'>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:
  宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:6.0pt'><o:p></o:p></span></p>
  </td>
  <td width=267 colspan=3 valign=top style='width:200.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 1.4pt 0cm 1.4pt;height:107.65pt'>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:3.0pt'>企业盖章<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
  vertical-align:bottom'><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
  6.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=right style='text-align:right;mso-pagination:widow-orphan;
  text-autospace:none;vertical-align:bottom'><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";
  letter-spacing:6.0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:14.0pt;mso-bidi-font-size:10.0pt;
  font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:1.0pt'>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:
  宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:6.0pt'><o:p></o:p></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=43 style='border:none'></td>
  <td width=75 style='border:none'></td>
  <td width=160 style='border:none'></td>
  <td width=28 style='border:none'></td>
  <td width=94 style='border:none'></td>
  <td width=145 style='border:none'></td>
 </tr>
 <![endif]>
</table>

</div>

<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>

</div>
</form>
<next:Window id="unitWin" title="选择要注销的企业" width="650" height="400" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" >
		<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
						class="GroupBoxTitle">查询条件 <img
						class="GroupBoxExpandButton"
						src="<%=SkinUtils.getImage(request,
										"groupbox_collapse.gif")%>"
						onclick="collapse(this)" /> </legend>
					<div>
						<form style="width: 95%; height: 100%;" class="L5form">
							<table  border="1" width="100%" >
								<tr >
									<td class="FieldLabel">编号:</td>
									<td class="FieldInput"><input type="text"  id="serialNumQuery" class="TextEditor" title="编号"  /></td>	
									<td class="FieldLabel">企业名称:</td>
									<td class="FieldInput"><input type="text"  id="companyNameQuery" class="TextEditor" title="企业名称"  /></td>	
									<td class="FieldLabel"><button onclick="query()">查 询</button></td>
								</tr>
								<tr>
									<td class="FieldLabel">法人代表:</td>
									<td class="FieldInput"><input type="text"  id="legalPeopleQuery" class="TextEditor" title="法人代表"  /></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>	
									<td class="FieldLabel"><button type="reset">重 置</button></td>
								</tr>
							</table>
						</form>
					</div>
		</fieldset>
		</next:Html>
	</next:Panel>
	
	<next:GridPanel id="editGridPanel" name="wealfitstatusGrid" width="98%" stripeRows="true" height="300" dataset="dsWin" autoScroll="true" title="企业列表">
		<next:TopBar>
			<next:ToolBarItem text="企业列表" ></next:ToolBarItem>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="save" handler="confirmWin"/>
			<next:ToolBarItem text="关闭" iconCls="return" handler="closeWin" />
		</next:TopBar>
		<next:Columns>
		    <next:RowNumberColumn width="30"/>
		    <next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="fitId" header="FIT_ID" field="fitId" width="90" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
		
			<next:Column id="taskCode" header="TASK_CODE" field="taskCode" width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="status" header="STATUS" field="status" width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="nextChagneCert" header="nextChagneCert" field="nextChagneCert " width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="applyYear" header="APPLY_YEAR" field="applyYear" width="90" hidden="true">
				<next:TextField  />
			</next:Column>
		
			<next:Column id="serialNumCol" header="编号" field="serialNum" width="150" >
				<next:TextField  />
			</next:Column>
		
			<next:Column id="companyNameCol" header="企业名称" field="companyName" width="150" >
				<next:TextField allowBlank="false" />
			</next:Column>
			
			<next:Column id="legalPeople" header="法人代表" field="legalPeople" width="90" >
				<next:TextField  />
			</next:Column>
			
			<next:Column id="address" header="注册地址" field="address" width="200" >
				<next:TextField  />
			</next:Column>
			
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="dsWin"/>
		</next:BottomBar>
	</next:GridPanel>
</next:Window>
</body>
</html>