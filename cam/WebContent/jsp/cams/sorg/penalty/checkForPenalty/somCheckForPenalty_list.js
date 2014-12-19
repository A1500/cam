function init() {
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("CHECK_RESULT@=","0");
	ds.setParameter("IF_PENALTY@=","0");
	ds.setParameter("BATCH_YEAR@=",year);
	ds.load();
	penaltiedDs.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	penaltiedDs.setParameter("CHECK_RESULT@=","0");
	penaltiedDs.setParameter("IF_PENALTY@=","1");
	penaltiedDs.setParameter("BATCH_YEAR@=",year);
	penaltiedDs.load();
	noCheckDs.setParameter("areaCode",areaCode+"%");
	noCheckDs.setParameter("checkYear",year);
	noCheckDs.load();
	noCheckPenaltiedDs.setParameter("areaCode",areaCode+"%");
	noCheckPenaltiedDs.setParameter("checkYear",year);
	noCheckPenaltiedDs.load();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("CHECK_RESULT@=","0");
	ds.setParameter("IF_PENALTY@=","0");
	ds.setParameter("CN_NAME@LIKE","%"+getParam("cnName")+"%");		
	ds.setParameter("SORG_CODE@=",getParam("sorgCode"));		
	ds.setParameter("BATCH_YEAR@=",getParam("batchYear"));		
	ds.load();
}
function queryNoPassPenaltied(){
	penaltiedDs.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	penaltiedDs.setParameter("CHECK_RESULT@=","0");
	penaltiedDs.setParameter("IF_PENALTY@=","1");
	penaltiedDs.setParameter("CN_NAME@LIKE","%"+getParam("cnNamePenaltied")+"%");		
	penaltiedDs.setParameter("SORG_CODE@=",getParam("sorgCodePenaltied"));		
	penaltiedDs.setParameter("BATCH_YEAR@=",getParam("batchYearPenaltied"));		
	penaltiedDs.load();
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
	var url='jsp/cams/sorg/jxcheck/fund/manage/somfundjxcheckacceptDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}

function penalty(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","checkForPenalty");
	data.put("sorgName",encodeURIComponent(encodeURIComponent(selected[0].get('CN_NAME'))));
	data.put("sorgType",selected[0].get('SORG_TYPE'));
	data.put("sorgCode",encodeURIComponent(encodeURIComponent(selected[0].get('SORG_CODE'))));
	data.put("statusDesc",encodeURIComponent(encodeURIComponent(selected[0].get('STATUS_DESC'))));
	var url='jsp/cams/sorg/penalty/penalty/penaltyAccept.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
function penaltyNoPass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","penaltyNoPass");
	data.put("sorgName",encodeURIComponent(encodeURIComponent(selected[0].get('cnName'))));
	data.put("sorgType",selected[0].get('sorgType'));
	data.put("checkTaskCode",selected[0].get('taskCode'));
	data.put("sorgCode",encodeURIComponent(encodeURIComponent(selected[0].get('sorgCode'))));
	data.put("statusDesc",encodeURIComponent(encodeURIComponent(year+"年年检不合格")));
	var url='jsp/cams/sorg/penalty/penalty/penaltyAccept.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}

//置为校对不通过状态
function notpass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('taskCode'));
	command.setParameter("status", "4");
	command.execute("updateStatus");
	if (!command.error) {
		L5.Msg.alert("提示","校对不通过成功！",function(){
			init();
		});		
	}else{
		L5.Msg.alert('提示',"校对不通过时出现错误！"+command.error);
	}
}

function query2(){
	noCheckDs.setParameter("areaCode",areaCode+"%");
	noCheckDs.setParameter("checkYear",year);
	noCheckDs.setParameter("status",document.getElementById("status").value);
	noCheckDs.setParameter("sorgType",document.getElementById("sorgType").value);
	noCheckDs.setParameter("userName",document.getElementById("userName").value);
	noCheckDs.load();
}
function query3(){
	noCheckPenaltiedDs.setParameter("areaCode",areaCode+"%");
	noCheckPenaltiedDs.setParameter("checkYear",year);
	noCheckPenaltiedDs.setParameter("status",document.getElementById("status").value);
	noCheckPenaltiedDs.setParameter("sorgType",document.getElementById("sorgType").value);
	noCheckPenaltiedDs.setParameter("userName",document.getElementById("userName").value);
	noCheckPenaltiedDs.load();
}


