function init() {
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "UPDATE") {
		//添加editGridPanel双击事件
		var editGridPanel=L5.getCmp('editGridPanel');
		editGridPanel.on("rowdblclick",function(){
			var s = L5.getCmp('addNewDisabiGrantObject');
			s.show();
		});
		ds.setParameter("REGISTER_ID", registerId);
		ds.load();
	} else if (method == "DETAIL") {
		ds.baseParams["REGISTER_ID@="] = registerId;
		ds.load();
	}

	else {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	}
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}


function save() {
	var records = ds.getAllRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if (isValidate != true) {
		L5.Msg.alert('提示', "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
	command.setParameter("records", records);
	command.execute("saveData");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示', "数据保存成功!");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

//新增发放对象
function addGrantObject(){
	var url = "peopleSelect.jsp";
	var width = screen.width-100;
    var height = screen.height-140;
    var peopleId;
 	var revalue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		peopleId = list[0];
	}else{
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
	command.setParameter("peopleId", peopleId);
	command.setParameter("registerId", registerId);
	command.execute("addDisabiGrantObject");
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
	var s = L5.getCmp('addNewDisabiGrantObject');
	s.show();
}

//校验是否是浮点型数字
function checkIfFload(element){
	if(element.value!=''){
		if(!isFloat(element.value)){
		L5.Msg.alert('提示','所填内容必须是数字');
		ds.getCurrent().set(element.id,"");
		document.getElementById(element.id).value = "";
		return false;
		}
	}
}

//计算发放金额（包括计算月份*标准）
function computeMon(){
	var grantStaMon = _$("grantStaMon");
	var grantMonths = _$("grantMonths");
	if(grantStaMon==0||grantMonths==0||grantStaMon==''||grantMonths==''){
		ds.getCurrent().set("grantMon","0.00");
		return false;
	}else{
		var grantMon = (parseFloat(grantStaMon))*(parseFloat(grantMonths));
		grantMon = Math.ceil((parseFloat(grantMon))*100)/100;
		ds.getCurrent().set("grantMon",grantMon);
	}
	computeSumMon();
}

//计算总金额
function computeSumMon(){
	//发放金额
	var grantMon = $("grantMon").innerHTML==''?"0.00":$("grantMon").innerHTML;
	//护理费
	var nursingMon = _$("nursingMon")==''?"0.00":_$("nursingMon");
	//地方补贴小计
	var increaseMechanism = _$("increaseMechanism")==''?"0.00":_$("increaseMechanism");//自然增长机制
	var grainOilMon = _$("grainOilMon")==''?"0.00":_$("grainOilMon");//粮油补贴
	var coalSubsidyMon = _$("coalSubsidyMon")==''?"0.00":_$("coalSubsidyMon");//煤补补贴
	var antiJapaneseMon = _$("antiJapaneseMon")==''?"0.00":_$("antiJapaneseMon");//抗日增发
	var oldLonelyMon = _$("oldLonelyMon")==''?"0.00":_$("oldLonelyMon");//孤老增发
	var supplyMon = _$("supplyMon")==''?"0.00":_$("supplyMon");//补发金额
	var otherSubsidyOne = _$("otherSubsidyOne")==''?"0.00":_$("otherSubsidyOne");//其他补助1
	var otherSubsidyTwo = _$("otherSubsidyTwo")==''?"0.00":_$("otherSubsidyTwo");//其他补助2
	var otherSubsidyThree = _$("otherSubsidyThree")==''?"0.00":_$("otherSubsidyThree");//其他补助3
	var otherSubsidyFour = _$("otherSubsidyFour")==''?"0.00":_$("otherSubsidyFour");//其他补助4
	var otherSubsidyFive = _$("otherSubsidyFive")==''?"0.00":_$("otherSubsidyFive");//其他补助5
	
	var subTotal = Math.ceil((parseFloat(increaseMechanism)+parseFloat(grainOilMon)+parseFloat(coalSubsidyMon)+parseFloat(antiJapaneseMon)+parseFloat(oldLonelyMon)
	+parseFloat(supplyMon)+parseFloat(otherSubsidyOne)+parseFloat(otherSubsidyTwo)+parseFloat(otherSubsidyThree)+parseFloat(otherSubsidyFour)+parseFloat(otherSubsidyFive))*100)/100;
	 ds.getCurrent().set("subTotal",subTotal);
	//计算总额
	var grantMonSum = parseFloat(grantMon)+parseFloat(nursingMon)+parseFloat(subTotal);
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
				var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
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

function back() {
	window.close();
}
