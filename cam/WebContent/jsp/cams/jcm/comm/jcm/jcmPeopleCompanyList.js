function init(){
	var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	jcmPeopleCompanyDataSet.load();
}
function query(){
	var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	
	jcmPeopleCompanyDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/jcmPeopleCompanyEdit.jsp";
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
	data.put("peopleCompanyId",records[0].get("peopleCompanyId"));
	var url="jsp/cams/jcm/jcmPeopleCompanyEdit.jsp";
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
	data.put("peopleCompanyId",records[0].get("peopleCompanyId"));
	var url="jsp/cams/jcm/jcmPeopleCompanyDetail.jsp";
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
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleCompanyCmd");
			command.setParameter("peopleCompanyId",records[0].get("peopleCompanyId"));
			command.execute("delete");
			if (!command.error){
				var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
				jcmPeopleCompanyDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}