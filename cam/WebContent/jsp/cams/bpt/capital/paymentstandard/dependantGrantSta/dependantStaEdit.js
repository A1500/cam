function init() {
	var ds = L5.DatasetMgr.lookup("ds");	
	var editGridPanel = L5.getCmp("editGridPanel");
	editGridPanel.on("validateedit",function(e){
		if(organType!=11&&e.field=="provinceStandard"){
			alert("省级标准不能修改");
			return false;
		}
	});
	editGridPanel.on("afteredit",function(){
		var record = ds.getCurrent();
		var subTotal = parseFloat((record.get("increaseMechanism")=='')?'0':record.get("increaseMechanism"))+
					   parseFloat((record.get("grainOilMon")=='')?'0':record.get("grainOilMon"))+
					   parseFloat((record.get("oldLonelyMon")=='')?'0':record.get("oldLonelyMon"))+
					   parseFloat((record.get("otherSubsidyOne")=='')?'0':record.get("otherSubsidyOne"))+
					   parseFloat((record.get("otherSubsidyTwo")=='')?'0':record.get("otherSubsidyTwo"))+
					   parseFloat((record.get("otherSubsidyThree")=='')?'0':record.get("otherSubsidyThree"))+
					   parseFloat((record.get("otherSubsidyFour")=='')?'0':record.get("otherSubsidyFour"))+
					   parseFloat((record.get("otherSubsidyFive")=='')?'0':record.get("otherSubsidyFive"));
		record.set("subTotal",subTotal);
		var yearTotal = parseFloat((record.get("provinceStandard")=='')?'0':record.get("provinceStandard"))+parseFloat(subTotal);
		record.set("yearTotal",yearTotal);
	});
	if(method=="insert"){
		ds.setParameter("STANDARDS_COUNTIES",'370000000000');
		ds.setParameter("TYPE","21");
		ds.setParameter("method","insert");
		ds.load();
		ds.on("load",function(){
			if(ds.getCount()>0){
				var records = ds.getAllRecords();
				var subTotal = [];
				var yearTotal = [];
				for(var j=0;j<records.length;j++){
					records[j].state = 1;
					subTotal[j] =  parseFloat((records[j].get("increaseMechanism")=='')?'0':records[j].get("increaseMechanism"))+
								   parseFloat((records[j].get("grainOilMon")=='')?'0':records[j].get("grainOilMon"))+
								   parseFloat((records[j].get("oldLonelyMon")=='')?'0':records[j].get("oldLonelyMon"))+
								   parseFloat((records[j].get("otherSubsidyOne")=='')?'0':records[j].get("otherSubsidyOne"))+
								   parseFloat((records[j].get("otherSubsidyTwo")=='')?'0':records[j].get("otherSubsidyTwo"))+
								   parseFloat((records[j].get("otherSubsidyThree")=='')?'0':records[j].get("otherSubsidyThree"))+
								   parseFloat((records[j].get("otherSubsidyFour")=='')?'0':records[j].get("otherSubsidyFour"))+
								   parseFloat((records[j].get("otherSubsidyFive")=='')?'0':records[j].get("otherSubsidyFive"));
					records[j].set("subTotal",subTotal[j]);
					yearTotal[j] = parseFloat((records[j].get("provinceStandard")=='')?'0':records[j].get("provinceStandard"))+parseFloat(subTotal[j]);
					records[j].set("yearTotal",yearTotal[j]);
				}
			}
		});
	}else if(method=="update"){
		ds.setParameter("STANDARDS_COUNTIES",organCode);
		ds.setParameter("START_DATE",startDate);
		ds.setParameter("TYPE","21");
		ds.load();
		ds.on("load",function(){
			document.getElementById("startDate").disabled = true;
			document.getElementById("dateSelect").disabled = true;
			if(ds.getCount()>0){ //加载时计算出小计和年合计
				var records = ds.getAllRecords();
				var subTotal = [];
				var yearTotal = [];
				for(var j=0;j<records.length;j++){
					subTotal[j] =  parseFloat((records[j].get("increaseMechanism")=='')?'0':records[j].get("increaseMechanism"))+
								   parseFloat((records[j].get("grainOilMon")=='')?'0':records[j].get("grainOilMon"))+
								   parseFloat((records[j].get("oldLonelyMon")=='')?'0':records[j].get("oldLonelyMon"))+
								   parseFloat((records[j].get("otherSubsidyOne")=='')?'0':records[j].get("otherSubsidyOne"))+
								   parseFloat((records[j].get("otherSubsidyTwo")=='')?'0':records[j].get("otherSubsidyTwo"))+
								   parseFloat((records[j].get("otherSubsidyThree")=='')?'0':records[j].get("otherSubsidyThree"))+
								   parseFloat((records[j].get("otherSubsidyFour")=='')?'0':records[j].get("otherSubsidyFour"))+
								   parseFloat((records[j].get("otherSubsidyFive")=='')?'0':records[j].get("otherSubsidyFive"));
					records[j].set("subTotal",subTotal[j]);
					yearTotal[j] = parseFloat((records[j].get("provinceStandard")=='')?'0':records[j].get("provinceStandard"))+parseFloat(subTotal[j]);
					records[j].set("yearTotal",yearTotal[j]);
				}
				var startDate = records[0].get("startDate");
				document.getElementById("startDate").value = startDate;
			}
		});
	}
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ds.newRecord();	
}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			if(method=="update"){
				var  delIds=[];
				for(var i=0;i<selected.length;i++){
					delIds[i]=selected[i].get("id");
				}
				var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalstaCommand");
				command.setParameter("delIds", delIds);
				command.execute("delete");
				if (!command.error) {
					for(var i=0;i<selected.length;i++){
				    	ds.remove(selected[i]);
					}
					ds.commitChanges();
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}else if(method=="insert"){
				for(var i=0;i<selected.length;i++){
				    ds.remove(selected[i]);
				}
			}
		}else{
			return false;
		}
	});
}

function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var startDate = document.getElementById("startDate").value;
    if(startDate==""){
       L5.Msg.alert('提示','生效日期不能为空!');
	   return false;
    }
    if(startDate!=''&&!validateDateFormat(startDate)){
		L5.Msg.alert("提示","生效日期格式不正确！");
		return false;
    }
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}

	//校验生效日期是否有效
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalstaCommand");
	var newDate =new Date(document.getElementById("startDate").value.replace("-","/"));
    command.setParameter("type", "21");
    command.setParameter("organCode", organCode);
    if(method=="insert"){
    	command.execute("getMaxDate");
	    if(command.getReturn("maxDate")!=undefined){
	       var oldMax =new Date(command.getReturn("maxDate").replace("-","/"));
	       if(newDate<=oldMax){
	          L5.Msg.alert('提示','生效日期必须大于'+oldMax+' !');
		      return false;
	       }
	    }
    }
    
    for(var i=0;i<records.length;i++){
    	if(records[i].get("objectType")==''){
			L5.Msg.alert('提示',"优抚对象类别不能为空！");
			return false;
		}
		if(records[i].get("provinceStandard")==''){
			L5.Msg.alert('提示',"省标准不能为空！");
			return false;
		}
	}
    
    command.setParameter("startDate", startDate);
	command.setParameter("records", records);
	command.setParameter("method", method);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
		method = "update";
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset() {
	window.history.go(-1);
}
