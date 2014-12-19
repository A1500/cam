function init() {
	L5.getCmp("tabPanels").setActiveTab("0");
    var YgjzJtxxCyxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet");
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    var assistanceTypeDS = L5.DatasetMgr.lookup("assistanceTypeDS");
   // DmXzqhDataSetStreet.setParameter("filterSql", "leve='3' and substr(id,1,6)= '" + organArea.substring(0, 6) + "'");
   // DmXzqhDataSetStreet.load();
   var DmXzqhDataSetState = L5.DatasetMgr.lookup("DmXzqhDataSetState");
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    	DmXzqhDataSetState.setParameter("filterSql", "leve='2' and substr(id,1,4)= '" + organArea.substring(0, 4) + "'");
    	DmXzqhDataSetState.load();

    L5.QuickTips.init();

    if (method == null || method == "") {
        L5.Msg.alert('提示', "未知的页面命令!");
        back();
    } else if (method == "INSERT") {
        YgjzJtxxDataSet.newRecord({
            familyId: document.forms[0].familyId.value
        });
        return;
    } else if (method == "UPDATE" || method == "addMember") {
        if (method == "addMember") {
            L5.getCmp("tabPanels").setActiveTab(1);
        }
        YgjzJtxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxDataSet.on("load", getValue);
        YgjzJtxxDataSet.load();
        
        assistanceTypeDS.setParameter("FAMILY_ID@=",idField);
		assistanceTypeDS.on("load",queryAssistance);
		assistanceTypeDS.load();
        //图片显示设置开始
        var paths = document.location.pathname.split("/");
        var url1=paths[0]+'/'+paths[1]+"/download?table=baseinfo_family&column=agreement&pk=family_id&filename=agreement_name&family_id='"+idField+"'&"+(new Date()).toTimeString();
        L5.fly('download').dom.href = url1;

        //图片显示设置结束
        return;
    } else if (method == "EXAM") {
        YgjzJtxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxDataSet.on("load", getValue);
        YgjzJtxxDataSet.load();
        //救助加载
		assistanceTypeDS.setParameter("FAMILY_ID@=",idField);
		assistanceTypeDS.load();
		assistanceTypeDS.on("load",queryAssistance2);
        //图片显示设置开始
        var paths = document.location.pathname.split("/");
        var url1=paths[0]+'/'+paths[1]+"/download?table=baseinfo_family&column=agreement&pk=family_id&filename=agreement_name&family_id='"+idField+"'&"+(new Date()).toTimeString();
        L5.fly('download').dom.href = url1;
        //图片显示设置结束
        return;
    }else if(method=="STATE_EXAM"){
    	L5.getCmp("tabPanels").setActiveTab("3");
   		L5.getCmp("tabPanels").setActiveTab("2");
   		L5.getCmp("tabPanels").setActiveTab("1");
   		L5.getCmp("tabPanels").setActiveTab("0");
        YgjzJtxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxDataSet.on("load", getValue);
        YgjzJtxxDataSet.load();
        //救助加载
		assistanceTypeDS.setParameter("FAMILY_ID@=",idField);
		assistanceTypeDS.load();
		assistanceTypeDS.on("load",queryAssistance2);
        //图片显示设置开始
        var paths = document.location.pathname.split("/");
        var url1=paths[0]+'/'+paths[1]+"/download?table=baseinfo_family&column=agreement&pk=family_id&filename=agreement_name&family_id='"+idField+"'&"+(new Date()).toTimeString();
        L5.fly('download').dom.href = url1;
        //图片显示设置结束
        return;
    }
    function getValue() {
        //如果起先数据为空，则直接调用增加方法
        if (YgjzJtxxDataSet.getCount() == 0) {
            YgjzJtxxDataSet.newRecord();
            return;
        }
        YgjzJtxxCyxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxCyxxDataSet.load();

        YgjzJtxxZrzhDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxZrzhDataSet.load();

        YgjzJzzsDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJzzsDataSet.load();
    }
    function setPhotoInfo(){
     	var data = new L5.Map();
    	data.put("dataBean1",  YgjzJzzsDataSet.get("photoid"));
		var text="家庭成员";
		L5.forward(text,data);
	}

}
function selectStructure(){
	var DmFwjgDataSet = L5.DatasetMgr.lookup("DmFwjgDataSet");
	var houseStatus=document.getElementById("houseStatus").value;
	if(houseStatus==""){
		document.getElementById("fwzk").innerHTML="房屋结构：";
	}
	if(houseStatus=="1"){
		document.getElementById("fwzk").innerHTML="房屋结构：";
		DmFwjgDataSet.setParameter("filterSql", "code between 1 and 5");
		DmFwjgDataSet.load();
	}
	if(houseStatus=="2"){
		document.getElementById("fwzk").innerHTML="危险程度：";
		DmFwjgDataSet.setParameter("filterSql", "code='6' or code='7'");
		DmFwjgDataSet.load();

	}
	if(houseStatus=="3"){
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
    var street = document.getElementById("town").value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "leve='4' and substr(id,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}

function removeYgjzJtxxSzlx() {
	var editGrid=L5.getCmp('YgjzJtxxSzlxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxSzlxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				YgjzJtxxSzlxDataSet.remove(selected[i]);
			}

		}else{
			return false;
		}
	});
}
function addYgjzJtxxZrzh() {
	YgjzJtxxZrzhDataSet.newRecord({
		familyId :  document.forms[0].familyId.value

	});
}

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
function addYgjzJzzs() {
	YgjzJzzsDataSet.newRecord({
		familyId : document.forms[0].familyId.value
	});

}

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
 //保存家庭信息
function saveClick(){

	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
 	var familyId=document.forms[0].familyId.value;
    YgjzJtxxRecord.set("familyId",familyId);
    YgjzJtxxRecord.set("curActivity","ACCEPT");
    YgjzJtxxRecord.set("checkFlag","1");
    YgjzJtxxRecord.set("assistanceType",jzlxquery);//-----------------

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
	
	//身份证校验
	if(!checkIDCard('familyCardNo',"身份证")){return;}

	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
	var YgjzJtxxSzlxRecords = YgjzJtxxSzlxDataSet.getAllChangedRecords();
	var x = 0 ;
	for(i=0;i<YgjzJtxxSzlxRecords.length;i++){
		for(j=i+1;j<YgjzJtxxSzlxRecords.length;j++){
			if(YgjzJtxxSzlxRecords[i].get("assistanceType") == YgjzJtxxSzlxRecords[j].get("assistanceType")){
					alert('不能选择重复的救助类型!');
					return false;
			}
		}
		if("01"==(YgjzJtxxSzlxRecords[i].get("assistanceType").toString())){
			++x;
		}
		if('02'==(YgjzJtxxSzlxRecords[i].get("assistanceType").toString())){
			++x;
		}
		if(x==2){
			alert("在救助类型中，城市低保和农村低保不能同时选择！");
			return false;
		}
	}
	command.setParameter("YgjzJtxxSzlxRecords", YgjzJtxxSzlxRecords);

	var YgjzJtxxZrzhRecords = YgjzJtxxZrzhDataSet.getAllChangedRecords();
	command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);

	var YgjzJzzsRecords = YgjzJzzsDataSet.getAllChangedRecords();
	command.setParameter("YgjzJzzsRecords", YgjzJzzsRecords);
     command.setForm(L5.getDom("YgjzJtxxForm"));
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.setParameter("organType", organType);
	command.execute("save");
	if (!command.error) {
		YgjzJtxxSzlxDataSet.commitChanges();
		YgjzJtxxZrzhDataSet.commitChanges();
		YgjzJzzsDataSet.commitChanges();
		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method", "addMember");
    	data.put("dataBean", familyId);
    	var url = 'jsp/ext/esurey/jtxx/ygjzjtxx_update.jsp';

		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//修改登记环节
function modifyClick(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	var fAssistanceType="";
	var assistanceTypeList=new Array();
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	if($("cityMi").checked){
		var record1=assistanceTypeDS.newRecord();
		fAssistanceType+="01,";
		record1.set("familyId",idField);
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
		record2.set("familyId",idField);
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
		record3.set("familyId",idField);
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
		record4.set("familyId",idField);
		record4.set("assistanceType","05");
		record4.set("cardStatus","0");
		assistanceTypeList[3]=record4;
	}
	if($("handicapped").checked){
		var record5=assistanceTypeDS.newRecord();
		fAssistanceType+="06,";
		record5.set("familyId",idField);
		record5.set("assistanceType","06");
		record5.set("cardStatus","0");
		assistanceTypeList[4]=record5;
	}
	if($("pmother").checked){
		var record6=assistanceTypeDS.newRecord();
		fAssistanceType+="07,";
		record6.set("familyId",idField);
		record6.set("assistanceType","07");
		record6.set("cardStatus","0");
		assistanceTypeList[5]=record6;
	}
	if($("kstudent").checked){
		var record7=assistanceTypeDS.newRecord();
		fAssistanceType+="08,";
		record7.set("familyId",idField);
		record7.set("assistanceType","08");
		record7.set("cardStatus","0");
		assistanceTypeList[6]=record7;
	}
	if($("threeNothing").checked){
		var record8=assistanceTypeDS.newRecord();
		fAssistanceType+="09,";
		record8.set("familyId",idField);
		record8.set("assistanceType","09");
		record8.set("cardStatus","0");
		assistanceTypeList[7]=record8;
	}
	if($("temployee").checked){
		var record9=assistanceTypeDS.newRecord();
		fAssistanceType+="10,";
		record9.set("familyId",idField);
		record9.set("assistanceType","10");
		record9.set("cardStatus","0");
		assistanceTypeList[8]=record9;
	}
	if($("elsehelp").checked){
		var record12=assistanceTypeDS.newRecord();
		fAssistanceType+="11,";
		record12.set("familyId",idField);
		record12.set("assistanceType","11");
		record12.set("cardStatus","0");
		assistanceTypeList[11]=record12;
	}
	if($("CityStu").checked){
		var record11=assistanceTypeDS.newRecord();
		fAssistanceType+="25,";
		record11.set("familyId",idField);
		record11.set("assistanceType","25");
		record11.set("cardStatus","0");
		assistanceTypeList[10]=record11;
	}
	if($("other").value!=""){
		var record10=assistanceTypeDS.newRecord();
		fAssistanceType+=$("other").value;
		record10.set("familyId",idField);
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
		L5.Msg.alert("提示","救助类型必须填写！");
		return;
	}
	YgjzJtxxRecord.state = L5.model.Record.STATE_MODIFIED;
 	var familyId=document.forms[0].familyId.value;
 	
 	var img=document.getElementById("photoId").value;
	var photoc=document.getElementById("photoTemp").value;
	var street=document.getElementById("town").value;
	var county=document.getElementById("county").value;
	YgjzJtxxRecord.set('photoId',img);
    YgjzJtxxRecord.set('photoTemp',photoc);
    YgjzJtxxRecord.set('county',county);
    YgjzJtxxRecord.set('town',street);

    YgjzJtxxRecord.set("assistanceType",fAssistanceType);
    
    var familyCardNo=YgjzJtxxRecord.get("familyCardNo");
    YgjzJtxxRecord.set("familyCardNo",familyCardNo);

    YgjzJtxxRecord.set("curActivity","ACCEPT");

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

	var YgjzJtxxZrzhRecords = YgjzJtxxZrzhDataSet.getAllChangedRecords();
	command.setForm(L5.getDom("YgjzJtxxForm"));
    command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);
    command.setParameter("assistanceTypeList",assistanceTypeList);
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.setParameter("opType", "update");
	command.execute("save");
	if (!command.error) {
		YgjzJtxxZrzhDataSet.commitChanges();
		YgjzJzzsDataSet.commitChanges();

		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method","INSERTA");
		data.put("familyId",familyId);
		var url='jsp/ext/esurey/jtxx/ygjzjtxx_list.jsp';
		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//查询页面修改登记环节
function modifyClick2(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	var fAssistanceType="";
	var assistanceTypeList=new Array();
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	if($("cityMi").checked){
		var record1=assistanceTypeDS.newRecord();
		fAssistanceType+="01,";
		record1.set("familyId",idField);
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
		record2.set("familyId",idField);
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
		record3.set("familyId",idField);
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
		record4.set("familyId",idField);
		record4.set("assistanceType","05");
		record4.set("cardStatus","0");
		assistanceTypeList[3]=record4;
	}
	if($("handicapped").checked){
		var record5=assistanceTypeDS.newRecord();
		fAssistanceType+="06,";
		record5.set("familyId",idField);
		record5.set("assistanceType","06");
		record5.set("cardStatus","0");
		assistanceTypeList[4]=record5;
	}
	if($("pmother").checked){
		var record6=assistanceTypeDS.newRecord();
		fAssistanceType+="07,";
		record6.set("familyId",idField);
		record6.set("assistanceType","07");
		record6.set("cardStatus","0");
		assistanceTypeList[5]=record6;
	}
	if($("kstudent").checked){
		var record7=assistanceTypeDS.newRecord();
		fAssistanceType+="08,";
		record7.set("familyId",idField);
		record7.set("assistanceType","08");
		record7.set("cardStatus","0");
		assistanceTypeList[6]=record7;
	}
	if($("threeNothing").checked){
		var record8=assistanceTypeDS.newRecord();
		fAssistanceType+="09,";
		record8.set("familyId",idField);
		record8.set("assistanceType","09");
		record8.set("cardStatus","0");
		assistanceTypeList[7]=record8;
	}
	if($("temployee").checked){
		var record9=assistanceTypeDS.newRecord();
		fAssistanceType+="10,";
		record9.set("familyId",idField);
		record9.set("assistanceType","10");
		record9.set("cardStatus","0");
		assistanceTypeList[8]=record9;
	}
	if($("CityStu").checked){
		var record11=assistanceTypeDS.newRecord();
		fAssistanceType+="25,";
		record11.set("familyId",idField);
		record11.set("assistanceType","25");
		record11.set("cardStatus","0");
		assistanceTypeList[10]=record11;
	}
	if($("elsehelp").checked){
		var record12=assistanceTypeDS.newRecord();
		fAssistanceType+="11,";
		record12.set("familyId",idField);
		record12.set("assistanceType","11");
		record12.set("cardStatus","0");
		assistanceTypeList[11]=record12;
	}
	if($("other").value!=""){
		var record10=assistanceTypeDS.newRecord();
		fAssistanceType+=$("other").value;
		record10.set("familyId",idField);
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
		L5.Msg.alert("提示","救助类型必须填写！");
		return;
	}
	YgjzJtxxRecord.state = L5.model.Record.STATE_MODIFIED;
 	var familyId=document.forms[0].familyId.value;
 	
 	var img=document.getElementById("photoId").value;
	var photoc=document.getElementById("photoTemp").value;
	var county=document.getElementById("county").value;
	YgjzJtxxRecord.set('photoId',img);
    YgjzJtxxRecord.set('photoTemp',photoc);
    YgjzJtxxRecord.set('county',county);

    YgjzJtxxRecord.set("assistanceType",fAssistanceType);
    
    var familyCardNo=YgjzJtxxRecord.get("familyCardNo");
    YgjzJtxxRecord.set("familyCardNo",familyCardNo);

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

	var YgjzJtxxZrzhRecords = YgjzJtxxZrzhDataSet.getAllChangedRecords();
	command.setForm(L5.getDom("YgjzJtxxForm"));
    command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);
    command.setParameter("assistanceTypeList",assistanceTypeList);
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.setParameter("opType", "change");
	command.execute("save");
	if (!command.error) {
		YgjzJtxxZrzhDataSet.commitChanges();
		YgjzJzzsDataSet.commitChanges();

		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method","INSERTA");
		data.put("familyId",familyId);
		var url='jsp/ext/esurey/jtxx/ygjzjtxx_state_list.jsp';
		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//更正环节
function correctClick(){
	var img=document.getElementById("photoTemp").value;

	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	var fAssistanceType="";
	var assistanceTypeList=new Array();
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	if($("cityMi").checked){
		var record1=assistanceTypeDS.newRecord();
		fAssistanceType+="01,";
		record1.set("familyId",idField);
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
		record2.set("familyId",idField);
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
		record3.set("familyId",idField);
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
		record4.set("familyId",idField);
		record4.set("assistanceType","05");
		record4.set("cardStatus","0");
		assistanceTypeList[3]=record4;
	}
	if($("handicapped").checked){
		var record5=assistanceTypeDS.newRecord();
		fAssistanceType+="06,";
		record5.set("familyId",idField);
		record5.set("assistanceType","06");
		record5.set("cardStatus","0");
		assistanceTypeList[4]=record5;
	}
	if($("pmother").checked){
		var record6=assistanceTypeDS.newRecord();
		fAssistanceType+="07,";
		record6.set("familyId",idField);
		record6.set("assistanceType","07");
		record6.set("cardStatus","0");
		assistanceTypeList[5]=record6;
	}
	if($("kstudent").checked){
		var record7=assistanceTypeDS.newRecord();
		fAssistanceType+="08,";
		record7.set("familyId",idField);
		record7.set("assistanceType","08");
		record7.set("cardStatus","0");
		assistanceTypeList[6]=record7;
	}
	if($("threeNothing").checked){
		var record8=assistanceTypeDS.newRecord();
		fAssistanceType+="09,";
		record8.set("familyId",idField);
		record8.set("assistanceType","09");
		record8.set("cardStatus","0");
		assistanceTypeList[7]=record8;
	}
	if($("temployee").checked){
		var record9=assistanceTypeDS.newRecord();
		fAssistanceType+="10,";
		record9.set("familyId",idField);
		record9.set("assistanceType","10");
		record9.set("cardStatus","0");
		assistanceTypeList[8]=record9;
	}
	if($("CityStu").checked){
		var record11=assistanceTypeDS.newRecord();
		fAssistanceType+="25,";
		record11.set("familyId",idField);
		record11.set("assistanceType","25");
		record11.set("cardStatus","0");
		assistanceTypeList[10]=record11;
	}
	if($("elsehelp").checked){
		var record12=assistanceTypeDS.newRecord();
		fAssistanceType+="11,";
		record12.set("familyId",idField);
		record12.set("assistanceType","11");
		record12.set("cardStatus","0");
		assistanceTypeList[11]=record12;
	}
	if($("other").value!=""){
		var record10=assistanceTypeDS.newRecord();
		fAssistanceType+="11,";
		record10.set("familyId",idField);
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
		L5.Msg.alert("提示","救助类型必须填写！");
		return;
	}
	YgjzJtxxRecord.state = L5.model.Record.STATE_MODIFIED;
	YgjzJtxxRecord.set('photoTemp',img);
    YgjzJtxxRecord.set("assistanceType",fAssistanceType);
    
    var familyCardNo=YgjzJtxxRecord.get("familyCardNo");
    YgjzJtxxRecord.set("familyCardNo",familyCardNo);
 	var familyId=document.forms[0].familyId.value;

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
		command.setParameter("assistanceTypeList",assistanceTypeList);
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

function returnClick(){
	var url='jsp/ext/esurey/jtxx/ygjzjtxx_list.jsp';
	var text='阳光救助_家庭信息';
	L5.forward(url,text);
}

function returnClick2(){
	var url='jsp/ext/esurey/jtxx/ygjzjtxx_state_list.jsp';
	var text='阳光救助_家庭信息';
	L5.forward(url,text);
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
	var records = YgjzJtxxSzlxDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
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
function undoJtxxZrzh() {
	YgjzJtxxZrzhDataSet.rejectChanges();
}
function undoJtxxJzzs() {
	YgjzJzzsDataSet.rejectChanges();
}

//残疾信息添加
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
//教育信息添加
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
//患病信息添加
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
//事故信息添加
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
//患病信息删除
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
//事故信息删除
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

function undoCyxxCjxx() {
	YgjzCyxxCjxxDataSet.rejectChanges();
}
function undoCyxxJyxx() {
	YgjzCyxxJyxxDataSet.rejectChanges();
}
function undoCyxxHbxx() {
	YgjzCyxxHbxxDataSet.rejectChanges();
}
function undoCyxxSgxx() {
	YgjzCyxxSgxxDataSet.rejectChanges();
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
	var photoid =selected[0].get("photoId");

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

	win.on("activate",function(){
	    document.getElementById("photocImg").src="/cam/downloadPhoto?primaryKey="+photoid;
	});
	win.on("close",function(){
	    document.getElementById("photocImg").src="";
	});
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
	var photoid =selected[0].get("photoId");

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
	win.on("activate",function(){
	    document.getElementById("photocImg").src="/cam/downloadPhoto?primaryKey="+photoid;
	});
	win.on("close",function(){
	    document.getElementById("photocImg").src="";
	});
	win.show(this);
}
function removeYgjzJtxxCyxx() {
	var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length < 1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.setParameter("familyId", document.getElementsByName("familyId")[0].value);
				command.execute("delete");
				YgjzJtxxCyxxDataSet.remove(selected[i]);
			}
			updatePeopleNum();
		}else{
			return false;
		}
	});
}
// 确认保存
function confirm() {
	if(saveJtcy()){
		var win=L5.getCmp("hello-win");
		win.hide(this);
	    YgjzJtxxCyxxDataSet.on("load", updatePeopleNum);
	    YgjzJtxxCyxxDataSet.load();
	}
}
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
    	YgjzJtxxDataSet.set("monthIncome",0);
    	YgjzJtxxDataSet.set("monthAverageIncome",0 );
    	YgjzJtxxDataSet.set("buildAverageArea",0);
    }
}
// 小数截取
function decimalRound(num,decimalNum){

    var decimal2 = 1;
	while(decimalNum > 0){
		decimal2 = 10 * decimal2;
		decimalNum = decimalNum - 1;
	}
	return Math.round(num*decimal2)/decimal2;
}
// 关闭窗口
function hide() {
	var win=L5.getCmp("hello-win");
	win.hide(this);
}

// 保存成员信息
function saveJtcy(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	YgjzJtxxDataSet.set("familyId",idField);
	var YgjzJtxxCyxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
	var YgjzJtxxCyxxRecord=YgjzJtxxCyxxDataSet.getCurrent();
	var photoc=document.getElementById("peoplePhotoTemp").value;
	
	var idCard=YgjzJtxxCyxxRecord.get("idCard");
	var birthday=document.getElementById("birthday").value;
    YgjzJtxxCyxxRecord.set("idCard",idCard);
    YgjzJtxxCyxxRecord.set("birthday",birthday);

    YgjzJtxxCyxxRecord.set("peoplePhotoTemp",photoc);
    
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
	//家庭成员残疾类型校验
	var YgjzCyxxCjxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxCjxxDataSet");
    var checkCjxxInfor=YgjzCyxxCjxxDataSet.isValidate();
	if(checkCjxxInfor != true){
		/*

		更改combox提示中文 根据header进行定位
		if(checkCjxxInfor.indexOf("残疾类型")!=-1){
			checkCjxxInfor=checkCjxxInfor.replace("cjlxdm","残疾类型");
		}
		*/
		L5.Msg.alert("提示",checkCjxxInfor);
		return false;
	}
	//家庭成员教育登记时间校验
	var YgjzCyxxJyxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxJyxxDataSet");
    var checkJyxxInfor=YgjzCyxxJyxxDataSet.isValidate();
	if(checkJyxxInfor != true){
		L5.Msg.alert("提示",checkJyxxInfor);
		return false;
	}
	//家庭成员患病时间校验
	var YgjzCyxxHbxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxHbxxDataSet");
    var checkHbxxInfor=YgjzCyxxHbxxDataSet.isValidate();
	if(checkHbxxInfor != true){
		L5.Msg.alert("提示",checkHbxxInfor);
		return false;
	}
	//家庭成员事故发生时间校验
	var YgjzCyxxSgxxDataSet = L5.DatasetMgr.lookup("YgjzCyxxSgxxDataSet");
    var checkSgxxInfor=YgjzCyxxSgxxDataSet.isValidate();
	if(checkSgxxInfor != true){
		L5.Msg.alert("提示",checkSgxxInfor);
		return false;
	}

	if(!checkIDCard('idCard',"身份证")){
	return;}

	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCommand");
	command.setParameter("YgjzJtxxCyxxRecord", YgjzJtxxCyxxRecord);

    var YgjzCyxxCjxxRecords = YgjzCyxxCjxxDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxCjxxRecords", YgjzCyxxCjxxRecords);

    var YgjzCyxxJyxxRecords = YgjzCyxxJyxxDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxJyxxRecords", YgjzCyxxJyxxRecords);

    var YgjzCyxxHbxxRecords = YgjzCyxxHbxxDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxHbxxRecords", YgjzCyxxHbxxRecords);

    var YgjzCyxxSgxxRecords = YgjzCyxxSgxxDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxSgxxRecords", YgjzCyxxSgxxRecords);
	command.execute("saveJtcy");
	if (!command.error) {
		YgjzCyxxCjxxDataSet.commitChanges();
		YgjzJtxxCyxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		return false;
	}
	return true;
}
//单独校验身份证
function  checkFamilyId(sfzh){
  var msg="";
  if(sfzh!=""){
	 var idmsg=checkIdcard(sfzh);
     msg=msg+"身份证号"+idmsg;

  }
  return true;
}
 //根据身份证回填出生日期
function getBirthdayByIdCard(){
    var idCard = document.getElementById("idCard").value;
	document.getElementById("birthday").value= idCard.substring(6,14);
 }
 //固定电话校验
function __isFixedTelephone(s){
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,8}(-\d+)?$/g.test(s);
}
 //手机校验
function __isMobileTelephone(s) {
	return /^1(3\d|(58|59|56|52|53|50|89|88|87|86|85|83|82|55|51|57|45|47))\d{8}$/g.test(s);
}
//固定电话
function checkDhhm(){
  var dhhm = document.getElementById("familyPhone");
    if(trim(dhhm.value)!=""&&!__isFixedTelephone(trim(dhhm.value)))
  {
     alert("请输入正确的电话号码！");
  	 dhhm.value="";
     dhhm.focus();
     return false;
  }
  return true;
}
//窗口固定电话
function checkWinDhhm(){
  var dhhm = document.getElementById("winDhhm");
    if(trim(dhhm.value)!=""&&!__isFixedTelephone(trim(dhhm.value)))
  {
     alert("请输入正确的电话号码！");
  	 dhhm.value="";
     dhhm.focus();
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

//手机
 function checkSjhm(){
  var sjhm = document.getElementById("familyMobile");
    if(trim(sjhm.value)!=""&&!__isMobileTelephone(trim(sjhm.value)))
  {
     alert("请输入正确的手机号码！");
  	 sjhm.value="";
     sjhm.focus();
     return false;
  }
  return true;
}
//窗口手机
 function checkWinSjhm(){
  var sjhm = document.getElementById("winSjhm");
    if(trim(sjhm.value)!=""&&!__isMobileTelephone(trim(sjhm.value)))
  {
     alert("请输入正确的手机号码！");
  	 sjhm.value="";
     sjhm.focus();
     return false;
  }
  return true;
}
//help帮助
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
		multiItem_search.addTextField("DIC_ASSITANCE_TYPE_EXT.CODE","编号","code");
		multiItem_search.addTextField("DIC_ASSITANCE_TYPE_EXT.NAME","名称","name");
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

//审核意见字数统计
function gbcount(message,total,used,remain) {
	var max;
	max = total.value;
	if (message.value.length > max) {
		message.value = message.value.substring(0,max);
		used.value = max;
		remain.value = 0;
		alert("审核意见不能超过 100 个字!");
	}
	else {
		used.value = message.value.length;
		remain.value = max - used.value;
	}
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
//身份证重复校验
function checkIfRepeat(){
	var YgjzJtxxDataSet1=L5.DatasetMgr.lookup("YgjzJtxxDataSet1");
	//获取身份证号
	var  idCard=document.getElementById('familyCardNo').value;
    if(idCard=='')return;

	var num=YgjzJtxxDataSet1.find("familyCardNo",idCard,0);

	if(num!=-1){
		L5.Msg.alert("提示","您输入的身份证已经存在！");
		document.getElementById('familyCardNo').value="";
	}else{

	}

}
//家庭成员身份证号重复校验
function checkCysfzhIfRepeat(){
	var YgjzJtxxCyxxDataSet3=L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet3");

	//获取身份证号
	var  idCard=document.getElementById('jtcysfzh').value;
    if(idCard=='')return;
   	YgjzJtxxCyxxDataSet3.baseParams["ID_CARD@="] = idCard;
	YgjzJtxxCyxxDataSet3.load();
	//alert(YgjzJtxxCyxxDataSet3.())
	//var num=YgjzJtxxCyxxDataSet3.find("sfzh",idCard,0);

	//if(num!=-1){
		//L5.Msg.alert("提示","您输入的身份证已经存在！");
		//document.getElementById('sfzh').value="";
	//}else{

	//}
}

//自动获取身份证号码
function getMaxCode(sfzh){
   var sfzh= document.getElementById(sfzh);
   var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }
   document.getElementById("familyCardNo").value=idCardExtend;
   YgjzJtxxDataSet.set("familyCardNo",idCardExtend);

}

//自动获取家庭成员身份证号码
function getMaxCode2(idCard){
   var jtcysfzh= document.getElementById(idCard);
   var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }
   document.getElementById("idCard").value=idCardExtend;
   YgjzJtxxCyxxDataSet2.set("idCard",idCardExtend);
}
//家庭成员户主关系重复提示
function checkHzgx(){
	var YgjzJtxxCyxxDataSet=L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet");

	var YgjzJtxxCyxxRecords = YgjzJtxxCyxxDataSet.getAllRecords();
	var  hzgx=document.getElementById('relationshipType').value;
	//alert("hzgx:"+hzgx);
	//alert("length:"+YgjzJtxxCyxxRecords.length)
    for(var i=0;i<YgjzJtxxCyxxRecords.length;i++){
    	if(YgjzJtxxCyxxRecords[i].get("relationshipType") == hzgx){
					L5.Msg.alert("提示","户主已经存在!");
					//DmHzgxDataSet.reload();
					//document.getElementById('hzgx').options[0].value);
					return false;
    	}
    	else{
    	return true;
    	}
    }
  }
  //家庭成员户主关系重复校验
  function chkecHzgx1(){
  	var YgjzJtxxCyxxDataSet=L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet");
	var YgjzJtxxCyxxRecords = YgjzJtxxCyxxDataSet.getAllRecords();
	var  hzgx=document.getElementById('relationshipType').value;
	var j=0;
    for(var i=0;i<YgjzJtxxCyxxRecords.length;i++){
    	if(YgjzJtxxCyxxRecords[i].get("relationshipType") == hzgx){
					j++;}
					}
					//L5.Msg.alert("提示","户主已经存在!");
					//DmHzgxDataSet.reload();
					//document.getElementById('hzgx').options[0].value);
				if(j>0){
					return false;
					}
    			else{
    				return true;
    			}
  }
  
    //---------------------------救助-----------
function queryAssistance(assistanceTypeDS){
	var OtherDataset=L5.DatasetMgr.lookup("OtherDataset");
	var other=document.getElementById("other").value; 
	
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
		}else if(assistanceType=="02"){
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
		}else if(assistanceType=="03"){
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

		}else if(assistanceType=="25"){
			$("CityStu").checked=true;
		}else if(assistanceType=="05"){
			$("giveMi").checked=true;
		}else if(assistanceType=="06"){
			$("handicapped").checked=true;
		}else if(assistanceType=="07"){
			$("pmother").checked=true;
		}else if(assistanceType=="08"){
			$("kstudent").checked=true;
		}else if(assistanceType=="09"){
			$("threeNothing").checked=true;
		}else if(assistanceType=="10"){
			$("temployee").checked=true;
		}else if(assistanceType=="11"){
			$("elsehelp").checked=true;
		}else if(assistanceType=="12"){
			$("other").value="12";
		}else if(assistanceType=="13"){
			$("other").value="13";
		}else if(assistanceType=="14"){
			$("other").value="14";
		}else if(assistanceType=="15"){
			$("other").value="15";
		}else if(assistanceType=="16"){
			$("other").value="16";
		}else if(assistanceType=="17"){
			$("other").value="17";
		}else if(assistanceType=="18"){
			$("other").value="18";
		}else if(assistanceType=="19"){
			$("other").value="19";
		}else if(assistanceType=="20"){
			$("other").value="20";
		}else if(assistanceType=="21"){
			$("other").value="21";
		}else if(assistanceType=="22"){
			$("other").value="22";
		}else if(assistanceType=="23"){
			$("other").value="23";
		}else if(assistanceType=="24"){
			$("other").value="24";
		}else if(assistanceType=="26"){
			$("other").value="26";
		}else if(assistanceType=="27"){
			$("other").value="27";
		}else if(assistanceType=="28"){
			$("other").value="28";
		}else if(assistanceType=="29"){
			$("other").value="29";
		}else if(assistanceType=="30"){
			$("other").value="30";
		}else if(assistanceType=="31"){
			$("other").value="31";
		}else if(assistanceType=="32"){
			$("other").value="32";
		}else if(assistanceType=="33"){
			$("other").value="33";
		}else if(assistanceType=="34"){
			$("other").value="34";
		}else if(assistanceType=="35"){
			$("other").value="35";
		}
	}
	
}

function queryAssistance2(assistanceTypeDS){
	var records=assistanceTypeDS.getAllRecords();
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		var assistanceType=records[i].get("assistanceType");
		if(assistanceType=="01"){
			$("cityMi").checked=true;
			$("isDetail").style.display="block";
			$("isCity").style.display="block";
			$("cardNo").innerHTML=records[i].get("cardNo");
			$("signOrgName").innerHTML=records[i].get("signOrgName");
			$("signDate").innerHTML=records[i].get("signDate");
			$("cardValidateBegin").innerHTML=records[i].get("cardValidateBegin");
			$("cardValidateEnd").innerHTML=records[i].get("cardValidateEnd");
			$("assistanceBegin").innerHTML=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").innerHTML=records[i].get("accountName");
			$("accountCode").innerHTML=records[i].get("accountCode");
			$("assistanceMon").innerHTML=records[i].get("assistanceMon");
			$("assistanceClassMon").innerHTML=records[i].get("assistanceClassMon");
		}else if(assistanceType=="02"){
			$("countryMi").checked=true;
			$("isDetail").style.display="block";
			$("isCountry").style.display="block";
			$("cardNo").innerHTML=records[i].get("cardNo");
			$("signOrgName").innerHTML=records[i].get("signOrgName");
			$("signDate").innerHTML=records[i].get("signDate");
			$("cardValidateBegin").innerHTML=records[i].get("cardValidateBegin");
			$("cardValidateEnd").innerHTML=records[i].get("cardValidateEnd");
			$("assistanceBegin").innerHTML=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").innerHTML=records[i].get("accountName");
			$("accountCode").innerHTML=records[i].get("accountCode");
			$("nassistanceMon").innerHTML=records[i].get("assistanceMon");
			$("nassistanceClassMon").innerHTML=records[i].get("assistanceClassMon");
		}else if(assistanceType=="03"){
			$("fiveMi").checked=true;
			$("isDetail").style.display="block";
			$("isFive").style.display="block";
			$("cardNo").innerHTML=records[i].get("cardNo");
			$("signOrgName").innerHTML=records[i].get("signOrgName");
			$("signDate").innerHTML=records[i].get("signDate");
			$("cardValidateBegin").innerHTML=records[i].get("cardValidateBegin");
			$("cardValidateEnd").innerHTML=records[i].get("cardValidateEnd");
			$("assistanceBegin").innerHTML=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").innerHTML=records[i].get("accountName");
			$("accountCode").innerHTML=records[i].get("accountCode");
			$("supportWay").value=records[i].get("supportWay");
			$("cassistanceMon").innerHTML=records[i].get("assistanceMon");

		}else if(assistanceType=="25"){
			$("CityStu").checked=true;
		}else if(assistanceType=="05"){
			$("giveMi").checked=true;
		}else if(assistanceType=="06"){
			$("handicapped").checked=true;
		}else if(assistanceType=="07"){
			$("pmother").checked=true;
		}else if(assistanceType=="08"){
			$("kstudent").checked=true;
		}else if(assistanceType=="09"){
			$("threeNothing").checked=true;
		}else if(assistanceType=="10"){
			$("temployee").checked=true;
		}else if(assistanceType=="11"){
			$("elsehelp").checked=true;
		}else if(assistanceType=="12"){
			$("other").value="12";
		}else if(assistanceType=="13"){
			$("other").value="13";
		}else if(assistanceType=="14"){
			$("other").value="14";
		}else if(assistanceType=="15"){
			$("other").value="15";
		}else if(assistanceType=="16"){
			$("other").value="16";
		}else if(assistanceType=="17"){
			$("other").value="17";
		}else if(assistanceType=="18"){
			$("other").value="18";
		}else if(assistanceType=="19"){
			$("other").value="19";
		}else if(assistanceType=="20"){
			$("other").value="20";
		}else if(assistanceType=="21"){
			$("other").value="21";
		}else if(assistanceType=="22"){
			$("other").value="22";
		}else if(assistanceType=="23"){
			$("other").value="23";
		}else if(assistanceType=="24"){
			$("other").value="24";
		}else if(assistanceType=="26"){
			$("other").value="26";
		}else if(assistanceType=="27"){
			$("other").value="27";
		}else if(assistanceType=="28"){
			$("other").value="28";
		}else if(assistanceType=="29"){
			$("other").value="29";
		}else if(assistanceType=="30"){
			$("other").value="30";
		}else if(assistanceType=="31"){
			$("other").value="31";
		}else if(assistanceType=="32"){
			$("other").value="32";
		}else if(assistanceType=="33"){
			$("other").value="33";
		}else if(assistanceType=="34"){
			$("other").value="34";
		}else if(assistanceType=="35"){
			$("other").value="35";
		}
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
    /*
    if(hzgx=='')return;
	YgjzJtxxCyxxDataSet3.baseParams["HZGXDM@="]=hzgx;
	YgjzJtxxCyxxDataSet3.load();
	var num =YgjzJtxxCyxxDataSet3.getCount();
	if(num!=0){
		L5.Msg.alert("提示","您输入的身份证已经存在！");
		document.getElementById('sfzh').value="";
	}else{
	}

	var num=YgjzJtxxCyxxDataSet3.find("hzgxdm",hzgx,0);
	if(num!=-1){
		L5.Msg.alert("提示","户主已经存在！");
		document.getElementById('hzgx').value="";
	}else{

	}*/

//家庭户主身份证号重复校验
/*
function changeHzSfzh('jtcysfzh'){
	var YgjzJtxxDataSet1=L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	//获取身份证号
	//var  idCard=document.getElementById('jtcysfzh').value;

    if(jtcysfzh=='')return;

	var num=YgjzJtxxDataSet1.find("sfzh",idCard,0);

	if(num!=-1){
		L5.Msg.alert("提示","您输入的身份证已经存在！");
		document.getElementById('jtcysfzh').value="";
	}else{

	}

}
*/

function agreementCheck(obj){
	if(obj.value!="" && isExceedMaxSize(obj.value,5*1024*1024)){		
		L5.Msg.alert("提示","委托协议文件大小超过5M,请重新选择！");
		return false;
	}
	return true;
}