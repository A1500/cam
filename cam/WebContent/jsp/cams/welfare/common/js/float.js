//福利企业翻页功能键
function nextPage(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/welfareapply'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPage(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/welfareapply'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPage(){
	var data = new L5.Map();
	var url='jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/welfareapply1.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
//年检翻页
function nextPageY(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
	
}
function lastPageY(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageY(){
	var data = new L5.Map();
	var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply1.jsp';
	var text = '网上申报';
	L5.forward(url,text,data);
}
//假肢翻页功能键
function nextPageJ(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/prosthesisapply'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPageJ(page){
	if(save() == "break"){
		return;
	}
	var data = new L5.Map();
	var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/prosthesisapply'+page+'.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageJ(){
	var data = new L5.Map();
	var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/prosthesisapply1.jsp';
	data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
//增加行
var count1=1;
var count2=1;
var count3=1;
