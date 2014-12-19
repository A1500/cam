function init() {
	//ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("STATUS@=","不存在！");
	ds.load();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	//ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","J");	
	if(getParam("cnName")!=undefined){
		ds.setParameter("CN_NAME@LIKE","%"+getParam("cnName")+"%");			
	}
	if(getParam("sorgCode")!=undefined){
		ds.setParameter("SORG_CODE@LIKE","%"+getParam("sorgCode")+"%");			
	}
	if(getParam("checkResult")!=undefined){
		ds.setParameter("CHECK_RESULT@=",getParam("checkResult"));		
	}
	ds.setParameter("CHECK_YEAR@=",getParam("batchYear"));		
	ds.setParameter("STATUS@=",getParam("status"));
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
	var url='jsp/cams/sorg/jxcheck/fund/detail/fundJXCheckDetail1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
function print(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	L5.getCmp('winPrint').show();
}

function confirmPrint(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('taskCode'));
	var printPart=document.getElementById('printPart').value;
	var url='';
	if(printPart==1){
		url='jsp/cams/sorg/jxcheck/fund/print/fundJXCheckPrint1.jsp';
	}else{
		url='jsp/cams/sorg/jxcheck/fund/print/fundJXCheckPrint16.jsp';
	}
	var text = '年检明细';
	L5.forward(url,text,data);
}
function closePrint(){
	L5.getCmp('winPrint').hide();
}
//点击导出Excel
function ToExcel(){
	var dataset=L5.DatasetMgr.lookup("ds");
	L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/query/somFundJxQueryToExcel.jsp");
} 