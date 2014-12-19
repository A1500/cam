var companyName = "";

//假肢企业获取企业名称
function getProsthesisName(){
 	wealFitInfoDataSet.setParameter("TASK_CODE@=",taskCode);
	wealFitInfoDataSet.load(true);
	companyName = wealFitInfoDataSet.getAt(0).get("companyName");
}
//福利企业获取企业名称
function getWelfarecorpName(){
 	wealUnitInfoDataSet.setParameter("TASK_CODE@=",taskCode);
	wealUnitInfoDataSet.load(true);
	companyName = wealUnitInfoDataSet.getAt(0).get("companyName");
}

	//电子档案目录初始化
 	function somElectronicDataSet_load(){

 		somElectronicDataSet.setParameter("companyName",companyName);
		somElectronicDataSet.setParameter("applyId",taskCode);
		somElectronicDataSet.setParameter("applyType",applyType);
		somElectronicDataSet.setParameter("companyType",companyType);
		somElectronicDataSet.setParameter("catalogType",catalogType);
		somElectronicDataSet.load(true);
	}
	
	//点击上传打开窗口
 	function clickUploadFile(){
 		var uploadGrid=L5.getCmp('uploadGrid');
		var selected=uploadGrid.getSelectionModel().getSelections();
		if(selected.length<1){
			L5.Msg.alert('提示',"请先选择一条记录!");
			return false;
		}
		ds_load();
		var win=L5.getCmp("uploadList");
		win.show();
 	}
 	
	 	//增加上传附件
	function addUploadFile(){
		var win=L5.getCmp("uploadWin");
		win.show();
		
	}
	//打开上传窗口后电子档案列表加载
	function ds_load(){
		var selected=L5.getCmp('uploadGrid').getSelectionModel().getSelections();
		var catalogId = selected[0].get("catalogId");
		var applyId = selected[0].get("applyId");
		ds.setParameter("CATALOG_ID@=",catalogId);
		ds.setParameter("APPLY_ID",applyId);
		ds.load(true);
	
	}
	
	//打开下载多个附件窗口
function clickDownload(index){
    var record= somElectronicDataSet.getAt(index);
    var paths = document.location.pathname.split("/");
	var ids = record.get("contentId");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("ids",ids);
	downloadDataSet.load();
	var win = L5.getCmp("downloadWin");
	win.show();
}
 	
 	
	//链接删除附件功能
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDelete(\'' + somElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
	
//点击删除附件
function clickDelete(index){
	var record= ds.getAt(0);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var delIds=new Array();
			delIds[0]=record.get("contentId");
			var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealElectronicfileContentCommand");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				ds_load();
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
	
 	//附件窗口点击上传
function click_upload(){
	var fileMess="";
	if(_$("fileMess").length>250){
		L5.Msg.alert('提示',"附件描述不能超过250个字符!");
		return false;
	}else if(_$("fileMess").length<=0){
		fileMess="无描述";
	}else{
		fileMess=_$("fileMess");
	}
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealElectronicfileContentCommand");
	
	record.set("applyId",taskCode);
	command.setParameter("fileMess",fileMess);
	command.setParameter("uploadRd",record);
	command.setForm("form_content");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
			//上传成功关闭当前窗口
				var win=L5.getCmp("uploadWin");
				win.hide();
			//刷新数据
				ds_load();
			});
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
      }
}


//链接下载附件功能
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var ids = record.get("contentId").split(";");
	if(ids[0]==""){
		return "";
	}
	if(ids[0]!="" && ids[1]==null){
		var url0=paths[0]+'/'+paths[1]+"/download?table=weal_electronicfile_content&column=content&pk=content_id&filename=catalog_name&content_id='"+ids[0]+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}
	return '<a href="javascript:clickDownload(\'' + somElectronicDataSet.indexOf(record) + '\')">' + '点击下载' + '</a>';
}

//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("contentId");
    var url0=paths[0]+'/'+paths[1]+"/download?table=weal_electronicfile_content&column=content&pk=content_id&filename=catalog_name&content_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
//上传窗口关闭
function closeUploadFile(){
	var win=L5.getCmp("uploadList");
	win.hide();
	somElectronicDataSet_load();	
}
//关闭下载窗口
function winClosedownload(){
	var win = L5.getCmp("downloadWin");
	win.hide();
}
//上传文件关闭窗口
function close_upload(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}