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
	String changId = (String)request.getParameter("changId");
	String method = (String)request.getParameter("method");
	String serialNum = (String)request.getParameter("serialNum");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
	if(changId==null){
		changId=IdHelp.getUUID32();
	}
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<link href="../apply/prosthesisQualification/css/prosthesisapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	//初始化
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var taskCode='<%=taskCode%>';
	var changId='<%=changId%>';
	var method='<%=method%>';
	var serialNum='<%=serialNum%>';
	function init(){
		if(method=="INSERT"){
			ds.setParameter("TASK_CODE@=", taskCode);
			ds.load();
			ds.on('load',function(ds){
				if(ds.getCount()==0){
					ds.newRecord({"changId":changId,"taskCode":taskCode,"corporationType":"1"});
				}
			});
		}else{
			ds.setParameter("TASK_CODE@=", taskCode);
			ds.load();
			dsWin.setParameter("SERIAL_NUM@=", serialNum);
			dsWin.load();
			document.getElementById("companyName").setAttribute("disabled","true");
			document.getElementById("serialNum").setAttribute("disabled","true");
			listDetail();
		}
	}
	
	function listDetail(){
		detailds.setParameter("CHANG_ID@=", changId);
		detailds.load();
		detailds.on('load',function(detailds){
			for(var i=0;i < detailds.getCount();i++){
				document.getElementById('itemCode'+i).value = detailds.getAt(i).get("itemCode");
				document.getElementById('itemName'+i).value = detailds.getAt(i).get("itemName");
				document.getElementById('itemBefore'+i).value = detailds.getAt(i).get("itemBefore");
				document.getElementById("itemBefore"+i).setAttribute("disabled","true");
				document.getElementById('itemAfter'+i).value = detailds.getAt(i).get("itemAfter");
			}
		});
	}
	function save(){
		var changeRecord=ds.getCurrent();
		if(changeRecord.get("ifConfirm")=="1"){
			L5.Msg.alert('提示',"此记录已经变更,不可保存!");
			return false;
		}
		var changerecordValidate = ds.isValidate();
		if(changerecordValidate != true){
			L5.Msg.alert("提示",changerecordValidate);
			return "break";
		}
		var statusRecord=dsWin.getCurrent();
		changeRecord.set("regDate",'<%=DateUtil.getTime()%>')
		for(var i=0;i<=2;i++){
			var itemCode = document.getElementById('itemCode'+i).value;
			var itemBefore = document.getElementById('itemBefore'+i).value;
			var itemAfter = document.getElementById('itemAfter'+i).value;
			if(itemCode!=""){
				for(var j=i+1;j<=2;j++){
					var itemCode2 = document.getElementById('itemCode'+j).value;
					if(itemCode==itemCode2){
						alert("变更事项不可重复");
						return false;
					}
				}
			}	
			//if(itemCode=="3"){
			//	if(!isNaN(itemAfter)){ 
					
			//	}else{
			//		alert("变更注册资金应为数字");
			//		return false;
			//	}
			//}
		};  
		for(var i=0;i<=2;i++){
			var detaildsI = L5.DatasetMgr.lookup("detailds"+i);
			if(document.getElementById("itemCode"+i).value!=""){
				var itemCode = document.getElementById("itemCode"+i).value;
				var itemName = document.getElementById("itemName"+i).value;
				var itemBefore = document.getElementById("itemBefore"+i).value;
				var itemAfter = document.getElementById("itemAfter"+i).value;
				detaildsI.newRecord({"itemCode":itemCode,"itemName":itemName,"itemBefore":itemBefore,"itemAfter":itemAfter});
			}else{
				detaildsI.newRecord();
			}
		}
		var changeRecordDetail = new Array();
		for(var i=0;i<=2;i++){
			var detaildsI = L5.DatasetMgr.lookup("detailds"+i);
			var d = detaildsI.getCurrent();
			if(detaildsI.getAt(0).get("itemCode")!=""){
				changeRecordDetail.push(d);
			}
		}
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.change.cmd.FitChangeCmd");
		command.setParameter("changeRecord", changeRecord);
		command.setParameter("changeRecordDetail", changeRecordDetail);
		command.setParameter("statusRecord", statusRecord);
		command.execute("saveFitChange");
		if (!command.error) {
			method="UPDATE";
			L5.Msg.alert('提示',"保存成功！");
			init();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	function submit(){
		var changeRecord=ds.getCurrent();
		if(changeRecord.get("ifConfirm")==""){
			L5.Msg.alert('提示',"请先保存企业变更信息!");
			return false;
		}
		if(changeRecord.get("ifConfirm")=="1"){
			L5.Msg.alert('提示',"此记录已经变更,不可重复变更!");
			return false;
		}
		L5.MessageBox.confirm('确定', '确定要变更选中的记录吗?',function(state){
			if(state=="yes"){
				var command = new L5.Command("com.inspur.cams.welfare.prosthesis.change.cmd.FitChangeCmd");
				command.setParameter("changeRecord", changeRecord);
				command.execute("submitFitChange");
				if (!command.error) {
					L5.Msg.alert('提示',"变更成功！");
					init();
				}else{
					L5.Msg.alert('提示',"保存变更时出现错误！"+command.error);
				}
			}else{
				return false;
			}
		});
	}
	//第一页返回按钮
	function back(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/prosthesis/change/fitChangeList.jsp';
		L5.forward(url);
	}
	//************************************弹出窗口方法开始
	//点击企业名称弹出企业列表
	function queryFitList(){
		var win=L5.getCmp('fitWin');
		win.show();
		dsWin.setParameter("WEAL_FIT_STATUS.STATUS@=","1");//加载状态正常
		dsWin.load();
	}
	function getParam(ElementId){
		var value=document.getElementById(ElementId).value;
		if(value=="") value=undefined;
		return value;
	}
	function query(){
		dsWin.setParameter("WEAL_FIT_STATUS.STATUS@=","1");//加载状态正常
		dsWin.setParameter("WEAL_FIT_STATUS.SERIAL_NUM@=",getParam("serialNumQuery"));		
		dsWin.setParameter("WEAL_FIT_STATUS.COMPANY_NAME@LIKE",getParam("companyNameQuery"));		
		dsWin.setParameter("WEAL_FIT_STATUS.LEGAL_PEOPLE@=",getParam("legalPeopleQuery"));
		dsWin.load();
	}
	function confirmWin(){
		var editGrid=L5.getCmp('editGridPanel');
		var selected=editGrid.getSelectionModel().getSelections();
		if(selected.length!=1){
			L5.Msg.alert('提示',"请选择一条企业记录进行变更备案!");
			return false;
		}else{
			document.getElementById("companyName").value=selected[0].get('companyName');
			document.getElementById("serialNum").value=selected[0].get('serialNum');
			document.getElementById("serialNum").setAttribute("disabled","true");
			ds.set("companyName",selected[0].get('companyName'));
			ds.set("serialNum",selected[0].get('serialNum'));
			closeWin();
		}
	}
	function closeWin(){
		var win = L5.getCmp("fitWin");
		win.hide();
	}
	function detail(id){
		var itemCode = document.getElementById('itemCode'+id).value;
		if(document.getElementById("companyName").value==""){
			alert("请先选择企业名称");
			init();
		}
		document.getElementById("itemAfter"+id).value="";
		var selectIndex = document.getElementById('itemCode'+id).selectedIndex;
		var itemName = document.getElementById('itemCode'+id).options[selectIndex].text; 
		if(itemCode!=""){
			document.getElementById("itemName"+id).value=itemName;
		}
		if(itemCode==""){
			document.getElementById("itemBefore"+id).value="";
		}else if(itemCode==0){
			document.getElementById("itemBefore"+id).value=document.getElementById("companyName").value;
		}else if(itemCode==1){
			document.getElementById("itemBefore"+id).value=document.getElementById("legalPeople").value;	
		}else if(itemCode==2){
			document.getElementById("itemBefore"+id).value=document.getElementById("address").value;
		}
		//else if(itemCode==3){
		//	document.getElementById("itemBefore"+id).value=document.getElementById("regFund").value;
		//}
		document.getElementById("itemBefore"+id).setAttribute("disabled","true");
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
	<!-- 变更备案表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecord">
			<model:field name="companyName" type="string" rule="require" />	
			<model:field name="linkman" type="string" rule="require" />
			<model:field name="phone" type="string" rule="require" />
			<model:field name="changeReason" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 变更备案明细表0 -->
	<model:dataset id="detailds0" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecordDetail">
		</model:record>
	</model:dataset>
	<!-- 变更备案明细表1 -->
	<model:dataset id="detailds1" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecordDetail">
		</model:record>
	</model:dataset>
	<!-- 变更备案明细表2 -->
	<model:dataset id="detailds2" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecordDetail">
		</model:record>
	</model:dataset>
	<!-- 变更备案明细表3 -->
	<model:dataset id="detailds3" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecordDetail">
		</model:record>
	</model:dataset>
	<model:dataset id="detailds" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecordDetail">
		</model:record>
	</model:dataset>
	<model:dataset id="dsWin" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus"></model:record>
	</model:dataset>
	<!-- 变更事项 -->
	<model:dataset id="somChangeItem" enumName="SOM.CHANGE.ITEM2"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:20px;"  onclick="save()"/>
	<input type="button" value="确认变更" style="height:25px;width:80px;position:absolute;margin-left:120px;"  onclick="submit()"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back()"/>
</div>
<form method="post"  onsubmit="return false" >
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
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>假肢和矫形器生产装配企业<span
lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>事项变更</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:18.0pt;mso-bidi-font-size:
10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
2.0pt'>备案表<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt'><o:p>&nbsp;</o:p></span></b></p>

<div align=center>

<table border=0 cellpadding=0 cellspacing=0 width=678 class=unnamed1 style='border-collapse:
 collapse;table-layout:fixed;width:510pt' >
 <col width=79 style='mso-width-source:userset;mso-width-alt:2528;width:59pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:2752;width:65pt'>
 <col width=72 style='width:54pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3008;width:71pt'>
 <col width=72 style='width:54pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:2976;width:70pt'>
 <col width=72 style='width:54pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:3520;width:83pt'>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' dataset="ds">
  <td colspan=2 height=52 class=unnamed1 width=165 style='border-right:.5pt solid black;
  height:39.0pt;width:124pt'>企业名称</td>
  <td colspan=2 class=unnamed1 width=166 style='border-right:.5pt solid black;
  border-left:none;width:125pt'><div align="left"><input id="companyName" field="companyName" title="企业名称" style="width:98%;" onclick="queryFitList()"/></div>　</td>
  <td colspan=2 class=unnamed1 width=165 style='border-right:.5pt solid black;
  border-left:none;width:124pt'>编号</td>
  <td colspan=2 class=unnamed1 width=182 style='border-right:.5pt solid black;
  border-left:none;width:137pt'><div align="left"><input id="serialNum" field="serialNum" title="编号" style="width:98%;" /></div>　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' dataset="ds">
  <td colspan=2 height=52 class=unnamed1 width=165 style='border-right:.5pt solid black;
  height:39.0pt;width:124pt'>联系人</td>
  <td colspan=2 class=unnamed1 width=166 style='border-right:.5pt solid black;
  border-left:none;width:125pt'><div align="left"><input id="linkman" field="linkman" title="联系人" style="width:98%;" /></div>　</td>
  <td colspan=2 class=unnamed1 width=165 style='border-right:.5pt solid black;
  border-left:none;width:124pt'>联系电话</td>
  <td colspan=2 class=unnamed1 width=182 style='border-right:.5pt solid black;
  border-left:none;width:137pt'><div align="left"><input id="phone" field="phone" title="联系电话" style="width:98%;" /></div>　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td colspan=2 height=52 class=unnamed1 width=165 style='border-right:.5pt solid black;
  height:39.0pt;width:124pt'><div align="center">变更事项</div></td>
  <td colspan=3 class=unnamed1 width=238 style='border-right:.5pt solid black;
  border-left:none;width:179pt'><div align="center">变更前</div></td>
  <td colspan=3 class=unnamed1 width=275 style='border-right:.5pt solid black;
  border-left:none;width:207pt'><div align="center">变更后</div></td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' dataset="detailds0">
  <td colspan=2 height=52 class=xl65 style='border-right:.5pt solid black;
  height:39.0pt'><select
						id=itemCode0 field="itemCode" title="变更事项" onchange="detail('0');">
						<option dataset="somChangeItem"></option>
					</select>　
					<input id="itemName0" field="itemName" title="变更事项名称" style="width:98%;display:none" />
					</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemBefore0" field="itemBefore" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemAfter0" field="itemAfter" title="变更后" style="width:98%;" />　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' dataset="detailds1">
  <td colspan=2 height=52 class=unnamed1 style='border-right:.5pt solid black;
  height:39.0pt'><select
						id=itemCode1 field="itemCode" title="变更事项" onchange="detail('1');">
						<option dataset="somChangeItem"></option>
					</select>　
					<input id="itemName1" field="itemName" title="变更事项名称" style="width:98%;display:none" />
					</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemBefore1" field="itemBefore" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemAfter1" field="itemAfter" title="变更后" style="width:98%;" />　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' dataset="detailds2">
  <td colspan=2 height=52 class=unnamed1 style='border-right:.5pt solid black;
  height:39.0pt'><select
						id=itemCode2 field="itemCode" title="变更事项" onchange="detail('2');">
						<option dataset="somChangeItem"></option>
					</select>　
					<input id="itemName2" field="itemName" title="变更事项名称" style="width:98%;display:none" />
					</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemBefore2" field="itemBefore" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemAfter2" field="itemAfter" title="变更后" style="width:98%;" />　</td>
 </tr>
 <%-- <tr height=52 style='mso-height-source:userset;height:39.0pt' dataset="detailds3">
  <td colspan=2 height=52 class=unnamed1 style='border-right:.5pt solid black;
  height:39.0pt'><select
						id=itemCode3 field="itemCode" title="变更事项" onchange="detail('3');">
						<option dataset="somChangeItem"></option>
					</select>　
					<input id="itemName3" field="itemName" title="变更事项名称" style="width:98%;display:none" />
					</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemBefore3" field="itemBefore" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><input id="itemAfter3" field="itemAfter" title="变更后" style="width:98%;" />　</td>
 </tr>
 --%>
 <tr height=40 style='mso-height-source:userset;height:30.0pt' dataset="ds">
  <td rowspan=5 height=200 class=unnamed1 width=79 style='border-bottom:.5pt solid black;
  height:150.0pt;border-top:none;width:59pt'><div align="center"><p>变</p>
						<p>&nbsp;</p>
						<p align="center">更</p>
						<p>&nbsp;</p>
						<p align="center">理</p>
						<p>&nbsp;</p>
						<p align="center">由</p></div></td>
  <td valign="top" colspan=7 rowspan=5 class=unnamed1 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'><textarea id="changeReason" field="changeReason"  title="变更理由" style="width:98%;height:75%;"></textarea>　</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt' dataset="ds">
  <td colspan=4 rowspan=8 height=192 class=xl79 width=331 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:144.0pt;width:249pt'><span
  style='mso-spacerun:yes'>&nbsp;</span>法定代表人<br>
    <br>
    <span style='mso-spacerun:yes'>&nbsp;</span>签 章：<br>
    <span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>年<span style='mso-spacerun:yes'>&nbsp;&nbsp; </span>月<span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span>日</td>
  <td colspan=4 rowspan=8 class=xl79 width=347 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:261pt'>企业盖章<br>
    <br>
    <span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>年<span style='mso-spacerun:yes'>&nbsp;&nbsp; </span>月<span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span>日<br>
    </td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'  dataset="dsWin">
 <input id="legalPeople" field="legalPeople" style="display:none;" />
 <input id="address" field="address" style="display:none;" />
 <input id="businessScope" field="businessScope" style="display:none;" />
 <input id="regFund"  field="regFund" style="display:none;" />
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
</table>

</div>

<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>

</div>
</form>
<next:Window id="fitWin" title="选择要变更的企业" width="650" height="400" autoHeight="true" resizable="false" closeAction="hide" modal="true">
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
	
	<next:GridPanel id="editGridPanel" name="wealFitstatusGrid" width="98%" stripeRows="true" height="300" dataset="dsWin" autoScroll="true" title="企业列表">
		<next:TopBar>
			<next:ToolBarItem text="企业列表" ></next:ToolBarItem>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="save" handler="confirmWin"/>
			<next:ToolBarItem text="关闭" iconCls="return" handler="closeWin" />
		</next:TopBar>
		<next:Columns>
		    <next:RowNumberColumn width="30"/>
		    <next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="FitId" header="Fit_ID" field="fitId" width="90" hidden="true">
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
