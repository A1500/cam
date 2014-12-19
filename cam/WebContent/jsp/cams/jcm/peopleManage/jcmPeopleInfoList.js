function init(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	jcmPeopleInfoDataSet.load();
}
function query(){
	var infoDs=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	infoDs.setParameter("PEOPLE_NAME@LIKE",getParam("qName"));
	infoDs.setParameter("PEOPLE_SEX",getParam("qSex"));
	infoDs.setParameter("PEOPLE_CARD",getParam("qIdCard"));
	infoDs.setParameter("PEOPLE_NATION",getParam("qNation"));
	infoDs.setParameter("PEOPLE_BIRTHDAY",getParam("qBirthday"));
	infoDs.setParameter("PEOPLE_POLITICS",getParam("qPolitical"));
	infoDs.setParameter("PEOPLE_EDU",getParam("qEdu"));
	infoDs.setParameter("PEOPLE_ADRESS@LIKE",getParam("qAdd"));
	infoDs.load();
}
function getParam(tag){
	return document.getElementById(tag).value;
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/peopleManage/jcmPeopleInfoEdit.jsp";
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
	var url="jsp/cams/jcm/peopleManage/jcmPeopleInfoEdit.jsp";
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
	var url="jsp/cams/jcm/peopleManage/jcmPeopleInfoDetail.jsp";
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
			command.execute("deleteAll");
			if (!command.error){
				var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
				jcmPeopleInfoDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	L5.dataset2excel(dataset,"/jsp/cams/jcm/peopleManage/peopleInfoExcel.jsp?userName="+organName);
}