function init() {
	deviceDataSet.setParameter("TASK_CODE@=",taskCode);
	deviceDataSet.load(true);
	
	//初次填写,默认加载七条必填记录
	if(deviceDataSet.getCount()<=0){
		var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp","Id32");
		//获得七个随机主键
		var deviceIds = new Array();
		for(var i=0;i<7;i++){
			command.execute();
			var deviceId=command.getReturn("id");
			deviceIds[i]=deviceId;
		}
		
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[0],"deviceCode":"1"});
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[1],"deviceCode":"2"});
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[2],"deviceCode":"3"});
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[3],"deviceCode":"4"});
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[4],"deviceCode":"5"});
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[5],"deviceCode":"6"});
		deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceIds[6],"deviceCode":"7"});
	}
	
};



function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){		
	deviceDataSet.setParameter("DEVICE_NAME@=",getParam("deviceName"));	
	deviceDataSet.setParameter("TASK_CODE@=",taskCode);	
	deviceDataSet.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var deviceId=command.getReturn("id");
	deviceDataSet.newRecord({"taskCode":taskCode,"deviceId":deviceId});

}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("deviceId");
			}
			var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitDeviceCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	deviceDataSet.remove(selected[i]);
				}
				deviceDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}
function save() {
	
	
	var records = deviceDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	

	//重复校验
	var rds= deviceDataSet.getAllRecords();
	var a = [];
	for(var i=0;i<rds.length;i++){
		a[i] = rds[i].get("deviceCode");
	}	
	Array.prototype.unique = function() {  
    var data = [];  
    var a = {}; //声明一个对象，javascript的对象可以当哈希表用  
    for (var i = 0; i < this.length; i++) {  
        if(!a[this[i]]){  
            a[this[i]] = true;  
            data[data.length] = this[i];  
       	 }  
  	  }  
    	return data;  
	};  
	if(a.length>a.unique().length){
		L5.Msg.alert('提示',"不能重复添加相同的数据!");
		return false;
	} 
	
	//保存设施名称
	for(var i=0;i<records.length;i++){
		deviceDataSet2.setParameter("CODE",records[i].get("deviceCode"));
		deviceDataSet2.load(true);
		records[i].set("deviceName",deviceDataSet2.getAt(0).get("name"));
	}
	
	var isValidate = deviceDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitDeviceCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		deviceDataSet.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!",function(){
		});
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}


function close(){
	 window.returnvalue=true;
}

