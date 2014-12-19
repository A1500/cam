<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript" src="json.js"></script>
<script type="text/javascript" src="printUtil.js"></script>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
		String id=request.getParameter("id");
		String sorgCode=request.getParameter("sorgCode");
		String organCode=request.getParameter("organCode");
		String PrintDate=request.getParameter("PrintDate");
		String beginDate=request.getParameter("beginDate");
		String endDate=request.getParameter("endDate");
		String taskCode=request.getParameter("taskCode");
		String certType=request.getParameter("certType");
		String business=request.getParameter("business");
		if(sorgCode==null){
			sorgCode="";
		}
		if(organCode==null){
			organCode="";
		}
		if(business==null){
			business="";
		}
	%>
	var sorgId='<%=id%>';
	var sorgCode='<%=sorgCode%>';
	var organCode='<%=organCode%>';
	var PrintDate='<%=PrintDate%>';
	var beginDate='<%=beginDate%>';
	var endDate='<%=endDate%>';
	var taskCode='<%=taskCode%>';
	var certType='<%=certType%>';
	var business='<%=business%>';
	business=decodeURIComponent(business);
</script>
<script type="text/javascript">
var webObj;
var activeDocument;
var marksNames;
var tag=0;
var showMap = new L5.Map("java.util.HashMap");

/**
本方法 以实例的方式，约定说明模板、标签和数据的格式
**/
function init(){
	var nowFileName="";
	//取得文件名 和标签
	if(certType == '0'){
		nowFileName = "ungovBuildO.doc";
	}else{
		nowFileName = "ungovBuildC.doc";
	}
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;

	somUngovCertPrintDataset.setParameter("SORG_ID",sorgId);
	somUngovCertPrintDataset.setParameter("PrintDate",PrintDate);
	somUngovCertPrintDataset.setParameter("beginDate",beginDate);
	somUngovCertPrintDataset.setParameter("endDate",endDate);
	somUngovCertPrintDataset.setParameter("taskCode",taskCode);
	somUngovCertPrintDataset.setParameter("sorgCode",sorgCode);
	somUngovCertPrintDataset.setParameter("organCode",organCode);
	somUngovCertPrintDataset.setParameter("business",business);
	somUngovCertPrintDataset.load();
	somUngovCertPrintDataset.on("load",function(ds){
		showMap.put("cnName",ds.get("sorgName"));
		showMap.put("sorgCode",ds.get("sorgCode"));
		showMap.put("organCode",ds.get("organCode"));
		showMap.put("legalPeople",ds.get("legalPeople"));
		showMap.put("business",ds.get("business"));
		showMap.put("actArea",ds.get("actArea"));
		showMap.put("actArea",ds.get("actArea"));
		showMap.put("regMon",Chinese(ds.get("regMon")*10000));
		showMap.put("residence",ds.get("residence"));
		showMap.put("borgName",ds.get("borgName"));
		showMap.put("organName",ds.get("signOrgan"));
		showMap.put("beginDateY",ds.get("QYear"));
		showMap.put("beginDateM",ds.get("QMonth"));
		showMap.put("beginDateD",ds.get("QDay"));
		showMap.put("endDateY",ds.get("ZYear"));
		showMap.put("endDateM",ds.get("ZMonth"));
		showMap.put("endDateD",ds.get("ZDay"));
		if(certType == '0'){
			showMap.put("signDateY",ds.get("FYear"));
			showMap.put("signDateM",ds.get("FMonth"));
			showMap.put("signDateD",ds.get("FDay"));
		}else{
			showMap.put("signDate",ds.get("FYear")+"年"+ds.get("FMonth")+"月"+ds.get("FDay")+"日");
		}

		if(ds.get("sorgKind")=="1"){
			showMap.put("sorgKind","法人");
			showMap.put("legalPeopleName","法定代表人");
		}
		if(ds.get("sorgKind")=="2"){
			showMap.put("sorgKind","合伙");
			showMap.put("legalPeopleName","单位负责人");
		}
		if(ds.get("sorgKind")=="3"){
			showMap.put("sorgKind","个体");
			showMap.put("legalPeopleName","单位负责人");
		}
		getMarks();
		writeDoc(showMap);
		//设置文档为只读
		webObj.SetReadOnly(true,"");
		if(tag == 0){
			if(certType == '0'){
				var nowFileName = "ungovBuildO.doc";
				//webObj.AddPicFromUrl(L5.webPath + "/jsp/cams/sorg/comm/print/certPic/ungov/"+"ungovO.jpg",true,0,0,1,100,0);
			}else{
				var nowFileName = "ungovBuildC.doc";
				//webObj.AddPicFromUrl(L5.webPath + "/jsp/cams/sorg/comm/print/certPic/ungov/"+"ungovC.jpg",true,0,0,1,100,0);
			}
		}
		tag="1";
	});
}

function initBeforePrint(){
	//取得文件名 和标签
	var nowFileName="";
	if(certType == '0'){
		var nowFileName = "ungovBuildO.doc";
	}else{
		var nowFileName = "ungovBuildC.doc";
	}

	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;

		getMarks();
		writeDoc(showMap);
		print();
		tag="1";
}

/**
打印（参数可以控制是前台打印还是后台打印）
*/
function printdoc(isBackground) {
	 initBeforePrint();
}

//转换成大写日期(中文)
function getChinaDate(year,month,day){
	if(month.substring(0,1) == '0'){
		month = month.substring(1,month.length);
	}
	if(day.substring(0,1) == '0'){
		day = day.substring(1,day.length);
	}
	var   arrNum   =   ["O","一","二","三","四","五","六","七","八","九","十","十一","十二"];
	var   strTmp="";
	for(var   i=0,j=year.length;i<j;i++){
		strTmp   +=   arrNum[year.charAt(i)];
	}
	strTmp   +=   "年";
	strTmp   +=   arrNum[month]+"月";
	if(day<10)
	strTmp   +=   arrNum[day];
	else   if   (day   <20)
	strTmp   +=   "十"+arrNum[day-10];
	else   if   (day   <30   )
	strTmp   +=   "二十"+arrNum[day-20];
	else
	strTmp   +=   "三十"+arrNum[day-30];
	strTmp   +=   "日";
	return   strTmp;
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
	<model:dataset id="somUngovCertPrintDataset" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true" method="createCert">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert">
			<model:field name="QYear" />
			<model:field name="QMonth" />
			<model:field name="QDay" />
			<model:field name="ZYear" />
			<model:field name="ZMonth" />
			<model:field name="ZDay" />
			<model:field name="FYear" />
			<model:field name="FMonth" />
			<model:field name="FDay" />
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
