function init() {
	//ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("STATUS@=","不存在！");
	var d = new Date(),
        nowYear = +d.getFullYear();
      document.getElementById("batchYear").value=nowYear-1
	ds.load();
};

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
		ds.setParameter("SORG_CODE@=",getParam("sorgCode"));
	}
	if(getParam("checkResult")!=undefined){
		ds.setParameter("CHECK_RESULT@=",getParam("checkResult"));
	}
	ds.setParameter("BATCH_YEAR@=",getParam("batchYear"));
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
	var url='jsp/cams/sorg/check/fund/detail/fundCheckDetail1.jsp';
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
		url='jsp/cams/sorg/check/fund/print/fundCheckPrint1.jsp';
	}else{
		url='jsp/cams/sorg/check/fund/print/fundCheckPrint16.jsp';
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
	L5.dataset2excel(dataset,"/jsp/cams/sorg/check/fund/query/somFundQueryToExcel.jsp");
}


function backto()
{
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}

			L5.MessageBox.confirm('确定', '确定要退回给社会组织吗？',function(sta){
					if(sta=="yes"){
						 		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("taskCode", selected[0].get('taskCode'));

				command.execute("backto");
				if (!command.error) {
					L5.Msg.alert("提示","退回成功！",function(){
						query();
					});
				}else{
					L5.Msg.alert('提示',"退回时出现错误！"+command.error);
				}

					}else{
						return;
					}
				});



}