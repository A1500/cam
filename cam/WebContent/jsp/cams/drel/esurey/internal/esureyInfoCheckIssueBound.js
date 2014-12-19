
//性别
var declareFamilyInfoDataset = new L5.model.SimpleDataset({id:"declareFamilyInfoDataset",
	fields: ['jtid','hzxm','sfzh','jtrksl','jtxz','jzlx','hjxzqh']});

function init() {
	
	alert(jtids + "");
	var arr = jtids.split("|");
	/*
	var _data;
	for(var i = 0; i < arr.length; i++) {
		var strTemp = arr[i];
		//if(strTemp == '00001')
			//_data 
	}
	*/
	
	declareFamilyInfoDataset.loadData([['00001','户主','370188888', '2', '农村', '五保户', '济南市高新区'],
		['00002','户主2','370122222', '3', '农村', '五保户', '济南市高新区'],
		['00003','户主3','370177777', '1', '农村', '五保户', '济南市高新区']],false);

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
		L5.Msg.alert("提示","请选择一条记录或多条数据!");
		return false;
	}
	
	var ids = "";
	for(var i=0; i < cell.length; i++) {
		var selected=cell[0];
		ids += cell[i].get("jtid") + "|";
	}
	
	
	var data = new L5.Map();
	//data.put("id", ids);
	var url='jsp/demo/cust/cust_detail.jsp'+'?id='+ids;
	var text = '选中家庭信息';
	L5.forward(url,text,data);
}

//返回至查询页面
function returnQuery() {
	var url='jsp/cams/drel/esurey/internal/esureyInfoCheckIssueQuery.jsp';
	var text = '查询家庭信息';
	L5.forward(url,text);
}

//按家庭进行核对分发
function familyIssue() {

	
}

//按成员进行核对分发
function memberIssue() {

}

