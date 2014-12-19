//初始化页面
function init() {
	var ds=L5.DatasetMgr.lookup("jzfaDataset");
	
	ds.setParameter("planId",arr2)
	
	ds.load();


};
//点击返回按钮
function undo(){
	var url='jsp/ext/esurey/jzfa/jzfafxQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text);
}
//点击按投入资金金额统计
function zjtrtj(){
	var data = new L5.Map();
	data.put("jzfaids",arr2);
	var url='jsp/ext/esurey/jzfa/jzfafxAnalyze.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);
}
//点击按救助户数统计
function jzhstj(){
	var data = new L5.Map();
	data.put("jzfaids",arr2);
	var url='jsp/ext/esurey/jzfa/jzfafxAnalyzeJzhs.jsp';
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