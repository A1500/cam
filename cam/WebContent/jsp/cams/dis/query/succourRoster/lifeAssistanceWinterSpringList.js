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
	//var cx_villiageCode = document.getElementById("cx_villiageCode").value;
	//var cx_name = document.getElementById("cx_name").value;
	if(batchDetailId!=""&&batchDetailId!=null){
		ds.setParameter("batchDetailId",batchDetailId);
	}
	if(cx_villiageCode!=""&&cx_villiageCode!=null){
		ds.setParameter("cx_villiageCode", cx_villiageCode);
	}
	if(cx_name!=""&&cx_name!=null){
		ds.setParameter("cx_name", cx_name);
	}
	ds.load();
}
/**
 * 添加按钮
 
function add(){
	var url='lifeAssistanceWinterSpringEdit.jsp?method=insert&batchDetailId='+batchDetailId;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	//window.open (url,"text","scroll:yes;status:no;width:"+width+"px;height:"+height+"px;resizable:0");
	if(win==true){
		ds.reload();
	}else{
		
	}
}*/

/**
 * 删除按钮
 
function deleteBatch(){
	var editGrid = L5.getCmp('lifeAssistanceWinterSpringGrid');
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
				L5.Msg.alert('提示',"删除成功！");
			}
			ds.commitChanges();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}else{
		return false;
	}
}*/
/**
 * 修改按钮

function edit(){
	var editGrid=L5.getCmp('lifeAssistanceWinterSpringGrid');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var cx_infoId = selected[0].get('INFO_ID');
	var cx_recordId = selected[0].get('RECORD_ID');
	var url='lifeAssistanceWinterSpringEdit.jsp?method=update&cx_infoId='+cx_infoId+'&cx_recordId='+cx_recordId;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if(win==true){
		ds.reload();
	}else{
		
	}
} */
/**
 * 明细按钮
 */
function detail(){
	var editGrid=L5.getCmp('lifeAssistanceWinterSpringGrid');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录明细!");
		return false;
	}
	var cx_infoId = selected[0].get('INFO_ID');
	var cx_recordId = selected[0].get('RECORD_ID');
	var url='../../assistance/lifeAssistanceWinterSpring/lifeAssistanceWinterSpringDetail.jsp?cx_infoId='+cx_infoId+'&cx_recordId='+cx_recordId;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}

/**
 * 返回按钮

function undo(){
	history.go(-1);
}

 */
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
function printPeople(){
	var editGrid = L5.getCmp('lifeAssistanceWinterSpringGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length<1) {
		L5.Msg.alert('提示', "请选择所要打印的记录!");
		return false;
	}
	
	var url = "peoplePrint.jsp?docPath=peoplePrint.doc";
	var text = '名册打印';
	var width = 1024;
	var height = 768;
	var ifPrint = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:no;status:no;");
}
function exportExcel(){
}


/*function getPrintDataByDataSet(reportName,printDataset){
		var dqsj=new Date();
		var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
		xmlStr+="<Report ReportName='冬春生活救助人员信息' Creater='" +dqsj+"' >";
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
}*/



















