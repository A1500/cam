function init() {
	L5.getCmp("tabPanels").setActiveTab("1");
	L5.getCmp("tabPanels").setActiveTab("0");
    var YgjzJtxxCyxxDataSet2 = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
    var DmXzqhDataSetState = L5.DatasetMgr.lookup("DmXzqhDataSetState");
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    
    	DmXzqhDataSetState.setParameter("filterSql", "leve='2' and substr(id,1,4)= '" + organArea.substring(0, 4) + "'");
    	DmXzqhDataSetState.load();

	DmMzDataSet.load();

     L5.QuickTips.init();

    if (method == null || method == "") {
        L5.Msg.alert('提示', "未知的页面命令!");
        back();
    } else if (method == "INSERT") {
      YgjzJtxxCyxxDataSet2.newRecord({
        peopleId: document.forms[0].peopleId.value,
        familyId: document.forms[0].familyId.value
    });
      YgjzJtxxDataSet.newRecord({
            familyId: document.forms[0].familyId.value
        });
        document.getElementById('idCard').value=idField;
        document.getElementById('relationshipType').value="01";//户主
        document.getElementById('familyCardNo').value=idField;
    	document.getElementById('familyCardNo').focus();
        return;
    } else if (method == "UPDATE" || method == "addMember") {
        if (method == "addMember") {
            L5.getCmp("tabPanels").setActiveTab(1);
        }
        YgjzJtxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxDataSet.on("load", getValue);
        YgjzJtxxDataSet.load();
        return;
    } else if (method == "EXAM") {
        YgjzJtxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxDataSet.on("load", getValue);
        YgjzJtxxDataSet.load();
        return;
    }
    function getValue() {
    	showJzlx();
        //如果起先数据为空，则直接调用增加方法
        if (YgjzJtxxDataSet.getCount() == 0) {
            YgjzJtxxDataSet.newRecord();
            return;
        }
        YgjzJtxxCyxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxCyxxDataSet.load();

        YgjzJtxxSzlxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxSzlxDataSet.load();

        YgjzJtxxZrzhDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxZrzhDataSet.load();

        YgjzJzzsDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJzzsDataSet.load();
    }
}
 /**
 *  困难家庭登记
 *  事件处理：关于选择 住房状况类型 联动'房屋结构'
 *
 */
function selectStructure(){
	var DmFwjgDataSet = L5.DatasetMgr.lookup("DmFwjgDataSet");
	var zfzklxdm=document.getElementById("houseStatus").value;
	if(zfzklxdm==""){
		document.getElementById("fwzk").innerHTML="房屋结构：";
	}
	if(zfzklxdm=="1"){
		document.getElementById("fwzk").innerHTML="房屋结构：";
		DmFwjgDataSet.setParameter("filterSql", "code between 1 and 5");
		DmFwjgDataSet.load();
	}
	if(zfzklxdm=="2"){
		document.getElementById("fwzk").innerHTML="危险程度：";
		DmFwjgDataSet.setParameter("filterSql", "code='6' or code='7'");
		DmFwjgDataSet.load();

	}
	if(zfzklxdm=="3"){
		document.getElementById("fwzk").innerHTML="居住状况：";
		DmFwjgDataSet.setParameter("filterSql", "code='8' or code='9'");
		DmFwjgDataSet.load();
	}
}

function setXzqhStreet() {
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    var county=document.getElementById("county").value;
    if (county.length > 9) {
        DmXzqhDataSetStreet.setParameter("filterSql", "leve='3' and substr(id,1,6)= '" + county.substring(0, 6) + "'");
        DmXzqhDataSetStreet.load();
    }
}

function setXzqhVillage() {
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street=document.getElementById("town").value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "leve='4' and substr(id,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}


 /***--------------------------------------困难家庭登记开始------------------------------------------******/
 /**
 *  困难家庭登记
 *  事件处理：点击保存并录入成员按钮
 *  保存家庭信息转向变更JSP
 *
 */
function saveClick(){
	var img=document.getElementById("photoTemp").value;
	var photoc=document.getElementById("peoplePhotoTemp").value;
	var street=document.getElementById("town").value;
	var county=document.getElementById("county").value;
	var relationshipType=document.getElementById("relationshipType").value;
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	YgjzJtxxRecord.set('photoTemp',img);
	YgjzJtxxRecord.set('county',county);
	YgjzJtxxRecord.set('town',street);
 	var familyId=document.forms[0].familyId.value;
 	var peopleId=document.forms[0].peopleId.value;
	var fAssistanceType="";
	var assistanceTypeList=new Array();
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	if($("cityMi").checked){
		var record1=assistanceTypeDS.newRecord();
		fAssistanceType+="01,";
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
		fAssistanceType+="02,";
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
		fAssistanceType+="03,";
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
		fAssistanceType+="05,";
		record4.set("familyId",familyId);
		record4.set("assistanceType","05");
		record4.set("cardStatus","0");
		assistanceTypeList[3]=record4;
	}
	if($("handicapped").checked){
		var record5=assistanceTypeDS.newRecord();
		fAssistanceType+="06,";
		record5.set("familyId",familyId);
		record5.set("assistanceType","06");
		record5.set("cardStatus","0");
		assistanceTypeList[4]=record5;
	}
	if($("pmother").checked){
		var record6=assistanceTypeDS.newRecord();
		fAssistanceType+="07,";
		record6.set("familyId",familyId);
		record6.set("assistanceType","07");
		record6.set("cardStatus","0");
		assistanceTypeList[5]=record6;
	}
	if($("kstudent").checked){
		var record7=assistanceTypeDS.newRecord();
		fAssistanceType+="08,";
		record7.set("familyId",familyId);
		record7.set("assistanceType","08");
		record7.set("cardStatus","0");
		assistanceTypeList[6]=record7;
	}
	if($("threeNothing").checked){
		var record8=assistanceTypeDS.newRecord();
		fAssistanceType+="09,";
		record8.set("familyId",familyId);
		record8.set("assistanceType","09");
		record8.set("cardStatus","0");
		assistanceTypeList[7]=record8;
	}
	if($("temployee").checked){
		var record9=assistanceTypeDS.newRecord();
		fAssistanceType+="10,";
		record9.set("familyId",familyId);
		record9.set("assistanceType","10");
		record9.set("cardStatus","0");
		assistanceTypeList[8]=record9;
	}
	if($("CityStu").checked){
		var record11=assistanceTypeDS.newRecord();
		fAssistanceType+="25,";
		record11.set("familyId",familyId);
		record11.set("assistanceType","25");
		record11.set("cardStatus","0");
		assistanceTypeList[10]=record11;
	}
	if($("elsehelp").checked){
		var record12=assistanceTypeDS.newRecord();
		fAssistanceType+="11,";
		record12.set("familyId",familyId);
		record12.set("assistanceType","11");
		record12.set("cardStatus","0");
		assistanceTypeList[11]=record12;
	}
	if($("other").value!=""){
		var record10=assistanceTypeDS.newRecord();
		fAssistanceType+=$("other").value;
		record10.set("familyId",familyId);
		record10.set("assistanceType",$("other").value);
		record10.set("cardStatus","0");
		record10.set("modTime","");
		assistanceTypeList[9]=record10;
	}else if($("other").value==""){
			fAssistanceType+="";
		}
	if(fAssistanceType.length!=0){
		fAssistanceType=fAssistanceType.substring(0,fAssistanceType.length-1);
	}
	if(fAssistanceType.length==0){
		L5.Msg.alert("提交","救助类型必须选择一种以上！");
		return;
	}
 	var YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent();
 	YgjzJtxxCyxxDataSet2.set("familyId",familyId);
    YgjzJtxxRecord.set("familyId",familyId);
    YgjzJtxxRecord.set("curActivity","ACCEPT");
    YgjzJtxxRecord.set("checkFlag","1");
    YgjzJtxxRecord.set("assistanceType",fAssistanceType);
    
    var familyCardNo=YgjzJtxxRecord.get("familyCardNo");
    YgjzJtxxRecord.set("familyCardNo",familyCardNo);

    YgjzJtxxCyxxRecord.set("familyId",familyId);
    YgjzJtxxCyxxRecord.set("peopleId",peopleId);
    YgjzJtxxCyxxRecord.set("peoplePhotoTemp",photoc);
    YgjzJtxxCyxxRecord.set("relationshipType",relationshipType);
	//校验家庭信息
	if(!checkJtxx()){return;}
	//身份证校验
	if(!checkIDCard('familyCardNo',"身份证")){return;}
	//
	if(!agreementCheck($("agreement"))){		
		return;
	}
	//校验家庭成员
	if(!checkJtcy()) { return;}
	//自然灾害受灾时间非空校验
	var YgjzJtxxZrzhDataSet=L5.DatasetMgr.lookup("YgjzJtxxZrzhDataSet");
	var checkZrzhInfo = YgjzJtxxZrzhDataSet.isValidate();
	if(checkZrzhInfo!=true){
		L5.Msg.alert("提示",checkZrzhInfo);
		return false;
	}
	//残疾信息残疾类型非空校验
	var YgjzCyxxCjxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxCjxxDataSet");
	var checkCjxxInfo = YgjzCyxxCjxxDataSet.isValidate();
	if(checkCjxxInfo!=true){
		L5.Msg.alert("提示",checkCjxxInfo);
		return false;
	}
	//教育信息登记时间非空校验
	var YgjzCyxxJyxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxJyxxDataSet");
	var checkJyxxInfo = YgjzCyxxJyxxDataSet.isValidate();
	if(checkJyxxInfo!=true){
		L5.Msg.alert("提示",checkJyxxInfo);
		return false;
	}
	//患病信息患病时间非空校验
	var YgjzCyxxHbxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxHbxxDataSet");
	var checkHbxxInfo = YgjzCyxxHbxxDataSet.isValidate();
	if(checkHbxxInfo!=true){
		L5.Msg.alert("提示",checkHbxxInfo);
		return false;
	}
	//事故信息发生时间非空校验
	var YgjzCyxxSgxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxSgxxDataSet");
	var checkSgxxInfo = YgjzCyxxSgxxDataSet.isValidate();
	if(checkSgxxInfo!=true){
		L5.Msg.alert("提示",checkSgxxInfo);
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
	var YgjzJtxxCyxxRecords = YgjzJtxxCyxxDataSet2.getAllChangedRecords();
    command.setParameter("YgjzJtxxCyxxRecords", YgjzJtxxCyxxRecords);

	var YgjzJtxxZrzhRecords = YgjzJtxxZrzhDataSet.getAllChangedRecords();
	command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);

	var YgjzJzzsRecords = YgjzJzzsDataSet.getAllChangedRecords();
	command.setParameter("YgjzJzzsRecords", YgjzJzzsRecords);

	var YgjzCyxxCjxxRecords = YgjzCyxxCjxxDataSet.getAllChangedRecords();
	command.setParameter("YgjzCyxxCjxxRecords", YgjzCyxxCjxxRecords);

	var YgjzCyxxJyxxRecords = YgjzCyxxJyxxDataSet.getAllChangedRecords();
	command.setParameter("YgjzCyxxJyxxRecords", YgjzCyxxJyxxRecords);

	var YgjzCyxxHbxxRecords = YgjzCyxxHbxxDataSet.getAllChangedRecords();
	command.setParameter("YgjzCyxxHbxxRecords", YgjzCyxxHbxxRecords);

	var YgjzCyxxSgxxRecords = YgjzCyxxSgxxDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxSgxxRecords", YgjzCyxxSgxxRecords);

	command.setForm(L5.getDom("YgjzJtxxForm"));
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.setParameter("organType",organType);
	
	command.setParameter("assistanceTypeList",assistanceTypeList);
	command.setParameter("YgjzJtxxCyxxRecord", YgjzJtxxCyxxRecord);
	command.execute("save");
	if (!command.error) {
		YgjzJtxxZrzhDataSet.commitChanges();
		YgjzJzzsDataSet.commitChanges();
		YgjzJtxxCyxxDataSet2.commitChanges();
		YgjzCyxxCjxxDataSet.commitChanges();
		YgjzCyxxJyxxDataSet.commitChanges();
		YgjzCyxxHbxxDataSet.commitChanges();
		YgjzCyxxSgxxDataSet.commitChanges();
		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method", "addMember");
    	data.put("dataBean", familyId);
    	data.put("photoId",YgjzJtxxRecord.get("photoId"));
    	var url = 'jsp/ext/esurey/jtxx/ygjzjtxx_update.jsp';
		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 /**
 *  困难家庭登记
 *  事件处理：点击返回按钮
 *  返回困难家庭登记列表
 *
 */
function returnClick(){
	var url='jsp/ext/esurey/jtxx/ygjzjtxx_list.jsp';
	var text='阳光救助_家庭信息';
	L5.forward(url,text);
}

/***********************************困难家庭自然灾害开始************************************************************/
 /**
 *  困难家庭登记--自然灾害
 *  事件处理：点击 阳光救助_家庭信息_自然灾害 的增加按钮
 *
 */
function addYgjzJtxxZrzh() {
	YgjzJtxxZrzhDataSet.newRecord({
		familyId : document.forms[0].familyId.value

	});
}
 /**
 *  困难家庭登记--自然灾害
 *  事件处理：点击 阳光救助_家庭信息_自然灾害 的删除按钮
 *
 */
function removeYgjzJtxxZrzh() {
	var editGrid=L5.getCmp('YgjzJtxxZrzhEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxZrzhCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzJtxxZrzhDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
 /**
 *  困难家庭登记--自然灾害
 *  事件处理：点击 阳光救助_家庭信息_自然灾害 的取消按钮
 *
 */
function undoJtxxZrzh() {
	YgjzJtxxZrzhDataSet.rejectChanges();
}
/***********************************困难家庭自然灾害结束************************************************************/


/***********************************困难家庭救助指数开始************************************************************/
 /**
 *  困难家庭登记--救助指数
 *  事件处理：点击 阳光救助_家庭信息_救助指数 的增加按钮
 *
 */
function addYgjzJzzs() {
	YgjzJzzsDataSet.newRecord({
		familyId : document.forms[0].familyId.value
	});
}
 /**
 *  困难家庭登记--救助指数
 *  事件处理：点击 阳光救助_家庭信息_救助指数 的删除按钮
 *
 */
function removeYgjzJzzs() {
	var editGrid=L5.getCmp('YgjzJzzsEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJzzsCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzJzzsDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
 /**
 *  困难家庭登记--救助指数
 *  事件处理：点击 阳光救助_家庭信息_救助指数 的取消按钮
 *
 */
 function undoJtxxJzzs() {
	YgjzJzzsDataSet.rejectChanges();
}
/***********************************困难家庭救助指数结束************************************************************/

/***********************************困难家庭成员残疾信息开始************************************************************/
 /**
 *  困难家庭登记--残疾信息
 *  事件处理：点击 阳光救助_家庭信息_残疾信息 的增加按钮
 *
 */
function addYgjzCyxxCjxx() {
	var YgjzCyxxCjxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxCjxxDataSet");
	if(method=="INSERT"){
		YgjzCyxxCjxxDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent()
	    YgjzCyxxCjxxDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}

 /**
 *  困难家庭登记--残疾信息
 *  事件处理：点击 阳光救助_家庭信息_残疾信息 的删除按钮
 *
 */
function removeYgjzCyxxCjxx() {
	var editGrid=L5.getCmp('YgjzCyxxCjxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzCyxxCjxxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzCyxxCjxxDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
 /**
 *  困难家庭登记--残疾信息
 *  事件处理：点击 阳光救助_家庭信息_残疾信息 的取消按钮
 *
 */
function undoCyxxCjxx() {
	YgjzCyxxCjxxDataSet.rejectChanges();
}
/***********************************困难家庭成员残疾信息结束************************************************************/

/***********************************困难家庭成员教育信息开始************************************************************/
 /**
 *  困难家庭登记--教育信息
 *  事件处理：点击 阳光救助_家庭信息_教育信息 的增加按钮
 *
 */
function addYgjzCyxxJyxx() {
	var YgjzCyxxJyxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxJyxxDataSet");
	if(method=="INSERT"){
		YgjzCyxxJyxxDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent()
	    YgjzCyxxJyxxDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
 /**
 *  困难家庭登记--教育信息
 *  事件处理：点击 阳光救助_家庭信息_教育信息 的删除按钮
 *
 */
function removeYgjzCyxxJyxx() {
	var editGrid=L5.getCmp('YgjzCyxxJyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzCyxxJyxxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzCyxxJyxxDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
 /**
 *  困难家庭登记--教育信息
 *  事件处理：点击 阳光救助_家庭信息_教育信息 的取消按钮
 *
 */
function undoCyxxJyxx() {
	YgjzCyxxJyxxDataSet.rejectChanges();
}
/***********************************困难家庭成员教育信息结束************************************************************/

/***********************************困难家庭成员患病信息开始************************************************************/
/**
 *  困难家庭登记--患病信息
 *  事件处理：点击 阳光救助_家庭信息_患病信息 的增加按钮
 *
 */
function addYgjzCyxxHbxx() {
    var YgjzCyxxHbxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxHbxxDataSet");
	if(method=="INSERT"){
		YgjzCyxxHbxxDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent()
	    YgjzCyxxHbxxDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
/**
 *  困难家庭登记--患病信息
 *  事件处理：点击 阳光救助_家庭信息_患病信息 的删除按钮
 *
 */
function removeYgjzCyxxHbxx() {
	var editGrid=L5.getCmp('YgjzCyxxHbxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzCyxxHbxxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzCyxxHbxxDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
/**
 *  困难家庭登记--患病信息
 *  事件处理：点击 阳光救助_家庭信息_患病信息 的取消按钮
 *
 */
function undoCyxxHbxx() {
	YgjzCyxxHbxxDataSet.rejectChanges();
}
/***********************************困难家庭成员患病信息结束************************************************************/

/***********************************困难家庭成员事故信息开始************************************************************/
/**
 *  困难家庭登记--事故信息
 *  事件处理：点击 阳光救助_家庭信息_事故信息 的取消按钮
 *
 */
function addYgjzCyxxSgxx() {
  	var YgjzCyxxSgxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxSgxxDataSet");
	if(method=="INSERT"){
		YgjzCyxxSgxxDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent()
	    YgjzCyxxSgxxDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
/**
 *  困难家庭登记--事故信息
 *  事件处理：点击 阳光救助_家庭信息_事故信息 的删除按钮
 *
 */
function removeYgjzCyxxSgxx() {
	var editGrid=L5.getCmp('YgjzCyxxSgxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzCyxxSgxxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzCyxxSgxxDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
/**
 *  困难家庭登记--事故信息
 *  事件处理：点击 阳光救助_家庭信息_事故信息 的取消按钮
 *
 */
function undoCyxxSgxx() {
	YgjzCyxxSgxxDataSet.rejectChanges();
}

/***********************************困难家庭成员事故信息结束************************************************************/
 /***--------------------------------------困难家庭登记结束------------------------------------------******/

//更正环节
function correctClick(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	YgjzJtxxRecord.state = L5.model.Record.STATE_MODIFIED;

	var jzlxquery=document.forms[0].jzlxquery.value;
    YgjzJtxxRecord.set("assistanceType",jzlxquery);

 	var familyId=document.forms[0].familyId.value;
	 //校验家庭信息
    if(!checkJtxx()){return;}
	 var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");

		var YgjzJtxxZrzhRecords = YgjzJtxxZrzhDataSet.getAllChangedRecords();
		command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);

		var YgjzJzzsRecords = YgjzJzzsDataSet.getAllChangedRecords();
		command.setParameter("YgjzJzzsRecords", YgjzJzzsRecords);

	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.execute("correct");
	if (!command.error) {
		YgjzJtxxZrzhDataSet.commitChanges();
		YgjzJzzsDataSet.commitChanges();

		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method","INSERTA");
		data.put("familyId",familyId);
		var url='jsp/ext/esurey/jtxx/ygjzjtxx_correct_list.jsp';
		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//审核意见返回
function shReturnClick(){
	var url='jsp/ext/esurey/jtxx/ygjzjtxx_exam_list.jsp';
	var text='阳光救助_家庭信息';
	L5.forward(url,text);
}

function correct_onclick(){
	var url='jsp/ext/esurey/jtxx/ygjzjtxx_correct_list.jsp';
	var text='阳光救助_家庭信息';
	L5.forward(url,text);
}

function submit() {
	var records = YgjzJtxxCyxxDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCommand");
	command.setParameter("ygjzjtxxcyxxRecords", records);
	command.execute("save");
	if (!command.error) {
		YgjzJtxxCyxxDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxSzlxCommand");
	command.setParameter("ygjzjtxxszlxRecords", records);
	command.execute("save");
	if (!command.error) {
		YgjzJtxxSzlxDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var records = YgjzJtxxZrzhDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxZrzhCommand");
	command.setParameter("ygjzjtxxzrzhRecords", records);
	command.execute("save");
	if (!command.error) {
		YgjzJtxxZrzhDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var records = YgjzJzzsDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.jzzs.cmd.YgjzJzzsCommand");
	command.setParameter("ygjzjzzsRecords", records);
	command.execute("save");
	if (!command.error) {
		YgjzJzzsDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function undoJtxxSzlx() {
	YgjzJtxxSzlxDataSet.rejectChanges();
}

// 增加残疾信息
function addYgjzCyxxCjxx() {
    YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent()
    YgjzCyxxCjxxDataSet.newRecord({
        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
    });
}
var peopleIdx = 0;
// 增加家庭成员
function addYgjzJtxxCyxx() {

	YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
    var YgjzJtxxRecord = YgjzJtxxDataSet.getCurrent();

    var sPpeopleIdx = "" + peopleIdx;
    if(peopleIdx < 10){
    	sPpeopleIdx = "0" + sPpeopleIdx;
    }
    YgjzJtxxCyxxDataSet2 = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
    YgjzJtxxCyxxDataSet2.newRecord({
        peopleId: "0" + sPpeopleIdx + document.forms[0].peopleId.value.substring(3, 10),
        familyId: YgjzJtxxRecord.get("familyId")
    });

	YgjzCyxxCjxxDataSet.removeAll();
	YgjzCyxxJyxxDataSet.removeAll();
	YgjzCyxxHbxxDataSet.removeAll();
	YgjzCyxxSgxxDataSet.removeAll();

    var win=L5.getCmp("hello-win");
	win.show(this);
	peopleIdx = peopleIdx + 1;
}

// 修改成员信息
function modifyCyxx() {
	var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条要修改的记录!");
		return false;
	}
	var peopleId =selected[0].get("peopleId");

	var YgjzJtxxCyxxDataSet2 = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
	YgjzJtxxCyxxDataSet2.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzJtxxCyxxDataSet2.load();

    YgjzCyxxCjxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxCjxxDataSet");
	YgjzCyxxCjxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxCjxxDataSet.load();

    YgjzCyxxJyxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxJyxxDataSet");
	YgjzCyxxJyxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxJyxxDataSet.load();

    YgjzCyxxHbxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxHbxxDataSet");
	YgjzCyxxHbxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxHbxxDataSet.load();

    YgjzCyxxSgxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxSgxxDataSet");
	YgjzCyxxSgxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxSgxxDataSet.load();

	var win=L5.getCmp("hello-win");
	win.show(this);
}
//家庭成员明细
function jtxxCyxxDetail() {
    var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条要查看的记录!");
		return false;
	}
	var peopleId =selected[0].get("peopleId");

	var YgjzJtxxCyxxDataSet2 = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
	YgjzJtxxCyxxDataSet2.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzJtxxCyxxDataSet2.load();

    YgjzCyxxCjxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxCjxxDataSet");
	YgjzCyxxCjxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxCjxxDataSet.load();

    YgjzCyxxJyxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxJyxxDataSet");
	YgjzCyxxJyxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxJyxxDataSet.load();

    YgjzCyxxHbxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxHbxxDataSet");
	YgjzCyxxHbxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxHbxxDataSet.load();

    YgjzCyxxSgxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxSgxxDataSet");
	YgjzCyxxSgxxDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzCyxxSgxxDataSet.load();

	var win=L5.getCmp("hello-win");
	win.show(this);
}

//成员提交
function confirm() {
	if(saveJtcy()){
		var win=L5.getCmp("hello-win");
		win.hide(this);
	    YgjzJtxxCyxxDataSet.on("load", updatePeopleNum);
	    YgjzJtxxCyxxDataSet.load();
	}
}

// 关闭窗口
function hide() {
	var win=L5.getCmp("hello-win");
	win.hide(this);
}



//审核提交
function examSave(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();

 	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.execute("exam");
	if (!command.error) {

		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var url='jsp/ext/esurey/jtxx/ygjzjtxx_exam_list.jsp';
		var text="用户表";
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

/******************************关于家庭登记公共校验开始**************************************************/
 /**
 *  困难家庭登记
 *  事件处理：计算人均年收入、人均建筑面积
 *
 */
function updatePeopleNum(){
	if(YgjzJtxxCyxxDataSet.getCount() > 0){
    	var YgjzJtxxRecord = YgjzJtxxDataSet.getCurrent();
    	YgjzJtxxDataSet.set("peopleNum",YgjzJtxxCyxxDataSet.getCount());
    	YgjzJtxxDataSet.set("yearAverageIncome",decimalRound(YgjzJtxxRecord.get("yearIncome")/YgjzJtxxCyxxDataSet.getCount(),2) );
    	YgjzJtxxDataSet.set("monthIncome",decimalRound(YgjzJtxxRecord.get("yearIncome")/12,2) );
    	YgjzJtxxDataSet.set("monthAverageIncome",decimalRound(YgjzJtxxRecord.get("yearIncome")/(YgjzJtxxCyxxDataSet.getCount()*12),2) );
    	YgjzJtxxDataSet.set("buildAverageArea",decimalRound(YgjzJtxxRecord.get("buildArea")/YgjzJtxxCyxxDataSet.getCount(),2) );

    }else{
        YgjzJtxxDataSet.set("peopleNum",0);
        YgjzJtxxDataSet.set("yearAverageIncome",0);
    	YgjzJtxxDataSet.set("monthIncome",decimalRound(YgjzJtxxRecord.get("yearIncome")/12,2) );
    	YgjzJtxxDataSet.set("monthAverageIncome",0 );
    	YgjzJtxxDataSet.set("buildAverageArea",0);
    }
}
 /**
 *  困难家庭登记
 *  事件处理：小数截取
 *
 */
function decimalRound(num,decimalNum){
    var decimal2 = 1;
	while(decimalNum > 0){
		decimal2 = 10 * decimal2;
		decimalNum = decimalNum - 1;
	}
	return Math.round(num*decimal2)/decimal2;
}

 /**
 *  困难家庭登记
 *  事件处理：单独校验身份证
 *
 */
function  checkFamilyId(sfzh){
  var msg="";
  if(sfzh!=""){
	 var idmsg=checkIdcard(sfzh);
     msg=msg+"身份证号"+idmsg;
  }
  return true;
}
  /**
 *  困难家庭登记
 *  事件处理：根据身份证回填出生日期
 *
 */
function getBirthdayByIdCard(){
    var idCard = document.getElementById("idCard").value;
    var flag = idCard.indexOf("B");
    if(flag!=-1){
    	document.getElementById("birthday").value="";
	}else{
		document.getElementById("birthday").value=idCard.substring(6,14);
	}
 }
  /**
 *  困难家庭登记
 *  事件处理：固定电话校验
 *
 */
function __isFixedTelephone(s){
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,8}(-\d+)?$/g.test(s);
}
 /**
 *  困难家庭登记
 *  事件处理：手机校验
 *
 */
function __isMobileTelephone(s) {
	return /^1(3\d|(58|59|56|52|53|50|89|88|87|86|85|83|82|55|51|57|45|47))\d{8}$/g.test(s);
}
 /**
 *  困难家庭登记
 *  事件处理：固定电话
 *
 */
function checkDhhm(){
  var familyPhone = document.getElementById("familyPhone");
    if(trim(familyPhone.value)!=""&&!__isFixedTelephone(trim(familyPhone.value)))
  {
     L5.Msg.alert('提示',"请输入正确的电话号码！");
  	 familyPhone.value="";
     familyPhone.focus();
     return false;
  }
  return true;
}
 /**
 *  困难家庭登记
 *  事件处理：空格清空
 *
 */
function trim(str){
   var start = -1,
   end = str.length;
   while (str.charCodeAt(--end) < 33);
   while (str.charCodeAt(++start) < 33);
   return str.slice(start, end + 1);
}
 /**
 *  困难家庭登记
 *  事件处理：手机校验
 *
 */
 function checkSjhm(){
  var familyMobile = document.getElementById("familyMobile");
    if(trim(familyMobile.value)!=""&&!__isMobileTelephone(trim(familyMobile.value)))
  {
     L5.Msg.alert('提示',"请输入正确的手机号码！");
  	 familyMobile.value="";
     familyMobile.focus();
     return false;
  }
  return true;
}
 /**
 *  困难家庭登记
 *  事件处理：显示受助类型
 *
 */
function showJzlx(){
	var jzlxText = "";
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
    var jzlx = YgjzJtxxRecord.get("assistanceType");
    var jzlxArr = jzlx.split(",");
    for (var i = 0; i < jzlxArr.length; i++){
    	if(i > 0) jzlxText = jzlxText + ",";
        jzlxText = jzlxText + get_Jzlx_Value(jzlxArr[i]);
    }
    if(document.getElementById("assistanceType")){
		document.getElementById("assistanceType").value=jzlxText;
	}
	if(document.getElementById("jzlxquery")){
		document.getElementById("jzlxquery").value=jzlx;
	}
}
 /**
 *  困难家庭登记
 *  事件处理：受助类型字典表
 *
 */
function get_Jzlx_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmJzlxDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}
  /**
 *  困难家庭登记
 *  事件处理：审核意见字数统计
 *
 */
function gbcount(message,total,used,remain) {
	var max;
	max = total.value;
	if (message.value.length > max) {
		message.value = message.value.substring(0,max);
		used.value = max;
		remain.value = 0;
		L5.Msg.alert('提示',"审核意见不能超过 100 个字!");
	}
	else {
		used.value = message.value.length;
		remain.value = max - used.value;
	}
}
  /**
 *  困难家庭登记
 *  事件处理：救助类型双击清空
 *
 */
function jzlxDbClick() {
	document.getElementById("assistanceType").value="";
	document.getElementById("jzlxquery").value="";
}
  /**
 *  困难家庭登记
 *  事件处理：家庭信息户主身份证重复校验、
 *
 */
function checkIfRepeat(){
	var YgjzJtxxDataSet1=L5.DatasetMgr.lookup("YgjzJtxxDataSet1");
	//获取身份证号c
	var  idCard=document.getElementById('familyCardNo').value;
    if(idCard=='')return;
	var num=YgjzJtxxDataSet1.find("familyCardNo",idCard,0);
	if(num!=-1){
		L5.Msg.alert("提示","您输入的身份证已经存在！");
		document.getElementById('familyCardNo').value="";
	}else{
	}
}
  /**
 *  困难家庭登记
 *  事件处理：自动获取身份证号码
 *
 */
function getMaxCode(sfzh){

   var sfzh= document.getElementById(sfzh);

   var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }

   document.getElementById("familyCardNo").value=idCardExtend;
   	YgjzJtxxDataSet.set('familyCardNo',idCardExtend);

    YgjzJtxxCyxxDataSet2.set('idCard',idCardExtend);

	YgjzJtxxCyxxDataSet2.set('relationshipType','1');

}
 /**
 *  困难家庭登记
 *  事件处理：根据家庭信息回填户主姓名
 *
 */
function changeCyHzxm(){
	YgjzJtxxCyxxDataSet2.set('name',document.getElementById('familyName').value);
}
 /**
 *  困难户家庭登记
 *  事件处理：根据户主姓名回填户主关系
 *
 */
function changeCyRea(){
	YgjzJtxxCyxxDataSet2.set('relationshipType','1');
	YgjzJtxxCyxxDataSet2.set('idCard',idField);
}
 /**
 *  困难家庭登记
 *  事件处理：根据家庭信息回填户主的身份证、出生日期、户主关系
 *
 */
function changeCySfzh(){
	var idCard=document.getElementById('familyCardNo').value;
	YgjzJtxxCyxxDataSet2.set('idCard',idCard);
	YgjzJtxxCyxxDataSet2.set('birthday',idCard.substring(6,14));
	YgjzJtxxCyxxDataSet2.set('relationshipType','1');
}
 /**
 *  困难家庭登记
 *  事件处理：校验家庭信息
 *
 */
function checkJtxx(){
	
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	var value1=YgjzJtxxRecord.get("familyName");
	var value2=YgjzJtxxRecord.get("familyCardNo");
	var value3=YgjzJtxxRecord.get("town");
	var value4=YgjzJtxxRecord.get("yearIncome");
	var value5=YgjzJtxxRecord.get("houseStatus");
	var value6=YgjzJtxxRecord.get("assistanceType");
	var value7=YgjzJtxxRecord.get("houseQuality");
	var value8=YgjzJtxxRecord.get("houseStatus");
	
	if(value1==""){
		L5.Msg.alert("提示","户主姓名不能为空！");
		return;
		}
	if(value2==""){
		L5.Msg.alert("提示","户主身份证不能为空！");
		return;
		}
	if(value3==""){
		L5.Msg.alert("提示","地址_镇不能为空！");
		return;
		}
	if(value4==""){
		L5.Msg.alert("提示","家庭年总收入不能为空！");
		return;
		}
	if(value5==""){
		L5.Msg.alert("提示","房屋状况不能为空！");
		return;
		}
	if(value6==""){
		L5.Msg.alert("提示","救助类型不能为空！");
		return;
	}
	if(value7==""){
		L5.Msg.alert("提示","住房类型不能为空！");
		return;
	}
	if(value8==""){
		L5.Msg.alert("提示","房屋状况不能为空！");
		return;
	}
	
	else 
	return true;
}
 /**
 *  困难家庭登记
 *  事件处理：校验家庭成员信息
 *
 */
function checkJtcy(){
	var YgjzJtxxCyxxDataSet2 = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
	var YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet2.getCurrent();
	
	var value1=YgjzJtxxCyxxRecord.get("name");
	var value2=YgjzJtxxCyxxRecord.get("idCard");
	var value3=YgjzJtxxCyxxRecord.get("relationshipType");
	var value4=YgjzJtxxCyxxRecord.get("birthday");
	var value5=YgjzJtxxCyxxRecord.get("domicileType");
	var value6=YgjzJtxxCyxxRecord.get("sex");
	var value7=YgjzJtxxCyxxRecord.get("nation");
	var value8=YgjzJtxxCyxxRecord.get("marriageCode");
	var value9=YgjzJtxxCyxxRecord.get("safeguardType");
	var value10=YgjzJtxxCyxxRecord.get("employmentCode");
	var value11=YgjzJtxxCyxxRecord.get("politicalCode");
	
	if(value1==""){
		L5.Msg.alert("提示","姓名不能为空！");
		return;
		}
	if(value2==""){
		L5.Msg.alert("提示","身份证号不能为空！");
		return;
		}
	if(value3==""){
		L5.Msg.alert("提示","户主关系不能为空！");
		return;
		}
	if(value4==""){
		L5.Msg.alert("提示","出生日期不能为空！");
		return;
		}
	if(value5==""){
		L5.Msg.alert("提示","户籍性质不能为空！");
		return;
		}
	if(value6==""){
		L5.Msg.alert("提示","性别不能为空！");
		return;
		}
	if(value7==""){
		L5.Msg.alert("提示","民族不能为空！");
		return;
		}
	if(value8==""){
		L5.Msg.alert("提示","婚姻状况不能为空！");
		return;
		}
	if(value9==""){
		L5.Msg.alert("提示","医疗状况不能为空！");
		return;
		}
	if(value10==""){
		L5.Msg.alert("提示","职业状况不能为空！");
		return;
		}
	if(value11==""){
		L5.Msg.alert("提示","政治面貌不能为空！");
		return;
		}
	else 
	return true;
}
/******************************关于家庭登记公共校验结束**************************************************/
function insertClick(e){
	document.getElementById("familyId").readOnly=false;
	var dataset = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	//如果某必填数据为"",不再继续增加
	if(dataset.getCount()>0 && document.forms[0].familyId.value.trim()==""){
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount()-1);

	YgjzJtxxCyxxDataSet.baseParams["PEOPLE_ID@="]="-" ;
	YgjzJtxxCyxxDataSet.load();
	YgjzJtxxSzlxDataSet.baseParams["FAMILY_ID@="]="-" ;
	YgjzJtxxSzlxDataSet.load();
	YgjzJtxxZrzhDataSet.baseParams["FAMILY_ID@="]="-" ;
	YgjzJtxxZrzhDataSet.load();
	YgjzJzzsDataSet.baseParams["FAMILY_ID@="]="-" ;
	YgjzJzzsDataSet.load();

}
function deleteClick(e){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
			var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
			var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
			var  delIds=[];
			delIds[0]= YgjzJtxxRecord.get("familyId");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				YgjzJtxxDataSet.remove(YgjzJtxxRecord);
				if(!Evt_butNext_click()){
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示','删除成功！');
				var url='jsp/ext/esurey/jtxx/ygjzjtxx_list.jsp';
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
//低保家庭应届大学本科新生
function setCityStu(src){
	if(src.checked){
		src.value = '25';
	}else{
		src.value = '';
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
//城市“三无”对象
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
function setElsehelp(src){
	if(src.checked){
		src.value = '11';
	}else{
		src.value = '';
	}
}


//取两位小数
function changeTwoDecimal(num){
    var f_Num=parseFloat(num);
    f_Num=Math.round(f_Num*100)/100;
    var s_Num=f_Num.toString();
    var pos_Num=s_Num.indexOf('.');
    if(pos_Num<0){
    	pos_Num=s_Num.length;
		s_Num+='.';
    }
    while(s_Num.length <= pos_Num + 2){
		s_Num += '0';
     }
    return s_Num;
}
function changeTwo(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("totalExpense").value="";
				$("totalExpense").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("totalExpense").value=num;
	}
}

function agreementCheck(obj){
	if(obj.value!="" && isExceedMaxSize(obj.value,5*1024*1024)){		
		L5.Msg.alert("提示","委托协议文件大小超过5M,请重新选择！");
		return false;
	}
	return true;
}