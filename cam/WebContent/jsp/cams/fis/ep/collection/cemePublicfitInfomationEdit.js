function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	if(method=="insert"){
		ds.newRecord({"prop" : "1"});	
	}else{
		ds.setParameter("ORGAN_ID@",organID);
		ds.load();
	}
	L5.QuickTips.init();
}
function getDay(item) {
	LoushangDate(item.previousSibling);
}
function save(){
    var ds=L5.DatasetMgr.lookup("ds");
   	var record = ds.getCurrent();
	if(record.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过!"+valid);
		return false;
	}	
   	if(!(record.get("greenArea")||record.get("greenRatio"))){
		L5.Msg.alert('提示','绿地面积、绿化覆盖率二者必填其一!');
		return false;
   	}
   	if(record.get("totalArea")&&record.get("greenArea")){
   	   	if(record.get("greenArea")/(record.get("totalArea")*666.66666666667)<0.4){
   			L5.Msg.alert('提示','绿地面积不能低于占地面积的40%');
   			return false;
   	   	}
   	}
   	if(record.get("greenRatio")&&(record.get("greenRatio")<75)){
		L5.Msg.alert('提示','绿化覆盖率不能低于75%!');
		return false;
   	}
	var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeteryOrganCmd"); 
	command.setParameter("record",record);
	if(organID=="null"){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
	
function reset(){
	window.close();
}	
//计算建设资金合计
function getFundTotal(obj){
	if(!_isNum(obj.value)){
		L5.Msg.alert("提示","请输入数字！");
		obj.value=0;
		obj.focus();
	}
	var ds=L5.DatasetMgr.lookup("ds");
	var fundFinance=document.getElementById("fundFinance").value;
	var fundHigher=document.getElementById("fundHigher").value;
	var fundSelf=document.getElementById("fundSelf").value;
	var fundLottery=document.getElementById("fundLottery").value;
	var fundOther=document.getElementById("fundOther").value;
	if(!fundFinance){
		fundFinance=0;
		ds.set("fundFinance",0);
	}
	if(!fundHigher){
		fundHigher=0;
		ds.set("fundHigher",0);
	}
	if(!fundSelf){
		fundSelf=0;
		ds.set("fundSelf",0);
	}
	if(!fundLottery){
		fundLottery=0;
		ds.set("fundLottery",0);
	}
	if(!fundOther){
		fundOther=0;
		ds.set("fundOther",0);
	}
	if(ds.getCount()>0){
		ds.set("fundTotal",fundFinance*1+fundHigher*1+fundSelf*1+fundLottery*1+fundOther*1)
	}
	
}		

//校验数字
function checkNum(domId){
	if(document.getElementById(domId).value){
		if(!_isNum(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
	}
}

//小数点位数处理
function checkAssMon(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById(domId).value=changeTwoDecimal(document.getElementById(domId).value);
	}
}
//更新所属行政区划信息
function updateSelectDeptCode(){
	var fisOrganCode = organId.substr(0, 4) + "00000000";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCityExt.jsp?radioMaxlevel=2&level=3&organCode="
							+ fisOrganCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	var record = ds.getCurrent();
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");//list[0] == areaCode,list[1]==areaName
		record.set("deptCode",list[0]);
		record.set("deptName",list[4]);
		L5.fly('deptName').dom.value=list[4];
	}
	if(organID=="null"){
		var organId$ = "GZ"+record.get("deptCode").substr(0, 9)+"-";
		var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisMaxOrganIdCmd"); 
		command.setParameter("organId", organId$);
		command.execute("query");
		var maxId=command.getReturn("organId");
		var organId_=null;
		if(maxId==null){
			organId_ = organId$+"01";
		}else{
			var max = parseFloat(maxId.substr(12, 2));
			max+=1;
			if(max>9){
				organId_ = organId$+max;
			}else{
				organId_ = organId$+"0"+max;
			}
		}
		document.getElementById("organId").value=organId_;
		ds.set("organId",organId_);
	}
}
//更新所属行政区划信息
function updateSelectManaCode(){
	var fisOrganCode = organId.substr(0, 4) + "00000000";
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/comm/fisDicCityExt.jsp?radioMaxlevel=1&level=2&isRootSelect=1&organCode="
							+ fisOrganCode + "&organName="
							+ escape(encodeURIComponent("中国")), "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	var record = ds.getCurrent();
	if(revalue!=undefined&&revalue!=""){
		var list = revalue.split(";");//list[0] == areaCode,list[1]==areaName
		record.set("manaLevelId",list[0]);
		record.set("manaLevel",list[4]+"民政局");
		L5.fly('manaLevel').dom.value=list[4]+"民政局";
	}
}