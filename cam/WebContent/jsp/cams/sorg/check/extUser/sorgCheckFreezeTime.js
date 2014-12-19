function init(){
	ds.load();
}
function query(){
	ds.setParameter("FREEZE_SORG_TYPE",document.getElementById('freezeSorgType').value);
	ds.setParameter("FREEZE_YEAR",document.getElementById('freezeYear').value);
	ds.load();
}
function submit(){
	var somFlowIsValidate = newDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}	
	var record = newDataset.getCurrent();
	var records = ds.getAllRecords();
	var freezeYear = record.get('freezeDate').substring(0,4);
	
	for(var i=0;i<records.length;i++){
		if(records[i].get('freezeSorgType') == record.get('freezeSorgType') 
			&& records[i].get('freezeYear') == freezeYear &&
				records[i].get('freezeId') != record.get('freezeId')
				){
			L5.Msg.alert('提示',"已经存在此年份该社会组织类型的时间配置！");
			return;
		}
	}
	var command = new L5.Command("com.inspur.cams.comm.extuser.cmd.SorgCheckFreezeTimeCmd");
	command.setParameter("sorgCheckFreezeTime",record);
	if( record.get('freezeId') != '' ){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功!",function(){
			query();
			var win = L5.getCmp("window");
			win.hide();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}	
}
function addFreeze(){
	var win = L5.getCmp("window");
	win.show();
	newDataset.removeAll();
	newDataset.newRecord();
}
function changeFreeze(){
	var grid = L5.getCmp('editGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var win = L5.getCmp("window");
		win.show();
		newDataset.removeAll();
		newDataset.add(records[0]);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function deleteFreeze(){
	var grid = L5.getCmp('editGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command = new L5.Command("com.inspur.cams.comm.extuser.cmd.SorgCheckFreezeTimeCmd");
				command.setParameter("sorgCheckFreezeTime",records[0]);
				command.execute("delete");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!",function(){
						query();
					});
				}else{
					L5.Msg.alert('提示',"删除时出现错误！"+command.error);
				}	
			}
			else{
				return;
			}
		});	
			
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("freezeSorgType")=="ST"){
		return "社会团体";
	}
	if(record.get("freezeSorgType")=="MF"){
		return "民办非企业";
	}
	if(record.get("freezeSorgType")=="JJ"){
		return "基金会";
	}
}