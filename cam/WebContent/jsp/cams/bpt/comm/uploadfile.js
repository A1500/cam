var row_index=0;
var Id = "";
function init() {
	//电子档案信息
	bptElectronicList.setParameter("PEOPLE_ID",peopleId);	
	bptElectronicList.setParameter("SERVICE_TYPE",serviceType);
	bptElectronicList.load();
	bptElectronicList.on("load",function(){
		var records=bptElectronicList.getAllRecords();
		if(records.length<1){
			//为新增记录时，初始化
			bptElectronicList.newRecord();
		}else{
			//当为更新时，先从ContentNumMaintainDataset中取得contentNumId，通过contentNumId在ContentNumMaintainDataset中
			//中查询相关记录，逐个set入ContentNumMaintainDataset中
			var ContentNumMaintainDataset = L5.DatasetMgr.lookup("ContentNumMaintainDataset");
			var contentNumId = records[0].get("contentNumId");
			ContentNumMaintainDataset.setParameter("CONTENT_NUM_ID",contentNumId);
			ContentNumMaintainDataset.load();
			ContentNumMaintainDataset.on("load",function(){
				var ContentNumMaintainRecords = ContentNumMaintainDataset.getAllRecords();
					var contentNumName = ContentNumMaintainRecords[0].get("contentNumName");
					bptElectronicList.set("contentNumName",contentNumName);
					if(ContentNumMaintainRecords[0].get("fileCabinetName") != null){
						var fileCabinetName = ContentNumMaintainRecords[0].get("fileCabinetName");
						bptElectronicList.set("fileCabinetName",fileCabinetName);
					}
					if(ContentNumMaintainRecords[0].get("layerNum") != null){
						var layerNum = ContentNumMaintainRecords[0].get("layerNum");
						bptElectronicList.set("layerNum",layerNum);
					}
					if(ContentNumMaintainRecords[0].get("boxNum") != null){
						var boxNum = ContentNumMaintainRecords[0].get("boxNum");
						bptElectronicList.set("boxNum",boxNum);
					}
					if(ContentNumMaintainRecords[0].get("contentYear") != null){
						var contentYear = ContentNumMaintainRecords[0].get("contentYear");
						bptElectronicList.set("contentYear",contentYear);
					}
					if(ContentNumMaintainRecords[0].get("plaitDate") != null){
						var plaitDate = ContentNumMaintainRecords[0].get("plaitDate");
						bptElectronicList.set("plaitDate",plaitDate);
					}
					if(bptElectronicList.get("archiveNo") != null){
						var archiveNo = bptElectronicList.get("archiveNo");
						bptElectronicList.set("ARCHIVE_NO",archiveNo);
					}
			});
		}
	});
	//附件信息
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("SERVICE_TYPE",serviceType);
	//
	ds.setParameter("APPLY_ID",applyId=="null"?"":applyId);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
	ds.on("load",function(){
	var records=ds.getAllRecords();
		if(records.length>=1){
			//upload_detail();
			var electCount = records.length;
			for(var i=0;i<electCount;i++){
				Id+=records[i].get("electronicId")+":";
			}
		}
//		}else{
//			insertPeopleid();
//		}
	});
}

//选择附件目录
function selectContent(){
	var url = "../../bpt/edoc/contentSelectOther.jsp?peopleId="+peopleId+"&serviceType="+serviceType+"&organCode="+organCode+"&applyId="+applyId;
	window.showModalDialog(url,"","dialogHeight:400px;dialogWidth:678px;resizable:no;scroll:yes;");
	//window.open(url);
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("SERVICE_TYPE",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.setParameter("APPLY_ID",applyId=="null"?"":applyId);
	ds.load();
	ds.on("load",function(){
		var records=ds.getAllRecords();
		if(records.length>=1){
			//upload_detail();
		}
	});
}

//选择目录号
function getContent(){
	var revalue =  window.showModalDialog("../../bpt/edoc/contentnummaintain/contentNumSelect.jsp","","dialogHeight:400px;dialogWidth:878px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var contentNumName = revalue;
		document.getElementById("contentNumName").value = contentNumName;
		bptElectronicList.getCurrent().set("contentNumName",contentNumName);
	}
	getInfo();
}

//查询目录号相关信息
function getInfo(){
	 var contentNumName = document.getElementById("contentNumName").value;
	 var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptContentNumMaintainCommand");
	 command.setParameter("DOMICILE_CODE",organCode); 
	 command.setParameter("CONTENT_NUM_NAME",contentNumName); 
	 command.execute("getContentInfo");
	 if(command.getReturn("contentNumId")!= undefined){
		 	if(command.getReturn("contentNumId") !=undefined){
					var contentNumId = command.getReturn("contentNumId");
					document.getElementById("contentNumId").value = contentNumId;
			}
			if(command.getReturn("contentNumName") !=undefined){
					var contentNumName = command.getReturn("contentNumName");
					document.getElementById("contentNumName").value = contentNumName;
			}
			if(command.getReturn("fileCabinetName") !=undefined){
					var fileCabinetName = command.getReturn("fileCabinetName");
					document.getElementById("fileCabinetName").value = fileCabinetName;
			}
			if(command.getReturn("layerNum") !=undefined){
					var layerNum = command.getReturn("layerNum");
					document.getElementById("layerNum").value = layerNum;
			}
			if(command.getReturn("boxNum") !=undefined){
					var boxNum = command.getReturn("boxNum");
					document.getElementById("boxNum").value = boxNum;
			}
			if(command.getReturn("contentYear") !=undefined){
					var contentYear = command.getReturn("contentYear");
					document.getElementById("contentYear").value = contentYear;
			}
			if(command.getReturn("plaitDate") !=undefined){
					var plaitDate = command.getReturn("plaitDate");
					document.getElementById("plaitDate").value = plaitDate;
			}
	 }else{
	 	L5.Msg.alert('提示',"此目录号不存在，请输入其他目录号!");
	 	document.getElementById("contentNumName").value = '';
	 	return false;
	 }
}

//首次登陆插入记录
function insertPeopleid(){
 	var command = new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand");
	command.setParameter("peopleId", peopleId);
	command.setParameter("serviceType", serviceType);
	command.setParameter("organCode", organCode);
	command.execute("insertPeopleid");
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
}

//解析fileName字段，分别加链接
function lookDetail(value,cellmeta,record,rowindex,colindex,dataset){
 	/*var record=ds.getAllRecords();
 	var fileName="";
 	var fileId="";
 	var electronicId="";
 	for(var i=0;i<record.length;i++){*/
 		fileName =record.get("fileName");
 		electronicId=record.get("electronicId");
 		//alert("electronicId"+electronicId);
 		fileId=record.get("fileId");
		//var allFileName=fileName.split(",");
		//var allFileId=fileId.split(",");
		//alert(fileName);
		if(fileName!=""&&fileName!="undefined")
		{
			//Id+=record.get("electronicId")+":";
			var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='color:blue;text-decoration:none' onclick='editfiles(\""+electronicId+"\")'>编辑</a>";
			//alert(returnfile);
			//record[i].set("fileName",returnfile);
			return returnfile;
		}else{
			return "";
		}
 	}
 	
//查看所有电子档案
function checkElectronic() {
	var param = window.dialogArguments; 
  	var url=L5.webPath+"/jsp/cams/bpt/comm/checkFileview.jsp?Id="+Id+"&serviceType="+serviceType+"&peopleId="+peopleId;
  	var electronic = param.window.open(url);
}

function savefile(){
	var bptElectronicList = L5.DatasetMgr.lookup("bptElectronicList");
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

//调用文件下载方法
function uploadfiles(electronicId){
	var param = window.dialogArguments;
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?electronicId="+electronicId;
 	//var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?peopleId='"+peopleId+"'&serviceType='"+serviceType+"'";
	var hPopup=param.window.open(url,"fielview","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
}
  
//调用文件下载方法
function editfiles(electronicId){
	var param = window.dialogArguments;
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileedit.jsp?electronicId="+electronicId;
	var hPopup=param.window.open(url,"fileedit","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
}

//附件上传按钮
function uploadfile(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一个档案目录进行电子扫描!");
		return false;
	}
	var electronicId = selected[0].get("electronicId");
	var param = window.dialogArguments; 
	//var theURL="../../comm/fileupload.jsp?electronicId="+selected[0].get('electronicId')
	var theURL="../../bpt/comm/fileupload.jsp?peopleId="+peopleId+"&serviceType="+serviceType+"&organCode="+organCode+"&electronicId="+electronicId+"";
	
	var width = screen.width;
    var height = screen.height;
	var win = window.showModalDialog (theURL,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	
	
	
	/*var   hPopup   =   param.window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    //alert("");
	
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);*/
	/*
	var dataset=L5.DatasetMgr.lookup('uploadds');
	dataset.newRecord();
	var win=L5.getCmp("updateWin");
	win.show();*/
}

//上传附件保存
function click_save(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	var uploadds = L5.DatasetMgr.lookup("uploadds");
	var record=uploadds.getCurrent();
	record.set("catalogCode",selected[0].get('catalogCode'));
	record.set("serviceType",selected[0].get('serviceType'));
	record.set("catalogName",selected[0].get('catalogName'));
	record.set("electronicId",selected[0].get('electronicId'));
	record.set("fileSave",document.getElementById("fileSave").value);
	record.set("fileMess",document.getElementById("fileMess").value);
	record.set("peopleId",peopleId);
	var command=new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand");
	command.setParameter("record",record);
	command.setForm("form_content");
	command.execute("uploadinsert");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
		L5.Msg.alert("提示","上传附件成功!",function(){
		var win=L5.getCmp("updateWin");
		win.hide();
		});
		ds.setParameter("PEOPLE_ID",peopleId);
		ds.load();

		}else{
	        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
        }
	}
}

 //增加一行
  function  add_row(){
    var table2 = document.getElementById("table2");
	row_index++;
    var new_row=table2.insertRow(table2.rows.length);
	new_row.setAttribute("id", "row"+row_index);
	var new_col=new_row.insertCell(0);
	new_col.innerHTML="<input type='file' name='filename"+row_index+"' size='87' >";
    var new_col=new_row.insertCell(1);
    new_col.innerHTML="&nbsp;<input type='button' value='删除' onclick=\"delete_row('row"+row_index+ "')\">";
    document.getElementById("filename"+row_index).focus();
    document.getElementById("span").innerHTML="<font color='red'>附件大小不能超过5M</font>";
  }
  /*
   * 删除一行
   */
  function delete_row(rname){
	var table2 = document.getElementById("table2");
    var i;
    i=table2.rows(rname).rowIndex;
    table2.deleteRow(i);
  }
  /*
   * 删除附件


function delfile(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		return;
	}else{
		var command=new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand");
		command.setParameter("electronicId",selected[0].get('electronicId'));
		command.setParameter("fileId",selected[0].get('fileId'));
		alert(selected[0].get('fileId'))
		alert(selected[0].get('fileId'))
		command.execute("deluploadtfile");

		//包含有大字段的异常判断
		command.afterExecute=function(){
			if(!command.error){
			L5.Msg.alert("提示","删除附件成功!",function(){
			var win=L5.getCmp("updateWin");
			win.hide();
			});
			ds.setParameter("PEOPLE_ID",peopleId);
			ds.load();

			}else{
		        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
	        }
		}
	}
}
 */
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

function detail(){
	url='uploadFileHistory.jsp?peopleId='+peopleId+'&serviceType='+serviceType;//+'&applyId='+applyId;
	width=screen.width-500;
	height=screen.height-400;
	window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}

function func_Close(){
	window.close();
}