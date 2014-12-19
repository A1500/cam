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
	var nowFileName = "/jsp/ext/somsd/manage/printWord/group/doc/groupElection.doc";
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
	var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
	somElectionDataSet.setParameter("TASK_CODE@=",taskCode);
	somElectionDataSet.load();
	somElectionDataSet.on('load', function(){
		somAspchiefDataSet.setParameter("TASK_CODE",taskCode);
		somAspchiefDataSet.load();
		somAspchiefDataSet.on("load",function(){
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
			var ifMakeFee = "";
			var chiefNum = "";
			var otherDuties = "";//候选法定代表人兼任其他社团法定代表人情况（具体列出）
			var penal = "";//候选人受剥夺政治权利刑事处罚的情况（具体列出）
			//somOrganDataSet
			if(somOrganDataSet.getCount()>0){
				cnName = somOrganDataSet.get("cnName");//社团名称
				showMap.put("cnName",cnName);
				sorgCode = somOrganDataSet.get("sorgCode");//登记证号或批准筹备文号
				showMap.put("sorgCode",sorgCode);
			}
			//somElectionDataSet
			if(somElectionDataSet.getCount()>0){
				linkPeople = somElectionDataSet.get("linkPeople");//联系人
				showMap.put("linkPeople",linkPeople);
				linkPhone = somElectionDataSet.get("linkPhone");//联系电话
				showMap.put("linkPhone",linkPhone);
				meetingName = somElectionDataSet.get("meetingName");//会议名称
				showMap.put("meetingName",meetingName);
				meetingDate = somElectionDataSet.get("meetingDate");
				showMap.put("meetingDate",meetingDate);
				meetingPlace = somElectionDataSet.get("meetingPlace");//召开时间和地点
				showMap.put("meetingPlace",meetingPlace);
				mainPeople = somElectionDataSet.get("mainPeople");//参会主要人员
				showMap.put("mainPeople",mainPeople);
				shouldNum = somElectionDataSet.get("shouldNum");//参会人数
				showMap.put("shouldNum",shouldNum);
				lastDate = somElectionDataSet.get("lastDate");//上次换届时间
				showMap.put("lastDate",lastDate);
				nextDate = somElectionDataSet.get("nextDate");//应到届时间
				showMap.put("nextDate",nextDate);
				ifMakeFee = somElectionDataSet.get("ifMakeFee")=="0"?"否":"是";//是否制定或修改会费标准
				showMap.put("ifMakeFee",ifMakeFee);
				chiefNum = somElectionDataSet.get("chiefNum");//共　 人
				showMap.put("chiefNum",chiefNum);
			}
			//somAspchiefDataSet
			var dsCount = somAspchiefDataSet.getCount();
			var wordLength = 0;
			if(dsCount<7){
				wordLength = dsCount;
			}else if(dsCount>=7){
				wordLength = 7;
			}
			if(dsCount>0){
				var records = somAspchiefDataSet.getAllRecords();
				for(var i=0;i<wordLength;i++){
					showMap.put("name"+i,records[i].get("name"));//姓  名
					showMap.put("birthday"+i,records[i].get("birthday"));//出生年月
					showMap.put("politics"+i,changePolitics(records[i].get("politics")));//政治面貌
					showMap.put("populace"+i,records[i].get("populace"));//户口所在地
					showMap.put("sorgDuties"+i,changeSorgDuties(records[i].get("sorgDuties")));//拟任社团职务
					showMap.put("workName"+i,records[i].get("workName"));
					showMap.put("workDuties"+i,records[i].get("workDuties"));//人事关系所在单位及职务（职称）
					showMap.put("promiseOrgan"+i,records[i].get("promiseOrgan"));
					showMap.put("promiseCode"+i,records[i].get("promiseCode"));//批准兼职的组织人事部门及文号
					if(records[i].get("otherDuties")!=""){
						otherDuties = otherDuties+records[i].get("name")+":"+records[i].get("otherDuties")+"\n";//候选法定代表人兼任其他社团法定代表人情况（具体列出）
					}
					if(records[i].get("penal")!=""){
						penal = penal+records[i].get("name")+":"+records[i].get("penal")+"\n";//候选人受剥夺政治权利刑事处罚的情况（具体列出）
					}
				}
				otherDuties = otherDuties.trim();
				penal = penal.trim();
				showMap.put("otherDuties",otherDuties);
				showMap.put("penal",penal);
			}
			getMarks();
			writeDoc(showMap);
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

//将拟任社团职务由code转换成name
function changeSorgDuties(sorgDuties){
	var re = "";
	switch (sorgDuties){
	case "00001" : re = "理事长";break;
	case "00002" : re = "分支机构负责人";break;
	case "00003" : re = "副理事长";break;
	case "00004" : re = "秘书长";break;
    case "00005" : re = "理事";break;
	case "00006" : re = "监事";break;
	case "00007" : re = "会长";break;
	case "00008" : re = "副会长";break;
	case "00009" : re = "副会长兼秘书长";break;
	case "00010" : re = "副组长";break;
	case "00011" : re = "社长";break;
	case "00012" : re = "法定代表人";break;
	case "00013" : re = "副理事长兼秘书长";break;
	case "00014" : re = "主席";break;
	case "00015" : re = "副主席";break;
	default : re = "";
	}
	return re;
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="meetingName" type="string" rule="require|length{100}"/>
			<model:field name="meetingFormat" type="string" rule="length{30}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="idCard" type="string" rule="require|length{18}"/>
			<model:field name="name" type="string" rule="require|length{32}"/>
			<model:field name="birthday" type="string" rule="length{10}"/>
			<model:field name="populace" type="string" rule="length{100}"/>
			<model:field name="workName" type="string" rule="length{100}"/>
			<model:field name="workDuties" type="string" rule="length{50}"/>
			<model:field name="promiseOrgan" type="string" rule="length{100}"/>
			<model:field name="promiseCode" type="string" rule="length{100}"/>
			<model:field name="otherDuties" type="string" rule="length{500}"/>
			<model:field name="penal" type="string" rule="length{500}"/>
		</model:record>
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




