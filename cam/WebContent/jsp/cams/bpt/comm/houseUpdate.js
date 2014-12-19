function init(){
	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	BaseinfoFamilyDataSet.setParameter("FAMILY_ID@=",familyId);
	BaseinfoFamilyDataSet.load();
	var HouseSubsidyInfoDataset = L5.DatasetMgr.lookup("HouseSubsidyInfoDataset");
	HouseSubsidyInfoDataset.setParameter("FAMILY_ID@=",familyId);
	HouseSubsidyInfoDataset.load();
	BaseinfoFamilyDataSet.on("load",function check_HouseStruct(){
		var buildingStructure = BaseinfoFamilyDataSet.getAllRecords();
		if(buildingStructure[0].get("houseStructureType")==''){
			HouseStructureDataset.setParameter("includeCode", "03,04,05,02,01");
			HouseStructureDataset.load();
		}
	})
	L5.QuickTips.init();
}

//判断是否可以填写
function setEditable(){
	var  value = L5.DatasetMgr.lookup("HouseSubsidyInfoDataset").getCurrent().get("subsidyType");
	var flag = true ;
	if(value=="3"){
		flag = false;
	}
	return flag;
}

//关闭
function func_Close(){
	window.close();
}

//选择住房状况
function selHouseStatus(){
	var HouseQualityDataset = L5.DatasetMgr.lookup("HouseQualityDataset");
	var houseStatus=document.getElementById("houseStatus").value; 
	if(houseStatus=="1"){
		HouseQualityDataset.setParameter("filterSql", "CODE BETWEEN '01' and '05'");
		HouseQualityDataset.load();
		document.getElementById("houseStatus2").disabled=""; 
	}
	if(houseStatus=="3"){
		HouseQualityDataset.setParameter("filterSql", "CODE BETWEEN '06' and '09'");
		HouseQualityDataset.load();
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.set("houseStatus2","");
		document.getElementById("houseStatus2").selectedIndex=0;
		document.getElementById("houseStatus2").disabled="disabled"; 
	}
}

//选择房屋结构
function selStructureType(){
	var HouseStructureDataset = L5.DatasetMgr.lookup("HouseStructureDataset");
	var houseStructureType=document.getElementById("houseStructureType").value; 
	if(houseStructureType=="1"){
		HouseStructureDataset.setParameter("includeCode", "04,05");
		HouseStructureDataset.load();
	}
	if(houseStructureType=="2"){
		HouseStructureDataset.setParameter("includeCode", "03,02,01");
		HouseStructureDataset.load();
	}
}

//自动计算人均建筑面积
function assignAverageArea(){
		var peopleNum = document.getElementById("peopleNum").value;
		var buildArea = document.getElementById("buildArea").value;
		if(peopleNum==''||peopleNum==null||peopleNum==0)
		{
			alert("家庭人口数不能为空或零！");
			return ;
		}
		var buildArea = document.getElementById("buildArea").value;		
		document.getElementById("buildAverageArea").value = decimal(buildArea/peopleNum,2);
		BaseinfoFamilyDataSet.set("buildAverageArea",document.getElementById("buildAverageArea").value);
		BaseinfoFamilyDataSet.set("peopleNum",peopleNum);
		BaseinfoFamilyDataSet.set("buildArea",buildArea);
}

//num表示要四舍五入的数,v表示要保留的小数位数。
function decimal(num,v)
{
    var vv = Math.pow(10,v);
    return Math.round(num*vv)/vv;
}

//新增建购房补助信息
function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	HouseSubsidyInfoDataset.newRecord();
}

//删除建购房补助信息
function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("houseSubsidyId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptHouseSubsidyInfoCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	HouseSubsidyInfoDataset.remove(selected[i]);
				}
				HouseSubsidyInfoDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}

//保存建购房补助信息
function save() {
	//验证房屋信息

	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	var BaseinfoFamilyRecord=BaseinfoFamilyDataSet.getCurrent();
	var isValidate = BaseinfoFamilyDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	if(BaseinfoFamilyRecord.get("peopleNum")==''){
		L5.Msg.alert('提示',"家庭人口数不能为空！");
		return false;
	}
	//建购房补助信息验证
	
	var records = HouseSubsidyInfoDataset.getAllChangedRecords();
	var isValidate = HouseSubsidyInfoDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var buildingDate = document.getElementById("buildingDate").value;
	if(buildingDate!=''&&!validateDateFormat(buildingDate)){
		L5.Msg.alert("提示","住房建筑时间格式不正确");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptHouseSubsidyInfoCommand");
	command.setParameter("records", records);
	command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);
	command.execute("save");
	if (!command.error) {
		HouseSubsidyInfoDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//取消建购房补助信息
function reset() {
	HouseSubsidyInfoDataset.rejectChanges();
}