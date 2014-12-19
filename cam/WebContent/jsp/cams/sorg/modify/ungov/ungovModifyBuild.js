var legalRecord="";
var dutyId='';
//初始化
function init(){
	loadInfo();
	//房屋来源意见过滤
	resideSourceSelect.filterBy(function(record, id){
		if("2".indexOf(record.get('value'))>-1){
			return record;
		}
		if("3".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
function loadInfo(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadBorgName);
}
function loadBorgName(ds){
	ds.un("load",loadBorgName);
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = ds.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
}
//保存按钮
function save(){
	//名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位名称已存在");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的民办非企业单位登记证号已存在");
		return;
	}	
	//登记日期
	if(!(document.getElementById("regDate").value)){
		L5.Msg.alert("提示","校验未通过："+"登记日期不能为空！");
		return;
	}	
	var somOrganIsValidate = somOrganDataSet.isValidate();
	if(somOrganIsValidate != true){
		L5.Msg.alert("提示",somOrganIsValidate);
		return false;
	}	
	//民办非企业邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"民办非企业邮编格式不正确");
		return;
	}
	//民办非企业传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"民办非企业传真格式不正确");
		return;
	}
	//用房面积
	if(_$("housingArea") != ''){
		var housingArea = checkMoneyFix(_$("housingArea"),2);
		if(housingArea == "整数"){
			if(_$("housingArea").length >8){
				L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,整数最长不超过8位");
				return;
			}
		}
		if(housingArea == false){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
			return;
		}
	}
	//基本信息
	var organRecord=somOrganDataSet.getCurrent();
	organRecord.set("sorgId",sorgId);
	organRecord.set("sorgKind","1");
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	organRecord.set('borgName',document.getElementById("borgName").value);
	
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("organRecord", organRecord);
	command.execute("modifyOrganInfo");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			somOrganDataSet.setParameter("SORG_ID",sorgId);
			somOrganDataSet.load();
			somOrganDataSet.on('load',loadBorgName);
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//返回按钮
function goBack(){
	var data=new L5.Map();
	var url="";
	data.put("searchSorgCode",searchSorgCode);	
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	url="jsp/cams/sorg/modify/ungov/ungovModifyBuildList.jsp";	
	L5.forward(url,'',data);
}
//onchange事件-----------------------------------------------
//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}
function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
//校验社会组织名称是否重复
var cnNameNum=0;
var sorgCodeNum=0;
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.setParameter("sorgId",sorgId);
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.setParameter("sorgType","M");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"登记证号已存在");
			return;
		}
	}
}