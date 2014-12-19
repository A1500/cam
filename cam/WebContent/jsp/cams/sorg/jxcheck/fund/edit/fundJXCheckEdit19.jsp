<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会 </title>
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
				//加载国际会议数据
				var somCheckInterMeetingDataSet = L5.DatasetMgr.lookup("somCheckInterMeetingDataSet");
				somCheckInterMeetingDataSet.setParameter("TASK_CODE", taskCode);
				//somCheckInterMeetingDataSet.setParameter("ORGAN_TYPE", "D");//代表机构
				somCheckInterMeetingDataSet.load();
				somCheckInterMeetingDataSet.on('load',function(ds){
					var count = ds.getCount();
					if(count == 0){
						somCheckInterMeetingDataSet.newRecord({"taskCode":taskCode});
						for(i=0;i<3;i++){
							addTrOfInternationalMeeting();
						}
					}else{		
						for(i=1;i<=ds.getCount();i++){
							addTrOfInternationalMeeting();
							document.getElementById("meetingName"+i).value=ds.getAt(i-1).get("meetingName");
							document.getElementById("meetingDate"+i).value=ds.getAt(i-1).get("meetingDate");
							document.getElementById("meetingPlace"+i).value=ds.getAt(i-1).get("meetingPlace");
							document.getElementById("hostOrganName"+i).value=ds.getAt(i-1).get("hostOrganName");
							document.getElementById("fundsSource"+i).value=ds.getAt(i-1).get("fundsSource");
						}
					}
				});
			
				//加载国组织数据
				var somCheckInterOrgDataSet = L5.DatasetMgr.lookup("somCheckInterOrgDataSet");
					somCheckInterOrgDataSet.setParameter("TASK_CODE", taskCode);
					//somCheckInterOrgDataSet.setParameter("ORGAN_TYPE", "D");//代表机构
					somCheckInterOrgDataSet.load();
					somCheckInterOrgDataSet.on('load',function(ds){
						var count = ds.getCount();
						if(count == 0){
							somCheckInterOrgDataSet.newRecord({"taskCode":taskCode});
							for(i=0;i<3;i++){
								addTrOfInternationalOrganization();
							}
						}else{		
							for(i=1;i<=ds.getCount();i++){
								addTrOfInternationalOrganization();
								document.getElementById("orgCnName"+i).value=ds.getAt(i-1).get("orgCnName");
								document.getElementById("orgEnName"+i).value=ds.getAt(i-1).get("orgEnName");
								document.getElementById("joinDate"+i).value=ds.getAt(i-1).get("joinDate");
								document.getElementById("dutyType"+i).value=ds.getAt(i-1).get("dutyType");
								document.getElementById("auditOrganName"+i).value=ds.getAt(i-1).get("auditOrganName");
							}
						}
					});
					//创建页面导航下拉框
				createFundEditSelect();
			}
			function save(){
				var somCheckInterMeetingDataSet = getSomCheckInterMeetingDataSet();
				var somCheckInterOrgDataSet = getSomCheckInterOrgDataSet();
				var somCheckInterMeetingRecords = somCheckInterMeetingDataSet.getAllRecords();
				var somCheckInterOrgRecords = somCheckInterOrgDataSet.getAllRecords();
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
				command.setParameter("somCheckInterMeetingRecords", somCheckInterMeetingRecords);
				command.setParameter("somCheckInterOrgRecords", somCheckInterOrgRecords);
				command.setParameter("taskCode", taskCode);
				command.execute("savePageJ19");
				if (!command.error) {
					L5.Msg.alert("提示","保存成功！",function(){
					});		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
			function previousPage(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/fund/edit/fundJXCheckEdit18.jsp';
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
			//获取国际会议dataset
			function getSomCheckInterMeetingDataSet(){
				var tab=document.getElementById("internationalMeeting");
				var somCheckInterMeetingDataSet = L5.DatasetMgr.lookup("somCheckInterMeetingDataSet");
				somCheckInterMeetingDataSet.removeAll();
				var count = 1;
				var item = 0;
				do{
					var somCheckInterMeetingRecord= somCheckInterMeetingDataSet.newRecord();
					somCheckInterMeetingRecord.set("taskCode",taskCode);
					var i = 0;
					for(i= item+1;i<=tab.rows.length;i++){
						if(document.getElementById("meetingName"+i)==null){
							continue;
						}else{
							item = i;
							break;
						}
					}
					somCheckInterMeetingRecord.set("meetingName",document.getElementById("meetingName"+i).value);
					somCheckInterMeetingRecord.set("meetingDate",document.getElementById("meetingDate"+i).value);
					somCheckInterMeetingRecord.set("meetingPlace",document.getElementById("meetingPlace"+i).value);
					somCheckInterMeetingRecord.set("hostOrganName",document.getElementById("hostOrganName"+i).value);
					somCheckInterMeetingRecord.set("fundsSource",document.getElementById("fundsSource"+i).value);
					count++;
				}while(count <tab.rows.length);
				return somCheckInterMeetingDataSet;
			}
			//获取国际组织dataset
			function getSomCheckInterOrgDataSet(){
				var tab=document.getElementById("internationalOrganization");
				var somCheckInterOrgDataSet = L5.DatasetMgr.lookup("somCheckInterOrgDataSet");
				somCheckInterOrgDataSet.removeAll();
				var count = 1;
				var item = 0;
				do{
					var somCheckInterOrgRecord= somCheckInterOrgDataSet.newRecord();
					somCheckInterOrgRecord.set("taskCode",taskCode);
					var i = 0;
					for(i=item+1;i<=tab.rows.length;i++){
						if(document.getElementById("orgCnName"+i)==null){
							continue;
						}else{
							item = i;
							break;
						}
					}
					somCheckInterOrgRecord.set("orgCnName",document.getElementById("orgCnName"+i).value);
					somCheckInterOrgRecord.set("orgEnName",document.getElementById("orgEnName"+i).value);
					somCheckInterOrgRecord.set("joinDate",document.getElementById("joinDate"+i).value);
					somCheckInterOrgRecord.set("auditOrganName",document.getElementById("auditOrganName"+i).value);
					somCheckInterOrgRecord.set("dutyType",document.getElementById("dutyType"+i).value);
					count++;
				}while(count <tab.rows.length);
				return somCheckInterOrgDataSet;
			}
			
			function checkData(){
				
			}
			//增加一行方法
			function addTrOfInternationalMeeting(){
				 var tab=document.getElementById("internationalMeeting");
			    //添加行
			    var newTR = tab.insertRow(tab.rows.length);
			    //trid++;
			    //获取序号=行索引
			    var  xuhao=newTR.rowIndex.toString();
			    newTR.id = "internationalMeeting"+xuhao;
			    //添加列:序号
			    var newNameTD=newTR.insertCell(0);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = xuhao;
			    //添加列:会议名称
			    var newNameTD=newTR.insertCell(1);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='会议名称' id='meetingName"+xuhao+"'  style='width:70.9pt;' maxlength='100'/></o:p></span></p>";
			    //添加列:会议时间
			    var newNameTD=newTR.insertCell(2);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='会议时间' id='meetingDate"+xuhao+"' style='width:77.95pt;' format='Y-m-d' onclick='LoushangDate(this)'/></o:p></span></p>";
			    //添加列:会议地点
			    var newNameTD=newTR.insertCell(3);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='会议地点' id='meetingPlace"+xuhao+"' style='width:72.0pt;' maxlength='100'/></o:p></span></p>";
			 	//添加列:主办方名称
			    var newNameTD=newTR.insertCell(4);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			   newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='主办方名称' id='hostOrganName"+xuhao+"' style='width:125.0pt;' maxlength='100'/></o:p></span></p>";
				//添加列:我方经费来源
			    var newNameTD=newTR.insertCell(5);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			   newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><select name='我方经费来源' id='fundsSource"+xuhao+"'><option value =''>请选择… …</optoion>"+
			   "<option value ='1'>政府资助</optoion><option value ='2'>外方资助</optoion><option value ='3'>自负费用</optoion><option value ='4'>境内其他单位资助</optoion><option value ='5'>个人资助</optoion><option value ='6'>其他</optoion></select></o:p></span></p>";
				//添加列:操作
			    var newNameTD=newTR.insertCell(6);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;' onclick=\"deltr(\'internationalMeeting\',\'internationalMeeting"+ xuhao + "')\">删除</a></o:p></span></p>";
			}
			
			//增加一行方法
			function addTrOfInternationalOrganization(){
				 var tab=document.getElementById("internationalOrganization");
			    //添加行
			    var newTR = tab.insertRow(tab.rows.length);
			    //trid++;
			    //获取序号=行索引
			     var  xuhao=newTR.rowIndex.toString();
			    newTR.id = "internationalOrganization"+xuhao;
			    //添加列:序号
			    var newNameTD=newTR.insertCell(0);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = xuhao;
			    //添加列:国际组织名称（中）
			    var newNameTD=newTR.insertCell(1);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><input type='text' name='国际组织中文全称'  id='orgCnName"+xuhao+"'  style='width:99.25pt;font-weight:normal;mso-bidi-font-weight:bold;' maxlength='100'/></p>";
			    //添加列:国际组织名称（英）
			    var newNameTD=newTR.insertCell(2);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='国际组织英文全称' id='orgEnName"+xuhao+"' style='width:99.25pt;font-weight:normal;mso-bidi-font-weight:bold;' maxlength='100'/></o:p></span></p>";
			    //添加列:参加时间
			    var newNameTD=newTR.insertCell(3);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='参加时间' id='joinDate"+xuhao+"' style='width:77.95pt;font-weight:normal;mso-bidi-font-weight:bold;' format='Y-m-d' onclick='LoushangDate(this)'/></o:p></span></p>";
			 	//添加列:批准部门
			    var newNameTD=newTR.insertCell(4);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			   newNameTD.innerHTML = "<p class=MsoNormal  mso-line-height-rule: exactly'><span lang=EN-US><o:p><input name='批准部门' id='auditOrganName"+xuhao+"' style='width:70.85pt;font-weight:normal;mso-bidi-font-weight:bold;' maxlength='100'/></o:p></span></p>";
				//添加列:担任何职务
			    var newNameTD=newTR.insertCell(5);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			   newNameTD.innerHTML = "<p class=MsoNormal mso-line-height-rule: exactly'><span lang=EN-US><o:p><select name='担任职务' id='dutyType"+xuhao+"'><option value =''>请选择… …</optoion>"+
			   "<option value ='1'>领导职务</optoion><option value ='2'>专门委员会领导职务</optoion><option value ='3'>理事单位</optoion><option value ='4'>会员单位</optoion><option value ='5'>观察员</optoion><option value ='6'>其他职务</optoion></select></o:p></span></p>";
				//添加列:操作
			    var newNameTD=newTR.insertCell(6);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p class=MsoNormal mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><a href='javascript:;' onclick=\"deltr(\'internationalOrganization\',\'internationalOrganization"+ xuhao + "')\">删除</a></o:p></span></p>";
			}
			
			
			function deltr(table,trid){
			 	var tab=document.getElementById(table);
			    var row=document.getElementById(trid);    
			    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
			    tab.deleteRow(index);  //从table中删除
			    //重新排列序号
			    var nextid;
			    for(i=index;i<tab.rows.length;i++){
			        tab.rows[i].cells[0].innerHTML = i.toString();
			    }
			}
		</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckInterMeetingDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.cmd.SomJxCheckInterMeetingQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeeting"></model:record>
	</model:dataset>
	<model:dataset id="somCheckInterOrgDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.cmd.SomJxCheckInterOrgQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrg"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('18')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="save()" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="backJ();" />
</div>

<div align="center">
<div class=Section1 style='width: 800;text-align:center' >
<p class=MsoNormal align=center style='margin-top:7.8pt;margin-right:0cm;
margin-bottom:7.8pt;margin-left:-42.5pt;mso-para-margin-top:.5gd;mso-para-margin-right:
0cm;mso-para-margin-bottom:.5gd;mso-para-margin-left:-4.05gd;text-align:center;
text-indent:36.0pt;mso-char-indent-count:2.0'><strong><span lang=EN-US
style='font-size:18.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;
mso-bidi-font-weight:bold'>2</span></strong><strong><span style='font-size:
18.0pt;mso-bidi-font-size:12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'>．参加国际会议情况</span></strong><strong><span lang=EN-US style='font-size:18.0pt;
mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
<div align="left">
<button onclick="addTrOfInternationalMeeting()">增加一行</button></div>
<table id="internationalMeeting" class=MsoNormalTable align=center border=1 cellspacing=0 cellpadding=0 width="800"
 style='border-collapse:collapse;border:none;mso-border-alt:
 solid windowtext .5pt;mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:27.7pt'>
  <td width=57 valign="middle" style='width:42.55pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.7pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>序号</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=95 valign="middle" style='width:70.9pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.7pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>会议名称</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=104 valign="middle" style='width:77.95pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.7pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>会议时间</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=94 valign="middle" style='width:70.65pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.7pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>会议地点</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=139 valign="middle" style='width:104.15pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.7pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>主办方名称</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=139 valign="middle" style='width:104.15pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.7pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>我方经费来源</span><strong><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=113 valign="middle" style='width:3.0cm;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>操作</span><strong><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><strong><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;
mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></strong></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0'><strong><span
lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;
mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></strong></p>

<p class=MsoNormal align=center style='margin-top:7.8pt;margin-right:0cm;
margin-bottom:7.8pt;margin-left:-49.55pt;mso-para-margin-top:.5gd;mso-para-margin-right:
0cm;mso-para-margin-bottom:.5gd;mso-para-margin-left:-4.72gd;text-align:center;
text-indent:36.0pt;mso-char-indent-count:2.0'><strong><span lang=EN-US
style='font-size:18.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;
mso-bidi-font-weight:bold'>3. </span></strong><strong><span style='font-size:
18.0pt;mso-bidi-font-size:12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'>参加国际组织情况</span></strong><strong><span lang=EN-US style='font-size:18.0pt;
mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>

<div align="left"  >
<button onclick="addTrOfInternationalOrganization()">增加一行</button></div>
<table id="internationalOrganization" class=MsoNormalTable align=center border=1 cellspacing=0 cellpadding=0 width=800
 style='border-collapse:collapse;border:
 none;mso-border-alt:solid windowtext .5pt;mso-yfti-tbllook:480;mso-padding-alt:
 0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.5pt solid windowtext;mso-border-insidev:
 .5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:41.65pt'>
  <td width=57 valign="middle" style='width:42.55pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><strong><span style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman";font-weight:normal;mso-bidi-font-weight:bold'>序号</span></strong><strong><span
  lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:
  normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=132 valign="middle" style='width:99.25pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>国际组织名称（中文全称）</span><strong><span lang=EN-US
  style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;
  mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=132 valign="middle" style='width:99.25pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>国际组织名称（英文全称）</span><strong><span lang=EN-US
  style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;
  mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=104 valign="middle" style='width:77.95pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>参加时间</span><strong><span lang=EN-US style='font-size:14.0pt;
  mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=94 valign="middle" style='width:70.85pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>批准部门</span><strong><span lang=EN-US style='font-size:14.0pt;
  mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=113 valign="middle" style='width:3.0cm;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>担任何职务</span><strong><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
  <td width=113 valign="middle" style='width:3.0cm;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:41.65pt'>
  <p class=MsoNormal><span style='font-size:14.0pt;mso-bidi-font-size:12.0pt;
  font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>操作</span><strong><span lang=EN-US style='font-size:
  14.0pt;mso-bidi-font-size:12.0pt;font-weight:normal;mso-bidi-font-weight:
  bold'><o:p></o:p></span></strong></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
12.0pt'><o:p>&nbsp;</o:p></span></p>

</div>
</div>
</body>
</html>
