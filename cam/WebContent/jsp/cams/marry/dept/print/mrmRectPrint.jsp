<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript" src="json.js"></script>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<%
	String applyId=request.getParameter("applyId");
%>
<script type="text/javascript">
var applyId='<%=applyId%>';
</script>
<model:datasets>
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true" 
		sortField="APPLY_TIME" sortDirection="desc">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
</model:datasets>
<script type="text/javascript">
var webObj;
var activeDocument;
var marksNames;

/**
本方法 以实例的方式，约定说明模板、标签和数据的格式
**/
function init(){  
	//取得文件名 和标签    
	var nowFileName = "mrmRectPrint.doc";
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(nowFileName);
	activeDocument = webObj.activeDocument;
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	var showMap = new L5.Map("java.util.HashMap");
	applyDataSet.setParameter("APPLY_ID@=",applyId);
	applyDataSet.load();
	applyDataSet.on('load',function (){
		if( applyDataSet.getCount() > 0 ){
			var record = applyDataSet.getCurrent();
			showMap.put("organName",record.get('organName'));
			showMap.put("organName1",record.get('organName'));
			showMap.put("applyLevel",getLevel(record.get('applyLevel')));
			showMap.put("cancelOrganName",record.get('cancelOrganName'));
			showMap.put("applyTime",record.get('applyTime'));
			showMap.put("applyLevel1",getLevel(record.get('applyLevel')));
			showMap.put("correctOrgan",record.get('correctOrgan'));
			showMap.put("correctDate",record.get('correctDate'));
			showMap.put("startLine",record.get('startLine'));
			showMap.put("deadLine",record.get('deadLine'));
			showMap.put("correctContent",record.get('correctContent'));
			showMap.put("correctResult",record.get('correctResult'));
			showMap.put("cityOpinion",record.get('cityOpinion'));
			showMap.put("cityAuditTime",getDayFormat(record.get('cityAuditTime')));
			showMap.put("provinceOpinion",record.get('provinceOpinion'));
			showMap.put("provinceAuditTime",getDayFormat(record.get('provinceAuditTime')));
			
			showMap.put("cityOrganName",record.get('cityOrganName'));
			showMap.put("provinceOrganName",record.get('provinceOrganName'));
			showMap.put("departmentOrganName",record.get('departmentOrganName'));
			showMap.put("organName2",record.get('organName'));
			
			getMarks();
			writeDoc(showMap);
		}else{
			L5.Msg.alert("提示","数据加载错误！");
			return false;
		}
	});
}
//2013-03-07
function getDayFormat(time){
	return time.substring(0,4)+"年"+time.substring(5,7)+"月"+time.substring(8,10)+"日";
}
function getLevel(value){
	if(value == "01"){
		return "国家3A级";
	}else if(value == "02"){
		return "国家4A级";
	}else if(value == "03"){
		return "国家5A级";
	}else {
		return "无";
	}  
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
