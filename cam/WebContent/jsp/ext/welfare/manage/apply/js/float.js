//假肢企业编辑页面翻页功能键
function nextPage(page){
	if(save()=="break"){
		return false;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPage(page){
	if(save()=="break"){
		return false;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPage(){
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExt1.jsp';
	var text = '网上申报';
	L5.forward(url,text,data);
}
//假肢企业明细页面翻页功能键
function nextPageD(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExtDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPageD(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExtDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageD(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/fitExtDetail1.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
//福利企业编辑页面翻页功能键
function nextPageW(page){
	if(save()=="break"){
		return false;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/unitExt'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPageW(page){
	if(save()=="break"){
		return false;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/unitExt'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageW(){
	var data = new L5.Map();
	data.put("taskCode",taskCode);
	var url='jsp/ext/welfare/manage/apply/welfarecorp/unitExt1.jsp';
	var text = '网上申报';
	L5.forward(url,text,data);
}
//福利企业明细页面翻页功能键
function nextPageY(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/unitExtDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPageY(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/unitExtDetail'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageY(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/unitExtDetail1.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
