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
	var nowFileName = "/jsp/ext/somsd/manage/printWord/ungov/doc/ungovNameApprovalWord.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(L5.webPath+nowFileName);
	activeDocument = webObj.activeDocument;
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
}
function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode=somApplyDataSet.get('taskCode');
	
	var appPeople = somApplyDataSet.get('appPeople');
	var appPhone = somApplyDataSet.get('appPhone');
	showMap.put("appPeople",appPeople);
	showMap.put("appPhone",appPhone);
	
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		//获得参数放入showMap中，以填入word中
		var cnName = somOrganDataSet.get("cnName");
		var purpose = somOrganDataSet.get("purpose");
		var business = somOrganDataSet.get("business");
		var borgName = somOrganDataSet.get("borgName");
		var borgDataSet = L5.DatasetMgr.lookup("borgDataSet");
		borgDataSet.setParameter("includeCode",borgName);
		borgDataSet.load();
		borgDataSet.on('load',function(){
			var borgName = borgDataSet.get("text");
			var currency = somOrganDataSet.get("currency");
			var regMon = somOrganDataSet.get("regMon");
			var fundingPeople = somOrganDataSet.get("fundingPeople");
			var moneySource = somOrganDataSet.get("moneySource");
			var residence = somOrganDataSet.get("residence");
			showMap.put("cnName",cnName);
			showMap.put("purpose",purpose);
			showMap.put("business",business);
			showMap.put("borgName",borgName);
			showMap.put("currency",currency);
			showMap.put("regMon",regMon);
			showMap.put("fundingPeople",fundingPeople);
			showMap.put("moneySource",moneySource);
			showMap.put("residence",residence);
			
			var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
			somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
			somHeldPeopleDataSet.load();
			somHeldPeopleDataSet.on("load",function(){
				var count = somHeldPeopleDataSet.getCount();
				var length = 0;//最后填4个举办者情况
				if(count<4){
					length = count;
				}else if(count>=4){
					length = 4;
				}
				if(length>0){
					var records =  somHeldPeopleDataSet.getAllRecords();
					for(var i=0;i<length;i++){
						showMap.put("name"+i,records[i].get("name"));
						showMap.put("birthday"+i,records[i].get("birthday"));
						showMap.put("populace"+i,records[i].get("populace"));
						showMap.put("workName"+i,records[i].get("workName"));
						showMap.put("workDuties"+i,records[i].get("workDuties"));
						showMap.put("phone"+i,records[i].get("phone"));
					}
				}
				
				var aspChiefDataset = L5.DatasetMgr.lookup("aspChiefDataset");
				aspChiefDataset.setParameter("SORG_ID@=", sorgId);
				aspChiefDataset.load();
				aspChiefDataset.on('load',function(){
					var count = aspChiefDataset.getCount();
					if(count==0){
						
					}else{
						showMap.put("name",aspChiefDataset.get("name"));
						showMap.put("birthday",aspChiefDataset.get("birthday"));
						showMap.put("populaceniren",aspChiefDataset.get("populace"));
						showMap.put("workName",aspChiefDataset.get("workName"));
						showMap.put("workDuties",aspChiefDataset.get("workDuties"));
						showMap.put("phone",aspChiefDataset.get("phone"));
					}
					
					var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
					somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
					somHeldOrganDataSet.load();
					somHeldOrganDataSet.on('load',function(){
						var count = somHeldOrganDataSet.getCount();
						var length = 0;//最多填两个
						if(count==1){
							length=count;
						}else if(count>=2){
							length=2;
						}
						if(length>0){
							var records = somHeldOrganDataSet.getAllRecords();
							for(var i=0;i<length;i++){
								showMap.put("namedanwei"+i,records[i].get("name"));
								showMap.put("heldorganPeopledanwei"+i,records[i].get("heldorganPeople"));
								showMap.put("phonedanwei"+i,records[i].get("phone"));
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
<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
	<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		<model:field name="appPeople" type="string" rule="length{30}"/>
		<model:field name="curOpinionId" type="string" rule="require"/>
		<model:field name="curOpinion" type="string" rule="length{200}"/>
	</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="currency" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|length{14}" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="moneySource" type="string" rule="length{500}" />	
			<model:field name="residence" type="string" rule="require|length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="OrganDataSetForQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="idCard" type="string" rule="custom{fn:validIDCard,min:2}" />
			<model:field name="birthday" type="string" rule="date{yyyy-MM}"/>
			<model:field name="name" type="string" rule="require|length{30}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="aspChiefDataset" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{50}" />
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="sex" type="string" rule="length{1}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require" />
			<model:field name="heldorganPeople" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<model:dataset id="SomFlowDataSet" cmd="com.inspur.cams.sorg.workflow.cmd.SomFlowCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_UNGOV_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true"  sortField="ORDER_NUMBER">
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
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
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
