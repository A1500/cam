function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	var somAccountDataSet=L5.DatasetMgr.lookup("somAccountDataSet");
	somAccountDataSet.setParameter("SORG_ID@=",sorgId);
	somAccountDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/ungov/ungovAccountEdit.jsp";
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
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("id",records[0].get("id"));
	data.put("taskCode",records[0].get("taskCode"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/ungov/ungovAccountEdit.jsp";
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
	data.put("method","detail");
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("id",records[0].get("id"));
	data.put("taskCode",records[0].get("taskCode"));
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/ungov/ungovAccountDetail.jsp";
	L5.forward(url,'',data);
}
function returnBack(){
	var data=new L5.Map();
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/ungov/ungovAccountList.jsp";
	L5.forward(url,'',data);	
}

function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomAccountCmd");
	command.setParameter("taskCode", records[0].get("taskCode"));
	command.execute("del");
	if (!command.error) {
		L5.Msg.alert("提示","删除成功！",function(){
			init();
		});		
	}else{
		L5.Msg.alert('提示',"删除时出现错误！"+command.error);
	}
	
}