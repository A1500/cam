//福利企业翻页功能键
function nextPage(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/welfareapply'+page+'.jsp';
	//data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPage(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/welfareapply'+page+'.jsp';
	//data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPage(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/welfarecorp/welfareapply1.jsp';
	var text = '网上申报';
	L5.forward(url,text,data);
}
//假肢翻页功能键
function nextPageJ(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/prosthesisapply'+page+'.jsp';
	//data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function lastPageJ(page){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/prosthesisapply'+page+'.jsp';
	//data.put("taskCode",taskCode);
	var text = '网上申报';
	L5.forward(url,text,data);
}
function backPageJ(){
	var data = new L5.Map();
	var url='jsp/ext/welfare/manage/apply/prosthesis/prosthesisapply1.jsp';
	var text = '网上申报';
	L5.forward(url,text,data);
}
//增加行
var count1=1;
var count2=1;
var count3=1;
//function addtr(idtr){
//	if(idtr=='tbl1'){
//		count1=count1+1;
//		if(count1<6){
//			document.getElementById(idtr+count1).style.display='inline';
//		}else{
//			return ;
//		}
//	}
//	if(idtr=='tbl2'){
//		count2=count2+1;
//		if(count2<6){
//			document.getElementById(idtr+count2).style.display='inline';
//		}else{
//			return ;
//		}
//	}
//	if(idtr=='tbl3'){
//		count3=count3+1;
//		if(count3<6){
//			document.getElementById(idtr+count3).style.display='inline';
//		}else{
//			return ;
//		}
//	}
//}