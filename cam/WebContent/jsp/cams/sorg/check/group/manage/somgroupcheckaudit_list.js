function init() {
	ds.setParameter("fillPeopleArea",areaCode+"%");
	ds.setParameter("sorgType","S");
	ds.setParameter("status","6");
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
	ds.setParameter("status","6");
ds.setParameter("cnName",getParam("cnName"));
	ds.setParameter("sorgCode",getParam("sorgCode"));
    ds.setParameter("batchYear",getParam("batchYear"));
	ds.load();
}

function acceptPass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行接收!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('TASK_CODE'));
	command.setParameter("status", "7");
	command.execute("updateStatus");
	if (!command.error) {
		L5.Msg.alert("提示","审核通过成功！",function(){
			init();
		});
	}else{
		L5.Msg.alert('提示',"审核通过时出现错误！"+command.error);
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
	data.put("flag","audit");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/cams/sorg/check/group/manage/somgroupcheckauditDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




