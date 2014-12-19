function init() {
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","J");
	ds.setParameter("STATUS@=","1");
	 var d = new Date(),
        nowYear = +d.getFullYear();
      document.getElementById("batchYear").value=nowYear-1
	ds.load();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","J");
	ds.setParameter("STATUS@=","1");
	ds.setParameter("CN_NAME@LIKE","%"+getParam("cnName")+"%");
	ds.setParameter("SORG_CODE@=",getParam("sorgCode"));
	ds.setParameter("BATCH_YEAR@=",getParam("batchYear"));
	ds.load();
}


function receive(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请至少选择一条记录进行接收!");
		return false;
	}
	var length=selected.length;
	var taskCodes=[];
	for(i=0;i<length;i++){
		taskCodes[i]=selected[i].get('taskCode');
	}
		var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
		command.setParameter("taskCodes", taskCodes);
		command.setParameter("status", "2");
		command.execute("updateStatusRecevie");
	if (!command.error) {
		L5.Msg.alert("提示","接收成功！",function(){
			init();
		});
	}else{
		L5.Msg.alert('提示',"接收时出现错误！"+command.error);
	}
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/check/fund/detail/fundCheckDetail1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




