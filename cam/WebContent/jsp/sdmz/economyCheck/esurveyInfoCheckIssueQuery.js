//家庭信息
var declareFamilyInfoDataset = new L5.model.SimpleDataset({id:"declareFamilyInfoDataset",
	fields: ['jtid','hzxm','sfzh','jtrksl','jtxz','jzlx','hjxzqh']});

//审核状态
var shztDs = new L5.model.SimpleDataset({id:"shztDs",
	fields: ['value','text']});
	
//救助类型
var jzlxDs = new L5.model.SimpleDataset({id:"jzlxDs",
	fields: ['value','text']});
	
function init() {
	declareFamilyInfoDataset.loadData([['00001','户主','370188888', '2', '农村', '五保户', '济南市高新区'],
		['00002','户主2','370122222', '3', '农村', '五保户', '济南市高新区'],
		['00003','户主3','370177777', '1', '农村', '五保户', '济南市高新区']],false);
	
	shztDs.loadData([['01','未审核'],['02','已审核']],false);
	jzlxDs.loadData([['城乡低保','城乡低保'],['低收入家庭','低收入家庭']],false);
}

//设置查询（后台组sql语句）
function query(){

}

//查看详细信息
function details() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看!");
		return false;
	}
	
	L5.Msg.alert("提示","你选择的家庭ID是" + cell[0].get("jtid"));
}

//进行核对分发
function checkIssue() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择一条记录或多条数据进行核对分发!");
		return false;
	}
	
	var ids = "";
	for(var i=0; i < cell.length; i++) {
		var selected=cell[0];
		ids += cell[i].get("jtid") + "|";
	}
	ids = ids.substring(0, ids.length - 1);
	
	var data = new L5.Map();
	//data.put("id", ids);
	var url='jsp/sdmz/economyCheck/esurveyInfoCheckIssue.jsp'+'?id='+ids;
	var text = '选中家庭信息';
	L5.forward(url,text,data);
	
}

