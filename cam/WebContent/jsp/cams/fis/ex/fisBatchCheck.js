var win_check;
var status = "";
function init(){
	var fisBatchApproveDs=L5.DatasetMgr.lookup("fisBatchApproveDS");
	if(organCode.substring(2, 12) == "0000000000") {
        var organArea1 = organCode.substring(0, 2);
        fisBatchApproveDs.setParameter("ORGAN_CODE@rlike", organArea1);
        fisBatchApproveDs.setParameter("APPLY_STATUS@in","3,9");
    } else if (organCode.substring(4, 12) == "00000000") {
        var organArea1 = organCode.substring(0, 4);
        fisBatchApproveDs.setParameter("ORGAN_CODE@rlike", organArea1);
        fisBatchApproveDs.setParameter("APPLY_STATUS@in","1,3");
    } else if (organCode.substring(6, 12) == "000000") {
        var organArea1 = organCode.substring(0, 6);
        fisBatchApproveDs.setParameter("ORGAN_CODE@rlike", organArea1);
    } 
	fisBatchApproveDs.setParameter("VALID_FLAG@=","1");
	fisBatchApproveDs.load(true);
}
function query(){
	var ds=L5.DatasetMgr.lookup("fisBatchApproveDS");
	ds.setParameter("CREATE_ORGAN_NAME@LIKE",getParam("create_Organ_Name"));
	ds.setParameter("APPLY_STATUS@=","1");
	if(organCode.substring(2, 12) == "0000000000") {
        var organArea1 = organCode.substring(0, 2);
        ds.setParameter("ORGAN_CODE@rlike", organArea1);
    } else if (organCode.substring(4, 12) == "00000000") {
        var organArea1 = organCode.substring(0, 4);
        ds.setParameter("ORGAN_CODE@rlike", organArea1);
    } else if (organCode.substring(6, 12) == "000000") {
        var organArea1 = organCode.substring(0, 6);
        ds.setParameter("ORGAN_CODE@rlike", organArea1);
    } 
	ds.setParameter("VALID_FLAG@=","1");
	ds.load();
}
function getParam(name){
	return document.getElementById(name).value;
}

function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var fisBatchDS=L5.DatasetMgr.lookup("fisBatchDS");
	fisBatchDS.setParameter("PRICE_APPLY_ID@=",records[0].get("priceApplyId"));
	fisBatchDS.load(true);
	status="detail";
	if(win_check==undefined){
		win_check=L5.getCmp("funeraChoiceDetail");
	}
	win_check.show();
}

function close_win(){
	win_check.hide();
}

//链接明细
function editHref(value,cellmeta,record,rowindex,colindex,dataset){
		return 	'<a href="javascript:forDetail(\''+record.get("priceApplyId")+'\')">'+value+'</a>';
}
function forDetail(priceApplyId){
	var data=new L5.Map();
	var fisBatchDS=L5.DatasetMgr.lookup("fisBatchDS");
	fisBatchDS.setParameter("PRICE_APPLY_ID@=",priceApplyId);
	fisBatchDS.load(true);
	var record = fisBatchDS.getCurrent();
	if(record.get("applyStatus")!="0" && record.get("applyStatus")!="2" && record.get("applyStatus")!="5"){
		data.put("method","detail");
	}else{
		data.put("method","insert");
	}
	data.put("priceApplyId",priceApplyId);
	data.put("createOrgan",record.get("createOrgan"));//殡仪馆编码
	data.put("applyStatus",record.get("applyStatus"));
	data.put("createOrganName",encodeURIComponent(encodeURIComponent(record.get("createOrganName"))));//殡仪馆名称
	url="jsp/cams/fis/ex/fisPriceGoodsService.jsp";
	L5.forward(url,'',data);
}
function check(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("priceApplyId",records[0].get("priceApplyId"));
	data.put("createOrgan",records[0].get("createOrgan"));//殡仪馆编码
	data.put("createOrganName",records[0].get("createOrganName"));//殡仪馆名称
	url="jsp/cams/fis/ex/fisPriceGoodsService.jsp";
	L5.forward(url,'',data);
}
/***********************************下载*************************************/
//链接下载附件功能
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var priceApplyId = record.get("priceApplyId");
	var attachDataSet=L5.DatasetMgr.lookup("attachDataSet");
	attachDataSet.setParameter("PRICE_APPLY_ID",priceApplyId);
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
	return '<a href="javascript:clickDownload(\'' + priceApplyId + '\')">' + '点击下载' + '</a>';
	
}
	//打开下载多个附件窗口
function clickDownload(index){
  var paths = document.location.pathname.split("/");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("PRICE_APPLY_ID",index);
	downloadDataSet.load(true);
	var win = L5.getCmp("downloadWin");
	win.show();
}

//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("attachId");
	var url0=paths[0]+'/'+paths[1]+"/download?table=FIS_PRICE_APPLY_ATTACH&column=attach_content&pk=attach_id&filename=attach_name&attach_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
function closeDownload(){
	L5.getCmp("downloadWin").hide();
}

function colorRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,b) {
	var desc="";
	if(value=="1"){
		value= "已上报";
		desc= '<font color="blue">' + value + '</font>';
	}else if(value=="0"){
		value= "未上报";
		desc= value;
	}else if(value=="2"){
		value= "已驳回审核";
		desc= '<font color="red">' + value + '</font>';
	}else if(value=="3"){
		value= "已审核";
		desc= '<font color="yellow">' + value + '</font>';
	}else if(value=="5"){
		value= "已备案驳回";
		desc= '<font color="red">' + value + '</font>';
	}else if(value=="9"){
		value= "已备案";
		desc= '<font color="green">' + value + '</font>';
	}
	 return desc;
}