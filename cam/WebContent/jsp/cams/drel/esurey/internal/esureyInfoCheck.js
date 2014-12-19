
//性别
var declareFamilyInfoDataset = new L5.model.SimpleDataset({id:"declareFamilyInfoDataset",
	fields: ['jtid','hzxm','sfzh','jtrksl','jtxz','jzlx','hjxzqh']});

function init() {
	declareFamilyInfoDataset.loadData([['00001','户主','370188888', '2', '农村', '五保户', '济南市高新区']],false);

}

//设置查询（后台组sql语句）
function query(){

}

