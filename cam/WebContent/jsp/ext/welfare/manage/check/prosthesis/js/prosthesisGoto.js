//假肢企业编辑页面跳转
function nextPage(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheck'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPage(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheck'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPage(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheck1.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
