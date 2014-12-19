function init() {
	partyCheckDataSet.setParameter("CHECK_STATUS@<>","0");
	partyCheckDataSet.setParameter("MORG_AREA@LIKE",areaCode);
	partyCheckDataSet.load();
};
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){

	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.SORG_NAME@LIKE","%"+getParam("sorgName")+"%");
	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.MORG_AREA@LIKE",areaCode);
	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.SORG_CODE@=",getParam("sorgCode"));
	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.SORG_TYPE@=",getParam("sorgType"));
	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.CHECK_STATUS@=",getParam("checkStatus"));
	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.CHECK_RESULT@=",getParam("checkResult"));
	partyCheckDataSet.setParameter("SOM_PARTY_CHECK.CHECK_STATUS@<>","0");
	partyCheckDataSet.load();
}
function handleCheck(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get('checkStatus')!='1'){
		L5.Msg.alert('提示',"该数据已经办理!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","HANDLE");
	data.put("ycheckId",selected[0].get('ycheckId'));
	var url='jsp/cams/sorg/check/partyCheck/partycheckDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
function detailCheck(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("ycheckId",selected[0].get('ycheckId'));
	var url='jsp/cams/sorg/check/partyCheck/partycheckDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}


function backto()
{
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}

			L5.MessageBox.confirm('确定', '确定要退回给社会组织吗？',function(sta){
					if(sta=="yes"){
						 		var command = new L5.Command("com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckCommand");
				command.setParameter("ycheckid", selected[0].get('ycheckId'));

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