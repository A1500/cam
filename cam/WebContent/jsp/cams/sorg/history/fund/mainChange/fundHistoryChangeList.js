function init(){
	$("cnName").value=searchCnName;
	$("sorgCode").value=searchSorgCode;
	if(searchCnName=="" && searchSorgCode==""){
		somApplyDataSet.setParameter("SORG_ID","不存在！");
		somApplyDataSet.load();
	}else{
		somOrganDataSet.setParameter("CN_NAME",searchCnName);
		somOrganDataSet.setParameter("SORG_CODE",searchSorgCode);
		somOrganDataSet.setParameter("IF_BRANCH","0");
		somOrganDataSet.setParameter("SORG_TYPE","J");
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
			if(somOrganDataSet.getCount() == 1){
				somApplyDataSet.setParameter("SORG_ID",somOrganDataSet.get('sorgId'));
				somApplyDataSet.setParameter("SORG_TYPE","J");
				somApplyDataSet.setParameter("APPLY_TYPE",applyType);
				somApplyDataSet.setParameter("ACCEPT_AREA",morgArea);
				somApplyDataSet.setParameter("DATA_SOURCE","MEND");
				somApplyDataSet.load();
			}
		});	
	}
	L5.QuickTips.init();
}
function queryItem(){
	var cnName=_$("cnName");
	var sorgCode=_$("sorgCode");
	if(cnName=="" && sorgCode==""){
		L5.Msg.alert("提示","请至少输入基金会名称或登记证号!");
		return false;
	}
	somOrganDataSet.setParameter("SORG_TYPE","J");
	somOrganDataSet.setParameter("CN_NAME",cnName);
	somOrganDataSet.setParameter("SORG_CODE",sorgCode);
	somOrganDataSet.setParameter("IF_BRANCH","0");
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
	url="jsp/cams/sorg/history/fund/mainChange/fundHistoryChange.jsp";
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
	data.put("sorgId",records[0].get('SORG_ID'));
	data.put("taskCode",records[0].get('TASK_CODE'));
	var url='';
	url="jsp/cams/sorg/history/fund/mainChange/fundHistoryChange.jsp";
	L5.forward(url,'',data);	
}
function bgsxRef(values) {
 if(values.length==0){
       return "";
    }
var somChangeItemDS = L5.DatasetMgr.lookup("somChangeItemDS");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = somChangeItemDS.getAllRecords();
	var record=somChangeItemDS.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}