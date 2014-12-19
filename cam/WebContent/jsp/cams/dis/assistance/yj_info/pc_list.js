function init() {
	/*ds.on("load", function() {
		var count = ds.getCount();
		if(count == 0) {
			L5.Msg.alert("提示", "暂无记录!");
		}
	});*/
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function query(){
	var pcmc = getParam("pcmc");
	var fillstate = getParam("fillstate");
//	ds.baseParams["BATCH_ID@like"]=pcbh;
	ds.setParameter("batchName",pcmc);
	ds.setParameter("fillState", fillstate);
	ds.on("load", function() {
		var count = ds.getCount();
		if(count == 0) {
			L5.Msg.alert("提示", "暂无记录!");
		}
	});
	ds.load();
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	
	var isupdate = false;
	if(selected[0].get("fillState") != _DISRELIEFBATCHDETAIL_STATE_WC) {
		isupdate = true;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("isupdate", isupdate);
	data.put("batchDetailId",selected[0].get('batchDetailId'));
	var url='jsp/cams/dis/assistance/yj_info/yj_info_list.jsp';
	var text = '过渡性救灾明细列表';
	L5.forward(url,text,data);
}

/**
 * 批量提交
 */
function batchSubmit() {
	var editGrid = L5.getCmp("editGridPanel");
	var selections = editGrid.getSelectionModel().getSelections();
	if(selections.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录！");
		return;
	}
	
	if(selections[0].get("fillState") == _DISRELIEFBATCHDETAIL_STATE_WC) {
		L5.Msg.alert("提示", "该批次已经提交!");
		return;
	}
	
	/*
		var subIds = [];
		for(var i = 0; i < selections.length; i++) {
			subIds[i] = selections[i].get("infoId");
		}
	*/
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCommand");
	//command.setParameter("subIds", subIds);
	command.setParameter("subId", selections[0].get("batchDetailId"));
	command.afterExecute = function() {
		if(!command.error) {
			var msg = command.getReturn("result");
			L5.Msg.alert("提示", msg);
			ds.reload();
			ds.commitChanges();
		} else {
			L5.Msg.alert("提示", "操作失败，错误信息为：" + command.error);
		}
	}
	command.execute("batchSubmit");
}



