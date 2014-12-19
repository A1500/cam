var composedPortrait;
var domicileType;
function init() {
	var CompulsoryGrantDataSet = L5.DatasetMgr.lookup("CompulsoryGrantDataSet");
	CompulsoryGrantDataSet.setParameter("regDetailId",regDetailId);
	CompulsoryGrantDataSet.setParameter("peopleId",peopleId);
	CompulsoryGrantDataSet.load();
	CompulsoryGrantDataSet.on("load",function getValue(){
		var records = CompulsoryGrantDataSet.getAllRecords();
		composedPortrait = records[0].get("composedPortrait");
		domicileType = records[0].get("domicileType");
	});
}

function save(){
	var CompulsoryGrantDataSet = L5.DatasetMgr.lookup("CompulsoryGrantDataSet");
	var CompulsoryGrantRecord=CompulsoryGrantDataSet.getCurrent();
	//校验发放所属年度
	var belongYear = CompulsoryGrantRecord.get("belongYear");
	if(belongYear==''){
		 L5.Msg.alert('提示','发放所属年度不能为空！');
		 return false;
	}
	//校验优待金发放时间
	var grantDate = CompulsoryGrantRecord.get("grantDate");
	if(grantDate==''){
		 L5.Msg.alert('提示','发放所属年度不能为空！');
		 return false;
	}
	if(grantDate!=''&&!validateDateFormat(grantDate)){
		L5.Msg.alert("提示","优待金发放时间格式不正确！");
		return false;
	}
	//校验领取人姓名
	var receiveName = CompulsoryGrantRecord.get("receiveName");
	if(receiveName==''){
		 L5.Msg.alert('提示','领取人姓名不能为空！');
		 return false;
	}
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand"); 
	command.setParameter("record",CompulsoryGrantRecord);
	command.execute("updateCompulsory");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		fun_Close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//当输入立功增发和其他增发时，计算合计金额
function changeTotal(){
	var grantMon = document.getElementById("grantMon").value;
	var inTibetAdditional = document.getElementById("inTibetAdditional").value;
	if(inTibetAdditional==""){
		inTibetAdditional= 0;
	}
	var meritAdditional = document.getElementById("meritAdditional").value;
	if(meritAdditional==""){
		meritAdditional= 0;
	}
	var otherAdditional = document.getElementById("otherAdditional").value;
	if(otherAdditional==""){
		otherAdditional= 0;
	}
	var total = Number(grantMon)+Number(inTibetAdditional)+Number(meritAdditional)+Number(otherAdditional);
	CompulsoryGrantDataSet.set("total",total);
}

//通过查询
function queryOtherInfor(){
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand"); 
	var belongYear = document.getElementById("belongYear").value;
	command.setParameter("belongDate",belongYear);
	command.setParameter("composedPortrait",composedPortrait);
	command.setParameter("domicileType",domicileType);
	command.setParameter("organCode",organCode);
	command.execute("queryBelongDateChange");
	if(command.getReturn("newmoonStandards")!=undefined){
		var newmoonStandards = command.getReturn("newmoonStandards");
		CompulsoryGrantDataSet.set("grantMon",Number(newmoonStandards));
		document.getElementById("grantMon").value = newmoonStandards;
		changeTotal();
		if(command.getReturn("inTibetAdditional")!=undefined){
			var inTibetAdditional = command.getReturn("inTibetAdditional");
			CompulsoryGrantDataSet.set("inTibetAdditional",Number(inTibetAdditional));
			document.getElementById("inTibetAdditional").value = inTibetAdditional;
			changeTotal();
		}
	}else{
		L5.Msg.alert('提示',"相应义务兵优待金标准不存在!");
		document.getElementById("belongYear").value="";
		document.getElementById("grantMon").value="";
		document.getElementById("inTibetAdditional").value="";
		document.getElementById("total").value="";
		return false;
	}
}

function fun_Close(){
 	window.close();
}