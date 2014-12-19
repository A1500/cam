var saveflag=true;
var jiazhuRecord=null;
function init(){
	updateFamilyData();//加载页面
}
function updateFamilyData(ds){//修改页面加载
	familyDataSet.setParameter("FAMILY_ID",familyId);
	familyDataSet.load();
	familyDataSet.on("load",loadpeople);
}
function loadpeople(ds){//加载成员
	ds.un("load",loadpeople);
    peopleListDataSet.setParameter("FAMILY_ID",familyId);
    peopleListDataSet.load();
    peopleListDataSet.on("load",loadsupport);
    
}
function loadsupport(ds){//加载赡养人	
	ds.un("load",loadsupport);
	
    lowSupportDataset.setParameter("FAMILY_ID",familyId);
    lowSupportDataset.load();
   	lowSupportDataset.on("load",loadconfirm);    
}
function loadconfirm(ds){//加载审批审核意见
	ds.un("load",loadconfirm);
    lowApplyInfoDs.setParameter("FAMILY_ID",familyId);
    lowApplyInfoDs.load();
    lowApplyInfoDs.on("load",loadEnd); 
  }
function loadEnd(){
	if(peopleListDataSet.getCount()>0){
			var index = peopleListDataSet.find("relationshipType","01",0);
			if(index>=0){
				jiazhuRecord = peopleListDataSet.getAt(index);
				var birthday = jiazhuRecord.get("birthday");
				var age= getAge(birthday);
				familyDataSet.set("age",age);

				familyDataSet.set("nation",jiazhuRecord.get("NATION"));//没有关联到数据库字段
				familyDataSet.set("sex",jiazhuRecord.get("SEX"));
			}
		}
	if (lowApplyInfoDs.getCount()==0){
		lowApplyInfoDs.newRecord();
	};
}

//计算年龄
function getAge(birthday){
	var date = new Date();
	var year = date.getFullYear();
	var birthYear = birthday.substr(0,4);
	var age = year-birthYear;
	if(age>=0){
		return age;
	}
	else{
		return 0;
	}
}

function returnBack(){
	var data = new L5.Map();
	var url='';
	if(from=="PEOPLE"){
		url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyListByPeople.jsp';
	}else{
		url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyList.jsp';
	}
	var text = '新增城市低收入家庭信息';
	L5.forward(url,text,data);
}
function showPeopleMsg(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:showPeopleWin(\''+record.get("peopleId")+'\',\''+record.get("FAMILY_ID")+'\')">'+value+'</a>';

}
function showSupportMsg(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:showSupportWin(\''+record.get("supportId")+'\',\''+record.get("FAMILY_ID")+'\')">'+value+'</a>';

}
function showPeopleWin(peopleId,familyId){
 	var win=L5.getCmp("peopleWin");
    win.show();
	peopleListDataSetWin.setParameter("PEOPLE_ID",peopleId);
	peopleListDataSetWin.load();

}
function showSupportWin(supportId,familyId){
 	var win=L5.getCmp("supportWin");
    win.show();
	lowSupportDatasetWin.setParameter("SUPPORT_ID",supportId);
	lowSupportDatasetWin.load();

}
function closePeopleWin(){
	var win=L5.getCmp("peopleWin");
	win.hide();
}
function closeSupportWin(){
	var win=L5.getCmp("supportWin");
	win.hide();
}

