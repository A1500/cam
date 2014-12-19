function init(){
	$("cnName").value=searchCnName;
	$("sorgCode").value=searchSorgCode;
	if(searchCnName=="" && searchSorgCode==""){
		somOrganDataSet.setParameter("SORG_ID","不存在！");
		somOrganDataSet.load();
	}else{
		somOrganDataSet.setParameter("CN_NAME",searchCnName);
		somOrganDataSet.setParameter("SORG_CODE",searchSorgCode);
		somOrganDataSet.setParameter("SORG_TYPE","M");
		somOrganDataSet.load();
	}
	L5.QuickTips.init();
}
function queryItem(){
	var cnName=_$("cnName");
	var sorgCode=_$("sorgCode");
	if(cnName=="" && sorgCode==""){
		L5.Msg.alert("提示","请至少输入民办非企业单位名称或登记证号!");
		return false;
	}
	somOrganDataSet.setParameter("SORG_TYPE","M");
	somOrganDataSet.setParameter("CN_NAME",cnName);
	somOrganDataSet.setParameter("SORG_CODE",sorgCode);
	somOrganDataSet.load();
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
	var url='';
	url="jsp/cams/sorg/modify/ungov/ungovModifyBuild.jsp";
	L5.forward(url,'',data);	
}
