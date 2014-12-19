function init() {	
	//ds.baseParams["TASK_ID@="]=idField;
	ds.load();
	ds.on("load",function(){
		var record = ds.getCurrent();
		if(record.get("ifEnd")=="0"){
			record.set("ifEnd","结束")
		}
		if(record.get("ifEnd")=="1"){
			record.set("ifEnd","启用")
		}
	});
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/sorg/assess/somassesstask/somassesstask_list.jsp';
		var text = 'SOM_ASSESS_TASK';
		L5.forward(url,text);	 
 }