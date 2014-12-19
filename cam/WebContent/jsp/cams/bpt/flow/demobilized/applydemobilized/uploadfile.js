var row_index=0;
function init() {
	FileCabinetDataset.setParameter("filterSql","DOMICILE_CODE = '"+organCode+"'");
	FileCabinetDataset.load();
	bptElectronic.setParameter("PEOPLE_ID",peopleId);
	bptElectronic.load();
	bptElectronic.on("load",function(){
		var records=bptElectronic.getAllRecords();
		if(records.length<1){
			bptElectronic.newRecord();
		}
	});
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("SERVICE_TYPE",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
	ds.on("load",function(){
	var records=ds.getAllRecords();
		if(records.length<1){
			insertPeopleid();
		}else{
			//upload_detail();
		}
		});
	
}

function getLayer(){
	var fileCabinetCode = document.getElementById("fileCabinetCode").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptFileCabinetMaintainCommand");
		command.setParameter("FILE_CABINET_CODE", fileCabinetCode);
		command.setParameter("DOMICILE_CODE", organCode);
		command.execute("getlayer");
		layerNum = command.getReturn("layerNum");
}

function getFileCabinet(){
	var fileCabinetCode = document.getElementById("fileCabinetCode").value;
	var layerNum = document.getElementById("layerNum").value;
	var ctnNo = document.getElementById("ctnNo").value;
	bptElectronic.set("electronicNo",fileCabinetCode+layerNum+ctnNo);
}

/*
 * 首次登陆插入记录
 */
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
  /*
   * 解析fileName字段，分别加链接
   */
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
			var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='color:blue;text-decoration:none' onclick='editfiles(\""+electronicId+"\")'>编辑</a>";
			//alert(returnfile);
			//record[i].set("fileName",returnfile);
			return returnfile;
		}else{
			return "";		
		}
  }
  function savefile(){
  		var bptElectronic = L5.DatasetMgr.lookup("bptElectronic");
		var bptElectronicRecord=bptElectronic.getCurrent();
  	
  		var layer = document.getElementById("layerNum").value;
  		if(layer.length>3){
  			L5.Msg.alert('提示','层数只能为三位数！');
			return false;
  		}
  		
		layer = parseInt(layer);
		layerNum = parseInt(layerNum);
		if(layer<1 || layer> layerNum){
			L5.Msg.alert('提示','层数必须大于1小于'+layerNum);
			return false;
		}
		
		var ctnNo = document.getElementById("ctnNo").value;
		if(ctnNo.length>3){
  			L5.Msg.alert('提示','箱数只能为三位数！');
			return false;
  		}
  		
		var command = new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptElectronicListCommand");
		command.setParameter("bptElectronicRecord", bptElectronicRecord);
		command.setParameter("peopleId", peopleId);
		command.execute("savefile");
		if (!command.error) {
			bptElectronic.commitChanges();
			L5.Msg.alert('提示',"数据保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
  }
 /*
   * 调用文件下载方法
   */
 function uploadfiles(electronicId){
	 var param = window.dialogArguments; 
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?electronicId="+electronicId;
	var hPopup=param.window.open(url,"fielview","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
  }
   /*
   * 调用文件下载方法
   */
function editfiles(electronicId){
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileedit.jsp?electronicId="+electronicId;
	var hPopup=window.open(url,"fileedit","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
}
//附件上传按钮
function uploadfile(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var theURL="../../comm/fileupload.jsp?electronicId="+selected[0].get('electronicId')
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);
	/*
	var dataset=L5.DatasetMgr.lookup('uploadds');
	dataset.newRecord();
	var win=L5.getCmp("updateWin");
	win.show();*/

}
/*
 * 上传附件保存
 */
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
	var electronicDate = document.getElementById("electronicDate").value;
	if(electronicDate!=''&&!validateDateFormat(electronicDate)){
		L5.Msg.alert("提示","编制日期格式不正确！");
		return false;
	}
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
 /*
  * 增加一行
  */
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
  //返回按钮
function back(){
	history.go(-1);
}