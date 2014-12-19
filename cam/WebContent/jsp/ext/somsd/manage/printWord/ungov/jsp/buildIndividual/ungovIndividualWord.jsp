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
	var nowFileName = "/jsp/ext/somsd/manage/printWord/ungov/doc/ungovIndividualWord.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(L5.webPath+nowFileName);
	activeDocument = webObj.activeDocument;
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;

	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",loadInfo);
}

function loadInfo(){
	var LegalPeopleDataSet = L5.DatasetMgr.lookup("LegalPeopleDataSet");
	LegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
	LegalPeopleDataSet.setParameter("SORG_DUTIES","00012");//法人编号
	LegalPeopleDataSet.load();
	LegalPeopleDataSet.on("load",function(){
		var dutyId = LegalPeopleDataSet.get("dutyId");
		var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
		somResumeLegalDataSet.setParameter("DUTY_ID",dutyId);
		somResumeLegalDataSet.setParameter("TASK_CODE", taskCode);
		somResumeLegalDataSet.load();	
		somResumeLegalDataSet.on('load',function(){
			//somOrganDataSet
			if(somOrganDataSet.getCount()>0){
				var cnName = somOrganDataSet.get("cnName");//单位名称
				var sorgCode = somOrganDataSet.get("sorgCode");//登记证号
				showMap.put("cnName",cnName);
				showMap.put("sorgCode",sorgCode);
			}
			//somResumeLegalDataSet
			if(somResumeLegalDataSet.getCount()>0){
				var length = 0;
				var count = somResumeLegalDataSet.getCount();
				if(count<8){
					length = count;
				}else if(count>=8){
					length = 8;
				}
				var records = somResumeLegalDataSet.getAllRecords();
				for(var i=0;i<length;i++){
					var startDate = records[length-i-1].get("startDate");//开始年月
					var endDate = records[length-i-1].get("endDate");//结束年月
					var startEndDate = startDate+"至"+endDate;
					showMap.put("startEndDate"+i,startEndDate);//何年月至何年月（开始+至+结束）
					var workOrgan = records[length-i-1].get("workOrgan");
					showMap.put("workOrgan"+i,workOrgan);//在何地区何单位
					var duty = records[length-i-1].get("duty");
					showMap.put("duty"+i,duty);//任（兼）何职
				}
			}
			//LegalPeopleDataSet
			if(LegalPeopleDataSet.getCount()>0){
				var name = LegalPeopleDataSet.get("name");//姓    名
				var sex = LegalPeopleDataSet.get("sex")==1?"男":"女";//性别
				var politics = changePolitics(LegalPeopleDataSet.get("politics"));//政治面貌
				var education = changeEducation(LegalPeopleDataSet.get("education"));//文化程度
				var birthday = LegalPeopleDataSet.get("birthday");//出生日期
				var idCard = LegalPeopleDataSet.get("idCard");//身份证号
				var workDuties = LegalPeopleDataSet.get("workDuties");//职    务
				var profession = LegalPeopleDataSet.get("profession");//技术职称
				var populace = LegalPeopleDataSet.get("populace");//户口所在地
				var adds = LegalPeopleDataSet.get("adds");//家庭住址
				var postCode = LegalPeopleDataSet.get("postCode");//邮编
				var phone = LegalPeopleDataSet.get("phone");//电话
				var personUnit = LegalPeopleDataSet.get("personUnit");//人事关系所在单位
				var personUnitPhone = LegalPeopleDataSet.get("personUnitPhone");//电话
				var folkCode = LegalPeopleDataSet.get("folk");//民族(code)
				var folkSelect = L5.DatasetMgr.lookup("folkSelect");
				folkSelect.setParameter("include",folkCode);
				folkSelect.load();
				folkSelect.on("load",function(){
					var folk = folkSelect.get("text");
					
					showMap.put("name",name);
					showMap.put("sex",sex);
					showMap.put("politics",politics);
					showMap.put("education",education);
					showMap.put("birthday",birthday);
					showMap.put("idCard",idCard);
					showMap.put("workDuties",workDuties);
					showMap.put("profession",profession);
					showMap.put("populace",populace);
					showMap.put("adds",adds);
					showMap.put("postCode",postCode);
					showMap.put("phone",phone);
					showMap.put("personUnit",personUnit);
					showMap.put("personUnitPhone",personUnitPhone);
					showMap.put("folk",folk);
					
					getMarks();
					writeDoc(showMap);
				});
			}
		});
	});
}	

//将政治面貌由code转换成name
function changePolitics(politics){
	var po = "";
	switch (politics){
	case "01": po = "中国共产党党员";break;
	case "02": po = "中国共产党预备党员";break;
	case "03": po = "中国共产主义青年团团员";break;
	case "04": po = "中国国民党革命委员会会员";break;
	case "05": po = "中国民主同盟盟员";break;
	case "06": po = "中国民主建国会会员";break;
	case "07": po = "中国民主促进会会员";break;
	case "08": po = "中国农工民主党党员";break;
	case "09": po = "中国致公党党员";break;
	case "10": po = "九三学社社员";break;
	case "11": po = "台湾民主自治同盟盟员";break;
	case "12": po = "无党派民主人士";break;
	case "13": po = "群众";break;
	case "99": po = "其他";break;
	default : po = "";
	}
	return po;
}
//将文化程度由code转换成name
function changeEducation(education){
	var ed = ""
	switch (education){
	case "10" : ed = "研究生";break;
	case "20" : ed = "大学本科";break;
	case "30" : ed = "大学专科和专科学校";break;
	case "40" : ed = "中等专业学校或中等技术学校";break;
	case "50" : ed = "技工学校";break;
	case "60" : ed = "高中";break;
	case "70" : ed = "初中";break;
	case "80" : ed = "小学";break;
	case "90" : ed = "文盲或半文盲";break;
	case "99" : ed = "其他";break;
	default : ed = "";
	}
	return ed;
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
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="organCode" type="string" rule="length{10}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|length{100}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{1000}" />
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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