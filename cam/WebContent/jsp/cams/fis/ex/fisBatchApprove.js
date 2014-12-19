var win_check;
var status = "";
function init(){
	var fisBatchApproveDs=L5.DatasetMgr.lookup("fisBatchApproveDS");
	if(organCode.substring(2, 12) == "0000000000") {
        var organArea1 = organCode.substring(0, 2);
        fisBatchApproveDs.setParameter("ORGAN_CODE@rlike", organArea1);
    } else if (organCode.substring(4, 12) == "00000000") {
        var organArea1 = organCode.substring(0, 4);
        fisBatchApproveDs.setParameter("ORGAN_CODE@rlike", organArea1);
    } else if (organCode.substring(6, 12) == "000000") {
        var organArea1 = organCode.substring(0, 6);
        fisBatchApproveDs.setParameter("ORGAN_CODE@rlike", organArea1);
    }
    fisBatchApproveDs.setParameter("CREATE_ORGAN@rlike", "BZ"+organCode.substring(0, 6));
	fisBatchApproveDs.load(true);
}
function query(){
	var ds=L5.DatasetMgr.lookup("fisBatchApproveDS");
	ds.setParameter("CREATE_ORGAN_NAME@LIKE",getParam("create_Organ_Name"));
	ds.setParameter("APPLY_STATUS@=",getParam("apply_status"));
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
	ds.setParameter("CREATE_ORGAN@rlike", "BZ"+organCode.substring(0, 6));
	ds.load();
}
function getParam(name){
	return document.getElementById(name).value;
}
function insert(){
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var priceApplyId=command.getReturn("id");
	var fisFuneralDS=L5.DatasetMgr.lookup("fisFuneralDS");
	fisFuneralDS.setParameter("filterSql", "  ORGAN_CODE LIKE  '" + organCode.substring(0, 6) + "%'");
	fisFuneralDS.load();
	win_check=L5.getCmp("funeraChoice");
	var fisBatchDS=L5.DatasetMgr.lookup("fisBatchDS");
	fisBatchDS.newRecord({"priceApplyId":priceApplyId,"applyStatus":"0","itemNums":"0","organCode":organCode,"organName":organName,"createPeople":organId,"ifBull":"1","validFlag":"1"});
	status="insert";
	win_check.show();
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("applyStatus")=="1"){
		L5.Msg.alert("提示","已上报不能修改!");
		return;
	}
	var fisBatchDS=L5.DatasetMgr.lookup("fisBatchDS");
	fisBatchDS.setParameter("PRICE_APPLY_ID@=",records[0].get("priceApplyId"));
	fisBatchDS.load(true);
	var fisFuneralDS=L5.DatasetMgr.lookup("fisFuneralDS");
	fisFuneralDS.setParameter("filterSql", "  ORGAN_CODE LIKE  '" + organCode.substring(0, 6) + "%'");
	fisFuneralDS.load();
	status="update";
	win_check=L5.getCmp("funeraChoice");
	win_check.show();
}
function submit(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("applyStatus")!="0" && records[0].get("applyStatus")!="2" && records[0].get("applyStatus")!="5"){
		L5.Msg.alert("提示","已上报不能重复上报!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceApplyCommand");
			records[0].set("applyStatus","1");
			command.setParameter("record",records[0]);
			command.execute("update");
			if (!command.error){
				close();
				L5.Msg.alert("提示","上报成功!");
				init();
			}else{
				L5.Msg.alert("提示","上报出错！"+command.error);
			}
		}
	});
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("applyStatus")!="0"){
		L5.Msg.alert("提示","已上报不能删除!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceApplyCommand");
			command.setParameter("priceApplyId",records[0].get("priceApplyId"));
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
	win_check=L5.getCmp("funeraChoiceDetail");
	win_check.show();
}

function save_win(){
	//查询是否有未审核完的数据
	var queryDs=L5.DatasetMgr.lookup("fisBatchApproveDS");
	queryDs.setParameter("CREATE_ORGAN@=", document.getElementById("createOrgan").value);
	queryDs.setParameter("APPLY_STATUS@!=","9");
	queryDs.load(true);
	if(queryDs.getCount()!=0&&queryDs.getAt(0).get("applyStatus")!="0"){
		L5.Msg.alert("提示","该馆有未完成审核的批次，请等待审核完再录入新批次!");
		return;
	}
	var fisBatchDS=L5.DatasetMgr.lookup("fisBatchDS");
	var valid=fisBatchDS.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示",valid);
		return false;
	}
	var record = fisBatchDS.getCurrent();
	var obj=document.getElementById("createOrgan");
    var createOrganName=obj.options[obj.selectedIndex].text;
	record.set("createOrganName",createOrganName);
	var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceApplyCommand");
	command.setParameter("record",record);
	if(status=="update"){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功");
		close_win();
		init();
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function close_win(){
	win_check.hide();
}

//链接明细
function editHref(value,cellmeta,record,rowindex,colindex,dataset){
		return 	'<a href="javascript:forDetail(\''+record.get("priceApplyId")+'\',\''+record.get("createOrgan")+'\')">'+value+'</a>';
}
function forDetail(priceApplyId,createOrgan){
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
	data.put("createOrgan",createOrgan);//殡仪馆编码
	data.put("applyStatus",record.get("applyStatus"));
	data.put("createOrganName",encodeURIComponent(encodeURIComponent(record.get("createOrganName"))));//殡仪馆名称
	url="jsp/cams/fis/ex/fisPriceGoodsService.jsp";
	L5.forward(url,'',data);
   
}
//点击下载省厅发文
function downloadWord() {
	var url = L5.webPath
			+ "/download?table=FIS_PRICE_APPLY_ATTACH&column=attach_content&pk=attach_id&filename=attach_name&attach_id='shengtingfawen[2014]149'";
	window.open(url);
}
//点击下载操作手册
function downloadBook() {
	var url = L5.webPath
			+ "/download?table=FIS_PRICE_APPLY_ATTACH&column=attach_content&pk=attach_id&filename=attach_name&attach_id='caozuoshouce001'";
	window.open(url);
}
/********************************上传***********************************/
function uploadFile(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("applyStatus")!="0"&&records[0].get("applyStatus")!="2"&&records[0].get("applyStatus")!="5"){
		L5.Msg.alert("提示","业务正在办理,不能上传附件!");
		return;
	}
	if(records[0].get("applyStatus")=="9"){
		L5.Msg.alert("提示","业务已办结,不能上传附件!");
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
	var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceApplyAttachCmd");
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
	//链接删除附件功能
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	/*var ds=L5.DatasetMgr.lookup("fisBatchApproveDS");
	ds.setParameter("PRICE_APPLY_ID@=",record.get("priceApplyId"));
	ds.load(true);
	var records = ds.getCurrent();*/
	/*if(records.get("batchType")!="0" && records.get("batchType")!="3"){
		return "";
	}*/
	return '<a href="javascript:clickDelete(\'' + downloadDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除附件
function clickDelete(index){
	var attachDataSet=L5.DatasetMgr.lookup("attachDataSet");
	attachDataSet.load(true);
	var record= attachDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceApplyAttachCmd");
			command.setParameter("delId",record.get("attachId"));
			command.execute("delete");
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！');
				downloadDataSet.setParameter("PRICE_APPLY_ID@=",record.get("priceApplyId"));
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
function readPublic() {
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var funeral_code=records[0].get("createOrgan");
	var url = '../../../ext/onlineService/fis/query/apply/fisServiceQuery.jsp?funeral_code='+funeral_code;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
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