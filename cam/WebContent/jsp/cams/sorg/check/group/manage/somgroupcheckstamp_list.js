function init() {
	ds.setParameter("fillPeopleArea",areaCode+"%");
	ds.setParameter("sorgType","S");
	ds.setParameter("status","7");
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
	ds.setParameter("fillPeopleArea",areaCode+"%");
	ds.setParameter("sorgType","S");
	ds.setParameter("status","7");
ds.setParameter("cnName",getParam("cnName"));
	ds.setParameter("sorgCode",getParam("sorgCode"));
    ds.setParameter("batchYear",getParam("batchYear"));
	ds.load();
}

function stamp(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行盖章!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('TASK_CODE'));
	command.setParameter("status", "8");
	command.execute("updateStatus");
	if (!command.error) {
		L5.Msg.alert("提示","盖章成功！",function(){
			init();
		});
	}else{
		L5.Msg.alert('提示',"盖章时出现错误！"+command.error);
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
	data.put("flag","stamp");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




