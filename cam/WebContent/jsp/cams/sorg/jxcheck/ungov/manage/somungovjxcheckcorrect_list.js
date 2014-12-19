function init() {
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","M");
	ds.setParameter("STATUS@=","2");
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
	ds.setParameter("SORG_TYPE@=","M");
	ds.setParameter("STATUS@=","2");
	ds.setParameter("CN_NAME@LIKE","%"+getParam("cnName")+"%");		
	ds.setParameter("SORG_CODE@=",getParam("sorgCode"));		
	ds.load();
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
	var url='jsp/cams/sorg/jxcheck/ungov/manage/somungovjxcheckcorrectDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




