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
	String taskCode=request.getParameter("taskCode");
	String sorgId=request.getParameter("sorgId");
%>
<script type="text/javascript">
var taskCode='<%=taskCode%>';
var sorgId='<%=sorgId%>';

var cnName="";
var enName="";
var abName="";
var purpose="";
var business="";
var borgNameDispaly="";
var residence="";
var sorgPhone="";
var sorgPost="";
var actArea="";
var peopleNum="";
var unitsNum="";
var regMon="";
var moneySource="";

var appPeople="";
var appPhone="";
var appDate="";

var name="";
var birthday="";
var workName="";
var politics="";
var workDuties="";

var nameAs="";
var birthdayAs="";
var workNameAs="";
var politicsAs="";
var workDutiesAs="";
var sorgDuties="";

var heldOrgan="";
var heldorganPeople="";
var phone="";

</script>
<script type="text/javascript">
var webObj;
var activeDocument;
var marksNames;

/**
本方法 以实例的方式，约定说明模板、标签和数据的格式
**/
function init(){
	//取得文件名 和标签
	var nowFileName = "/jsp/ext/somsd/manage/printWord/group/doc/groupPrepare.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(L5.webPath+nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap=new L5.Map("java.util.HashMap");

	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', function(){


		showMap.put("appPeople",somApplyDataSet.get("appPeople"));
		showMap.put("appPhone",somApplyDataSet.get("appPhone"));
		showMap.put("appDate",somApplyDataSet.get("appDate"));

	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=", sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load', function(){

	 	showMap.put("cnName",somOrganDataSet.get("cnName"));
	 	showMap.put("enName",somOrganDataSet.get("enName"));
	 	showMap.put("abName",somOrganDataSet.get("abName"));
		showMap.put("purpose",somOrganDataSet.get("purpose"));
		showMap.put("business",somOrganDataSet.get("business"));
		showMap.put("residence",somOrganDataSet.get("residence"));
		showMap.put("sorgPhone",somOrganDataSet.get("sorgPhone"));
		showMap.put("sorgPost",somOrganDataSet.get("sorgPost"));
		showMap.put("actArea",somOrganDataSet.get("actArea"));
		showMap.put("peopleNum",somOrganDataSet.get("peopleNum"));
		showMap.put("unitsNum",somOrganDataSet.get("unitsNum"));
		showMap.put("regMon",somOrganDataSet.get("regMon"));
		showMap.put("moneySource",somOrganDataSet.get("moneySource"));
		showMap.put("buildStatus",somOrganDataSet.get("buildStatus"));
		showMap.put("absorpMember",somOrganDataSet.get("absorpMember"));


	var borgDataSet=L5.DatasetMgr.lookup("borgDataSet");
		borgDataSet.setParameter("includeCode", somOrganDataSet.get("borgName"));
		borgDataSet.load();
		borgDataSet.on('load', function(){
		showMap.put("borgNameDispaly",borgDataSet.get("text"));

	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
		somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
		somHeldPeopleDataSet.load();
		somHeldPeopleDataSet.on('load', function(){
		var records=somHeldPeopleDataSet.getAllRecords();
		for(var i=0;i<records.length;i++){
			var record =records[i];
			name = record.get("name");
			politics = record.get("politics");
			switch (politics){
			case "01" : politics = "中国共产党党员"; break;
			case "02" : politics = "中国共产党预备党员"; break;
			case "03" : politics = "中国共产主义青年团团员"; break;
			case "04" : politics = "中国国民党革命委员会会员"; break;
			case "05" : politics = "中国民主同盟盟员"; break;
			case "06" : politics = "中国民主建国会会员"; break;
			case "07" : politics = "中国民主促进会会员"; break;
			case "08" : politics = "中国农工民主党党员"; break;
			case "09" : politics = "中国致公党党员"; break;
			case "10" : politics = "九三学社社员"; break;
			case "11" : politics = "台湾民主自治同盟盟员"; break;
			case "12" : politics = "无党派民主人士"; break;
			case "13" : politics = "群众"; break;
			case "14" : politics = "其他"; break;
			default : politics = "";
	}
			birthday = record.get("birthday");
			workName = record.get("workName");
			workDuties = record.get("workDuties");
			showMap.put("name"+i,name);
		 	showMap.put("politics"+i,politics);
			showMap.put("birthday"+i,birthday);
			showMap.put("workName"+i,workName);
			showMap.put("workDuties"+i,workDuties);
		}

	var somAspchiefDataSet=L5.DatasetMgr.lookup("somAspchiefDataSet");
		somAspchiefDataSet.setParameter("SORG_ID@=", sorgId);
		somAspchiefDataSet.load();
		somAspchiefDataSet.on('load', function(){
		var records=somAspchiefDataSet.getAllRecords();
		for(var i=0;i<records.length;i++){
			var record =records[i];
			nameAs = record.get("name");
			politicsAs = record.get("politics");
			switch (politicsAs){
			case "01" : politicsAs = "中国共产党党员"; break;
			case "02" : politicsAs = "中国共产党预备党员"; break;
			case "03" : politicsAs = "中国共产主义青年团团员"; break;
			case "04" : politicsAs = "中国国民党革命委员会会员"; break;
			case "05" : politicsAs = "中国民主同盟盟员"; break;
			case "06" : politicsAs = "中国民主建国会会员"; break;
			case "07" : politicsAs = "中国民主促进会会员"; break;
			case "08" : politicsAs = "中国农工民主党党员"; break;
			case "09" : politicsAs = "中国致公党党员"; break;
			case "10" : politicsAs = "九三学社社员"; break;
			case "11" : politicsAs = "台湾民主自治同盟盟员"; break;
			case "12" : politicsAs = "无党派民主人士"; break;
			case "13" : politicsAs = "群众"; break;
			case "14" : politicsAs = "其他"; break;
			default : politicsAs = "";
	}
			birthdayAs = record.get("birthday");
			workNameAs = record.get("workName");
			workDutiesAs = record.get("workDuties");
			sorgDuties = record.get("sorgDuties");

			showMap.put("nameAs"+i,nameAs);
		 	showMap.put("politicsAs"+i,politicsAs);
			showMap.put("birthdayAs"+i,birthdayAs);
			showMap.put("workNameAs"+i,workNameAs);
			showMap.put("workDutiesAs"+i,workDutiesAs);
			showMap.put("sorgDuties"+i,sorgDuties);
		}


		var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
		somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
		somHeldOrganDataSet.load();
		somHeldOrganDataSet.on('load', function(){
		var records=somHeldOrganDataSet.getAllRecords();
		for(var i=0;i<records.length;i++){
			var record =records[i];
			name = record.get("name");

			showMap.put("heldOrgan"+i,name);

		}
		getMarks();
		writeDoc(showMap);
							});
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
	<!-- 业务 -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="appPeople" type="string" rule="length{72}" />
			<model:field name="appPhone" type="string" rule="length{30}" />
			<model:field name="acceptPeopleName" type="string" rule="length{100}" />
			<model:field name="acceptOpinion" type="string" rule="length{500}"/>
			<model:field name="examinPeopleName" type="string" rule="length{30}" />
			<model:field name="examinOpinion" type="string" rule="length{30}" />
			<model:field name="checkPeopleName" type="string" rule="length{30}" />
			<model:field name="checkOpinion" type="string" rule="length{30}" />
			<model:field name="auditPeopleName" type="string" rule="length{30}" />
			<model:field name="auditOpinion" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<!-- 社会组织 -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="english|length{100}" />
			<model:field name="abName" type="string" rule="english|length{50}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgPhone" type="string" rule="length{30}" />
			<model:field name="sorgPost" type="string" rule="length{6}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="peopleNum" type="string" rule="integer|length{6}" />
			<model:field name="unitsNum" type="string" rule="integer|length{6}" />
			<model:field name="borgName" type="string" rule="length{100}" />
			<model:field name="regMon" type="string" rule="double|length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{2000}" />
			<model:field name="buildStatus" type="string" rule="length{500}" />
			<model:field name="absorpMember" type="string" rule="length{2000}" />
		</model:record>
	</model:dataset>
	<!-- 发起人 -->
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="length{72}" />
			<model:field name="sex" type="string" rule="length{1}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="politics" type="string" rule="length{2}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
			<model:field name="ifChief" type="string" rule="length{1}" />
		</model:record>
	</model:dataset>
	<!-- 发起单位 -->
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<!-- 拟任负责人 -->
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="sex" type="string" rule="length{1}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="politics" type="string" rule="length{2}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="sorgDuties" type="string" rule="length{50}" />
		</model:record>
	</model:dataset>
	<!-- 附件 -->
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
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
		              <object id="webOfficeNt" codebase="../../ofcontrol/OfficeControl.cab#version=4,0,6,0" height="100%"
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
