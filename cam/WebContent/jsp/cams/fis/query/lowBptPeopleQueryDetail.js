function init() {
	var peopleinfods = L5.DatasetMgr.lookup("peopleinfods");
	peopleinfods.setParameter("idcard", "-1");
	peopleinfods.load();
	peopleinfods.on("load",function(){
		var count = peopleinfods.getCount();
		if(count==0){
			peopleinfods.newRecord();
		}
	});
	L5.QuickTips.init();
	
}
function print(){  
	var peopleinfods = L5.DatasetMgr.lookup("peopleinfods");
	var count = peopleinfods.getCount();
	var name = document.getElementById("name").value;
	var idcard = document.getElementById("idcard").value;
	if(name==''&&idcard==''){
		alert("没有要写入的内容!");
		return;
	}
	document.getElementById("nameprint").value = name;
	document.getElementById("idcardprint").value = idcard;
	var url="../../comm/print/jspcommonprint.jsp?";
	var text='低保优抚查询';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
function query(){     
	var name = document.getElementById("name").value;
	var idcard = document.getElementById("idcard").value;
	if(name==''||idcard==''){
		alert("请完整填写 姓名 及 身份证号!");
	}
	var peopleinfods = L5.DatasetMgr.lookup("peopleinfods");
	peopleinfods.setParameter("name", name);
	peopleinfods.setParameter("idcard", idcard);
	peopleinfods.load();
	peopleinfods.on("load",function(){
		var count = peopleinfods.getCount();
		if(count==0){
			alert("没有找到该人员!");
		}
	});
}
function personalscan(){

	var getreturn =window.showModalDialog("scan.jsp",window,"dialogWidth=0px;dialogHeight=0px;help:no;scroll:no;status:0");
	if(getreturn!=""&&getreturn!=undefined){
		var content = decodeURI(getreturn)
		var list = content.split(";");
		document.getElementById("name").value=list[0];
		document.getElementById("idcard").value=list[2];
		query();
	}
}