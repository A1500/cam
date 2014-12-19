function init(){
	$("cnName").value=searchCnName;
	$("sorgCode").value=searchSorgCode;
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	if(searchCnName=="" && searchSorgCode==""){
		somOrganDataSet.setParameter("SORG_ID@=","不存在！");
	}else{
		somOrganDataSet.setParameter("SORG_TYPE@=","M");
		//somOrganDatDaSet.setParameter("SORG_STATUS@=","22");
		somOrganDataSet.setParameter("CN_NAME@=",searchCnName);
		somOrganDataSet.setParameter("SORG_CODE@=",searchSorgCode);	
	}
	somOrganDataSet.load();
	var somSignetDataSet = L5.DatasetMgr.lookup("somSignetDataSet");
	somSignetDataSet.setParameter("MORG_AREA@=",morgArea);
	somSignetDataSet.setParameter("CREATE_PEOPLE@=",peopleName);
	somSignetDataSet.setParameter("TASK_CODE@LIKE",'M%');
	somSignetDataSet.load();
	somSignetDataSet.on("load",somSignetOnLoad);
	L5.QuickTips.init();
}

function somSignetOnLoad(ds){
	ds.each(function(record, id){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgId",record.get('sorgId'));
		command.execute("queryOrganNameAndSorgCode");
		var cnName = command.getReturn("cnName");
		var sorgCode = command.getReturn("sorgCode");
		record.set('signetDate',cnName);
		record.set('fetchPeople',sorgCode);
	});
	ds.commitChanges();
}

function queryItem(){
	var cnName=_$("cnName");
	var sorgCode=_$("sorgCode");
	if(cnName=="" && sorgCode==""){
		L5.Msg.alert("提示","请至少输入单位名称或登记证号!");
		return false;
	}
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_TYPE@=","M");
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
	var url="jsp/cams/sorg/manage/ungov/ungovSignetEdit.jsp";
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
	var url="jsp/cams/sorg/manage/ungov/ungovSignet.jsp";
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
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("signetDate"))));
	data.put("sorgCode",records[0].get("fetchPeople"));
	data.put("id",records[0].get("id"));
	data.put("taskCode",records[0].get("taskCode"));
	var url="jsp/cams/sorg/manage/ungov/ungovSignetDetail.jsp";
	L5.forward(url,'',data);
}