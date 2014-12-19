function init(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	jcmPeopleInfoDataSet.load();
}
function query(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	
	jcmPeopleInfoDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/jcmPeopleInfoEdit.jsp";
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
	data.put("peopleId",records[0].get("peopleId"));
	var url="jsp/cams/jcm/jcmPeopleInfoEdit.jsp";
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
	data.put("peopleId",records[0].get("peopleId"));
	var url="jsp/cams/jcm/jcmPeopleInfoDetail.jsp";
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
			var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleInfoCmd");
			command.setParameter("peopleId",records[0].get("peopleId"));
			command.execute("delete");
			if (!command.error){
				var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
				jcmPeopleInfoDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}