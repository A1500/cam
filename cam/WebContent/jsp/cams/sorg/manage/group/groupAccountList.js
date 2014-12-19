function init(){
	$("cnName").value=searchCnName;
	$("sorgCode").value=searchSorgCode;
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	if(searchCnName=="" && searchSorgCode==""){
		somOrganDataSet.setParameter("SORG_ID@=","不存在！");
	}else{
		somOrganDataSet.setParameter("SORG_TYPE@=","S");
		//somOrganDatDaSet.setParameter("SORG_STATUS@=","22");
		somOrganDataSet.setParameter("CN_NAME@=",searchCnName);
		somOrganDataSet.setParameter("SORG_CODE@=",searchSorgCode);	
	}
	somOrganDataSet.load();
	var somAccountDataSet = L5.DatasetMgr.lookup("somAccountDataSet");
	somAccountDataSet.setParameter("MORG_AREA@=",morgArea);
	somAccountDataSet.setParameter("CREATE_PEOPLE@=",peopleName);
	somAccountDataSet.setParameter("TASK_CODE@LIKE",'S%');
	somAccountDataSet.load();
	somAccountDataSet.on("load",accountOnLoad);
	L5.QuickTips.init();
}
function accountOnLoad(ds){
	ds.each(function(record, id){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgId",record.get('sorgId'));
		command.execute("queryOrganNameAndSorgCode");
		var cnName = command.getReturn("cnName");
		var sorgCode = command.getReturn("sorgCode");
		record.set('name',cnName);
		record.set('sorgType',sorgCode);
	});
	ds.commitChanges();
}
function queryItem(){
	var cnName=_$("cnName");
	var sorgCode=_$("sorgCode");
	if(cnName=="" && sorgCode==""){
		L5.Msg.alert("提示","请至少输入社团名称或登记证号!");
		return false;
	}
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_TYPE@=","S");
	//somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("CN_NAME@=",cnName);
	somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
	somOrganDataSet.load();	
}
function insert(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","insert");
	data.put("sorgId",records[0].get("sorgId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("cnName"))));
	data.put("sorgCode",records[0].get("sorgCode"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));	
	var url="jsp/cams/sorg/manage/group/groupAccountEdit.jsp";
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
	data.put("sorgId",records[0].get("sorgId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("cnName"))));
	data.put("sorgCode",records[0].get("sorgCode"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));
	var url="jsp/cams/sorg/manage/group/groupAccount.jsp";
	L5.forward(url,'',data);
}

function detailHis(){
	var grid=L5.getCmp("grid2");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("sorgId",records[0].get("sorgId"));
	data.put("sorgCode",records[0].get("sorgType"));
	data.put("id",records[0].get("id"));
	data.put("taskCode",records[0].get("taskCode"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("name"))));
	var url="jsp/cams/sorg/manage/group/groupAccountDetail.jsp";
	L5.forward(url,'',data);
}