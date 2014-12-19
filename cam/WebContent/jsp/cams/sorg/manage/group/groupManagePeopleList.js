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
	//做权限限制 
	somOrganDataSet.on('load',function(){
		somOrganDataSet.filterBy(function(record, id){
			if(record.get('morgArea') == morgArea){
				return record;
			}
		});
	});
	var somSessionQueryDataSet = L5.DatasetMgr.lookup("somSessionQueryDataSet");
	somSessionQueryDataSet.setParameter("MORG_AREA@=",morgArea);
	somSessionQueryDataSet.setParameter("CREATE_PEOPLE@=",peopleName);
	somSessionQueryDataSet.setParameter("TASK_CODE@LIKE",'S%');
	somSessionQueryDataSet.load();
	somSessionQueryDataSet.on("load",sessionOnLoad);
	L5.QuickTips.init();
}
function sessionOnLoad(ds){
	ds.each(function(record, id){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgId",record.get('sorgId'));
		command.execute("queryOrganNameAndSorgCode");
		var cnName = command.getReturn("cnName");
		var sorgCode = command.getReturn("sorgCode");
		record.set('sessionName',cnName);
		record.set('seq',sorgCode);
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
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_TYPE@=","S");
	//somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("CN_NAME@=",cnName);
	somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
	somOrganDataSet.load();
}
// 换届备案
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
	data.put("ifBranch",records[0].get("ifBranch"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));	
	var url='';
	if(records[0].get("ifBranch") == '1'){
		L5.Msg.alert("提示","分支（代表）机构请点负责人管理进行备案!");
		return;
	}else{
		url="jsp/cams/sorg/manage/group/groupManagePeopleEdit.jsp";
	}
	
	L5.forward(url,'',data);
}
// 负责人管理
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("sorgId",records[0].get("sorgId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("cnName"))));
	data.put("sorgCode",records[0].get("sorgCode"));
	data.put("ifBranch",records[0].get("ifBranch"));
	data.put("mainSorgId",records[0].get("mainSorgId"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));
	var url='';
	if(records[0].get("ifBranch") == '1'){
		url="jsp/cams/sorg/manage/group/groupBranchManagePeopleEdit.jsp";
	}else{
		url="jsp/cams/sorg/manage/group/groupManagePeopleEdit.jsp";
	}
	L5.forward(url,'',data);	
}

// 历届负责人管理
function manage(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","his");
	data.put("sorgId",records[0].get("sorgId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("cnName"))));
	data.put("sorgCode",records[0].get("sorgCode"));
	data.put("mainSorgId",records[0].get("mainSorgId"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));	
	var url='';
	if(records[0].get("ifBranch") == '1'){
		url="jsp/cams/sorg/manage/group/groupBranchManagePeopleEdit.jsp";
	}else{
		url="jsp/cams/sorg/manage/group/groupManageAllSessionPeople.jsp";
	}
	L5.forward(url,'',data);	
}

// 查看当前备案
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("sorgId",records[0].get("sorgId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("cnName"))));
	data.put("sorgCode",records[0].get("sorgCode"));
	data.put("mainSorgId",records[0].get("mainSorgId"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));	
	var url='';
	if(records[0].get("ifBranch") == '1'){
		url="jsp/cams/sorg/manage/group/groupBranchManagePeopleDetail.jsp";
	}else{
		url="jsp/cams/sorg/manage/group/groupManagePeopleDetail.jsp";
	}
	L5.forward(url,'',data);	
}
// 查看历史备案
function his(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","his");
	data.put("sorgId",records[0].get("sorgId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("cnName"))));
	data.put("sorgCode",records[0].get("sorgCode"));
	data.put("mainSorgId",records[0].get("mainSorgId"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));	
	var url='';
	if(records[0].get("ifBranch") == '1'){
		url="jsp/cams/sorg/manage/group/groupBranchManagePeopleDetail.jsp";
	}else{
		url="jsp/cams/sorg/manage/group/groupManagePeopleHis.jsp";
	}
	L5.forward(url,'',data);	
}


// 查看历史备案详情
function hisDetail(){
	var grid=L5.getCmp("grid2");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","hisDetail2");
	data.put("sorgId",records[0].get("sorgId"));	
	data.put("cnName",encodeURIComponent(encodeURIComponent(records[0].get("sessionName"))));
	data.put("sorgCode",records[0].get("seq"));
	data.put("sessionId",records[0].get("sessionId"));	
	data.put("taskCode",records[0].get("taskCode"));
	var url="jsp/cams/sorg/manage/group/groupManagePeopleHisDetail.jsp";
	L5.forward(url,'',data);
}