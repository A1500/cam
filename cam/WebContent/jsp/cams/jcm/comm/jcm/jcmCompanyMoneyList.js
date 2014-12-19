function init(){
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	jcmCompanyMoneyDataSet.load();
}
function query(){
	var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
	
	jcmCompanyMoneyDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/jcmCompanyMoneyEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("companyMoneyId",records[0].get("companyMoneyId"));
	var url="jsp/cams/jcm/jcmCompanyMoneyEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("companyMoneyId",records[0].get("companyMoneyId"));
	var url="jsp/cams/jcm/jcmCompanyMoneyDetail.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyMoneyCmd");
			command.setParameter("companyMoneyId",records[0].get("companyMoneyId"));
			command.execute("delete");
			if (!command.error){
				var jcmCompanyMoneyDataSet=L5.DatasetMgr.lookup("jcmCompanyMoneyDataSet");
				jcmCompanyMoneyDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}