var fileCode_noUpLoad="S017,S018,S028,S059,S064,S072,S074,S087,J015,J016,J022,J046,J055,J061,J064,J072,M004,M015,M026,M044";//在普通法律要件中无法上传的fileCode
var fileCode_legalPeople="S017,S028,M004,M015,M026,M044,J015,J022";
var applyTypeNameStr = "";
applyTypeJsonInit();
//电子档案列表初始化加载
function somElectronicDataSet_load(){
	somElectronicDataSet.setParameter("sorgId",sorgId);
	somElectronicDataSet.setParameter("taskCode",taskCode);
	somElectronicDataSet.setParameter("applyType",applyType);
	somElectronicDataSet.load();
}
//打开上传窗口后电子档案列表加载
function winElectronicDataSet_load(){
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	
	var sorgIdSelected = selected[0].get("sorgId");
	var taskCodeSelected = selected[0].get("taskCode");
	var applyTypeSelected = selected[0].get("applyType");
	var catalogCodeSelect = selected[0].get("catalogCode");
	var electronicIds = selected[0].get("electronicId");
	
	winElectronicDataSet.setParameter("sorgId",sorgIdSelected);
	winElectronicDataSet.setParameter("taskCode",taskCodeSelected);
	winElectronicDataSet.setParameter("applyType",applyTypeSelected);
	winElectronicDataSet.setParameter("catalogCode",catalogCodeSelect);
	winElectronicDataSet.setParameter("electronicIds",electronicIds);
	winElectronicDataSet.load();
}
//附件窗口点击上传
function click_upload(){
	if(_$("fileMess").length>250){
		L5.Msg.alert('提示',"附件描述不能超过250个字符!");
		return false;
	}
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	record.set("sorgId",sorgId);
	command.setParameter("fileMess",_$("fileMess"));
	command.setParameter("uploadRd",record);
	command.setForm("form_content");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadWin");
				win.hide();
			});
			winElectronicDataSet_load();
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
function close_upload(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}
//弹出上传附件窗口
function uploadFile(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	winElectronicDataSet_load();
	var win=L5.getCmp("uploadList");
	win.show();
}
//增加上传附件
function addUploadFile(){
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	var fileCodeSelect = selected[0].get("fileCode");
    if(fileCode_noUpLoad.indexOf(fileCodeSelect) != -1){
    	L5.Msg.alert('提示',"此法律要件请从负责（法定代表）人信息中的法律要件中上传!");
		return false;
    }
	var win=L5.getCmp("uploadWin");
	win.show();
	
}
//关闭附件列表窗口
function closeUploadFile(){
	var win = L5.getCmp("uploadList");
	win.hide();
}
//电子档案上传窗口关闭事件
function uploadListCloseEvent(){
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
				somElectronicDataSet_load();
		});	
	}	
}
//链接删除附件功能
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDelete(\'' + winElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除附件
function clickDelete(index){
	var record= winElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var electronicId = record.get("electronicId");
			var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
			command.setParameter("electronicId",electronicId);
			command.execute("delElectronic");
			if (!command.error) {
				winElectronicDataSet_load();	
				L5.Msg.alert('提示','删除成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
//链接下载附件功能
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId").split(";");
	if(ids[0]==""){
		return "";
	}
	if(ids[0]!="" && ids[1]==null){
		var url0=paths[0]+'/'+paths[1]+"/download?table=som_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+ids[0]+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}
	return '<a href="javascript:clickDownload(\'' + somElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
}
//打开下载多个附件窗口
function clickDownload(index){
    var record= somElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("ids",ids);
	downloadDataSet.load();
	var win = L5.getCmp("downloadWin");
	win.show();
}
//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("electronicId");
    var url0=paths[0]+'/'+paths[1]+"/download?table=som_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
//关闭下载窗口
function winClosedownload(){
	var win = L5.getCmp("downloadWin");
	win.hide();
}
//----------------------------------------------------------人员法律要件-----------------------------------------------------------
//人员电子档案列表初始化加载
function somPeopleElectronicDataSet_load(fileCodes,dutyId){
	somPeopleElectronicDataSet.setParameter("fileCodes",fileCodes);
	somPeopleElectronicDataSet.setParameter("dutyId",dutyId);
	somPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somPeopleElectronicDataSet.setParameter("taskCode",taskCode);
//	somPeopleElectronicDataSet.setParameter("applyType",applyType);
	somPeopleElectronicDataSet.load();
}
//打开上传窗口后人员电子档案列表加载
function winPeopleElectronicDataSet_load(){
	var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
/*	var sorgIdSelected = selected[0].get("sorgId");
	var applyTypeSelected = selected[0].get("applyType");
	winPeopleElectronicDataSet.setParameter("sorgId",sorgIdSelected);
	winPeopleElectronicDataSet.setParameter("applyType",applyTypeSelected);*/
	var catalogCodeSelected = selected[0].get("catalogCode");
	var taskCodeSelected = selected[0].get("taskCode");
	var dutyIdSelected = selected[0].get("dutyId");
	var electronicIds = selected[0].get("electronicId");
	winPeopleElectronicDataSet.setParameter("catalogCode",catalogCodeSelected);
	winPeopleElectronicDataSet.setParameter("taskCode",taskCodeSelected);
	winPeopleElectronicDataSet.setParameter("dutyId",dutyIdSelected);
	winPeopleElectronicDataSet.setParameter("electronicIds",electronicIds);
	winPeopleElectronicDataSet.load();
}
//弹出上传人员附件窗口
function uploadPeopleFile(){
	var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	winPeopleElectronicDataSet_load();
	var win=L5.getCmp("uploadPeopleList");
	win.show();
}
//增加人员附件上传
function addUploadPeopleFile(){
	var win=L5.getCmp("uploadPeopleWin");
	win.show();
}
//附件窗口点击上传人员信息
function click_uploadPeople(){
	if(_$("peopleFiles")=="" || _$("peopleFiles")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("fileMess",_$("peopleFileMess"));
	command.setParameter("uploadRd",record);
	command.setForm("form_content_people");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadPeopleWin");
				win.hide();
			});
			winPeopleElectronicDataSet_load();
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
function close_uploadPeople(){
	var win=L5.getCmp("uploadPeopleWin");
	win.hide();
}
//关闭人员附件列表窗口
function closeUploadPeopleFile(){
	var win = L5.getCmp("uploadPeopleList");
	win.hide();
}
//人员附件上传窗口关闭事件
function uploadPeopleListCloseEvent(){
	var win=L5.getCmp("uploadPeopleList");
	if(win!=null){
		win.on("hide",function(el){
			var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
			var record=selected[0];
			if(typeof(peopleType) != "undefined"){
				if(peopleType=="L" || peopleType=="LU"){
					somPeopleElectronicDataSet_load(fileCodeL,record.get("dutyId"));
				}
				if(peopleType=="S" || peopleType=="SU"){
					if(fileCodeS != ""){
						somPeopleElectronicDataSet_load(fileCodeS,record.get("dutyId"));
					}
				}
			}else {
				somPeopleElectronicDataSet_load(fileCode,record.get("dutyId"));
			}
			somElectronicDataSet_load();
		});	
	}	
}
//链接删除人员附件功能
function delPeopleUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDeletePeople(\'' + winPeopleElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除人员附件
function clickDeletePeople(index){
	var record= winPeopleElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
			command.setParameter("record",record);
			command.execute("delElectronicAndDutyElectronic");
			if (!command.error) {
				winPeopleElectronicDataSet_load();	
				L5.Msg.alert('提示','删除成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
//链接下载人员附件功能
function clickDownloadPeopleHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId").split(";");
	if(ids[0]==""){
		return "";
	}
	if(ids[0]!="" && ids[1]==null){
		var url0=paths[0]+'/'+paths[1]+"/download?table=som_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+ids[0]+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}
	return '<a href="javascript:clickDownloadPeople(\'' + somPeopleElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
}
//打开下载多个人员附件窗口
function clickDownloadPeople(index){
    var record= somPeopleElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("ids",ids);
	downloadDataSet.load();
	var win = L5.getCmp("downloadWin");
	win.show();
}
//----------------------------------------------------------法定代表人员法律要件-----------------------------------------------------------
//法定代表人员电子档案列表初始化加载
function somLegalPeopleElectronicDataSet_load(){
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
//	somLegalPeopleElectronicDataSet.setParameter("applyType",applyType);
	somLegalPeopleElectronicDataSet.load();
}
//打开上传窗口后法定代表人员电子档案列表加载
function winLegalPeopleElectronicDataSet_load(){
	var selected=L5.getCmp('uploadLegalPeopleGrid').getSelectionModel().getSelections();
	
	var sorgIdSelected = selected[0].get("sorgId");
	var taskCodeSelected = selected[0].get("taskCode");
	var applyTypeSelected = selected[0].get("applyType");
	var dutyIdSelected = selected[0].get("dutyId");
	var catalogCodeSelected = selected[0].get("catalogCode");
	
	winLegalPeopleElectronicDataSet.setParameter("sorgId",sorgIdSelected);
	winLegalPeopleElectronicDataSet.setParameter("taskCode",taskCodeSelected);
	winLegalPeopleElectronicDataSet.setParameter("applyType",applyTypeSelected);
	winLegalPeopleElectronicDataSet.setParameter("catalogCode",catalogCodeSelected);
	winLegalPeopleElectronicDataSet.setParameter("dutyId",dutyIdSelected);
	winLegalPeopleElectronicDataSet.load();
}
//弹出上传法定代表人员附件窗口
function uploadLegalPeopleFile(){
	var selected=L5.getCmp('uploadLegalPeopleGrid').getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	winLegalPeopleElectronicDataSet_load();
	var win=L5.getCmp("uploadLegalPeopleList");
	win.show();
}
//增加法定代表人员附件上传
function addUploadLegalPeopleFile(){
	var win=L5.getCmp("uploadLegalPeopleWin");
	win.show();
}
//附件窗口点击上传人员信息
function click_uploadLegalPeople(){
	if(_$("legalPeopleFiles")=="" || _$("legalPeopleFiles")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var selected=L5.getCmp('uploadLegalPeopleGrid').getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("fileMess",_$("legalPeopleFileMess"));
	command.setParameter("uploadRd",record);
	command.setForm("form_content_legalPeople");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadLegalPeopleWin");
				win.hide();
			});
			winLegalPeopleElectronicDataSet_load();
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
function close_uploadLegalPeople(){
	var win=L5.getCmp("uploadLegalPeopleWin");
	win.hide();
}
//关闭法定代表人员附件列表窗口
function closeUploadLegalPeopleFile(){
	var win = L5.getCmp("uploadLegalPeopleList");
	win.hide();
}
//法定代表人员附件上传窗口关闭事件
function uploadLegalPeopleListCloseEvent(){
	var win=L5.getCmp("uploadLegalPeopleList");
	if(win!=null){
		win.on("hide",function(el){
			somLegalPeopleElectronicDataSet_load();
			somElectronicDataSet_load();
		});	
	}	
}
//链接删除法定代表人员附件功能
function delLegalPeopleUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDeleteLegalPeople(\'' + winLegalPeopleElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除法定代表人员附件
function clickDeleteLegalPeople(index){
	var record= winLegalPeopleElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
			command.setParameter("record",record);
			command.execute("delElectronicAndDutyElectronic");
			if (!command.error) {
				winLegalPeopleElectronicDataSet_load();	
				L5.Msg.alert('提示','删除成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
//链接下载法定代表人员附件功能
function clickDownloadLegalPeopleHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId").split(";");
	if(ids[0]==""){
		return "";
	}
	if(ids[0]!="" && ids[1]==null){
		var url0=paths[0]+'/'+paths[1]+"/download?table=som_electronic&column=files&pk=electronic_id&filename=file_name&electronic_id='"+ids[0]+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}
	return '<a href="javascript:clickDownloadLegalPeople(\'' + somLegalPeopleElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
}
//打开下载多个法定代表人员附件窗口
function clickDownloadLegalPeople(index){
    var record= somLegalPeopleElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
	var ids = record.get("electronicId");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("ids",ids);
	downloadDataSet.load();
	var win = L5.getCmp("downloadWin");
	win.show();
}
//清空法定代表人电子档案
function somLegalPeopleElectronicDeleteDataSet_load(){
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("taskCode",taskCode);
	command.setParameter("fileCodes",fileCodeF);
	command.setParameter("dutyId",legalDutyId);
	command.execute("delLegalElectronicAndDutyElectronic");
	somLegalPeopleElectronicDataSet_load();
	somElectronicDataSet_load();
}
//----------------------------------------------------------归档法律要件-----------------------------------------------------------
//打开上传窗口后电子档案列表加载
function winElectronicDataSetForArchive_load(){
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	
	var sorgIdSelected = selected[0].get("sorgId");
	var taskCodeSelected = selected[0].get("taskCode");
	var applyTypeSelected = selected[0].get("applyType");
	var catalogCodeSelect = selected[0].get("catalogCode");
	var electronicIds = selected[0].get("electronicId");
	var fileCode = selected[0].get("fileCode");
	if(fileCode_noUpLoad.indexOf(fileCode)!=-1){
		var dutyPeopleDataSet = L5.DatasetMgr.lookup("dutyPeopleDataSet");
		dutyPeopleDataSet.setParameter("SORG_ID",sorgIdSelected);
		dutyPeopleDataSet.setParameter("TASK_CODE",taskCodeSelected);
		if(fileCode_legalPeople.indexOf(fileCode)!=-1){
			dutyPeopleDataSet.setParameter("SORG_DUTIES","00012");//法定代表人或者单位负责人					
		}
		if("S018,S074,J016,J064".indexOf(fileCode)!=-1){
			dutyPeopleDataSet.setParameter("SORG_DUTIES!=","00012,00006");//非法定代表人或者监事
		}
		if("S059,S064,S072,S087,J046,J055,J061,J072".indexOf(fileCode)!=-1){
			dutyPeopleDataSet.setParameter("SORG_DUTIES=","00002");//分支负责人
		}
		
		dutyPeopleDataSet.load();
		winElectronicDataSet.removeAll();
	}else{
		winElectronicDataSet.setParameter("sorgId",sorgIdSelected);
		winElectronicDataSet.setParameter("taskCode",taskCodeSelected);
		winElectronicDataSet.setParameter("applyType",applyTypeSelected);
		winElectronicDataSet.setParameter("catalogCode",catalogCodeSelect);
		winElectronicDataSet.setParameter("electronicIds",electronicIds);
		winElectronicDataSet.load();
	}
}
//弹出上传附件窗口
function uploadForArchive(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	winElectronicDataSetForArchive_load();
	var fileCode = selected[0].get("fileCode");
	if(fileCode_noUpLoad.indexOf(fileCode)!=-1){
		//关联人员（法定代表人、负责人）的法律要件
		var win=L5.getCmp("uploadList2");
		win.show();
	}else{	
		//不关联人员（法定代表人、负责人）的法律要件
		var win=L5.getCmp("uploadList");
		win.show();
	}
}
//归档上传列表窗口中点击人员列表的事件
function clickEventForUploadOfArchive(){
	var uploadListGrid2 = L5.getCmp("uploadListGrid2");
	uploadListGrid2.on("rowclick",function(){
		var selected= uploadListGrid2.getSelectionModel().getSelections();
		if(selected.length==1){
			var dutyId = selected[0].get("dutyId");
			winElectronicDataSet.setParameter("dutyId",dutyId);
			winElectronicDataSet.load();
		}
	});
}
//增加上传附件
function addUploadFileForArchive(){
	var uploadListGrid2 = L5.getCmp("uploadListGrid2");
	var selected= uploadListGrid2.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.Msg.alert('提示',"请先选择人员!");
		return false;
	}
	var win=L5.getCmp("uploadWin2");
	win.show();
}
//关闭附件列表窗口
function closeUploadFileForArchive(){
	var win = L5.getCmp("uploadList2");
	win.hide();
}
//归档中关联人员（法定代表人、负责人）附件窗口点击上传
function click_uploadForArchive(){
	if(_$("files2")=="" || _$("files2")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	record.set("sorgId",sorgId);
	var uploadListGrid2 = L5.getCmp('uploadListGrid2');
	var selected=uploadListGrid2.getSelectionModel().getSelections();
	var dutyId = selected[0].get("dutyId");
	record.set("dutyId",dutyId);
	
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("fileMess",_$("fileMess2"));
	command.setParameter("uploadRd",record);
	command.setForm("form_content2");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
				var win=L5.getCmp("uploadWin2");
				win.hide();
			});
			winElectronicDataSetForArchive_load();
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}	
}
function close_uploadForArchive(){
	var win = L5.getCmp("uploadWin2");
	win.hide();
}
//归档中关联人员（法定代表人、负责人）链接删除附件功能
function delUploadFileForArchive(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDeleteForArchive(\'' + winElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//归档中关联人员（法定代表人、负责人）点击删除附件
function clickDeleteForArchive(index){
	var record= winElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var electronicId = record.get("electronicId");
			var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
			command.setParameter("electronicId",electronicId);
			command.execute("delElectronic");
			if (!command.error) {
				winElectronicDataSetForArchive_load();	
				L5.Msg.alert('提示','删除成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
//打开下载多个法定代表人员附件窗口
function clickDownloadHrefForArchive(value,cellmeta,record,rowindex,colindex,dataset){
	var fileCode = record.get("fileCode");
	if(fileCode_noUpLoad.indexOf(fileCode)!=-1){
		//关联人员（法定代表人、负责人）的法律要件下载
		var paths = document.location.pathname.split("/");
		var ids = record.get("electronicId").split(";");
		if(ids[0]==""){
			return "";
		}
		return '<a href="javascript:clickDownloadForArchive(\'' + somElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
	}else{	
		//不关联人员（法定代表人、负责人）的法律要件下载
		return clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset);
	}
}
//打开关联人员（法定代表人、负责人）的下载附件窗口
function clickDownloadForArchive(index){
    var record= somElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
    var fileCode = record.get("fileCode");
	//var ids = record.get("electronicId");
	var dutyPeopleDataSet = L5.DatasetMgr.lookup("dutyPeopleDataSet");
	dutyPeopleDataSet.setParameter("SORG_ID",record.get("sorgId"));
	dutyPeopleDataSet.setParameter("TASK_CODE",record.get("taskCode"));
	if(fileCode_legalPeople.indexOf(fileCode)!=-1){
		dutyPeopleDataSet.setParameter("SORG_DUTIES","00012");//法定代表人或者单位负责人					
	}
	if("S018,S074,J016,J064".indexOf(fileCode)!=-1){
		dutyPeopleDataSet.setParameter("SORG_DUTIES!=","00012,00006");//非法定代表人或者监事
	}
	if("S059,S064,S072,S087,J046,J055,J061,J072".indexOf(fileCode)!=-1){
		dutyPeopleDataSet.setParameter("SORG_DUTIES=","00002");//分支负责人
	}
	dutyPeopleDataSet.load();
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.removeAll();
	var win = L5.getCmp("downloadWin2");
	win.show();
}
//关联人员（法定代表人、负责人）的下载列表点击人员事件
function clickEventForDownLoadOfArchive(){
	var uploadListGrid4 = L5.getCmp("uploadListGrid4");
	uploadListGrid4.on("rowclick",function(){
		var selected= uploadListGrid4.getSelectionModel().getSelections();
		if(selected.length==1){
			var dutyId = selected[0].get("dutyId");
			var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
			downloadDataSet.setParameter("dutyId",dutyId);
			downloadDataSet.load();
		}
	});
}
//关闭下载窗口
function winClosedownload2(){
	var win = L5.getCmp("downloadWin2");
	win.hide();
}
//分组规则-----------------------------------------------------------------------------------------------------------------
/**
 * 根据这个返回值去决定分组，比如两个record都返回同样一个值，那就将这个record放到一组中,并且将返回值作为分组栏显示的字符串。
 * @param val	record对应的field的值
 * @param unused 空的对象
 * @param rec	reocrd，当前处理record
 * @param rowIndex	行索引
 * @param colIndex	列索引
 * @param ds	grid绑定的dataset
 * @returns	返回处理后的value
 */
function grender(val,unused,rec,rowIndex,colIndex,ds){
	var name = "";
	var applyTypeArr = applyTypeNameStr.split(",");
	for(var i=0;i<applyTypeArr.length;i++){
		if(applyTypeArr[i].indexOf(ds.getAt(rowIndex).get("applyType"))!= -1){
			name = applyTypeArr[i].split(":")[1];
		}
	}
	return name+"    创建时间："+ds.getAt(rowIndex).get("createTime");
}


function applyTypeJsonInit(){
	var command = new L5.Command("com.inspur.cams.sorg.util.ApplyTypeReflectUtil");
	command.execute("reflectAll");
	applyTypeNameStr = command.getReturn("applyTypeNameStr");
	
}
var uploadRecord="";//供弹出的文拍仪扫描页面调用
function addUploadFileEquipment(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
	var fileCodeSelect = selected[0].get("fileCode");
    if(fileCode_noUpLoad.indexOf(fileCodeSelect) != -1){
    	L5.Msg.alert('提示',"此法律要件无法上传!");
		return false;
    }
	uploadRecord=selected[0];
	uploadRecord.set("sorgId",sorgId);
	var theURL=L5.webPath+"/jsp/cams/sorg/comm/upload/equipmentScanUpload/fileupload.jsp?type=normal";
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);
	
}
//供文拍仪弹出窗口调用
function uploadWinHide(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}
function winElectronicDataSetload(){
	winElectronicDataSet_load();
}

function getUploadRecord(){
	return uploadRecord;
}
function addUploadFileForArchiveEquipment(){
	var uploadListGrid2 = L5.getCmp("uploadListGrid2");
	var selected= uploadListGrid2.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.Msg.alert('提示',"请先选择人员!");
		return false;
	}
	uploadRecord=selected[0];
	uploadRecord.set("sorgId",sorgId);
	var theURL=L5.webPath+"/jsp/cams/sorg/comm/upload/equipmentScanUpload/fileupload.jsp?type=normal";
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);
	
}
//弹出上传负责人附件窗口
function uploadPeopleFileEquipment(){
	var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	uploadRecord=selected[0];
	uploadRecord.set("sorgId",sorgId);
	var theURL=L5.webPath+"/jsp/cams/sorg/comm/upload/equipmentScanUpload/fileupload.jsp?type=people";
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);
}
function winPeopleElectronicDataSetload(){
	winPeopleElectronicDataSet_load();
}

//弹出上传法定代表人人附件窗口
function uploadLegalPeopleFileEquipment(){
	var selected=L5.getCmp('uploadLegalPeopleGrid').getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	uploadRecord=selected[0];
	uploadRecord.set("sorgId",sorgId);
	var theURL=L5.webPath+"/jsp/cams/sorg/comm/upload/equipmentScanUpload/fileupload.jsp?type=legalPeople";
	var   hPopup   =   window.open(theURL,"HideWin","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    //hPopup.blur();
    hPopup.resizeTo(screen.availWidth,   screen.availHeight);
}
function winLegalPeopleElectronicDataSetload(){
	winLegalPeopleElectronicDataSet_load();
}

function clickSavePieceNumber(){
	var somElectronicDataSet=L5.DatasetMgr.lookup("somElectronicDataSet");
	var somElectronicRecords = somElectronicDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("somElectronicRecords", somElectronicRecords);
	command.execute("savePieceNumber");
	var status = command.getReturn("status");
		if(status == 0){
			L5.Msg.alert("提示","保存成功！");
			somElectronicDataSet.commitChanges();
		}
}
function chooseExistFile(){
	var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
	var catalogCodeSelected = selected[0].get("catalogCode");
	var taskCodeSelected = selected[0].get("taskCode");
	var electronicIds = selected[0].get("electronicId");
	winPeopleExistDataSet.setParameter("CATALOG_CODE",catalogCodeSelected);
	winPeopleExistDataSet.setParameter("TASK_CODE",taskCodeSelected);
	winPeopleExistDataSet.load();
	var win = L5.getCmp("uploadExistWindow");
	win.show();
}
//关闭下载窗口
function closeExistWin(){
	var win = L5.getCmp("uploadExistWindow");
	win.hide();
}
function saveExistFile(){
	var selected1=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
	var dutyIdSelected = selected1[0].get("dutyId");
	var selected=L5.getCmp('uploadExistGrid').getSelectionModel().getSelections();
	if(selected.length < 1 ){
		L5.Msg.alert("提示","请先选中一条附件！");
		return false;
	}
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("dutyId",dutyIdSelected);
	command.setParameter("electronicId",record.get('electronicId'));
	command.execute("saveExistFile");
	if(!command.error){
		L5.Msg.alert("提示","保存成功!",function(){
			var win = L5.getCmp("uploadExistWindow");
			win.hide();
			winPeopleElectronicDataSet_load();
		});
	}else{
		 L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
	}
}