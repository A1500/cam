function init(){
	var ds=L5.DatasetMgr.lookup("ds");
	if(organCode.length==2){
		ds.setParameter("BATCH_TYPE@in","1,2");
	}else{
		ds.setParameter("BATCH_TYPE@!=","0");
	}
	ds.setParameter("ORGAN_CODE@rLIKE",organCode);
	//ds.setParameter("sort","batchMonth");
	//ds.setParameter("dir","desc");
	ds.load();
}
function reQuery(){
	var ds=L5.DatasetMgr.lookup("ds");
	if(organCode.length==2){
		ds.setParameter("BATCH_TYPE@in","1,2");
	}else{
		ds.setParameter("BATCH_TYPE@!=","0");
	}
	ds.setParameter("ORGAN_CODE@RLIKE",organCode);
	ds.load();
}
function query(){
	var ds=L5.DatasetMgr.lookup("ds");
	var organCodequery = getParam("organCodequery");
	var shyjquery = getParam("shyjquery");
	var sjspquery = getParam("sjspquery");
	if(organCodequery==null||organCodequery==""){
		ds.setParameter("ORGAN_CODE@rLIKE",organCode);
	}else{
		if(organCodequery.substring(2, 12) == "0000000000") {
	        var organArea1 = organCodequery.substring(0, 2);
	        ds.setParameter("ORGAN_CODE@rlike", organArea1);
	    } else if (organCodequery.substring(4, 12) == "00000000") {
	        var organArea1 = organCodequery.substring(0, 4);
	        ds.setParameter("ORGAN_CODE@rlike", organArea1);
	    } else if (organCodequery.substring(6, 12) == "000000") {
	        var organArea1 = organCodequery.substring(0, 6);
	        ds.setParameter("ORGAN_CODE@rlike", organArea1);
	    } 
	}
	if(organCode.length==2){
		if(shyjquery=="1"){
			ds.setParameter("BATCH_TYPE@=","1");
		}else if(shyjquery=="2"){
			ds.setParameter("BATCH_TYPE@=","2");
		}else{
			ds.setParameter("BATCH_TYPE@in","1,2");
		}
	}else{
		ds.setParameter("BATCH_TYPE@!=","0");
	}
	if(sjspquery=="0"){
		ds.setParameter("AUDIT_TYPE@is","null");
	}else if(sjspquery=="1"){
		ds.setParameter("AUDIT_TYPE@=","2");
	}else if(sjspquery=="2"){
		ds.setParameter("AUDIT_TYPE@=","4");
	}else if(sjspquery=="3"){
		ds.setParameter("AUDIT_TYPE@=","3");
	}else{
		
	}
	ds.setParameter("BATCH_MONTH@RLIKE",getParam("pre_date"));
	ds.setParameter("BATCH_NAME@LIKE",getParam("pre_name"));
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
	var url = "dicCityCheckDetail.jsp?method=detail&batchId="+records[0].get("batchId");
	var width = screen.availWidth;
    var height = screen.availHeight;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
	/*var data=new L5.Map();
	data.put("method","detail");
	data.put("batchId",records[0].get("batchId"));
	url="jsp/cams/comm/diccityChange/dicCityChangeList.jsp";
	L5.forward(url,'',data);*/
}
function check(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("changeResult")=="2"){
		L5.Msg.alert("提示","已完成，无需重复审批!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否审批该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
			command.setParameter("record",records[0]);
			command.execute("check");
			if (!command.error){
				var dicCityCheckDataSet=L5.DatasetMgr.lookup("dicCityCheckDataSet");
				dicCityCheckDataSet.setParameter("CHANGE_RESULT@=","1");
				dicCityCheckDataSet.load();
			}else{
				L5.Msg.alert("提示","提交出错！");
			}
		}
	});
}
function winShow(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(organCode.length==2){
		if(records[0].get("auditType")=="4"){
			L5.Msg.alert("提示","已完成审批!");
			return;
		}
	}else{
		if(records[0].get("batchType")=="2" || records[0].get("batchType")=="3"){
			L5.Msg.alert("提示","已完成审批!");
			return;
		}
	}
	if(organCode.length==2){
		L5.getCmp("reasonWin2").show();
	}else{
		L5.getCmp("reasonWin").show();
	}
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("BATCH_ID",records[0].get("batchId"));
	queryDs.load();
}
function closeWin(){
	if(organCode.length==2){
		L5.getCmp("reasonWin2").hide();
	}else{
		L5.getCmp("reasonWin").hide();
	}
	
}
function confirm(){
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	var record = queryDs.getCurrent();
	//省级审核意见不能为空
	if(organCode.length==2){
		if(record.get("auditType")=="3"){
			record.set("batchType","3");
		}
		if(document.getElementById("auditType").value==""){
			L5.Msg.alert("提示","审批意见不能为空！");
			return;
		}
	}else{
		if(document.getElementById("batchType").value==""){
			L5.Msg.alert("提示","审批意见不能为空！");
			return;
		}
	}
	L5.MessageBox.confirm("提示", "是否提交该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchCmd");
			//维护审批时间
			if(organCode.length==4){
				record.set("checkTime",new Date());
			}else{
				record.set("auditTime",new Date());
			}
			command.setParameter("record",record);
			command.execute("update");
			if (!command.error){
				closeWin();
				reQuery();
			}else{
				L5.Msg.alert("提示","提交出错！");
			}
		}
	});
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

function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&level=2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organCodequery").value = list[0];
		document.getElementById("organNamequery").value = list[1];
	}
}

function batchNameRender(val,el,rec,rowIndex,colIndex,ds,field,grid){
	var desc;
	if(rec.get("batchType")=="1"){
		desc= '<font color="red">' + val + '</font>';
	}else{
		desc= '<font color="blue">' + val + '</font>';
	}
	return desc;
}
/*function numHref(val,el,rec,rowIndex,colIndex,ds,field,grid){
	var changeDs=L5.DatasetMgr.lookup("changeDs");
	var records=grid.getSelectionModel().getSelections();
	changeDs.setParameter("BATCH_ID",records[0].get("batchId"));
	changeDs.load();
	
	return changeDs.getCount();
}*/