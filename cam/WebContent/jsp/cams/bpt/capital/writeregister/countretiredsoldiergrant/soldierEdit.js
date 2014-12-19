function init() {
	if(method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}else if (method=="UPDATE"){
		//添加editGridPanel双击事件
		var editGridPanel=L5.getCmp('editGridPanel');
		editGridPanel.on("rowdblclick",function(){
			var s = L5.getCmp('addNewDemobilizedIllGrantObject');
			s.show();
		});
	    dsLife.setParameter("REGISTER_ID",registerId);
		dsLife.load();
	}else if (method=="DETAIL"){
	    dsLife.baseParams["REGISTER_ID@="]=registerId;	
		dsLife.load();
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	if(document.getElementById("shouldTimeStart").value==''){
	   L5.Msg.alert('提示',"应发日期(起)不能为空!");
	   return false;
	}
	if( document.getElementById("shouldTimeEnd").value==''){
	   L5.Msg.alert('提示',"应发日期(止)不能为空!");
	   return false;
	}
	if(document.getElementById("shouldTimeStart").value>document.getElementById("shouldTimeEnd").value){
	  L5.Msg.alert('提示',"应发日期(止)不能早于应发日期(发)!");
	   return false;
	}		
	dsLife.setParameter("organId",'1');	
	dsLife.setParameter("start",getParam("shouldTimeStart"));	
	dsLife.setParameter("end",getParam("shouldTimeEnd"));		
	dsLife.load();
}

function del(){
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
				delIds[i]=selected[i].get("regDetailId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	dsLife.remove(selected[i]);
				}
				dsLife.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}


function save(){
   var records = dsLife.getAllRecords();
   	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = dsLife.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
	command.setParameter("records", records);
    command.execute("saveData");
	if (!command.error) {
		dsLife.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//新增发放对象
function addGrantObject(){
	var url = "soldierList.jsp";
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
	command.execute("addDemobilizedIllGrantObject");
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
	var dsLife = L5.DatasetMgr.lookup("dsLife");
	dsLife.newRecord(rd);
	var editGridPanel=L5.getCmp('editGridPanel');
	//editGridPanel.getSelectionModel().selectLastRow();
	var s = L5.getCmp('addNewDemobilizedIllGrantObject');
	s.show();
}

//校验是否是浮点型数字
function checkIfFload(element){
	if(element.value!=''){
		if(!isFloat(element.value)){
			L5.Msg.alert('提示','所填内容必须是数字');
			dsLife.getCurrent().set(element.id,"");
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
		dsLife.getCurrent().set("grantMon","0.00");
		return false;
	}else{
		var grantMon = (parseFloat(grantStaMon))*(parseFloat(grantMonths));
		grantMon = Math.ceil((parseFloat(grantMon))*100)/100;
		dsLife.getCurrent().set("grantMon",grantMon);
	}
	computeSumMon();
}

//计算总金额
function computeSumMon(){
	var grantMonths = _$("grantMonths");
	//发放金额
	var grantMon = $("grantMon").innerHTML==''?"0.00":$("grantMon").innerHTML;
	//地方补贴
	var otherSubsidyOne = _$("otherSubsidyOne")==''?"0.00":_$("otherSubsidyOne");//地方补贴
	
	//计算总额
	var grantMonSum = parseFloat(grantMon)+parseFloat(otherSubsidyOne);
	dsLife.getCurrent().set("grantMonSum",grantMonSum);
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
				    	dsLife.remove(selected[i]);
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