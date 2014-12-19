var applyId = "";
var Id ="";
function init(){
		var dsPro = L5.DatasetMgr.lookup("dsPro");
		dsPro.setParameter("PEOPLE_ID",peopleId);
		
//		dsPro.setParameter("ORGAN_ID",organCode);
		var index_type = objectType.substring(0,1);
		if(index_type == "1" || index_type =="2") {
			objectType = index_type+"1";
		}
		dsPro.setParameter("serviceType",objectType);
		dsPro.load();
}

function selectService(a,b,record) {
	var serviceType = record.get("SERVICE_TYPE");
	applyId = record.get("APPLY_ID");
	var dsProInfo = L5.DatasetMgr.lookup("dsProInfo");
	dsProInfo.setParameter("PEOPLE_ID",peopleId);
	dsProInfo.setParameter("serviceType",serviceType);
	dsProInfo.load();
	dsProInfo.on("load",function() {
		if(dsProInfo.getAllRecords().length == 0) {
			dsProInfo.newRecord();
		}
	});
	
	
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("serviceType",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
	ds.on("load",function(){
		var records=ds.getAllRecords();
		if(records.length>=1){
			upload_detail();
		}
	});
	
	dsProPrint.setParameter("PEOPLE_ID",peopleId);
	var index_type = objectType.substring(0,1);
	if(index_type == "1" || index_type =="2") {
		objectType = index_type+"1";
	}
	dsProPrint.setParameter("objectType",objectType);
	dsProPrint.setParameter("serviceType",serviceType);
	dsProPrint.load();
}

//选择目录号
function getContent(){
	var revalue =  window.showModalDialog("../edoc/contentnummaintain/contentNumSelect.jsp","","dialogHeight:400px;dialogWidth:878px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var contentNumName = revalue;
		document.getElementById("contentNumName").value = contentNumName;
		//dsPro.getCurrent().set("CONTENT_NUM_NAME",contentNumName);
	}
	getInfo();
}

//查询目录号相关信息
function getInfo(){
	 var dsProInfo = L5.DatasetMgr.lookup("dsProInfo");
	 var contentNumName = document.getElementById("contentNumName").value;
	 var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptContentNumMaintainCommand");
	 command.setParameter("DOMICILE_CODE",organCode); 
	 command.setParameter("CONTENT_NUM_NAME",contentNumName); 
	 command.execute("getContentInfo");
	 if(command.getReturn("contentNumId")!= undefined){
		 	if(command.getReturn("contentNumId") !=undefined){
					var contentNumId = command.getReturn("contentNumId");
					//document.getElementById("contentNumId").value = contentNumId;
					dsProInfo.set("contentNumId",contentNumId);
			}
			if(command.getReturn("contentNumName") !=undefined){
					var contentNumName = command.getReturn("contentNumName");
					//document.getElementById("contentNumName").value = contentNumName;
					dsProInfo.set("CONTENT_NUM_NAME",contentNumName);
			}
			if(command.getReturn("fileCabinetName") !=undefined){
					var fileCabinetName = command.getReturn("fileCabinetName");
					//document.getElementById("fileCabinetName").value = fileCabinetName;
					dsProInfo.set("FILE_CABINET_NAME",fileCabinetName);
			}
			if(command.getReturn("layerNum") !=undefined){
					var layerNum = command.getReturn("layerNum");
					//document.getElementById("layerNum").value = layerNum;
					dsProInfo.set("LAYER_NUM",layerNum);
			}
			if(command.getReturn("boxNum") !=undefined){
					var boxNum = command.getReturn("boxNum");
					//document.getElementById("boxNum").value = boxNum;
					dsProInfo.set("BOX_NUM",boxNum);
			}
			if(command.getReturn("contentYear") !=undefined){
					var contentYear = command.getReturn("contentYear");
					//document.getElementById("contentYear").value = contentYear;
					dsProInfo.set("CONTENT_YEAR",contentYear);
			}
			if(command.getReturn("plaitDate") !=undefined){
					var plaitDate = command.getReturn("plaitDate");
					//document.getElementById("plaitDate").value = plaitDate;
					dsProInfo.set("PLAIT_DATE",plaitDate);
			}
	 }else{
	 	L5.Msg.alert('提示',"此目录号不存在，请输入其他目录号!");
	 	document.getElementById("contentNumName").value = '';
	 	return false;
	 }
}
//选择附件目录
function selectContent(){
	var serviceType = getselected();
	var service_type = serviceType;
	if(serviceType == "42") {
		serviceType = "45";
	} else {
		var index_type = serviceType.substring(0,1);
		if(index_type == "1" || index_type =="2") {
			serviceType = index_type+"1";
		}
	}
	//onlyinsert : 当人员完成流程是 档案只能增加 不能修改删除 标志
	var url = "../edoc/baseinforContentSelect.jsp?peopleId='"+peopleId+"'&serviceType='"+serviceType+"'&organCode='"+organCode+"'"+"&applyId="+applyId+"&onlyinsert="+objectState;
	window.showModalDialog(url,"","dialogHeight:400px;dialogWidth:678px;resizable:no;scroll:yes;");
	
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("serviceType",service_type);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
	ds.on("load",function(){
		var records=ds.getAllRecords();
		if(records.length>=1){
			upload_detail();
		}
	});
}

function fileNameFormat(value,cellmeta,record) {
	if(value!="") {
		var eId = record.get("electronicId");
		var  restr="";
		if(objectState=="1"){
			restr="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+eId+"\")'>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='color:blue;text-decoration:none' onclick='editfiles(\""+eId+"\")'>编辑</a>";
		}else{
			restr="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+eId+"\")'>查看</a>";
		}
		
		return restr
	} else {
		return value;
	}
}

  /*
   * 解析fileName字段，分别加链接
   */
function upload_detail(){
 	var record=ds.getAllRecords();
 	var fileName="";
 	var fileId="";
 	var electronicId="";
 	Id="";
 	for(var i=0;i<record.length;i++){
 		fileName =record[i].get("fileName");
 		electronicId=record[i].get("electronicId");
 		//alert("electronicId"+electronicId);
 		fileId=record[i].get("fileId");
		//var allFileName=fileName.split(",");
		//var allFileId=fileId.split(",");
		//alert(fileName);
		if(fileName!="")
		{
			Id+=record[i].get("electronicId")+":";
			//var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='color:blue;text-decoration:none' onclick='editfiles(\""+electronicId+"\")'>编辑</a>";
			//alert(returnfile);
			//record[i].set("fileName",returnfile);
		}
 	}
  }
  //查看所有电子文档
   function checkElectronic() {
   var record=ds.getAllRecords();
   var stypes="";
 	for(var i=0;i<record.length;i++){
 		serviceType =record[i].get("serviceType");
		if(serviceType!="")
		{
			stypes+=record[i].get("serviceType")+":";
		}
 	}
   	
  	var url=L5.webPath+"/jsp/cams/bpt/comm/checkFileview.jsp?Id="+Id+"&peopleId="+peopleId+"&serviceType="+stypes;
  	var param = window.dialogArguments;
	var electronic = param.window.open(url);
  
  }

 //保存负责人，上传时间，页数
  function saveELE() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptElectronicCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {

		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',command.error);
	}
}

  
function getselected(){
	var editGrid = L5.getCmp('editGridPanelPro');
	var selected = editGrid.getSelectionModel().getSelections();
	return serviceType = selected[0].get("SERVICE_TYPE");
}
  
  //附件上传按钮
function uploadfile(){
	var serviceType = getselected();
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一个档案目录进行电子扫描!");
		return false;
	}
	var electronicId = selected[0].get("electronicId");
	var theURL="../comm/fileupload.jsp?peopleId="+peopleId+"&serviceType="+serviceType+"&organCode="+organCode+"&electronicId="+electronicId;
	//var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	
	var param = window.dialogArguments;
	var electronic = param.window.open(theURL);
   // hPopup.resizeTo(screen.availWidth,   screen.availHeight);
}

function savefile(){
		var dsProInfo = L5.DatasetMgr.lookup("dsProInfo");
		var records = dsProInfo.getAllChangedRecords();
		if(records.length<1){
			L5.Msg.alert('提示','没有需要保存的数据!');
			return false;
		}
		var serviceType = getselected();
  		var bptElectronicList = L5.DatasetMgr.lookup("dsProInfo");
		var bptElectronicListRecord=bptElectronicList.getCurrent();
  		var contentNumId = document.getElementById("contentNumId").value;
		var command = new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptElectronicListCommand");
		command.setParameter("bptElectronicRecord", bptElectronicListRecord);
		command.setParameter("peopleId", peopleId);
		command.setParameter("organCode", organCode);
		command.setParameter("serviceType", serviceType);
		command.setParameter("contentNumId", contentNumId);
		command.execute("savefile");
		if (!command.error) {
			var archiveNo = command.getReturn("archiveNo");
			bptElectronicList.set("ARCHIVE_NO",archiveNo);
			L5.Msg.alert('提示',"数据保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
}

function func_Close(){
	window.close();
}

 /*
   * 调用文件下载方法
   */
 function uploadfiles(electronicId){
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?electronicId="+electronicId;
 	//var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?peopleId='"+peopleId+"'&serviceType='"+serviceType+"'";
	//var hPopup=window.open(url,"fielview","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	var param = window.dialogArguments;
	var electronic = param.window.open(url);
	//hPopup.blur();
   // hPopup.resizeTo(screen.availWidth,screen.availHeight);
  }
   /*
   * 调用文件下载方法
   */
function editfiles(electronicId){
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileedit.jsp?electronicId="+electronicId;
	var hPopup=window.open(url,"fileedit","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	var param = window.dialogArguments;
	var electronic = param.window.open(url);
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
}
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/peopleBasicInfo/table/Electronic2.fr3'; 
	var reportName="归档文件目录";
	doReportPrint(reportName,"fdfd","dfa",printDataset ,url);
}
 //打印预览调用方法
function printFront(){
	var url = L5.webPath+'/jsp/cams/bpt/peopleBasicInfo/table/dcover.fr3'; 
	doReportPrint("","","",dsProPrint ,url);
}