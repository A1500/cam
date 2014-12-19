//初始化
function init() {
	
	var ds=L5.DatasetMgr.lookup("jzfaDataset");
	ds.setParameter("planId",arr2);
	ds.load();
	var ds2=L5.DatasetMgr.lookup("sjtjfxDataset");
	ds2.setParameter("planId",arr2);
	ds2.load();
	
	var ds3=L5.DatasetMgr.lookup("repeatDataset");
	
	ds3.setParameter("planId",arr2);
	ds3.load();
	//var he=ds.sum("JZZJJE",0,ds.getTotalCount-1);
};
//点击返回按钮 取消操作
function undo(){
	var url='jsp/ext/esurey/jzfa/jzfafxQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text);
}
//点击按救助户数统计 跳转页面
function jzhstj(){
	var data = new L5.Map();
	data.put("jzfaids",arr2);
	var url='jsp/ext/esurey/jzfa/jzfafxAnalyzeJzhs.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);
}
//点击按救助资金投入分析 
function zjtrtj(){
	var data = new L5.Map();
	data.put("jzfaids",arr2);
	var url='jsp/ext/esurey/jzfa/jzfafxAnalyze.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);
}
//点击按救助人数统计
function jzrstj(){
var data = new L5.Map();
	data.put("jzfaids",arr2);
	var url='jsp/ext/esurey/jzfa/jzfafxAnalyzeJzrs.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);
}



//跳转重复救助页面
function jzRepeatList(jtid){
var ds=L5.DatasetMgr.lookup('repeatDataset');
	var record = ds.getCurrent();
	var jzfa=record.get("PLAN_ID");
    var data = new L5.Map();
     data.put("jzfa", jzfa);
    data.put("dataBean", jtid);
    data.put("jzfaids",arr2);
    var url = 'jsp/ext/esurey/jzfa/jzRepeatList.jsp';
    var text = '阳光救助_家庭信息';
    L5.forward(url, text, data);
}

//救助对象和救助单位超链接的实现。
function jtxxDetailHref(value,cellmeta,record,rowindex,colindex,repeatDataset){
   
	return '<a href="javascript:jzRepeatList(\'' + record.data["FAMILY_ID"] + '\')">' + value + '</a>';
}
 
