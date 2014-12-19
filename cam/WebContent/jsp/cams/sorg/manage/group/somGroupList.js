function init(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_TYPE@=","S");
	somOrganDataSet.setParameter("SORG_STATUS@in","22,32,52,62");
	if(sorgId != ""){
		somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	}
	somOrganDataSet.load();
}
function queryItem(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_CODE@=",_$("sorgCode"));
	if(_$("sorgStatus") == ""){
		somOrganDataSet.setParameter("SORG_STATUS@in","22,32,52,62");
	}else{
		somOrganDataSet.setParameter("SORG_STATUS@=",_$("sorgStatus"));
	}
	somOrganDataSet.setParameter("CN_NAME@=",_$("cnName"));
	somOrganDataSet.setParameter("MORG_NAME@=",_$("morgName"));
	somOrganDataSet.setParameter("SORG_TYPE@=","S");
	somOrganDataSet.load();
}
function insert(){
	var url = "jsp/cams/sorg/manage/group/somGroupInsert.jsp";
	var text = "主体录入";
	L5.forward(url,text);
}

function update(){
	var url = "jsp/cams/sorg/manage/group/somGroupUpdate.jsp";
	var text = "主体修改";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(record.get("sorgStatus")=="32" || record.get("sorgStatus")=="62"){
		L5.Msg.alert("提示","选中的基金会已注销，不能进行修改操作!");
		return;
	}
	if(record.get("sorgStatus")=="52"){
		L5.Msg.alert("提示","选中的基金会已撤销，不能进行修改操作!");
		return;
	}
	
	var id = record.get("sorgId");
	var map = new L5.Map();
	map.put("sorgId",id);
	L5.forward(url,text,map);
}
function cancel(){
	var url = "jsp/cams/sorg/manage/group/somGroupCancel.jsp";
	var text = "主体注销";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomGroupCmd");
	var id = record.get("sorgId");
	//查询主体社团的分支是否未被注销
	if(record.get("sorgStatus")=="52"){
		command.setParameter("mainSorgId",id);
		command.setParameter("sorgStatus","52");
		command.execute("branchStatusNum");
		var num = command.getReturn("num");
		if(num != 0){
			L5.Msg.alert("提示","此社团还有"+num+"个未被注销的分支(代表)机构，请先将其注销！");
			return;
		}
	}
	if(record.get("sorgStatus")=="22"){
		command.setParameter("mainSorgId",id);
		command.setParameter("sorgStatus","22");
		command.setParameter("sorgStatus2","52");
		command.execute("branchStatusNum");
		var num = command.getReturn("num");
		if(num != 0){
			L5.Msg.alert("提示","此社团还有"+num+"个未被注销的分支(代表)机构，请先将其注销！");
			return;
		}
	}
	var map = new L5.Map();
	map.put("sorgId",id);
	L5.forward(url,text,map);
}
function repeal(){
		var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(record.get("sorgStatus")=="32" || record.get("sorgStatus")=="62"){
		L5.Msg.alert("提示","选中的社会团体已注销，不能进行撤销操作!");
		return;
	}
	if(record.get("sorgStatus")=="52"){
		L5.Msg.alert("提示","选中的社会团体已被撤销!");
		return;
	}
	
	var id = record.get("sorgId");
	//查询主体社团的分支是否已被撤销
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomGroupCmd");
	command.setParameter("mainSorgId",id);
	command.setParameter("sorgStatus","22");
	command.execute("branchStatusNum");
	var num = command.getReturn("num");
	if(num != 0){
		L5.Msg.alert("提示","此社团还有"+num+"个未被撤销的分支(代表)机构，请先将其撤销！");
		return;
	}
	L5.MessageBox.confirm('', '你确定要撤销吗？',function(sure){
		if(sure=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomGroupCmd");
			command.setParameter("sorgId", id);
			command.execute("saveRepeal");
			if (!command.error) {
				var url = "jsp/cams/sorg/manage/group/somGroupList.jsp";
				var text = "刷新";			
				L5.Msg.alert('提示','撤销成功！',function(){L5.forward(url,text);});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);
	
}
function branch(){
	var url ;
	var text = "分支/代表机构";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var mainSorgId = record.get("sorgId");
	url = "jsp/cams/sorg/manage/group/somGroupBranchList.jsp";
	var map = new L5.Map();
	map.put("mainSorgId",mainSorgId);
	L5.forward(url,text,map);
}
function detail(){
	var url ;
	var text = "主体明细";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var sorgStatus = record.get("sorgStatus");
	if(sorgStatus=="22" || sorgStatus=="52"){
		url = "jsp/cams/sorg/manage/group/somGroup.jsp";
	}
	if(sorgStatus=="32" || sorgStatus=="62"){
		url = "jsp/cams/sorg/manage/group/somGroup2.jsp";
	}
	var id = record.get("sorgId");
	var map = new L5.Map();
	map.put("sorgId",id);
	map.put("sorgStatus",sorgStatus);
	L5.forward(url,text,map);
}