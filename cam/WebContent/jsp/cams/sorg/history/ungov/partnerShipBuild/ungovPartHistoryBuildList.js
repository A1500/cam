function init(){
	$("cnName").value=searchCnName;
	$("sorgCode").value=searchSorgCode;
	if(searchCnName=="" && searchSorgCode==""){
		somApplyDataSet.setParameter("SORG_ID","不存在！");
		somApplyDataSet.load();
	}else{
		if(searchSorgCode!=""){
			somOrganDataSet.setParameter("SORG_CODE",searchSorgCode);
		}
		if(searchCnName!=""){
			somOrganDataSet.setParameter("CN_NAME",searchCnName);
		}
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
			if(somOrganDataSet.getCount() == 1){
				somApplyDataSet.setParameter("SORG_ID",somOrganDataSet.get('sorgId'));
				somApplyDataSet.setParameter("APPLY_TYPE",applyType);
				somApplyDataSet.setParameter("ACCEPT_AREA",morgArea);
				somApplyDataSet.setParameter("DATA_SOURCE","MEND");
				somApplyDataSet.load();
			}else{
				somApplyDataSet.removeAll();
			}
		});	
	}
	L5.QuickTips.init();
}
function queryItem(){
	var cnName=_$("cnName");
	var sorgCode=_$("sorgCode");
	if(cnName=="" && sorgCode==""){
		L5.Msg.alert("提示","请至少输入民非名称或登记证号!");
		return false;
	}
	if(cnName!=""){
		somOrganDataSet.setParameter("CN_NAME",cnName);
	}
	if(sorgCode!=""){
		somOrganDataSet.setParameter("SORG_CODE",sorgCode);
	}
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() == 1){
			somApplyDataSet.setParameter("SORG_ID",somOrganDataSet.get('sorgId'));
			somApplyDataSet.setParameter("APPLY_TYPE",applyType);
			somApplyDataSet.setParameter("ACCEPT_AREA",morgArea);
			somApplyDataSet.load();
		}else{
			somApplyDataSet.removeAll();
		}
	});	
}
function insert(){
	var data=new L5.Map();
	data.put("method","INSERT");
	url="jsp/cams/sorg/history/ungov/partnerShipBuild/ungovPartHistoryBuild.jsp";
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
	data.put("method","UPDATE");
	data.put("sorgId",records[0].get('sorgId'));
	data.put("taskCode",records[0].get('taskCode'));
	data.put("searchCnName",_$("cnName"));
	data.put("searchSorgCode",_$("sorgCode"));
	var url="jsp/cams/sorg/history/ungov/partnerShipBuild/ungovPartHistoryBuild.jsp";
	L5.forward(url,'',data);	
}
