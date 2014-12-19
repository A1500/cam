<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript" src="json.js"></script>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
var penaltyInformDayNum='<%=request.getParameter("penaltyInformDayNum")%>';
var beginDate='<%=request.getParameter("beginDate")%>';
var endDate='<%=request.getParameter("endDate")%>';
var op='<%=request.getParameter("op")%>';
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
	var nowFileName = "";
	if(op==""){
		nowFileName = "penaltyInform.doc";
	}else if(op=="noCheck"){
		nowFileName = "penaltyInformNoCheck.doc";
	}else if(op=="noCheckTwo"){
		nowFileName = "penaltyInformNoCheckTwo.doc";
	}else if(op=="overScope"){
		nowFileName = "penaltyInformOverScope.doc";
	}else if(op=="penaltyPublic"){
		nowFileName = "penaltyInformPublic.doc";
	}
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;

	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");
	ds.setParameter("TASK_CODE",taskCode);
	ds.load();
	ds.on("load",function(ds){
		showMap.put("morgName",ds.get("morgName"));
		showMap.put("caseCodeYear",ds.get("caseCodeYear"));
		showMap.put("caseCode",ds.get("caseCode"));
		showMap.put("sorgName",ds.get("sorgName"));
		showMap.put("partyName",ds.get("partyName"));
		showMap.put("partyAdd",ds.get("partyAdd"));
		showMap.put("partyCharger",ds.get("partyCharger"));
		showMap.put("partyChargerDuties",ds.get("partyChargerDuties"));
		showMap.put("partyPhone",ds.get("partyPhone"));
		var regDate = ds.get("regDate").split("-");
		var regDateY = regDate[0];
		var regDateM = regDate[1];
		var regDateD = regDate[2];
		showMap.put("regDateY",regDateY);
		showMap.put("regDateM",regDateM);
		showMap.put("regDateD",regDateD);
		showMap.put("regName",ds.get("regName"));
		if(op=="overScope"){
			beginDate=beginDate.split("-");
			var beginDateY = beginDate[0];
			var beginDateM = beginDate[1];
			var beginDateD = beginDate[2];
			showMap.put("beginDateY",beginDateY);
			showMap.put("beginDateM",beginDateM);
			showMap.put("beginDateD",beginDateD);
			endDate=endDate.split("-");
			var endDateY = endDate[0];
			var endDateM = endDate[1];
			var endDateD = endDate[2];
			showMap.put("endDateY",endDateY);
			showMap.put("endDateM",endDateM);
			showMap.put("endDateD",endDateD);
		}
		showMap.put("penaltyInfact",ds.get("penaltyInfact"));
		showMap.put("penaltyDeregulation",ds.get("penaltyDeregulation"));
		showMap.put("penaltyProof",ds.get("penaltyProof"));
		var informDate = ds.get("informDate").split("-");
		var informDateY = informDate[0];
		var informDateM = informDate[1];
		var informDateD = informDate[2];
		showMap.put("informDateY",informDateY);
		showMap.put("informDateM",informDateM);
		showMap.put("informDateD",informDateD);
		var informNo=ds.get("informNo");
		if(informNo.indexOf("事")>-1){
			showMap.put("informName","《行政处罚事先告知书》");
		}else if(informNo.indexOf("听")>-1){
			showMap.put("informName","《行政处罚听证告知书》");
		}else
                 showMap.put("informName","  ");
		showMap.put("informContent",ds.get("informContent"));
		var ifAverment=ds.get("ifAverment");
		if(ifAverment=="0"){
			showMap.put("ifAverment","你单位未在规定期限内作出陈述、申辩。");
		}else if(ifAverment=="1"){
			showMap.put("ifAverment","本机关依法听取了你单位作出的相关陈述、申辩。");
		}
		var ifHearing=ds.get("ifHearing");
		if(ifHearing=="0"){
			showMap.put("ifHearing","你单位未在规定期限内提出听证要求。");
		}else if(ifHearing=="1"){
			hearingDate=ds.get("hearingDate").split("-");
			var hearingDateY=hearingDate[0];
			var hearingDateM=hearingDate[1];
			var hearingDateD=hearingDate[2];
			var hearingPartyCharger=ds.get("hearingPartyCharger");
			if(hearingPartyCharger=="1"){
				hearingPartyCharger="法定代表人";
			}else if(hearingPartyCharger=="2"){
				hearingPartyCharger="委托代理人";
			}
			var hearingPartyChargerName=ds.get("hearingPartyChargerName");
			ifHearing="根据你单位提出的听证要求，本机关依法于"+hearingDateY+"年"+hearingDateM+"月"+hearingDateD+"日对上述拟作出的处罚决定举行了听证，你单位"+hearingPartyCharger+hearingPartyChargerName+"参加了听证。";
			showMap.put("ifHearing",ifHearing);
		}
		showMap.put("penaltyReason",ds.get("penaltyReason"));
		showMap.put("penaltyResult",ds.get("penaltyResult"));
		showMap.put("dayNum",penaltyInformDayNum);
		var sorgType=ds.get("sorgType");
		if(sorgType=="S"){
			showMap.put("sorgType","社会团体");
		}else if(sorgType=="M"){
			showMap.put("sorgType","民办非企业单位");
		}else if(sorgType=="J"){
			showMap.put("sorgType","基金会");
		}
		showMap.put("penaltyBank",ds.get("penaltyBank"));
		showMap.put("penaltyBankAccount",ds.get("penaltyBankAccount"));
		showMap.put("penaltyReviewOrgan",ds.get("penaltyReviewOrgan"));
		showMap.put("penaltyReviewOrganOther",ds.get("penaltyReviewOrganOther"));
		showMap.put("linkmanAdd",ds.get("linkmanAdd"));
		showMap.put("linkmanPost",ds.get("linkmanPost"));
		showMap.put("linkmanName",ds.get("linkmanName"));
		showMap.put("linkmanPhone",ds.get("linkmanPhone"));
		var printTime=new Date();
		var printTimeY = printTime.getYear();
		var printTimeM = printTime.getMonth()+1;
		if(printTimeM<10){
			printTimeM='0'+printTimeM;
		}
		var printTimeD = printTime.getDate();
		if(printTimeD<10){
			printTimeD='0'+printTimeD;
		}
		showMap.put("printTimeY",printTimeY);
		showMap.put("printTimeM",printTimeM);
		showMap.put("printTimeD",printTimeD);
		showMap.put("lastYear",printTimeY-1);
		getMarks();
		writeDoc(showMap);
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenalty">
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
