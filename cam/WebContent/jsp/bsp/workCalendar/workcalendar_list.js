function init() {
	if(msg!=""){
				L5.MessageBox.alert('提示',msg);
				return false;
			}

	//动态生成年度选择列表
	var ss=[];
	for (var i=0;i<20;i++)
	{
		ss[i]={};
		ss[i].text=nf+i+"年";
		ss[i].value=nf+i+"";
	}
	nfds.loadData({metaData:{root:'rows',totalProperty: 'results',id:'value'},results:12,rows:ss});
//
	ds.load(true);
	L5.QuickTips.init();
};
function edityear() {
	if (ds.getCurrent().state== L5.model.Record.STATE_NEW)
		return true;
	else
		return false;
}
function update(){
	var records = ds.getAllChangedRecords();
	//if(records.length>0){
		//L5.Msg.alert('提示',"请先保存数据！");
	   // return false;
	  // }
	for(var i=0;i<records.length;i++){
	  if(records[i].state==1){
	     L5.Msg.alert('提示',"请先保存数据！");
	    return false;
	  }
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行设置!");
		return false;
	}
	var record =selected[0];
	var solarDate=record.get("solarDate");
	var organId=record.get("organId");
	var organName=record.get("organName");
	organName=L5.util.Base64.encodeURIParameter(organName);//
	var url="command/dispatcher/org.loushang.bsp.workCalendar.cmd.WorkdayCmd/getList?solarDate="+solarDate+"&organId="+organId+"&organName="+organName;
	L5.forward(url,"机构日历修改");
}

function insert(){
	ds.newRecord({organId:organId,organName:organName});
}

function save(){
	var records = ds.getAllChangedRecords();
	var addrecords=[];
	var j=0;
	if(records.length<1){
		L5.Msg.alert('提示',"没有要保存的数据");
		return false;
	}

   var validate=true;
	for(var i=0;i<records.length;i++){
	  var record=records[i];
	  if(record.state=="1"){
		    addrecords[j]=record;
		    var solarDate=record.get("solarDate");
		    if(solarDate==undefined||solarDate==""){
		    	validate=false;
		    }
		    j++;
		}
	}
	
	if(validate!= true){
		L5.Msg.alert('提示',"校验未通过,不能保存!");
		return false;
	}
	var tempRecord ;
	for(var i=0; i<records.length; i++){
		tempRecord = records[i];
		for(var j=i+1; j<records.length; j++){
			if(tempRecord.get("solarDate") == records[j].get("solarDate")){
				L5.Msg.alert("提示","新增记录中有重复年份");
				return;
			}
		}
	}
	if(addrecords.length>0){
		var command = new L5.Command("org.loushang.bsp.workCalendar.cmd.WorkCalendarCmd");
		command.setParameter("records", records);
		command.execute("insert");
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功！");
			ds.commitChanges();
		}else{
			L5.Msg.alert('提示',command.error);
		}
	}

}
function saveInsert(){
	var records = ds.getAllChangedRecords();
	var addrecords=[];
	var j=0;
	if(records.length<1){
		return false;
	}

   var validate=true;
	for(var i=0;i<records.length;i++){
	  var record=records[i];
	  if(record.state=="1"){
		    addrecords[j]=record;
		    var solarDate=record.get("solarDate");
		    if(solarDate==undefined||solarDate==""){
		    	validate=false;
		    }
		    j++;
		}
	}

	if(validate!= true){
		L5.Msg.alert('提示',"校验未通过,不能保存!");
		return false;
	}
	if(addrecords.length>0){
		var command = new L5.Command("org.loushang.bsp.workCalendar.cmd.WorkCalendarCmd");
		command.setParameter("records", records);
		command.execute("insert");
		if (!command.error) {
		}else{
			L5.Msg.alert('提示',command.error);
		}
	}
}

function del(){
	var list="";
	var wokdcalendarGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = wokdcalendarGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录");
		return false;
	} else {
		L5.MessageBox.confirm("提示", "你确定要删除吗？", function(sta) {
			if (sta == "yes") {
				for (var i = 0; i < selected.length; i++) {
					var record = selected[i];
					var recordState = record.state;
					if (recordState != "1") {
						list = list + record.get("solarDate")+","+record.get("organId") + ";";
					}
				}
				
				if(list != ""){
					var records = list.split(";");
					var command = new L5.Command("org.loushang.bsp.workCalendar.cmd.WorkCalendarCmd");
					command.setParameter("records", records);
					command.execute("delete");
					if (!command.error) {
						L5.Msg.alert('提示', '删除成功!');
						
						for(var i=0;i<selected.length;i++){
								ds.remove(selected[i]);
	   				 	}
	   				 //	saveInsert();
					} else {
						L5.Msg.alert('提示', command.error);
					}
				}else{
					for(var i=0;i<selected.length;i++){
							ds.remove(selected[i]);
   				 	}
				}

			} else{
				return;
				}
		});
	}
}

