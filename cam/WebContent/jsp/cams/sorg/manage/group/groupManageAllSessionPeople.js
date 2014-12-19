function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("SORG_ID@=",sorgId);
	somSessionDataSet.load();
}
// 维护选中届次负责人信息
function hisManage(){
	var grid=L5.getCmp("sessionGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("sorgId",sorgId);	
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("sessionId",records[0].get("sessionId"));	
	data.put("taskCode",records[0].get("taskCode"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/group/groupManagePeopleEdit.jsp";
	L5.forward(url,'',data);
}
function returnBack(){
	var data=new L5.Map();
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/group/groupManagePeopleList.jsp";
	L5.forward(url,'',data);	
}

// 换届备案
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	var url="jsp/cams/sorg/manage/group/groupManagePeopleEdit.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("sessionGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var seq = records[0].get("seq");
	if(seq == "1"){
		L5.Msg.alert("提示","第一届的负责人信息不能删除！");		
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.setParameter("taskCode", records[0].get("taskCode"));
	command.execute("deleteSessionAllByTaskCode");
	if (!command.error) {
		L5.Msg.alert("提示","删除成功！",function(){
			init();
		});		
	}else{
		L5.Msg.alert('提示',"删除时出现错误！"+command.error);
	}
	
}