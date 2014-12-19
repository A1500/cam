function init(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_TYPE@=","M");
	somOrganDataSet.setParameter("SORG_STATUS@in","22,32,52,62");
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
	somOrganDataSet.setParameter("SORG_KIND@=",_$("sorgKind"));
	somOrganDataSet.setParameter("SORG_TYPE@=","M");
	somOrganDataSet.load();
}
function insert(){
	var url = "jsp/cams/sorg/manage/ungov/somUngovInsert.jsp";
	var text = "民非录入";
	L5.forward(url,text);
}

function update(){
	var url = "jsp/cams/sorg/manage/ungov/somUngovUpdate.jsp";
	var text = "民非修改";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(record.get("sorgStatus")=="32" || record.get("sorgStatus")=="62"){
		L5.Msg.alert("提示","选中的民办非企业单位已注销，不能进行修改操作!");
		return;
	}
	if(record.get("sorgStatus")=="52"){
		L5.Msg.alert("提示","选中的民办非企业单位已撤销，不能进行修改操作!");
		return;
	}
	var id = record.get("sorgId");
	var sorgKind = record.get("sorgKind");
	var map = new L5.Map();
	map.put("sorgId",id);
	map.put("sorgKind",sorgKind);
	L5.forward(url,text,map);
}
function cancel(){
	var url = "jsp/cams/sorg/manage/ungov/somUngovCancel.jsp";
	var text = "民非注销";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var id = record.get("sorgId");
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
		L5.Msg.alert("提示","选中的民办非企业单位已注销，不能进行撤销操作!");
		return;
	}
	if(record.get("sorgStatus")=="52"){
		L5.Msg.alert("提示","选中的民办非企业单位已被撤销!");
		return;
	}
	var id = record.get("sorgId");
	L5.MessageBox.confirm('', '你确定要撤销吗？',function(sure){
		if(sure=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomUngovCmd");
			command.setParameter("sorgId", id);
			command.execute("saveRepeal");
			if (!command.error) {
				var url = "jsp/cams/sorg/manage/ungov/somUngovList.jsp";
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
function detail(){
	var url ;
	var text = "民非明细";
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var sorgStatus = record.get("sorgStatus");
	if(sorgStatus=="22" || sorgStatus=="52"){
		url = "jsp/cams/sorg/manage/ungov/somUngov.jsp";
	}
	if(sorgStatus=="32" || sorgStatus=="62"){
		url = "jsp/cams/sorg/manage/ungov/somUngov2.jsp";
	}
	var id = record.get("sorgId");
	var map = new L5.Map();
	map.put("sorgStatus",sorgStatus);
	map.put("sorgId",id);
	L5.forward(url,text,map);

}