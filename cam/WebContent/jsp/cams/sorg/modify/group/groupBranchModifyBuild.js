function init() {
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").value = borgCode;
				}
			}
		});	
}
//保存
function save(){
	//社团名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
		return;
	}
	//成立日期
	if(!(document.getElementById("buildDate").value)){
		L5.Msg.alert("提示","校验未通过："+"成立日期不能为空！");
		return;
	}
	var somOrganRecord=somOrganDataSet.getCurrent();
	
	var somOrganValidate = somOrganDataSet.isValidate();
	if(somOrganValidate != true){
		L5.Msg.alert("提示",somOrganValidate);
		return false;
	}
	//社团邮编
	if(_$("sorgPost")!=""){
		if(_isPostCode(_$("sorgPost")) != true){
			L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
			return;
		}
	}
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("organRecord", somOrganRecord);
	command.execute("modifyOrganInfo");
	if(!command.error){
		L5.Msg.alert("提示","保存成功!",function(){
			 init();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	var data=new L5.Map();
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("branchSorgCode"));	
	url="jsp/cams/sorg/modify/group/groupModifyBuildList.jsp";
	L5.forward(url,'',data);
}
//向dataset中增加数据
function addRecordToDataset(dataset,record){
	var methodName=window.dialogArguments.methodName;
	var ret=window.dialogArguments.activityList;
	dataset.removeAll();
	dataset.add(record);
}
function getValue() {
	//如果起先数据为空，则直接调用增加方法
	if(somOrganDataSet.getCount()==0){
		somOrganDataSet.newRecord();
		return;
	}
}
var sorgCodeNum = "";
var cnNameNum = "";
//校验社会组织名称是否重复
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


//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("branchSorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("branchSorgCode"));
		command.setParameter("sorgType","S");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
			return;
		}
	}
}