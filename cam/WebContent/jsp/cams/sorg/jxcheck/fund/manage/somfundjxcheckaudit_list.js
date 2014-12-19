function init() {
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","J");
	ds.setParameter("STATUS@=","6");
	ds.load();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","J");
	ds.setParameter("STATUS@=","6");
	ds.setParameter("CN_NAME@LIKE","%"+getParam("cnName")+"%");		
	ds.setParameter("SORG_CODE@=",getParam("sorgCode"));		
	ds.load();
}

function acceptPass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行接收!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('taskCode'));
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
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/jxcheck/fund/manage/somfundjxcheckauditDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




