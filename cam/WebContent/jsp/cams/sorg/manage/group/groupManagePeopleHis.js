function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("SORG_ID@=",sorgId);
	somSessionDataSet.load();
}
// 查看历史备案详情
function hisDetail(){
	var grid=L5.getCmp("sessionGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","hisDetail");
	data.put("sorgId",sorgId);	
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("sessionId",records[0].get("sessionId"));	
	data.put("taskCode",records[0].get("taskCode"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/group/groupManagePeopleHisDetail.jsp";
	L5.forward(url,'',data);
}
function returnBack(){
	var data=new L5.Map();
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/group/groupManagePeopleList.jsp";
	L5.forward(url,'',data);	
}
