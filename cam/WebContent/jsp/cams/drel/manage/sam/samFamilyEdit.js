var BaseinfoFamilyDS;
var BaseinfoPeopleDS2;
var BaseinfoPeopleDS
function init() {
    BaseinfoPeopleDS = L5.DatasetMgr.lookup("BaseinfoPeopleDS");
    BaseinfoFamilyDS=L5.DatasetMgr.lookup("BaseinfoFamilyDS");
    BaseinfoPeopleDS2=L5.DatasetMgr.lookup("BaseinfoPeopleDS2");
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    DmXzqhDataSetStreet.setParameter("filterSql", "xzqhjb='3' and substr(xzqhdm,1,6)=370112");
    DmXzqhDataSetStreet.load();
    L5.QuickTips.init();
	var assistanceTypeDS = L5.DatasetMgr.lookup("assistanceTypeDS");

    if (method == null || method == "") {
        L5.Msg.alert('提示', "未知的页面命令!");
        back();
    } else if (method == "INSERT") {
        BaseinfoFamilyDS.newRecord({
            familyId: document.forms[0].familyId.value
        });
        return;
    } else if (method == "UPDATE" || method == "addMember") {
        if (method == "addMember") {
            L5.getCmp("tabPanels").setActiveTab(1);
        }
        BaseinfoFamilyDS.baseParams["FAMILY_ID@="] = idField;
        BaseinfoFamilyDS.on("load", getValue);
        BaseinfoFamilyDS.load();

		assistanceTypeDS.setParameter("FAMILY_ID@=",idField);
		assistanceTypeDS.on("load",queryAssistance);
		assistanceTypeDS.load();
        return;
    } else if (method == "EXAM") {
        BaseinfoFamilyDS.baseParams["FAMILY_ID@="] = idField;
        BaseinfoFamilyDS.on("load", getValue);
        BaseinfoFamilyDS.load();
        return;
    }
	function getValue() {
    	showJzlx();
        //如果起先数据为空，则直接调用增加方法
        if (BaseinfoFamilyDS.getCount() == 0) {
            BaseinfoFamilyDS.newRecord();
            return;
        }
        //户主信息加载
        BaseinfoPeopleDS.baseParams["FAMILY_ID@="] = idField;
        BaseinfoPeopleDS.load();
        //自然灾害加载
        SamFamilyCalamityDataSet.baseParams["FAMILY_ID@="] = idField;
        SamFamilyCalamityDataSet.load();

 	}
 }
 //根据选择的街道过滤村居
function setXzqhVillage() {
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street=document.getElementById("town").value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "xzqhjb='4' and substr(xzqhdm,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}
//-----照片显示-----------------------------
function itemLoad(){
alert("--");
	var paths = document.location.pathname.split("/");
	L5.fly('PHOTO_IMG').dom.src = paths[0] + '/' + paths[1]+ "/download?table=com_photo_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+ photoId + "'";
}
//---------------------------救助-----------
function queryAssistance(assistanceTypeDS){
	var records=assistanceTypeDS.getAllRecords();
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		var assistanceType=records[i].get("assistanceType");
		if(assistanceType=="01"){
			$("cityMi").checked=true;
			$("isDetail").style.display="block";
			$("isCity").style.display="block";
			$("cardNo").value=records[i].get("cardNo");
			$("signOrgName").value=records[i].get("signOrgName");
			$("signDate").value=records[i].get("signDate");
			$("cardValidateBegin").value=records[i].get("cardValidateBegin");
			$("cardValidateEnd").value=records[i].get("cardValidateEnd");
			$("assistanceBegin").value=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").value=records[i].get("accountName");
			$("accountCode").value=records[i].get("accountCode");
			$("assistanceMon").value=records[i].get("assistanceMon");
			$("assistanceClassMon").value=records[i].get("assistanceClassMon");
		}
		if(assistanceType=="02"){
			$("countryMi").checked=true;
			$("isDetail").style.display="block";
			$("isCountry").style.display="block";
			$("cardNo").value=records[i].get("cardNo");
			$("signOrgName").value=records[i].get("signOrgName");
			$("signDate").value=records[i].get("signDate");
			$("cardValidateBegin").value=records[i].get("cardValidateBegin");
			$("cardValidateEnd").value=records[i].get("cardValidateEnd");
			$("assistanceBegin").value=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").value=records[i].get("accountName");
			$("accountCode").value=records[i].get("accountCode");
			$("nassistanceMon").value=records[i].get("assistanceMon");
			$("nassistanceClassMon").value=records[i].get("assistanceClassMon");
		}
		if(assistanceType=="03"){
			$("fiveMi").checked=true;
			$("isDetail").style.display="block";
			$("isFive").style.display="block";
			$("cardNo").value=records[i].get("cardNo");
			$("signOrgName").value=records[i].get("signOrgName");
			$("signDate").value=records[i].get("signDate");
			$("cardValidateBegin").value=records[i].get("cardValidateBegin");
			$("cardValidateEnd").value=records[i].get("cardValidateEnd");
			$("assistanceBegin").value=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").value=records[i].get("accountName");
			$("accountCode").value=records[i].get("accountCode");
			$("supportWay").value=records[i].get("supportWay");
			$("cassistanceMon").value=records[i].get("assistanceMon");

		}
		if(assistanceType=="05"){
			$("giveMi").checked=true;
		}
		if(assistanceType=="06"){
			$("handicapped").checked=true;
		}
		if(assistanceType=="07"){
			$("pmother").checked=true;
		}
		if(assistanceType=="08"){
			$("kstudent").checked=true;
		}
		if(assistanceType=="09"){
			$("threeNothing").checked=true;
		}
		if(assistanceType=="10"){
			$("temployee").checked=true;
		}
		if(assistanceType=="11"){
			$("other").checked=true;
		}
	}
}
function modifyClick(){
 	var BaseinfoFamilyDS = L5.DatasetMgr.lookup("BaseinfoFamilyDS");
	var BaseinfoFamilyRecord=BaseinfoFamilyDS.getCurrent();
	BaseinfoFamilyRecord.state=L5.model.Record.STATE_MODIFIED;
	var familyId=idField;
	var photoTemp = document.forms[0].photoTemp.value;
	var photoPeople = document.forms[0].photoPeople.value;

	BaseinfoFamilyRecord.set("photoTemp",photoTemp);

	var assistanceTypeList=new Array();
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	if($("cityMi").checked){
		var record1=assistanceTypeDS.newRecord();
		record1.set("assistanceId","01"+familyId);
		record1.set("familyId",familyId);
		record1.set("assistanceType","01");
		record1.set("cardNo",_$("cardNo"));
		record1.set("signOrgName",_$("signOrgName"));
		record1.set("signDate",_$("signDate"));
		record1.set("cardValidateBegin",_$("cardValidateBegin"));
		record1.set("cardValidateEnd",_$("cardValidateEnd"));
		record1.set("assistanceBegin",_$("assistanceBegin"));
		record1.set("bank",_$("bank"));
		record1.set("accountName",_$("accountName"));
		record1.set("accountCode",_$("accountCode"));
		record1.set("assistanceMon",_$("assistanceMon"));
		record1.set("assistanceClassMon",_$("assistanceClassMon"));
		record1.set("cardStatus","0");
		assistanceTypeList[0]=record1;
	}
	if($("countryMi").checked){
		var record2=assistanceTypeDS.newRecord();
		record2.set("assistanceId","02"+familyId);
		record2.set("familyId",familyId);
		record2.set("assistanceType","02");
		record2.set("cardNo",_$("cardNo"));
		record2.set("signOrgName",_$("signOrgName"));
		record2.set("signDate",_$("signDate"));
		record2.set("cardValidateBegin",_$("cardValidateBegin"));
		record2.set("cardValidateEnd",_$("cardValidateEnd"));
		record2.set("assistanceBegin",_$("assistanceBegin"));
		record2.set("bank",_$("bank"));
		record2.set("accountName",_$("accountName"));
		record2.set("accountCode",_$("accountCode"));
		record2.set("assistanceMon",_$("nassistanceMon"));
		record2.set("assistanceClassMon",_$("nassistanceClassMon"));
		record2.set("cardStatus","0");
		assistanceTypeList[1]=record2;
	}
	if($("fiveMi").checked){
		var record3=assistanceTypeDS.newRecord();
		record3.set("assistanceId","03"+familyId);//------
		record3.set("familyId",familyId);
		record3.set("assistanceType","03");
		record3.set("cardNo",_$("cardNo"));
		record3.set("signOrgName",_$("signOrgName"));
		record3.set("signDate",_$("signDate"));
		record3.set("cardValidateBegin",_$("cardValidateBegin"));
		record3.set("cardValidateEnd",_$("cardValidateEnd"));
		record3.set("assistanceBegin",_$("assistanceBegin"));
		record3.set("bank",_$("bank"));
		record3.set("accountName",_$("accountName"));
		record3.set("accountCode",_$("accountCode"));
		record3.set("supportWay",_$("supportWay"));
		record3.set("assistanceMon",_$("cassistanceMon"));
		record3.set("cardStatus","0");
		assistanceTypeList[2]=record3;
	}
	if($("giveMi").checked){
		var record4=assistanceTypeDS.newRecord();
		record4.set("assistanceId","04"+familyId);//------
		record4.set("familyId",familyId);
		record4.set("assistanceType","05");
		record4.set("cardStatus","0");
		assistanceTypeList[3]=record4;
	}
	if($("handicapped").checked){
		var record5=assistanceTypeDS.newRecord();
		record5.set("assistanceId","05"+familyId);//------
		record5.set("familyId",familyId);
		record5.set("assistanceType","06");
		record5.set("cardStatus","0");
		assistanceTypeList[4]=record5;
	}
	if($("pmother").checked){
		var record6=assistanceTypeDS.newRecord();
		record6.set("assistanceId","06"+familyId);//------
		record6.set("familyId",familyId);
		record6.set("assistanceType","07");
		record6.set("cardStatus","0");
		assistanceTypeList[5]=record6;
	}
	if($("kstudent").checked){
		var record7=assistanceTypeDS.newRecord();
		record7.set("assistanceId","07"+familyId);//------
		record7.set("familyId",familyId);
		record7.set("assistanceType","08");
		record7.set("cardStatus","0");
		assistanceTypeList[6]=record7;
	}
	if($("threeNothing").checked){
		var record8=assistanceTypeDS.newRecord();
		record8.set("assistanceId","08"+familyId);//------
		record8.set("familyId",familyId);
		record8.set("assistanceType","09");
		record8.set("cardStatus","0");
		assistanceTypeList[7]=record8;
	}
	if($("temployee").checked){
		var record9=assistanceTypeDS.newRecord();
		record9.set("assistanceId","09"+familyId);//------
		record9.set("familyId",familyId);
		record9.set("assistanceType","10");
		record9.set("cardStatus","0");
		assistanceTypeList[8]=record9;
	}
	if($("other").checked){
		var record10=assistanceTypeDS.newRecord();
		record10.set("assistanceId","10"+familyId);//------
		record10.set("familyId",familyId);
		record10.set("assistanceType","11");
		record10.set("cardStatus","0");
		record10.set("modTime","");
		assistanceTypeList[9]=record10;
	}

	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
	command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);

	var YgjzJtxxZrzhRecords = SamFamilyCalamityDataSet.getAllChangedRecords();
    command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);

	command.setParameter("assistanceTypeList",assistanceTypeList);
	command.setParameter("opType", "update");
	command.execute("save");
	if (!command.error) {

		BaseinfoFamilyDS.getCurrent().state=L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method", "INSERTA");
    	data.put("familyId", familyId);
    	var url = 'jsp/cams/drel/manage/sam/samFamilyList.jsp';
		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setXzqhVillage() {
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street = document.getElementById("town").value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "xzqhjb='4' and substr(xzqhdm,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}
//-------------------jiang
function selectStructure(){
	var DmFwjgDataSet = L5.DatasetMgr.lookup("DmFwjgDataSet");
	var houseStatus=document.getElementById("houseStatus").value;
	if(houseStatus==""){
		document.getElementById("fwzk").innerHTML="房屋结构：";
	}
	if(houseStatus=="1"){
		document.getElementById("fwzk").innerHTML="房屋结构：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm between 1 and 5");
		DmFwjgDataSet.load();
	}
	if(houseStatus=="2"){
		document.getElementById("fwzk").innerHTML="危险程度：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm='6' or fwjgdm='7'");
		DmFwjgDataSet.load();

	}
	if(houseStatus=="3"){
		document.getElementById("fwzk").innerHTML="居住状况：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm='8' or fwjgdm='9'");
		DmFwjgDataSet.load();
	}
}
//-------jiang??????????
function insertClick(e){
	document.getElementById("familyId").readOnly=false;
	var dataset = L5.DatasetMgr.lookup("BaseinfoFamilyDS");
	//如果某必填数据为"",不再继续增加
	if(dataset.getCount()>0 && document.forms[0].familyId.value.trim()==""){
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount()-1);

	BaseinfoPeopleDS.baseParams["PEOPLE_ID@="]="-" ;
	BaseinfoPeopleDS.load();
	SamFamilyAssistanceDataSet.baseParams["FAMILY_ID@="]="-" ;
	SamFamilyAssistanceDataSet.load();
	YgjzJtxxZrzhDataSet.baseParams["FAMILY_ID@="]="-" ;
	YgjzJtxxZrzhDataSet.load();
	YgjzJzzsDataSet.baseParams["FAMILY_ID@="]="-" ;
	YgjzJzzsDataSet.load();

}
////-------jiang?
function deleteClick(e){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var BaseinfoFamilyDS = L5.DatasetMgr.lookup("BaseinfoFamilyDS");
			var BaseinfoFamilyRecord=BaseinfoFamilyDS.getCurrent();
			var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
			var  delIds=[];
			delIds[0]= BaseinfoFamilyRecord.get("familyId");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				BaseinfoFamilyDS.remove(BaseinfoFamilyRecord);
				if(!Evt_butNext_click()){
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示','删除成功！');
				var url='jsp/cams/drel/manage/sam/samFamilyList.jsp';
				var text="用户表";
				L5.forward(url,text);
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}
		else
			return;
	}
	);

}
//-----jiang
function returnClick(){
	var url='jsp/cams/drel/manage/sam/samFamilyList.jsp';
	var text='社会救助_家庭信息';
	L5.forward(url,text);
}

var peopleIdx=0;
// 增加家庭成员----jiang
function addYgjzJtxxCyxx() {

	BaseinfoFamilyDS = L5.DatasetMgr.lookup("BaseinfoFamilyDS");
    var BaseinfoFamilyRecord = BaseinfoFamilyDS.getCurrent();
    var sPpeopleIdx = "" + peopleIdx;
    if(peopleIdx < 10){
    	sPpeopleIdx = "0" + sPpeopleIdx;
    }
    BaseinfoPeopleDS2 = L5.DatasetMgr.lookup("BaseinfoPeopleDS2");
    BaseinfoPeopleDS2.newRecord({
        peopleId: "0" + sPpeopleIdx + document.forms[0].peopleId.value.substring(3, 10),
        familyId: BaseinfoFamilyRecord.get("familyId")
    });

    SamPeopleDisabilityDataSet.removeAll();
	SamPeopleEduDataSet.removeAll();
	SamPeopleDiseaseDataSet.removeAll();
	SamPeopleAccidentDataSet.removeAll();

    var win=L5.getCmp("hello-win");
	win.show(this);
	peopleIdx = peopleIdx + 1;
}

// 修改成员信息----jiang
function modifyCyxx() {
	var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条要修改的记录!");
		return false;
	}
	var peopleId =selected[0].get("peopleId");
	var photoc=selected[0].get("photoId");
	var BaseinfoPeopleDS2 = L5.DatasetMgr.lookup("BaseinfoPeopleDS2");
	BaseinfoPeopleDS2.baseParams["PEOPLE_ID@="] = peopleId;
    BaseinfoPeopleDS2.load();

    SamPeopleDisabilityDataSet = L5.DatasetMgr.lookup("SamPeopleDisabilityDataSet");
	SamPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleDisabilityDataSet.load();

    SamPeopleEduDataSet = L5.DatasetMgr.lookup("SamPeopleEduDataSet");
	SamPeopleEduDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleEduDataSet.load();

    SamPeopleDiseaseDataSet = L5.DatasetMgr.lookup("SamPeopleDiseaseDataSet");
	SamPeopleDiseaseDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleDiseaseDataSet.load();

    SamPeopleAccidentDataSet = L5.DatasetMgr.lookup("SamPeopleAccidentDataSet");
	SamPeopleAccidentDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleAccidentDataSet.load();

	var win=L5.getCmp("hello-win");
	win.on("activate",function(){

		if(photoc!=""){
			var paths = document.location.pathname.split("/");
			L5.fly('PHOTO_PEOPLE').dom.src = paths[0] + '/' + paths[1]+ "/download?table=com_photo_"+photoc.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+ photoc + "'";
		} else {
			L5.fly('PHOTO_PEOPLE').dom.src="";
		}
	});
	win.show(this);


}
//家庭成员明细---------jiang?
function jtxxCyxxDetail() {
    var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条要查看的记录!");
		return false;
	}
	var peopleId =selected[0].get("peopleId");
	var BaseinfoPeopleDS2 = L5.DatasetMgr.lookup("BaseinfoPeopleDS2");
	BaseinfoPeopleDS2.baseParams["PEOPLE_ID@="] = peopleId;
    BaseinfoPeopleDS2.load();
	win.show(this);
}
///删除信息-----jiang
function removeYgjzJtxxCyxx() {
	var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length < 1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				BaseinfoPeopleDS.remove(selected[i]);
			}
			updatePeopleNum();
		}else{
			return false;
		}
	});
}
// 确认保存----jiang
function confirm() {
	if(saveJtcy()){
		var win=L5.getCmp("hello-win");
		win.hide(this);
	    BaseinfoPeopleDS.on("load", updatePeopleNum);
	    BaseinfoPeopleDS.baseParams["FAMILY_ID@="] = idField;
	    BaseinfoPeopleDS.load();
	}
}
function updatePeopleNum(){
	if(BaseinfoPeopleDS.getCount() > 0){
    	var BaseinfoFamilyRecord = BaseinfoFamilyDS.getCurrent();
    	BaseinfoFamilyDS.set("peopleNum",BaseinfoPeopleDS.getCount());
    	BaseinfoFamilyDS.set("yearAverageIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/BaseinfoPeopleDS.getCount(),2) );
    	BaseinfoFamilyDS.set("monthIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/12,2) );
    	BaseinfoFamilyDS.set("monthAverageIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/(BaseinfoPeopleDS.getCount()*12),2) );
    	BaseinfoFamilyDS.set("buildAverageArea",decimalRound(BaseinfoFamilyRecord.get("buildArea")/BaseinfoPeopleDS.getCount(),2) );

    }else{
        BaseinfoFamilyDS.set("peopleNum",0);
        BaseinfoFamilyDS.set("yearAverageIncome",0);
    	BaseinfoFamilyDS.set("monthIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/12,2) );
    	BaseinfoFamilyDS.set("monthAverageIncome",0 );
    	BaseinfoFamilyDS.set("buildAverageArea",0);
    }
}

function decimalRound(num,decimalNum){
    var decimal2 = 1;
	while(decimalNum > 0){
		decimal2 = 10 * decimal2;
		decimalNum = decimalNum - 1;
	}
	return Math.round(num*decimal2)/decimal2;
}
// 关闭窗口----jiang
function hide() {
	var win=L5.getCmp("hello-win");
	win.hide(this);
}

// 保存成员信息--jiang
function saveJtcy(){
	var BaseinfoPeopleDS = L5.DatasetMgr.lookup("BaseinfoPeopleDS2");
	var BaseinfoPeopleRecord=BaseinfoPeopleDS.getCurrent();
//	alert(BaseinfoPeopleRecord.get("familyId"));
//	alert(BaseinfoPeopleRecord.get("peopleId"));
/*    var isValidate = BaseinfoPeopleDS.isValidate();
	if(isValidate != true){
		if(isValidate.indexOf("hzxm")!=-1){
			isValidate=isValidate.replace("hzxm","姓名");
		}
		if(isValidate.indexOf("familyCardNo")!=-1){
			isValidate=isValidate.replace("familyCardNo","身份证号");
		}
	    if(isValidate.indexOf("xbdm")!=-1){
			isValidate=isValidate.replace("xbdm","性别");
		}
        if(isValidate.indexOf("csrq")!=-1){
			isValidate=isValidate.replace("csrq","出生日期");
		}
        if(isValidate.indexOf("hjxzdm")!=-1){
			isValidate=isValidate.replace("hjxzdm","户籍性质");
		}
        if(isValidate.indexOf("mzdm")!=-1){
			isValidate=isValidate.replace("mzdm","民族");
		}
		if(isValidate.indexOf("hyzkdm")!=-1){
			isValidate=isValidate.replace("hyzkdm","婚姻状况");
		}
		if(isValidate.indexOf("ylzkdm")!=-1){
			isValidate=isValidate.replace("ylzkdm","医疗状况");
		}

		if(isValidate.indexOf("jyzkdm")!=-1){
			isValidate=isValidate.replace("jyzkdm","职业状况");
		}

		L5.Msg.alert("提示",isValidate);

		return false;
	}
*/
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd");
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	//残疾
	var YgjzCyxxCjxxRecords = SamPeopleDisabilityDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxCjxxRecords", YgjzCyxxCjxxRecords);
    //教育
    var YgjzCyxxJyxxRecords = SamPeopleEduDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxJyxxRecords", YgjzCyxxJyxxRecords);
    //患病
    var YgjzCyxxHbxxRecords = SamPeopleDiseaseDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxHbxxRecords", YgjzCyxxHbxxRecords);
    //事故
    var YgjzCyxxSgxxRecords = SamPeopleAccidentDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxSgxxRecords", YgjzCyxxSgxxRecords);

	command.execute("saveJtcy");
	if (!command.error) {
	    SamPeopleDisabilityDataSet.commitChanges();
		return true;
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		return false;
	}
	return true;
}
//单独校验身份证----jiang
function  checkFamilyId(familyCardNo){
  var msg="";
  if(familyCardNo!=""){
	 var idmsg=checkIdcard(familyCardNo);
     msg=msg+"身份证号"+idmsg;

  }
  return true;
}
 //根据身份证回填出生日期---jiang
function getBirthdayByIdCard(){
    var idCard = document.getElementById("familyCardNo").value;
	document.getElementById("birthday").value= idCard.substring(6,14);
 }
 //固定电话校验---jiang
function __isFixedTelephone(s){
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,8}(-\d+)?$/g.test(s);
}
 //手机校验---jiang
function __isMobileTelephone(s) {
	return /^1(3\d|(58|59|56|52|53|50))\d{8}$/g.test(s);
}
//固定电话----jiang
function checkDhhm(){
  var familyPhone = document.getElementById("familyPhone");
    if(trim(familyPhone.value)!=""&&!__isFixedTelephone(trim(familyPhone.value)))
  {
     alert("请输入正确的电话号码！");
  	 familyPhone.value="";
     familyPhone.focus();
     return false;
  }
  return true;
}
//窗口固定电话---jiang
function checkWinDhhm(){
  var workUnitTel = document.getElementById("workUnitTel");
    if(trim(workUnitTel.value)!=""&&!__isFixedTelephone(trim(workUnitTel.value)))
  {
     alert("请输入正确的电话号码！");
  	 workUnitTel.value="";
     workUnitTel.focus();
     return false;
  }
  return true;
}
function trim(str){
   var start = -1,
   end = str.length;
   while (str.charCodeAt(--end) < 33);
   while (str.charCodeAt(++start) < 33);
   return str.slice(start, end + 1);
}

//手机---jiang
 function checkSjhm(){
  var familyMobile = document.getElementById("familyMobile");
    if(trim(familyMobile.value)!=""&&!__isMobileTelephone(trim(familyMobile.value)))
  {
     alert("请输入正确的手机号码！");
  	 familyMobile.value="";
     familyMobile.focus();
     return false;
  }
  return true;
}
//窗口手机---jiang
 function checkWinSjhm(){
  var telMobile = document.getElementById("telMobile");
    if(trim(telMobile.value)!=""&&!__isMobileTelephone(trim(telMobile.value)))
  {
     alert("请输入正确的手机号码！");
  	 telMobile.value="";
     telMobile.focus();
     return false;
  }
  return true;
}
//help帮助----jiang?????
 function mutiHelp() {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup("DmJzlxDataSet");
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchArea();
		multiItem_search.addTextField("DM_JZLX.JZLXDM","编号","jzlxdm");
		multiItem_search.addTextField("DM_JZLX.JZLXMC","名称","jzlxmc");
		itemWin = new L5.MultiGridHelpWindow1(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result);
    	}
	}
}
//设置帮主栏值----jiang????

function setValue(result) {
	var jzlx = document.getElementById("jzlx");
	var assistanceTypeCode = document.getElementById("assistanceTypeCode");
	jzlx.value="";
	assistanceTypeCode.value="";
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlx.value=="") {
				jzlx.value += (record.get("text"));
				assistanceTypeCode.value += (record.get("value"));
			} else {
				jzlx.value += (","+record.get("text"));
				assistanceTypeCode.value += (","+record.get("value"));
			}
		}
	} else {
		jzlx.value = result.get("text");
		assistanceTypeCode.value = result.get("value");
	}
}
// 显示受助类型-----jiang??
function showJzlx(){
	var jzlxText = "";
	var BaseinfoFamilyRecord=BaseinfoFamilyDS.getCurrent();
    var assistanceType = BaseinfoFamilyRecord.get("assistanceType");
    var jzlxArr = assistanceType.split(",");
    for (var i = 0; i < jzlxArr.length; i++){
    	if(i > 0) jzlxText = jzlxText + ",";
        jzlxText = jzlxText + get_Jzlx_Value(jzlxArr[i]);
    }
    if(document.getElementById("assistanceType")){
		document.getElementById("assistanceType").value=jzlxText;
	}
	if(document.getElementById("assistanceTypeCode")){
		document.getElementById("assistanceTypeCode").value=assistanceType;
	}
}
// 受助类型字典表----jiang??
function get_Jzlx_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmJzlxDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}

//身份证重复校验
function checkIfRepeat(){
	var BaseinfoFamilyDS1=L5.DatasetMgr.lookup("BaseinfoFamilyDS1");
	//获取身份证号
	var  idCard=document.getElementById('familyCardNo').value;
    if(idCard=='')return;
 	 BaseinfoFamilyDS1.setParameter("BASEINFO_FAMILY.FAMILY_CARD_NO@=",idCard);
	BaseinfoFamilyDS1.load();
	BaseinfoFamilyDS1.on('load',queryIdCard);
}
//---jiang
function queryIdCard(BaseinfoFamilyDS1){
	if(BaseinfoFamilyDS1.getCount()!=0){
		L5.Msg.alert("提示","您输入的身份证已经存在！");
		document.getElementById('familyCardNo').value="";
	}else{

	}
}
//家庭成员身份证号重复校验---jiang
function checkCysfzhIfRepeat(){alert()
	var BaseinfoPeopleDS3=L5.DatasetMgr.lookup("BaseinfoPeopleDS3");

	//获取身份证号
	var  idCard=document.getElementById('idCard').value;
    if(idCard=='')return;
   	BaseinfoPeopleDS3.baseParams["ID_CARD@="] = idCard;
	BaseinfoPeopleDS3.load();

}

//救助类型双击清空---jiang???
function jzlxDbClick() {
	document.getElementById("assistanceType").value="";
	document.getElementById("assistanceTypeCode").value="";
}
//自动获取身份证号码---jiang??
function getMaxCode(familyCardNo){
   var familyCardNo= document.getElementById(familyCardNo);
   var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }
   document.getElementById("familyCardNo").value=idCardExtend;
   BaseinfoFamilyDS.set("familyCardNo",idCardExtend);

}

//自动获取家庭成员身份证号码---jiang??
function getMaxCode2(jtcysfzh){
   var jtcysfzh= document.getElementById(jtcysfzh);
   var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }
   document.getElementById("familyCardNo").value=idCardExtend;
   BaseinfoPeopleDS2.set("idCard",idCardExtend);
}
//家庭成员户主关系重复提示
function checkHzgx(){
	var BaseinfoPeopleDS=L5.DatasetMgr.lookup("BaseinfoPeopleDS");

	var BaseinfoPeopleRecords = BaseinfoPeopleDS.getAllRecords();
	var  relationshipType=document.getElementById('relationshipType').value;

    for(var i=0;i<BaseinfoPeopleRecords.length;i++){
    	if(BaseinfoPeopleRecords[i].get("relationshipType") == relationshipType){
					L5.Msg.alert("提示","户主已经存在!");

					return false;
    	}
    	else{
    	return true;
    	}
    }
  }
  //家庭成员户主关系重复校验
  function chkecHzgx1(){
  	var BaseinfoPeopleDS=L5.DatasetMgr.lookup("BaseinfoPeopleDS");
	var BaseinfoPeopleRecords = BaseinfoPeopleDS.getAllRecords();
	var  relationshipType=document.getElementById('relationshipType').value;
	var j=0;
    for(var i=0;i<BaseinfoPeopleRecords.length;i++){
    	if(BaseinfoPeopleRecords[i].get("relationshipType") == relationshipType){
					j++;}
					}
				if(j>0){
					return false;
					}
    			else{
    				return true;
    			}
  }
//------------------------------------------------救助类型信息----------------------------------
//城市低保
function setCityMi(src){
	if(src.checked){
		src.value = '01';
		$("countryMi").checked=false;
		$("fiveMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isCity").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
	}
}

//农村低保
function setCountryMi(src){
	if(src.checked){
		src.value = '02';
		$("cityMi").checked=false;
		$("fiveMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isCountry").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isCountry").style.display="none";
	}
}
//农村五保
function setFiveMi(src){
	if(src.checked){
		src.value = '03';
		$("cityMi").checked=false;
		$("countryMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isFive").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isFive").style.display="none";
	}
}
//优抚
function setGiveMi(src){
	if(src.checked){
		src.value = '05';
	}else{
		src.value = '';
	}
}
//残疾人
function setHandicapped(src){
	if(src.checked){
		src.value = '06';
	}else{
		src.value = '';
	}
}
//单亲特困母亲
function setPmother(src){
	if(src.checked){
		src.value = '07';
	}else{
		src.value = '';
	}
}
//困难学生
function setKstudent(src){
	if(src.checked){
		src.value = '08';
	}else{
		src.value = '';
	}
}
//“三无”对象
function setThreeNothing(src){
	if(src.checked){
		src.value = '09';
	}else{
		src.value = '';
	}
}
//特困职工
function setTemployee(src){
	if(src.checked){
		src.value = '10';
	}else{
		src.value = '';
	}
}
//其他
function setOther(src){
	if(src.checked){
		src.value = '11';
	}else{
		src.value = '';
	}
}
//－－－－－－－－－－－－－－－－家庭自然灾害－－－－－－－－－－－
//新增自然灾害
function addYgjzJtxxZrzh() {
	SamFamilyCalamityDataSet.newRecord({
		familyId :  document.forms[0].familyId.value

	});
}
//删除自然灾害
function removeYgjzJtxxZrzh() {
	var editGrid=L5.getCmp('YgjzJtxxZrzhEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyCalamityCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("familyId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamFamilyCalamityDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
//撤销自然灾害
function undoJtxxZrzh() {
	SamFamilyCalamityDataSet.rejectChanges();
}

//－－－－－－－－－－－－－－－－人员残疾信息－－－－－－－－－－－
// 增加残疾信息
function addYgjzCyxxCjxx() {
    YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
    SamPeopleDisabilityDataSet.newRecord({
        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
    });
}
//删除残疾信息
function removeYgjzCyxxCjxx() {
	var editGrid=L5.getCmp('YgjzCyxxCjxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamPeopleDisabilityCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleDisabilityDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
//撤销残疾信息
function undoCyxxCjxx() {
	SamPeopleDisabilityDataSet.rejectChanges();
}

//---------------------人员教育信息---------------------
//教育信息添加
function addYgjzCyxxJyxx() {
	var SamPeopleEduDataSet=L5.DatasetMgr.lookup("SamPeopleEduDataSet");
	if(method=="INSERT"){
		SamPeopleEduDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleEduDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
//教育信息删除
function removeYgjzCyxxJyxx() {
	var editGrid=L5.getCmp('YgjzCyxxJyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamPeopleEduCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleEduDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
//撤销教育信息
function undoCyxxJyxx() {
	SamPeopleEduDataSet.rejectChanges();
}

//-----------------------人员患病信息--------------------------
//添加患病信息
function addYgjzCyxxHbxx() {
    var SamPeopleDiseaseDataSet=L5.DatasetMgr.lookup("SamPeopleDiseaseDataSet");
	if(method=="INSERT"){
		SamPeopleDiseaseDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleDiseaseDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
//删除患病信息
function removeYgjzCyxxHbxx() {
	var editGrid=L5.getCmp('YgjzCyxxHbxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamPeopleDiseaseCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleDiseaseDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
//撤销患病信息
function undoCyxxHbxx() {
	SamPeopleDiseaseDataSet.rejectChanges();
}

//-----------------------人员事故信息--------------------------
//添加事故信息
function addYgjzCyxxSgxx() {
  	var SamPeopleAccidentDataSet=L5.DatasetMgr.lookup("SamPeopleAccidentDataSet");
	if(method=="INSERT"){
		SamPeopleAccidentDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleAccidentDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
//删除事故信息
function removeYgjzCyxxSgxx() {
	var editGrid=L5.getCmp('YgjzCyxxSgxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleAccidentDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
//撤销事故
function undoCyxxSgxx() {
	SamPeopleAccidentDataSet.rejectChanges();
}