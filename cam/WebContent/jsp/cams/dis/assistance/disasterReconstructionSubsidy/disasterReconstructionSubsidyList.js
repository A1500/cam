function init() {
	if(batchDetailId!=""&&batchDetailId!=null){
		ds.setParameter("batchDetailId",batchDetailId);
		ds.load();
	}//初始化查询
	
};
/**
 * 查询按钮
 */
function query(){
	var cx_name = document.getElementById("cx_name").value;
	var cx_villiageCode = _$("cx_villiageCode");
	if(cx_name!=""&&cx_name!=null){
		ds.setParameter("cx_name", cx_name);
	}
	if(cx_villiageCode!=""&&cx_villiageCode!=null){
		ds.setParameter("cx_villiageCode",cx_villiageCode);
	}
	if(batchDetailId!=""&&batchDetailId!=null){
		ds.setParameter("batchDetailId",batchDetailId);
	}
	ds.load();
}
/**
 * 添加按钮
 */
function add(){
	var url='disasterReconstructionSubsidyEdit.jsp?method=insert&batchDetailId='+batchDetailId;
	var width = 900;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if(true || win){
		ds.reload();
	}
}
/**
 * 删除按钮
 */
function deleteBatch(){
	var editGrid = L5.getCmp('disasterReconstructionSubsidyGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length<1) {
		L5.Msg.alert('提示', "请选择所要删除的记录!");
		return false;
	}
	var state=confirm('确定要删除选中的记录吗?');
	if(state==true){
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.AssistanceCommand");
		command.setParameter("records",selected);
		if(batchDetailId!=""&&batchDetailId!=null){
			command.setParameter("batchDetailId",batchDetailId);
		}
		command.execute("deleteBatch");
		if(!command.error){
			for(var i=0;i<selected.length;i++){
				ds.remove(selected[i]);
			}
			ds.commitChanges();
			L5.Msg.alert('提示',"删除成功！");
			ds.reload();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}else{
		return false;
	}
}
/**
 * 修改按钮
 */
function edit(){
	var editGrid=L5.getCmp('disasterReconstructionSubsidyGrid');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var cx_infoId = selected[0].get('INFO_ID');
	var cx_recordId = selected[0].get('RECORD_ID');
	var url='disasterReconstructionSubsidyEdit.jsp?method=update&cx_infoId='+cx_infoId+'&cx_recordId='+cx_recordId;
	var width = 900;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if(win==true){
		ds.reload();
	}else{
		
	}
}
/**
 * 明细按钮
 */
function detail(){
	var editGrid=L5.getCmp('disasterReconstructionSubsidyGrid');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录明细!");
		return false;
	}
	var cx_infoId = selected[0].get('INFO_ID');
	var cx_recordId = selected[0].get('RECORD_ID');
	var url='disasterReconstructionSubsidyDetail.jsp?cx_infoId='+cx_infoId+'&cx_recordId='+cx_recordId;
	var width = 900;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}
/**
 * 返回按钮
 */
function undo(){
	history.go(-1);
}

/**
 * 选择住址行政区划窗口
 */
function forOrganSelect() {
	var revalue = window.showModalDialog(
			L5.webPath+"/jsp/cams/dis/assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("cx_villiageCode").value=list[0];
		document.getElementById("areaName").value=list[4];
	}
}

/**
 * 打印人员信息按钮
 */
function printPeople(){
	return;
	printDs.setParameter("batchDetailId",batchDetailId);
	printDs.setParameter("ifAll","ifAll");
	printDs.load();
	printDs.on("load",function(){
		var printTitle = "";
		printReport(getPrintDataByDataSet(printTitle,printDs),L5.webPath+'/jsp/cams/dis/assistance/cjPrint1.fr3');
	});
}
function getPrintDataByDataSet(reportName,printDataset){
		var dqsj=new Date();
		var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
		xmlStr+="<Report ReportName='灾区民房恢复重建补助' Creater='" +dqsj+"' >";
		var records=printDataset.getAllRecords();
		var n=records.length;
		if(records.length==0){return;}
		for(i=0;i<n;i++){
			xmlStr +="<Info>";
			L5.each(records[i].fields.items,function(item,index){xmlStr+="<"+item.name+">"+records[i].get(item.name)+"</"+item.name+">";});
			xmlStr +="</Info>";
		}
		xmlStr +="</Report>";
		return xmlStr;
}

/**
 * 提交按钮
 */
function selectBatch(){
	if(!confirm('确定要进行提交吗？')){
		return ;
		
	}
	if(ds.getCount()>0){
		//var batchDetailId = selected[0].get('batchDetailId');//获得批次明细主键
		if(batchDetailId!=""&&batchDetailId!=null){
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.AssistanceCommand");
			command.setParameter("batchDetailId", batchDetailId);
			command.execute("selectBatch");
		}
		if(!command.error){
			L5.Msg.alert('提示','提交成功！');
			window.close();
			/*ds.commitChanges();
			ds.reload();*/
		}else{
			L5.Msg.alert('提示','提交失败！'+command.error);
		}
	}else{
		L5.Msg.alert('提示','请先进行填写，再进行提交！');
		return false;
	}
}









