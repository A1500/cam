var count = "";
var ciitcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
ciitcommand.setParameter("id",organCode);
ciitcommand.execute("getNameById");
var cityName = ciitcommand.getReturn("cityName");
function init(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("ORGAN_CODE@=",organCode);
	ds.setParameter("sort","batchMonth");
	ds.setParameter("dir","desc");
	ds.load(true);
	
	if(ds.getCount()==0){
		count="1";
	}else{
		count = ds.getAt(0).get("submitTiems")=="-1"?"无限制":ds.getAt(0).get("submitTiems");
		
	}
}
function query(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("BATCH_MONTH@RLIKE",getParam("pre_date"));
	ds.setParameter("BATCH_NAME@LIKE",getParam("pre_name"));
	ds.setParameter("AUDIT_TYPE@=",getParam("audit_type"));
	ds.setParameter("ORGAN_CODE@=",organCode);
	ds.load();
}
function getParam(name){
	return document.getElementById(name).value;
}

function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("batchType")!="0" && records[0].get("batchType")!="3"){
		L5.Msg.alert("提示","已提交不能删除!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchCmd");
			command.setParameter("batchId",records[0].get("batchId"));
			command.execute("deleteAll");
			if (!command.error){
				L5.Msg.alert("提示","删除成功!");
				init();
			}else{
				L5.Msg.alert("提示","删除出错！"+command.error);
			}
		}
	});
}
function edit(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("batchType")!="0" && records[0].get("batchType")!="3"){
		L5.Msg.alert("提示","已提交不能修改!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("batchId",records[0].get("batchId"));
	url="jsp/cams/comm/diccityChange/dicCityChangeList.jsp";
	L5.forward(url,'',data);
}
function winShow(){
	var ds=L5.DatasetMgr.lookup("changeDs");
	//查询当月批次是否超过次数
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("ORGAN_CODE@=",organCode);
	queryDs.setParameter("BATCH_MONTH@=",new Date().toString());
	queryDs.load(true);
	if(queryDs.getCount()!=0){
		var record = queryDs.getAt(0);
		if(record.get("submitTiems")!=-1){
			if(queryDs.getCount()>=record.get("submitTiems")){
				alert("批次数超过当日最大限制!一天只能提交一个批次!");
				return;
			}
		}
	}
	ds.newRecord({"batchId":batchId,"organCode":organCode,"organName":cityName,"batchMonth":new Date().toString(),"submitTiems":"1","batchType":"0","city":city});
	L5.getCmp("batchWin").show();
	document.getElementById("tipsLabel").innerHTML="<font color='red'>提示：每日最多上报1个批次行政区划调整！<font>";
}
function closeWin(){
	L5.getCmp("batchWin").hide();
}
var status = "";
function show(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("batchType")!="0" && records[0].get("batchType")!="3"){
		L5.Msg.alert("提示","已提交不能修改!");
		return;
	}
	var ds=L5.DatasetMgr.lookup("changeDs");
	ds.setParameter("BATCH_ID@=",records[0].get("batchId"));
	ds.load(true);
	status= "update";
	L5.getCmp("batchWin").show();
	document.getElementById("tipsLabel").innerHTML="<font color='red'>提示每月最多上报 "+count+" 次行政区划调整<font>";
}
function confirm(){
	if(document.getElementById("batchMonth").value==""){
		L5.Msg.alert("提示","批次日期不能为空");
		return;
	}
	if(document.getElementById("batchName").value==""){
		L5.Msg.alert("提示","批次名称不能为空");
		return;
	}
	var applyPhone=document.getElementById("applyPhone").value;
	var applyPeo=document.getElementById("applyPeo").value;
	if(applyPhone==""){
		L5.Msg.alert("提示","联系电话不能为空！");
		return;
	}
	if(applyPeo==""){
		L5.Msg.alert("提示","申请人不能为空！");
		return;
	}
	var ds=L5.DatasetMgr.lookup("changeDs");
	
	var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchCmd");
	command.setParameter("record",record);
	if(status=="update"){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功");
		closeWin();
		init();
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
//链接明细
function editHref(value,cellmeta,record,rowindex,colindex,dataset){
		return 	'<a href="javascript:detail(\''+record.get("batchId")+'\')">'+value+'</a>';
}
function detail(batchId){
	var data=new L5.Map();
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("BATCH_ID@=",batchId);
	queryDs.load(true);
	var record = queryDs.getCurrent();
	if(record.get("batchType")!="0" && record.get("batchType")!="3"){
		data.put("method","detail");
	}else{
		data.put("method","insert");
	}
	data.put("batchId",batchId);
	url="jsp/cams/comm/diccityChange/dicCityChangeList.jsp";
	L5.forward(url,'',data);
   
}
function submit(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("batchType")!="0" && records[0].get("batchType")!="3"){
		L5.Msg.alert("提示","已提交不能重复提交!");
		return;
	}
	var transcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
	transcommand.setParameter("batchId",records[0].get("batchId"));
	transcommand.execute("queryTrans");
	var transTips = transcommand.getReturn("transTips");
	if(transTips){
		L5.Msg.alert("提示",transTips);
		return;
	}
	L5.MessageBox.confirm("提示", "是否提交该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchCmd");
			records[0].set("batchType","1");
			records[0].set("submitDate",new Date());
			command.setParameter("record",records[0]);
			command.execute("update");
			if (!command.error){
				close();
				L5.Msg.alert("提示","提交成功!");
				init();
			}else{
				L5.Msg.alert("提示","提交出错！"+command.error);
			}
		}
	});
}

/********************************上传***********************************/
function uploadFile(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("batchType")!="0" && records[0].get("batchType")!="3"){
		L5.Msg.alert("提示","业务正在办理,不能上传附件!");
		return;
	}
	var win=L5.getCmp("uploadWin");
	win.show();
}
function click_upload(){
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('grid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchAttachCmd");
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
				init();
			});
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
      }
}
//上传文件关闭窗口
function close_upload(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}
/***********************************下载*************************************/
//链接下载附件功能
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var batchId = record.get("batchId");
	var attachDataSet=L5.DatasetMgr.lookup("attachDataSet");
	attachDataSet.setParameter("BATCH_ID",batchId);
	attachDataSet.load(true);
	if(attachDataSet.getCount()!=0){
		var ids = attachDataSet.getAt(0).get("attachId");
	}else{
		return "";
	}
	/*if(attachDataSet.getCount()==1){
		var url0=paths[0]+'/'+paths[1]+"/download?table=dic_city_change_batch_attach&column=attach_content&pk=attach_id&filename=attach_name&attach_id='"+ids+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}*/
	return '<a href="javascript:clickDownload(\'' + batchId + '\')">' + '点击下载' + '</a>';
	
}
	//打开下载多个附件窗口
function clickDownload(index){
    var paths = document.location.pathname.split("/");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("BATCH_ID",index);
	downloadDataSet.load(true);
	var win = L5.getCmp("downloadWin");
	win.show();
}

//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("attachId");
  	var url0=paths[0]+'/'+paths[1]+"/download?table=dic_city_change_batch_attach&column=attach_content&pk=attach_id&filename=attach_name&attach_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
function closeDownload(){
	L5.getCmp("downloadWin").hide();
}
	//链接删除附件功能
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("queryDs");
	ds.setParameter("BATCH_ID@=",record.get("batchId"));
	ds.load(true);
	var records = ds.getCurrent();
	if(records.get("batchType")!="0" && records.get("batchType")!="3"){
		return "";
	}
	return '<a href="javascript:clickDelete(\'' + downloadDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除附件
function clickDelete(index){
	var attachDataSet=L5.DatasetMgr.lookup("attachDataSet");
	attachDataSet.load(true);
	var record= attachDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchAttachCmd");
			command.setParameter("delId",record.get("attachId"));
			command.execute("delete");
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！');
				downloadDataSet.setParameter("BATCH_ID@=",record.get("batchId"));
				downloadDataSet.load();
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
