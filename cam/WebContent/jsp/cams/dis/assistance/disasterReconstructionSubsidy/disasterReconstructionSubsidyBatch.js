/**
 * 界面初始化
 */
function init(){
	ds.setParameter("reliefType","CJ");//灾区民房
	ds.setParameter("requiredOrganCode",organCode);//当前行政区划
	ds.load();
	ds.on("load", function() {
		var count = ds.getCount();
		if(count == 0) {
			L5.Msg.alert("提示", "暂无记录!");
		}
	});
	
	L5.QuickTips.init();
};

function query(){
	ds.setParameter("reliefType","CJ");//灾区民房
	ds.setParameter("requiredOrganCode",organCode);//当前行政区划
	var cx_batchName = _$("cx_batchName");
	if(cx_batchName!=""&&cx_batchName!=null){
		ds.setParameter("batchName",cx_batchName);
	}
	ds.load();
}

/**
 * 明细按钮
 */
function detail(){
	var editGrid = L5.getCmp("disasterReconstructionSubsidyBatchGrid");//获得控制权
	var selected = editGrid.getSelectionModel().getSelections();//获得选中行
	if(selected.length!=1){
		L5.Msg.alert('提示','请选中一条记录查看！');
		return false;
	}
	var url='jsp/cams/dis/assistance/disasterReconstructionSubsidy/disasterReconstructionSubsidyList.jsp';
	var text='救助批次明细';
	var data=new L5.Map();
	data.put("batchDetailId",selected[0].get("batchDetailId"));//供添加按钮中自动填写DIS_RELIEF_INFO表中batchDetailId字段，提交时填写DIS_RELIEF_BATCH_DETAIL表中FILL_STATE，FILL_PEOPLE，FILL_TIME字段
	L5.forward(url, text, data);
}
/**
 * 提交按钮
 */
function selectBatch(){
	var editGrid = L5.getCmp("disasterReconstructionSubsidyBatchGrid");//获得控制权
	var selected = editGrid.getSelectionModel().getSelections();//获得选中行
	if(selected.length!=1){
		L5.Msg.alert('提示','请选中一条记录进行提交！');
		return false;
	}
	var state;
	switch(selected[0].get('fillState')){
	case "0": L5.Msg.alert('提示','请先点击办理进行填写，再进行提交！');
	return false;
	case "1": state = confirm('确定要进行提交吗？');
	break;
	case "2": L5.Msg.alert('提示','由于已经提交过，不能进行提交！');
	return false;
	default: L5.Msg.alert('提示','提交失败！');
	return false;
	}
	if(state==true){
		var batchDetailId = selected[0].get('batchDetailId');//获得批次明细主键
		if(batchDetailId!=""&&batchDetailId!=null){
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.AssistanceCommand");
			command.setParameter("batchDetailId", batchDetailId);
			command.execute("selectBatch");
		}
		if(!command.error){
			L5.Msg.alert('提示','提交成功！');
			ds.commitChanges();
			ds.reload();
		}else{
			L5.Msg.alert('提示','提交失败！'+command.error);
		}
	}else{
		return false;
	}
}