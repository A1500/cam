<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<script type="text/javascript" src="json.js"></script>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String userId = comExtUser.getUserId();
	String sorgId=request.getParameter("sorgId");
	String taskCode=request.getParameter("taskCode");
%>
<script type="text/javascript">
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var j=0;
	var cnName = "";
	var sorgCode = "";
	var linkPeople = "";
	var linkPhone = "";
	var meetingName = "";
	var meetingDate = "";
	var meetingPlace = "";
	var mainPeople = "";
	var shouldNum = "";
	var lastDate = "";
	var nextDate = "";
	var councilNum = "";
	var supervisorNum = "";
	var chiefNum = "";
</script>
<script type="text/javascript">
var webObj;
var activeDocument;
var marksNames;
var showMap=new L5.Map("java.util.HashMap");

/**
本方法 以实例的方式，约定说明模板、标签和数据的格式
**/
function init(){  
	//取得文件名 和标签    
	var nowFileName = "/jsp/ext/somsd/manage/printWord/fund/doc/election.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(L5.webPath+nowFileName);
	activeDocument = webObj.activeDocument;
	
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap=new L5.Map("java.util.HashMap");
	
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=", sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load', function(){
		showMap.put("cnName",somOrganDataSet.get("cnName"));
		showMap.put("sorgCode",somOrganDataSet.get("sorgCode"));
	
		var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
		somElectionDataSet.setParameter("SORG_ID@=", sorgId);
		somElectionDataSet.load();
		somElectionDataSet.on('load', function(){
		showMap.put("linkPeople",somElectionDataSet.get("linkPeople"));
		showMap.put("linkPhone",somElectionDataSet.get("linkPhone"));
		showMap.put("meetingName",somElectionDataSet.get("meetingName"));
		meetingPlace=somElectionDataSet.get("meetingPlace");
		meetingDate=somElectionDataSet.get("meetingDate")+meetingPlace;
		showMap.put("meetingDate",meetingDate);
		showMap.put("mainPeople",somElectionDataSet.get("mainPeople"));
		showMap.put("lastDate",somElectionDataSet.get("lastDate"));
		showMap.put("nextDate",somElectionDataSet.get("nextDate"));
		showMap.put("councilNum",somElectionDataSet.get("councilNum"));
		showMap.put("supervisorNum",somElectionDataSet.get("supervisorNum"));
		showMap.put("chiefNum",somElectionDataSet.get("chiefNum"));
		
			var aspForLiShi=L5.DatasetMgr.lookup("aspForLiShi");
				aspForLiShi.setParameter("SORG_ID@=", sorgId);
				aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00013");
				aspForLiShi.load();
				aspForLiShi.on('load', function(){
				var records=aspForLiShi.getAllRecords();
				for(var i=0;i<records.length;i++){
					var record =records[i];
					var lishi = record.get("name");
					var lishiSex=record.get("sex");
					if(lishiSex!=""){
					switch(lishiSex){
						case "1" : lishiSex = "男"; break;
						case "2" : lishiSex = "女"; break;
						default : lishiSex = "";
						}
					}
					var lishiAge=record.get("age");
					var lishiIffulltime=record.get("ifFulltime");
					var workName=record.get("workName");
					var workDuties=record.get("workDuties");
					var ifRetire=record.get("ifRetire");
					if(ifRetire!=""){
					switch(ifRetire){
					case "0" : ifRetire = "否"; break;
					case "1" : ifRetire = "是"; break;
					default : ifRetire = "";
						}
					}
					var lishirenshi=workName+workDuties+ifRetire;
					var lishiIffulltime=record.get("ifFulltime");
					if(lishiIffulltime!=""){
					switch(lishiIffulltime){
					case "0" : lishiIffulltime = "专职"; break;
					case "1" : lishiIffulltime = "兼职"; break;
					default : lishiIffulltime = "";
						}
					}
					var relative=record.get("relative");
					var sorgDuties=record.get("sorgDuties");
					
					showMap.put("lishi"+i,lishi);
					showMap.put("lishiAge"+i,lishiAge);
					showMap.put("lishiSex"+i,lishiSex);
					showMap.put("lishiIffulltime"+i,lishiIffulltime);
					showMap.put("lishirenshi"+i,lishirenshi);	
					showMap.put("lishiIffulltime"+i,lishiIffulltime);
					showMap.put("relative"+i,relative);	
						
			}
			
			
		var aspForJianShi=L5.DatasetMgr.lookup("aspForJianShi");
				aspForJianShi.setParameter("SORG_ID@=", sorgId);
				aspForJianShi.setParameter("SORG_DUTIES", "00006");
				aspForJianShi.load();
				aspForJianShi.on('load', function(){
				var records=aspForJianShi.getAllRecords();
				for(var i=0;i<records.length;i++){
					var record =records[i];
					var jianshi = record.get("name");
					var jianshiSex=record.get("sex");
					if(jianshiSex!=""){
					switch(jianshiSex){
						case "1" : jianshiSex = "男"; break;
						case "2" : jianshiSex = "女"; break;
						default : jianshiSex = "";
						}
					}
					var jianshiAge=record.get("age");
					var workName2=record.get("workName");
					var workDuties2=record.get("workDuties");
					var ifRetire2=record.get("ifRetire");
					if(ifRetire2!=""){
					switch(ifRetire2){
					case "0" : ifRetire2 = "否"; break;
					case "1" : ifRetire2 = "是"; break;
					default : ifRetire2 = "";
						}
					}
					var jianshirenshi=workName2+workDuties2+ifRetire2;
					var sorgDuties=record.get("sorgDuties");
					
					showMap.put("jianshi"+i,jianshi);
					showMap.put("jianshiAge"+i,jianshiAge);
					showMap.put("lishiSex"+i,lishiSex);
					showMap.put("jianshirenshi"+i,jianshirenshi);
				
			}
			
			var CurrentDataset=L5.DatasetMgr.lookup("CurrentDataset");
				CurrentDataset.setParameter("SORG_ID@=", sorgId);
				CurrentDataset.setParameter("SORG_DUTIES@in", "00001,00003,00004,00013");
				CurrentDataset.load();
				CurrentDataset.on('load', function(){
				var records=CurrentDataset.getAllRecords();
				for(var i=0;i<records.length;i++){
				
					var record =records[i];
					var name = record.get("name");
					var sex=record.get("sex");
					
					if(sex!=""){
					switch(sex){
						case "1" : sex = "男"; break;
						case "2" : sex = "女"; break;
						default : sex = "";
						}
					}
					var age=record.get("age");
					var workName=record.get("workName");
					var workDuties=record.get("workDuties");
					var ifRetire=record.get("ifRetire");
					if(ifRetire!=""){
					switch(ifRetire){
					case "0" : ifRetire = "否"; break;
					case "1" : ifRetire = "是"; break;
					default : ifRetire = "";
						}
					}
					var renshi=workName+workDuties+ifRetire;
					var ifFulltime=record.get("ifFulltime");
					if(ifFulltime!=""){
					switch(lishiIffulltime){
					case "0" : ifFulltime = "专职"; break;
					case "1" : ifFulltime = "兼职"; break;
					default : ifFulltime = "";
						}
					}
					var sorgDuties=record.get("sorgDuties");
					if(sorgDuties==00001)//理事长
						{
							showMap.put("lishizhang",name);
							showMap.put("lishizhangAge",age);
							showMap.put("lishizhangSex",sex);
							showMap.put("lishizhangIffulltime",ifFulltime);
							showMap.put("lishizhangrenshi",renshi);	
						}
					else if(sorgDuties==00004)//秘书长
						{
							showMap.put("mishuzhang",name);
							showMap.put("mishuzhangAge",age);
							showMap.put("mishuzhangSex",sex);
							showMap.put("mishuzhangIffulltime",ifFulltime);
							showMap.put("mishuzhangrenshi",renshi);	
						}
					else if(sorgDuties=="00003"||sorgDuties=="00013")
						{  
							showMap.put("fulishizhang"+j,name);
							showMap.put("fulishizhangAge"+j,age);
							showMap.put("fulishizhangSex"+j,sex);
							showMap.put("fulishizhangIffulltime"+j,ifFulltime);
							showMap.put("fulishizhangrenshi"+j,renshi);	
							j++;
						}
			}
			
			getMarks();
			writeDoc(showMap);
								});
						});
				});
		});
	});
}
  
function writeDoc(mp){
	//遍历map的值
	for(var key in mp.map)
	{
		//var getMapMark = mp.get(key);
		//分割标签
		var marks=marksNames.split("&");
		//遍历所有标签
		for(var i=0;i<marks.length;i++)
		{
				//分离标签和标记
				var marksStr = marks[i].split("__");
				//标签和预含义标签相等的场合
				if(marksStr[0]==key)
				{
					//获取标签值
		  			var bkmkObj = activeDocument.Bookmarks(marks[i]);
					//向模板中写数据
					if(bkmkObj)
					{
						var inputValue = mp.get(key);						
						var saverange = bkmkObj.Range;
						saverange.Text = inputValue;
						//saverange.InsertBefore(""); //之前写内容
						//saverange.InsertAfter("");  //之后写内容
					}		  			

			    }
		}
	
	}
}
/**
获得 模板中的标签并组成串 "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
*/        
function getMarks(){

	marksNames = "";
	var count = activeDocument.Bookmarks.Count;
	for(var i=1;i<=count;i++)
	{
		if(i<count){
			marksNames = marksNames + activeDocument.Bookmarks(i).Name + "&";
		}
		else{
			marksNames = marksNames + activeDocument.Bookmarks(i).Name;
		}
	}
	//alert(marksNames);
}




function  returnButton(){
	webObj = document.getElementById("webOfficeNt");
	webObj.close();
	//window.close();  //如果本界面为独立窗口显示，可放开这个注释
}
/**
打印（参数可以控制是前台打印还是后台打印）
*/
function printdoc(isBackground)
{
	var oldOption;	
	try
	{
		var objOptions =  activeDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = isBackground;
	}
	catch(err){};
	webObj.printout(true);
	try
	{
		var objOptions =  activeDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	}
	catch(err){};	
}
</script>
<title>打印</title>
</head>
<body >
<model:datasets>
	<model:dataset id="somElectionDataSet"cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd"method="queryElection" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="meetingName" type="string" rule="length{100}" />
			<model:field name="meetingDate" type="string" rule="length{10}" />
			<model:field name="meetingPlace" type="string" rule="length{100}" />
			<model:field name="mainPeople" type="string" rule="length{500}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="chiefNum" type="string" rule="length{6}" />
			<model:field name="councilNum" type="string" rule="length{6}" />
			<model:field name="supervisorNum" type="string" rule="length{6}" />			
		</model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--基金会基本信息验证 --%>
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true"  pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{10}" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true"  pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{10}" />
		</model:record>
	</model:dataset>
	<!-- 新增人员 -->
	<model:dataset id="peopleInsertDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{10}" />
			<model:field name="age" type="string" rule="length{2}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="relative" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 负责人 -->
	<model:dataset id="CurrentDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务 -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<!-- 人员简历 -->
	<model:dataset id="somResumeInsertDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>	
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeDS"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel  name="form" anchor="100% 100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" >
			<next:Html>
		   		<form id="Form1" >
					<table  cellspacing="0" width="100%">
			            <tr>
			               <td class="FieldLabel">
			               		<div style="width:130px"><span id="limit"></span></div>
			               </td>
			               <td class="FieldLabel">
			               		<div style="width:130px"><span id="evryPrt"></span></div>
			               </td>
				  		   <td class="FieldLabel">
				  		   		<button name="print" onclick="printdoc(false)">打印</button>
				  		   </td>
				  		   <td class="FieldLabel">
				  				<button name="close" onclick="returnButton()">关闭</button>
				  		   </td>
			            </tr>
			        </table>
			      <div id="divOjet" width="100%" height="100%" >
		              <object id="webOfficeNt" codebase="../../../ofcontrol/OfficeControl.cab#version=4,0,6,0" height="100%"
		                  width="100%" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" viewastext>
		                  <param name="_ExtentX" value="22728">
		                  <param name="_ExtentY" value="17039">
		                  <param name="BorderColor" value="-2147483632">
		                  <param name="BackColor" value="-2147483643">
		                  <param name="ForeColor" value="-2147483640">
		                  <param name="TitlebarColor" value="42768">
		                  <param name="TitlebarTextColor" value="0">
		                  <param name="BorderStyle" value="1">
		                  <param name="Titlebar" value="1">
		                  <param name="Toolbars" value="1">
		                  <param name="Caption" value="正文内容">
		                  <param name="ProductCaption" value="浪潮ECGAP">
		                  <param name="ProductKey" value="99820CD845CC062ECE8362C16BC825CDCA3B1C41">
		                  <param name="MakerCaption" value="山东浪潮齐鲁软件产业股份有限公司">
		                  <param name="MakerKey" value="57B3D598DFFAAE2EC83F4E49B6EB14A03769AF82">
		                  <param name="IsShowToolMenu" value="1">
		                  <param name="IsNoCopy" value="0">
		                  <param name="IsHiddenOpenURL" value="0">
		                  <param name="MaxUploadSize" value="0">
		                  <param name="Menubar" value="1">
		                  <param name="Statusbar" value="1">
		                  <param name="FileNew" value="-1">
		                  <param name="FileOpen" value="-1">
		                  <param name="FileClose" value="-1">
		                  <param name="FileSave" value="-1">
		                  <param name="FileSaveAs" value="-1">
		                  <param name="FilePrint" value="-1">
		                  <param name="FilePrintPreview" value="-1">
		                  <param name="FilePageSetup" value="-1">
		                  <param name="FileProperties" value="-1">
		                  <param name="IsStrictNoCopy" value="0">
		                  <param name="IsUseUTF8URL" value="0">
		                  <param name="MenubarColor" value="16777215">
		                  <param name="IsUseControlAgent" value="0">
		                  <param name="IsUseUTF8Data" value="0">
		                  <param name="IsSaveDocExtention" value="0">
		                  <param name="IsDirectConnect" value="0">
		                  <param name="SignCursorType" value="0">
		                  <param name="IsResetToolbarsOnOpen" value="0">
		                  <param name="IsSaveDataIfHasVDS" value="0">
		                  <param name="MenuButtonStyle" value="0">
		                  <param name="MenuButtonColor" value="16180947">
		                  <param name="MenuButtonFrameColor" value="14924434">
		                  <param name="MenuBarStyle" value="0">
		                  <param name="IsGetPicOnlyOnHandSign" value="0">
		                  <span >不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</span>
		              </object>
			 	</div>
		    </form>
		  </next:Html>
	  </next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>	
	
	
	
	
	