function init(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	cdcBaseinfoPeopleDataSet.on("load",function(){
		var record=cdcBaseinfoPeopleDataSet.getCurrent();
		setDisabilityFlag(record.get("disabilityFlag"));
		setBptType(record.get("bptType"));
	});
	if(method=="insert"){
		document.getElementById("save").style.display = 'none';
		cdcBaseinfoPeopleDataSet.newRecord({"relationshipType":"01","domicileCode":organCode,"domicileName":organName});
	}else{
		document.getElementById("saveAdd").style.display = 'none';
		cdcBaseinfoPeopleDataSet.setParameter("PEOPLE_ID@=",databeanId);
		cdcBaseinfoPeopleDataSet.load();
	}
}
function save(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	var valid=cdcBaseinfoPeopleDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=cdcBaseinfoPeopleDataSet.getCurrent();
	if(record.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空");
		return false;
	}
	record.set("bptType",getBptType());
	record.set("disabilityFlag",getDisabilityFlag());
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			window.returnValue="OK";
			window.close();
		});
	}else{
		L5.Msg.alert("提示","保存出错！",function(){
			window.returnValue="Failed";
			window.close();
		});
	}
}
function saveAndAdd(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	var valid=cdcBaseinfoPeopleDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=cdcBaseinfoPeopleDataSet.getCurrent();
	if(record.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空");
		return false;
	}
	if(record.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空");
		return false;
	}
	
	if(record.get("nation")==""){
		L5.Msg.alert("提示","民族不能为空");
		return false;
	}
	record.set("bptType",getBptType());
	record.set("disabilityFlag",getDisabilityFlag());
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var data=new L5.Map();
			data.put("method","update");
			data.put("databeanId",command.getReturn("familyId"));
			var url="jsp/ext/cdc/manage/basePeople/cdcBaseinfoFamilyUpdateEdit.jsp";
			L5.forward(url,'',data);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	history.go(-1);
}
function sexChenges(){
	var sex = document.getElementById("sex").value;
	if(sex=='1'){
		document.getElementById("womanFlag").value = '0';
		document.getElementById("womanFlag").disabled = true;
	}else{
		document.getElementById("womanFlag").value = '';
		document.getElementById("womanFlag").disabled = false;
	}
}

function getBptType(){
	var bptType = "";
	var checked;
	for(var i = 1;i<=9;i++){
		checked = document.getElementById("yf"+i);
		if(checked.checked==true){
			bptType+="1";
		}else{
			bptType+="0";	
		}
	}
	return bptType;
}

function setBptType(bptType){
	for(var i = 0;i<bptType.length;i++){
		if(bptType.charAt(i)=='1'){
			document.getElementById("yf"+(i+1)).checked = true;
		}
	}
}
function peasantFlagChenges(){
	var flag = document.getElementById("peasantFlag").value;
	if(flag == '0'){
		document.getElementById("childrenEducation").value ='';
		document.getElementById("childrenEducation").disabled = true;
	}else{
		document.getElementById("childrenEducation").disabled = false;
	}
}
function getDisabilityFlag(){
	var disabilityFlag = "";
	var checked;
	for(var i = 1;i<=6;i++){
		checked = document.getElementById("cj"+i);
		if(checked.checked==true){
			disabilityFlag+="1";
		}else{
			disabilityFlag+="0";	
		}
	}
	return disabilityFlag;
}

function setDisabilityFlag(disabilityFlag){
	for(var i = 0;i<disabilityFlag.length;i++){
		if(disabilityFlag.charAt(i)=='1'){
			document.getElementById("cj"+(i+1)).checked = true;
		}
	}
}
