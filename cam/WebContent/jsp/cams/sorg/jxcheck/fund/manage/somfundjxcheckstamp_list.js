function init() {
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","J");
	ds.setParameter("STATUS@=","7");
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
	ds.setParameter("STATUS@=","7");
	ds.setParameter("SOM_CHECK.CN_NAME@LIKE","%"+getParam("cnName")+"%");		
	ds.setParameter("SOM_CHECK.SORG_CODE@=",getParam("sorgCode"));		
	ds.load();
}

function stamp(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行盖章!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('taskCode'));
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
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/jxcheck/fund/detail/fundJXCheckDetail1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




