function init() {
	//添加editGridPanel双击事件
	var editGridPanel=L5.getCmp('editGridPanel');
	editGridPanel.on("rowdblclick",function(){
		var s = L5.getCmp('addNewCompulsoryGrantObject');
		s.show();
	});
	var ds =L5.DatasetMgr.lookup("ds");	
	ds.setParameter("registerId",registerId);
	ds.load();
};
function save(){
	var records = ds.getAllRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand");
	command.setParameter("records", records);
	
	command.execute("updateNonCompul");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//新增发放对象
function addGrantObject(){
	var url = "peopleIdTypeSelect.jsp";
	var width = screen.width-100;
    var height = screen.height-140;
    var peopleId;
    var objectType;
 	var revalue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		peopleId = list[0];
		objectType = list[1];
	}else{
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand");
	command.setParameter("peopleId", peopleId);
	command.setParameter("registerId", registerId);
	command.setParameter("objectType",objectType);
	command.execute("addNewCompulsoryGrantObject");
	var rd = command.getReturn("rd");
	var flag = command.getReturn("flag");
	if (!command.error) {
		if(flag==1){
			L5.Msg.alert('提示', "新增发放对象已在列表中！");
			return;
		}
	} else {
		L5.Msg.alert('提示', "新增发放对象失败！" + command.error);
	}
	var ds = L5.DatasetMgr.lookup("ds");
	ds.newRecord(rd);
	var editGridPanel=L5.getCmp('editGridPanel');
	//editGridPanel.getSelectionModel().selectLastRow();
	var s = L5.getCmp('addNewCompulsoryGrantObject');
	s.show();
}

//校验是否是浮点型数字
function checkIfFload(element){
	if(element.value==''){
		return;
	}else{
		if(!isFloat(element.value)){
		L5.Msg.alert('提示','所填内容必须是数字');
		ds.getCurrent().set(element.id,"");
		document.getElementById(element.id).value = "";
		return false;
		}
	}
}

//计算总金额
function computeSumMon(){
	var grantMonths = _$("grantMonths")==''?"0.00":_$("grantMonths");//发放月数
	var grantMonSta = _$("grantMonSta")==''?"0.00":_$("grantMonSta");//发放标准
	var oldLonelyMon = _$("oldLonelyMon")==''?"0.00":_$("oldLonelyMon");//孤老增发
	var otherSubsidyOne = _$("otherSubsidyOne")==''?"0.00":_$("otherSubsidyOne");//其他补助1
	var otherSubsidyTwo = _$("otherSubsidyTwo")==''?"0.00":_$("otherSubsidyTwo");//其他补助2
	var otherSubsidyThree = _$("otherSubsidyThree")==''?"0.00":_$("otherSubsidyThree");//其他补助3
	var otherSubsidyFour = _$("otherSubsidyFour")==''?"0.00":_$("otherSubsidyFour");//其他补助4
	var otherSubsidyFive = _$("otherSubsidyFive")==''?"0.00":_$("otherSubsidyFive");//其他补助5
	
	var grantMonSum = Math.ceil((parseFloat(grantMonSta)*grantMonths+parseFloat(oldLonelyMon)
	+parseFloat(otherSubsidyOne)+parseFloat(otherSubsidyTwo)+parseFloat(otherSubsidyThree)+parseFloat(otherSubsidyFour)+parseFloat(otherSubsidyFive))*100)/100;
	//计算总额
	ds.getCurrent().set("grantMonSum",grantMonSum);
}

//删除发放对象
function deleteGrantObject(){
	var list="";
	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","选择要删除的记录1");
		return false;
	}else{
		//下面是一个提示框，如果用户点击是，那么就执行删除，否则不执行。
		L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
			if(state=="yes"){
				var  delIds=[];
				for(var i=0;i<selected.length;i++){
					delIds[i]=selected[i].get("regDetailId");
				}
				var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand");
				command.setParameter("delIds", delIds);
				command.execute("delete");
				if (!command.error) {
					for(var i=0;i<selected.length;i++){
				    	ds.remove(selected[i]);
					}
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}else{
				return false;
			}
		});
	}
}

function fun_close(){
	window.close();
}