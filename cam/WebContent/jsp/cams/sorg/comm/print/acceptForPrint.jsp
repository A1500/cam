<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="json.js"></script>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<%
	String cnName="";
	if(request.getParameter("cnName")!=null){
		cnName=request.getParameter("cnName");
	}
%>
<script type="text/javascript">
var cnName=decodeURIComponent('<%=cnName%>');
var taskCode='<%=request.getParameter("taskCode")%>';
var applyType='<%=request.getParameter("applyType")%>';
var sorgType='<%=request.getParameter("sorgType")%>';
var printPeople='<%=BspUtil.getEmpOrgan().getOrganName()%>';
var sendAddress='<%=BspUtil.getDeptOrgan().getOrganName()%>';
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
	var nowFileName = "accept.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");
	if(applyType=="001"){
		showMap.put("applyType","社会团体筹备核准");
		showMap.put("dayNum","40");
	}else if(applyType=="002"){
		showMap.put("applyType","社会团体成立登记");
		showMap.put("dayNum","20");
	}else if(applyType=="003"){
		showMap.put("applyType","社会团体变更登记");
		showMap.put("dayNum","7");
	}else if(applyType=="004"){
		showMap.put("applyType","社会团体注销登记");
		showMap.put("dayNum","20");
	}else if(applyType=="005"){
		showMap.put("applyType","社会团体分支（代表）机构设立登记");
		showMap.put("dayNum","40");
	}else if(applyType=="006"){
		showMap.put("applyType","社会团体分支（代表）机构变更登记");
		showMap.put("dayNum","7");
	}else if(applyType=="007"){
		showMap.put("applyType","社会团体分支（代表）机构注销登记");
		showMap.put("dayNum","20");
	}else if(applyType=="012"){
		showMap.put("applyType","社会团体登记证书补办、印章补刻");
		showMap.put("dayNum","20");
	}else if(applyType=="013"){
		showMap.put("applyType","社会团体分支（代表）机构登记证书补办、印章补刻");
		showMap.put("dayNum","20");
	}else if(applyType=="014"){
		showMap.put("applyType","社会团体年度检查");
		showMap.put("dayNum","7");
	}else if(applyType=="011"){
		showMap.put("applyType","社会团体异地设立分支（代表）机构的审查");
		showMap.put("dayNum","30");
	}else if(applyType=="000"){
		showMap.put("applyType","社会团体申请名称核准");
		showMap.put("dayNum","30");
	}

	else if(applyType=="101"||applyType=="105"||applyType=="106"){
		showMap.put("applyType","民办非企业单位成立登记");
		showMap.put("dayNum","40");
	}else if(applyType=="102"){
		showMap.put("applyType","民办非企业单位变更登记");
		showMap.put("dayNum","40");
	}else if(applyType=="103"){
		showMap.put("applyType","民办非企业单位注销登记");
		showMap.put("dayNum","20");
	}else if(applyType=="112"){
		showMap.put("applyType","民办非企业单位登记证书补办、印章补刻");
		showMap.put("dayNum","20");
	}else if(applyType=="114"){
		showMap.put("applyType","民办非企业单位年度检查");
		showMap.put("dayNum","7");
	}else if(applyType=="100"){
		showMap.put("applyType","民办非企业单位申请名称核准");
		showMap.put("dayNum","30");
	}

	else if(applyType=="201"){
		showMap.put("applyType","基金会设立登记");
		showMap.put("dayNum","40");
	}else if(applyType=="202"){
		showMap.put("applyType","基金会变更登记");
		showMap.put("dayNum","20");
	}else if(applyType=="203"){
		showMap.put("applyType","基金会注销登记");
		showMap.put("dayNum","20");
	}else if(applyType=="204"){
		showMap.put("applyType","基金会分支（代表）机构设立登记");
		showMap.put("dayNum","40");
	}else if(applyType=="205"){
		showMap.put("applyType","基金会分支（代表）机构变更登记");
		showMap.put("dayNum","20");
	}else if(applyType=="206"){
		showMap.put("applyType","基金会分支（代表）机构注销登记");
		showMap.put("dayNum","20");
	}else if(applyType=="212"){
		showMap.put("applyType","基金会登记证书补办、印章补刻");
		showMap.put("dayNum","20");
	}else if(applyType=="213"){
		showMap.put("applyType","基金会分支（代表）机构登记证书补办、印章补刻");
		showMap.put("dayNum","20");
	}else if(applyType=="214"){
		showMap.put("applyType","基金会年度检查");
		showMap.put("dayNum","7");
	}else if(applyType=="210"){
		showMap.put("applyType","基金会异地设立分支（代表）机构的审查");
		showMap.put("dayNum","30");
	}else if(applyType=="200"){
		showMap.put("applyType","基金会申请名称核准");
		showMap.put("dayNum","30");
	}

	if(sorgType == "S"){
		showMap.put("fileName","《社会团体登记管理条例》");
	}else if(sorgType == "M"){
		showMap.put("fileName","《民办非企业单位登记管理暂行条例》");
	}else if(sorgType == "J"){
		showMap.put("fileName","《基金会管理条例》");
	}

	var printTime=new Date();
	var printTimeY=(printTime).getYear();
	var printTimeM=(printTime).getMonth()+1;
	if(printTimeM<10){
		printTimeM='0'+printTimeM;
	}
	var printTimeD=(printTime).getDate();
	if(printTimeD<10){
		printTimeD='0'+printTimeD;
	}
	var h=(printTime).getHours();
	if(h<10){
		h='0'+h;
	}
	var m=(printTime).getMinutes();
	if(m<10){
		m='0'+m;
	}
	var s=(printTime).getSeconds();
	if(s<10){
		s='0'+s;
	}
	printTime=printTime+" "+h+":"+m+":"+s;
	showMap.put("printTime",printTime);
	showMap.put("printTimeY",printTimeY);
	showMap.put("printTimeM",printTimeM);
	showMap.put("printTimeD",printTimeD);
	showMap.put("printPeople",printPeople);

	showMap.put("acceptFileNo","acceptFileNo");

	if(cnName==""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomApplyCmd");
		command.setParameter("TASK_CODE",taskCode);
		command.execute("queryApplyNoAccept");
		cnName = command.getReturn("cnName");
	}
	//var appDateY = command.getReturn("appDateY");
	//var appDateM = command.getReturn("appDateM");
	//var appDateD = command.getReturn("appDateD");
	showMap.put("cnName",cnName);
	showMap.put("appDateY",printTimeY);
	showMap.put("appDateM",printTimeM);
	showMap.put("appDateD",printTimeD);
	showMap.put("sendAddress",sendAddress);
	showMap.put("taskCodeBar","*"+taskCode);
	showMap.put("taskCode",taskCode);
	showMap.put("signOrgan",sendAddress);
	getMarks();
	writeDoc(showMap);
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
		              <object id="webOfficeNt" codebase="ofcontrol/OfficeControl.cab#version=4,0,6,0" height="100%"
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
