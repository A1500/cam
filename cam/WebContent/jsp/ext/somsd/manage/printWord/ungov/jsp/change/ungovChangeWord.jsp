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
	String id = request.getParameter("id");
%>
<script type="text/javascript">
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var id='<%=id%>';
	var changeItem;
	var changeBefore;
	var changeAfter;
	var changeReason;
	var changeDesc;
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
	var nowFileName = "/jsp/ext/somsd/manage/printWord/ungov/doc/ungovChangeWord.doc";
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
	somOrganDataSet.on('load', loadInfo);
}

function loadInfo(){
	var somChangeDataSet=L5.DatasetMgr.lookup("somChangeDataSet");
	somChangeDataSet.setParameter("ID@=",id);
	somChangeDataSet.load();//变更
	somChangeDataSet.on('load',function(){
		//somOrganDataSet
		if(somOrganDataSet.getCount()>0){
			var cnName = somOrganDataSet.get("cnName");//单位名称
			var sorgCode = somOrganDataSet.get("sorgCode");//登记证号
			showMap.put("cnName",cnName);
			showMap.put("sorgCode",sorgCode);
		}
		//somChangeDataSet
		if(somChangeDataSet.getCount()>0){
			var changeItem = somChangeDataSet.get("changeItem");
			if(changeItem=="0"){//变更名称
				putSomChange();
			}else if(changeItem=="1"){//变更住所
				putSomChange();
				var changeBefores=changeBefore.split(';');
				var houseSourceBefore1 = changeBefores[0];//住所来源
				var houseNameBefore1 = changeBefores[4];//住所名称
				var houseBorgBefore1 = changeBefores[2];//产权单位
				var houseAreaBefore1 = changeBefores[3];//用房面积
				var houseDateBefore1 = changeBefores[1];//租借期限
				var changeAfters=changeAfter.split(';');
				var houseSourceAfter1 = changeAfters[0];
				var houseNameAfter1 = changeAfters[4];
				var houseBorgAfter1 = changeAfters[2];
				var houseAreaAfter1 = changeAfters[3];
				var houseDateAfter1 = changeAfters[1];
				//改变showMap中 变更前，变更后的值
				var newChangeBefore = "";
				var newChangeAfter = "";
				if(houseNameBefore1!=houseNameAfter1){
					newChangeBefore+="住所名称："+houseNameBefore1+"\n";
					newChangeAfter+="住所名称："+houseNameAfter1+"\n";
				}
				if(houseSourceBefore1!=houseSourceAfter1){
					newChangeBefore+="住所来源："+changeSource(houseSourceBefore1)+"\n";
					newChangeAfter+="住所来源："+changeSource(houseSourceAfter1)+"\n";
				}
				if(houseBorgBefore1!=houseBorgAfter1){
					newChangeBefore+="产权单位："+houseBorgBefore1+"\n";
					newChangeAfter+="产权单位："+houseBorgAfter1+"\n";
				}
				if(houseAreaBefore1!=houseAreaAfter1){
					newChangeBefore+="用房面积："+houseAreaBefore1+"\n";
					newChangeAfter+="用房面积："+houseAreaAfter1+"\n";
				}
				if(houseDateBefore1!=houseDateAfter1){
					newChangeBefore+="租借期限："+houseDateBefore1+"\n";
					newChangeAfter+="租借期限："+houseDateAfter1+"\n";
				}
				showMap.put("changeBefore",newChangeBefore.trim());
				showMap.put("changeAfter",newChangeAfter.trim());
			}else if(changeItem=="2"){//变更法定代表人
				putSomChange();
				//需要打印法定代表人信息
				var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/ungov/jsp/change/ungovChangeLegalWord.jsp?taskCode="+taskCode+"&sorgId="+sorgId;
				window.open(url);
			}else if(changeItem=="3"){//变更业务范围
				putSomChange();
			}else if(changeItem=="4"){//变更注册资金
				putSomChange();
				var changeBefores=changeBefore.split(';');
				var moneySourceBefore1 = changeBefores[0];//资金来源
				var moneyBefore1 = changeBefores[1];//开办资金数额
				var changeAfters=changeAfter.split(';');
				var moneySourceAfter1 = changeAfters[0];
				var moneyAfter1 = changeAfters[1];
				//改变showMap中 变更前，变更后的值
				var newChangeBefore = "";
				var newChangeAfter = "";
				if(moneySourceBefore1!=moneySourceAfter1){
					newChangeBefore+="资金来源："+moneySourceBefore1+"\n";
					newChangeAfter+="资金来源："+moneySourceAfter1+"\n";
				}
				if(moneyBefore1!=moneyAfter1){
					newChangeBefore+="开办资金数额："+moneyBefore1+"万元"+"\n";
					newChangeAfter+="开办资金数额："+moneyAfter1+"万元"+"\n";
				}
				showMap.put("changeBefore",newChangeBefore.trim());
				showMap.put("changeAfter",newChangeAfter.trim());
			}else if(changeItem=="5"){//变更业务主管单位
				putSomChange();
				var businessOrganSelect1 = L5.DatasetMgr.lookup("businessOrganSelect1");
				businessOrganSelect1.setParameter("includeCode",changeBefore);
				businessOrganSelect1.load();
				businessOrganSelect1.on("load",function(){
					changeBefore = businessOrganSelect1.get("text");
					var businessOrganSelect2 = L5.DatasetMgr.lookup("businessOrganSelect2");
					businessOrganSelect2.setParameter("includeCode",changeAfter);
					businessOrganSelect2.load();
					businessOrganSelect2.on("load",function(){
						changeAfter = businessOrganSelect2.get("text");
						showMap.put("changeBefore",changeBefore);
						showMap.put("changeAfter",changeAfter);
						getMarks();
						writeDoc(showMap);
					});
				});
			}else if(changeItem=="7"){//变更出资人
				putSomChange();
			}
		}
		
		if(changeItem!=5){//5中已经包含
			getMarks();
			writeDoc(showMap);
		}
	});
}
//转换changeItem的code到name
function changeChangeItem(changeItem){
	var ch = "";
	switch (changeItem){
	case "0" : ch = "变更名称"; break;
	case "1" : ch = "变更住所"; break;
	case "2" : ch = "变更法定代表人"; break;
	case "3" : ch = "变更业务范围"; break;
	case "4" : ch = "变更注册资金"; break;
	case "5" : ch = "变更业务主管单位"; break;
	case "7" : ch = "变更出资人"; break;
	default : ch = "";
	}
	return ch;
}
//住所来源转换
function changeSource(houseSource){
	var ho = "";
	switch (houseSource){
	case "1" : ho = "自有"; break;
	case "2" : ho = "租赁"; break;
	case "3" : ho = "个人或组织无偿提供"; break;
	default : ho = "";
	}
	return ho;
}
//将somChangeDataSet中的数据取出放出showMap中
function putSomChange(){
	changeItem = changeChangeItem(somChangeDataSet.get("changeItem"));//变更事项
	changeBefore = somChangeDataSet.get("changeBefore");//变更前
	changeAfter = somChangeDataSet.get("changeAfter");//变更后
	changeReason = somChangeDataSet.get("changeReason");//变  更  理  由
	changeDesc = somChangeDataSet.get("changeDesc");//变  更  程  序
	showMap.put("changeItem",changeItem);
	showMap.put("changeBefore",changeBefore);
	showMap.put("changeAfter",changeAfter);
	showMap.put("changeReason",changeReason);
	showMap.put("changeDesc",changeDesc);
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
	<model:dataset id="somChangeDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="cnName" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect2" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
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
