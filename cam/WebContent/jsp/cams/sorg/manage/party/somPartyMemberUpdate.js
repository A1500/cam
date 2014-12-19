var sorgName;
var borgName;
function init(){
 	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
 	organDataSet.setParameter("SOM_ORGAN.SORG_ID@=",sorgId);
	organDataSet.load();
	organDataSet.on("load",queryOrganName);
	
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	somPartyMemberDS.setParameter("SOM_PARTY_MEMBER.MEMBER_ID@=",memberId);	
	somPartyMemberDS.load();
	somPartyMemberDS.on('load',function(ds){
		var peopleType=ds.get('peopleType');
	 	var dangyuan=$("dangyuanDiv");
	 	var yubei=$("yubeiDiv");
	 	var fazhan=$("fazhanDiv");
	 	var jijifenzi=$("jijifenziDiv");
	 	var shenqingren=$("shenqingrenDiv");
	 	if(peopleType==5){
	 		dangyuan.style.display="none";
	 		yubei.style.display="none"; 
	 		fazhan.style.display="none";
	 		jijifenzi.style.display="none"; 
	 		shenqingren.style.display="block";
	 	}else if(peopleType==4){
	 		dangyuan.style.display="none";
	 		yubei.style.display="none"; 
	 		fazhan.style.display="none";
	 		jijifenzi.style.display="block"; 
	 		shenqingren.style.display="none";
	 	}else if(peopleType==3){
	 		dangyuan.style.display="none";
	 		yubei.style.display="none"; 
	 		fazhan.style.display="block";
	 		jijifenzi.style.display="none"; 
	 		shenqingren.style.display="none";
	 	}else if(peopleType==2){
	 		dangyuan.style.display="none";
	 		yubei.style.display="block"; 
	 		fazhan.style.display="none";
	 		jijifenzi.style.display="none"; 
	 		shenqingren.style.display="none";
	 	}else{	
	 		dangyuan.style.display="block";
	 		yubei.style.display="none"; 
	 		fazhan.style.display="none";
	 		jijifenzi.style.display="none"; 
	 		shenqingren.style.display="none";
	 	}
	 	if(ds.get("inType") == "1"){
	 		$("fullSystemInDiv").style.display="block";
	 	}
		if(ds.get("inType") == "0"){
	 		$("fullSystemInDiv").style.display="block";
	 	}
	});	
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.setParameter('MEMBER_ID',memberId);
	somPartyPraiseInsertDataSet.setParameter('PRAISE_TYPE','M');//党建：P，党员：M
	somPartyPraiseInsertDataSet.load();		
	//处理editgridpanel中枚举值的过滤
	var grantedTitleComboBox=L5.getCmp("grantedTitleComboBox");
    grantedTitleComboBox.on("expand",onSelectGrantedTitleCode);
 }
 
 function onSelectGrantedTitleCode(){
	var grantedTitleSelect=L5.DatasetMgr.lookup("grantedTitleSelect");
	grantedTitleSelect.load();
	grantedTitleSelect.on("load",function(ds){
		//过滤授予称号，保留先进党组织
		ds.filterBy(function(record,id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
			if("2".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	});
	grantedTitleComboBox.un("expand",onSelectGrantedTitleCode);
}

 function showOtherInfo(obj){
 	var peopleType=obj.value;
 	var dangyuan=$("dangyuanDiv");
 	var yubei=$("yubeiDiv");
 	var fazhan=$("fazhanDiv");
 	var jijifenzi=$("jijifenziDiv");
 	var shenqingren=$("shenqingrenDiv");
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	var record=somPartyMemberDS.getCurrent();
 	if(peopleType==5){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="block";
 	}else if(peopleType==4){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="block"; 
 		shenqingren.style.display="none";
 	}else if(peopleType==3){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="block";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 		
 		//清空党员div中的隶属组织信息
 		$("belongOrg").value = "";
 		$("belongOrgType").value = "";
 		$("belongOrg").disabled = "";
 		somPartyMemberDS.set("belongOrg","");
 		
 		//清空预备党员div中的隶属组织信息
 		$("belongOrgYubei").value = "";
 		$("belongOrgTypeYubei").value = "";
 		$("belongOrgYubei").disabled = "";
 		clearSomPartyMemberDSInDiv();
 	}else if(peopleType==2){
 		dangyuan.style.display="none";
 		yubei.style.display="block"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 		
 		$("belongOrg").disabled = "";
 		clearSomPartyMemberDSInDiv();
 	}else{	
 		dangyuan.style.display="block";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 		
 		$("belongOrgYubei").disabled = "";
 		clearSomPartyMemberDSInDiv();
 	}
 	
 	if(peopleType==1){
 		$('ifFulltime').disabled=false;
 	}else{
 		$('ifFulltime').disabled=true;
 		record.set('ifFulltime','');
 	}
 }
 
 function queryOrganName(organDataSet){
	if(organDataSet.getCount()==0){
		L5.Msg.alert("提示","此社会组织已经不存在了！");
		return;
	}else{
		var record=organDataSet.getCurrent();
//		$("sorgCode").innerText=record.get("sorgCode");
		$("sorgName").innerHTML=record.get("cnName");
		sorgName = record.get("cnName");
		borgName = record.get("borgName");
		$("sorgType").value=record.get("sorgType");		
	}

}

 function returnList(){
	var data=new L5.Map();
	var url="jsp/cams/sorg/manage/party/somPartyMemberList.jsp";
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(searchSorgName)));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(searchSorgCode)));
	data.put("searchSorgType",searchSorgType);
	data.put("sorgId",sorgId);
	L5.forward(url,'',data);
 }
 
 function savePartyMember(){
		var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
		var somPartyMember=somPartyMemberDS.getCurrent();
		var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
		var somPartyPraiseRecords=somPartyPraiseInsertDataSet.getAllChangedRecords();
		//校验
		var validate=somPartyMemberDS.isValidate(true);
		if(validate!=true){
			L5.Msg.alert("提示","校验未通过："+validate);
			return;
		}
		var peopleType=_$('peopleType');
		var ifFulltime=_$('ifFulltime');
		if(peopleType==1&&ifFulltime==''){
			L5.Msg.alert("提示","校验未通过："+'请选择专职/兼职！');
			return;
		}
		var belongOrg=_$('belongOrg');	
		var belongOrgYubei=_$('belongOrgYubei');
		if(peopleType==1 &&belongOrg==''){
			L5.Msg.alert("提示","校验未通过："+'请输入隶属组织！');
			return;
		}
		if(peopleType==2 &&belongOrgYubei==''){
			L5.Msg.alert("提示","校验未通过："+'请输入隶属组织！');
			return;
		}
		var idCard = _$('idCard');
		if(idCard==''){
			L5.Msg.alert("提示","校验未通过："+'请输入身份证号！');
			return;
		}
		if(_$("inType") == "1" && (_$("inTime") == ""||_$("inFromOrgan") == "")){
			L5.Msg.alert("提示","整建制转入时请填写转入时间和从何单位转入！");
			$("inFromOrgan").focus();
			return false;
		}
		if(_$("inType") == "0" && (_$("inTime") == ""||_$("inFromOrgan") == "")){
			L5.Msg.alert("提示","转入时请填写转入时间和从何单位转入！");
			$("inFromOrgan").focus();
			return false;
		}
		var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyMemberCmd");
		command.setParameter("somPartyMember",somPartyMember);
		command.setParameter("somPartyPraiseRecords",somPartyPraiseRecords);
		command.execute("updatePartyMember");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
				returnList();
			//var url="jsp/cams/sorg/manage/party/somPartyMemberList.jsp";
			//L5.forward(url);
			});
		}else{
			L5.Msg.alert("提示","Error: " + command.error);
			return;
		}	
 }
 
  function doCheckIdCard(){
  	if(_$("idCard")==''){
  		return;
  	}else if(checkIDCard($("idCard")) != true){
 		L5.Msg.alert("提示","校验未通过："+"身份证号不合法!");
		return;
 	}else{
	var somPartyMemberQueryDataSet = L5.DatasetMgr.lookup("somPartyMemberQueryDataSet");
	somPartyMemberQueryDataSet.setParameter("ID_CARD",_$('idCard'));
	somPartyMemberQueryDataSet.setParameter("SORG_ID",sorgId);
	somPartyMemberQueryDataSet.setParameter("OUT_TYPE@<","0");
	somPartyMemberQueryDataSet.load();
	somPartyMemberQueryDataSet.on('load',function(){
		if(somPartyMemberQueryDataSet.getCount()>0){
			L5.Msg.alert("提示","已录入此人信息，不能重复录入！");
			$('idCard').value='';
			return;				
		}else{
		// 根据证件号码索引人员
		var somDutyDataSet = L5.DatasetMgr.lookup("somDutyDataSet");
		somDutyDataSet.setParameter("ID_CARD",_$('idCard'));
		somDutyDataSet.setParameter("SORG_ID",sorgId);
		somDutyDataSet.load();
		somDutyDataSet.on('load', function(ds){		
			if(ds.getCount()>0){
				var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
				var record=somPartyMemberDS.getCurrent();
				record.set('name',ds.get("name"));
				record.set('sex',ds.get("sex"));
				record.set('birthday',ds.get("birthday"));
				record.set('folk',ds.get("folk"));
				record.set('education',ds.get("education"));
				record.set('phone',ds.get("phone"));
				record.set('sorgDuties',ds.get("sorgDuties"));
				record.set('workName',ds.get("workName"));
				record.set('workDuties',ds.get("workDuties"));
				record.set('profession',ds.get("profession"));
				record.set('ifFulltime',ds.get("ifFulltime"));
			}
		});
		}
	});
	}
 }
 function idCardfillBack(idCard){
 	//$("sex").value=getSexByCode(idCard);
 	//$("birthday").value=getBirthByCode(idCard);
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	var somPartyMember=somPartyMemberDS.getCurrent();
	somPartyMember.set("sex",getSexByCode(idCard));
	somPartyMember.set("birthday",getBirthByCode(idCard));
 } 
function getIfOtherBranch(){
	var belongOrg;
	if(_$('peopleType') == 1){
		belongOrg=_$('belongOrg');
	}
	if(_$('peopleType') == 2){
		belongOrg=_$('belongOrgYubei');
	}
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	if(belongOrg==$('sorgName').innerHTML){
		somPartyMemberDS.set('ifOtherBranch','0');
	}else{
		somPartyMemberDS.set('ifOtherBranch','1');
	}
}      
// 增加
function addPraise(){
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.newRecord({"memberId":memberId,'praiseType':'M'});
}
// 删除
function delPraise(){
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var record=somPartyPraiseInsertDataSet.getCurrent();
	if(record!=null){
		somPartyPraiseInsertDataSet.remove(record);
	}
}
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}

/**
 * 根据隶属组织类型来处理隶属组织输入域
 * 选择社会组织和业务主管单位类别的“隶属组织”字段自动回填并不可修改，其他类别的手工填写
 * 由于党员与预备党员在页面所引用的div不同，字段取值的id得区分开，所以此处多加了两个参数，用来出来党员与预备党员两种情况
 * @param {} value 隶属组织类型值
 * @param {} typeid 隶属组织类型输入域的id
 * @param {} belongOrgId 隶属组织输入域的id
 */
function dealBelongOrg(value,typeid,belongOrgId){
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	if(value == "0"){
		somPartyMemberDS.set("belongOrg",sorgName);
		$(belongOrgId).value = sorgName;
		$(belongOrgId).disabled = "disabled";
		return;
	}
	if(value == "1"){
		var borgNameDs=L5.DatasetMgr.lookup("borgNameDs");
		borgNameDs.setParameter("includeCode",borgName);
		borgNameDs.load();
		borgNameDs.on('load',function (ds){
			somPartyMemberDS.set("belongOrg",ds.get("text"));
			$(belongOrgId).value = ds.get("text");
			$(belongOrgId).disabled = "disabled";
			return;
		});
		
	}
	$(belongOrgId).value = "";
	$(belongOrgId).disabled = "";
}

function clearSomPartyMemberDSInDiv(){
 	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
 	somPartyMemberDS.set("partyDuties","");
 	somPartyMemberDS.set("ifInstrctor","");
 	somPartyMemberDS.set("ifOtherBranch","");
 	somPartyMemberDS.set("belongOrgType","");
 	somPartyMemberDS.set("belongOrg","");
 	somPartyMemberDS.set("relation","");
 	somPartyMemberDS.set("applicationDate","");
 	somPartyMemberDS.set("activistsDate","");
 	somPartyMemberDS.set("developDate","");
 	somPartyMemberDS.set("joinDate","");
 	somPartyMemberDS.set("normalDate","");
 	somPartyMemberDS.set("normalInfo","");
 }