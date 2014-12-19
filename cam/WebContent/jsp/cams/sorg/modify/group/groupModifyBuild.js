//初始化
function init(){
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
//保存按钮
function saveAll(){
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
		return;
	}
	//登记日期
	if(!(document.getElementById("regDate").value)){
		L5.Msg.alert("提示","校验未通过："+"登记日期不能为空！");
		return;
	}
	//社会团体邮编
	if(_$("sorgPost")!= '' && _isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"社会团体邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//社会团体传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"社会团体传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//用房面积
	if(_$("housingArea") != ''){
		var housingArea = checkMoneyFix(_$("housingArea"),2);
		if(housingArea == "整数"){
			if(_$("housingArea").length >8){
				L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,整数最长不超过8位");
				L5.getCmp("tab").setActiveTab("0");
				return;
			}
		}
		if(housingArea == false){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	
	var organRecord=somOrganDataSet.getCurrent();
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
			init();
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//返回按钮
function goBack(){
	var data=new L5.Map();
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("sorgCode"));	
	url="jsp/cams/sorg/modify/group/groupModifyBuildList.jsp";
	L5.forward(url,'',data);
}

//校验登记证号是否重复
var sorgCodeNum='';
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.setParameter("sorgType","S");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
			return;
		}
	}
}
//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}
