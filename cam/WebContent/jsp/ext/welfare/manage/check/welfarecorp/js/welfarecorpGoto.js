//福利企业编辑页面跳转
function nextPage(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheck'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPage(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheck'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPage(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheck1.jsp';
	var text = '网上申报';
	data.put("taskCode",taskCode);
	L5.forward(url,text,data);
}
//福利企业
function nextPageD(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPageD(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheckDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageD(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/welfarecorp/unitExtCheckDetail1.jsp';
	var text = '网上申报';
	data.put("taskCode",taskCode);
	L5.forward(url,text,data);
}
