/**
*
*/
function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.setParameter("SOM_PARTY.PARTY_ID@=",partyId);
	somPartyDS.load();
	somPartyDS.on('load',function(ds){
		var organDataSet=L5.DatasetMgr.lookup("organDataSet");
		sorgId=ds.get('sorgId');
		organDataSet.setParameter("SORG_ID",ds.get('sorgId'));
		organDataSet.load();
		organDataSet.on('load',function(){
			$('sorgAdds').innerHTML=organDataSet.get('sorgAdds');
			$('sorgPhone').innerHTML=organDataSet.get('sorgPhone');
			$('borgName').value=organDataSet.get('borgName');
			ds.set('borgIfBuildParty',getDicText(ifSorgPartySelect,_$('borgName')));
		});		
		var somPartyMemberDataSet1=L5.DatasetMgr.lookup("somPartyMemberDataSet1");
		somPartyMemberDataSet1.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet1.setParameter('PEOPLE_TYPE','1');
		somPartyMemberDataSet1.load();
		somPartyMemberDataSet1.on('load',function(){
			somPartyMemberDataSet1.filterBy(function(record, id){
				//领导班子、工作人员兼职并且排除掉转出的
				if((record.get('ifFulltime')=='00' || record.get('ifFulltime')=='01') && record.get('outType')==''){
					return record;
				}
			});
			ds.set('fulltimeNum',somPartyMemberDataSet1.getCount());
			
			var somPartyMemberDataSet_1=L5.DatasetMgr.lookup("somPartyMemberDataSet_1");
			somPartyMemberDataSet_1.setParameter('SORG_ID',ds.get('sorgId'));
			somPartyMemberDataSet_1.setParameter('PEOPLE_TYPE','1');
			somPartyMemberDataSet_1.load();
			somPartyMemberDataSet_1.on('load',function(){			
				somPartyMemberDataSet_1.filterBy(function(record, id){
					//领导班子、工作人员专职并且排除掉转出的
					if((record.get('ifFulltime')=='10' || record.get('ifFulltime')=='11') && record.get('outType')==''){
						return record;
					}
				});
				ds.set('parttimeNum',somPartyMemberDataSet_1.getCount());
				var fulltimeNum=ds.get('fulltimeNum');	
				var parttimeNum=ds.get('parttimeNum');	
				if(ds.get('ifBuildParty')=='1'){
					if(fulltimeNum>0&&parttimeNum==0){
						ds.set('partyType','0');//专0，兼1，专兼2
						ds.set('ifComParty','0');
					}else if(fulltimeNum==0&&parttimeNum>0){
						ds.set('partyType','1');
						ds.set('ifComParty','1');
					}else if(fulltimeNum>0&&parttimeNum>0){
						ds.set('partyType','2');
						ds.set('ifComParty','1');
					}
				}
				ds.set('engagedMemberNum',parseInt(fulltimeNum)+parseInt(parttimeNum));
			});
		});	
		var somPartyMemberDataSet2=L5.DatasetMgr.lookup("somPartyMemberDataSet2");
		somPartyMemberDataSet2.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet2.setParameter('PEOPLE_TYPE','2');
		somPartyMemberDataSet2.load();
		somPartyMemberDataSet2.on('load',function(){
			somPartyMemberDataSet2.filterBy(function(record, id){
				if(record.get('outType')==''){
					return record;
				}
			});
			ds.set('prepareNum',somPartyMemberDataSet2.getCount());
		});		
		var somPartyMemberDataSet3=L5.DatasetMgr.lookup("somPartyMemberDataSet3");
		somPartyMemberDataSet3.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet3.setParameter('PEOPLE_TYPE','3');
		somPartyMemberDataSet3.load();
		somPartyMemberDataSet3.on('load',function(){
			somPartyMemberDataSet3.filterBy(function(record, id){
				if(record.get('outType')==''){
					return record;
				}
			});
			ds.set('developNum',somPartyMemberDataSet3.getCount());
		});			
		var somPartyMemberDataSet4=L5.DatasetMgr.lookup("somPartyMemberDataSet4");
		somPartyMemberDataSet4.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet4.setParameter('PEOPLE_TYPE','4');
		somPartyMemberDataSet4.load();
		somPartyMemberDataSet4.on('load',function(){
			somPartyMemberDataSet4.filterBy(function(record, id){
				if(record.get('outType')==''){
					return record;
				}
			});
			ds.set('energeticNum',somPartyMemberDataSet4.getCount());
		});		
		var somPartyMemberDataSet5=L5.DatasetMgr.lookup("somPartyMemberDataSet5");
		somPartyMemberDataSet5.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet5.setParameter('PEOPLE_TYPE','5');
		somPartyMemberDataSet5.load();
		somPartyMemberDataSet5.on('load',function(){
			somPartyMemberDataSet5.filterBy(function(record, id){
				if(record.get('outType')==''){
					return record;
				}
			});
			ds.set('appPartyNum',somPartyMemberDataSet5.getCount());
		});
		somElectronicDataSet_load();
		
		//控制是否整建制转入信息隐藏显示
		showInInfo();
	});
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.setParameter('MEMBER_ID',partyId);
	somPartyPraiseInsertDataSet.setParameter('PRAISE_TYPE',"P");//党建：P，党员：M
	somPartyPraiseInsertDataSet.load();
	var somPartyChangeDataSet=L5.DatasetMgr.lookup("somPartyChangeDataSet");
	somPartyChangeDataSet.setParameter('PARTY_ID',partyId);
	somPartyChangeDataSet.load();
	
	//转入类型过滤，只有整建制转入
	inTypeSelect.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	
	//处理editgridpanel中枚举值的过滤
	var grantedTitleComboBox=L5.getCmp("grantedTitleComboBox");
    grantedTitleComboBox.on("expand",onSelectGrantedTitleCode);
    
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
}

function onSelectGrantedTitleCode(){
	var grantedTitleSelect=L5.DatasetMgr.lookup("grantedTitleSelect");
	grantedTitleSelect.load();
	grantedTitleSelect.on("load",function(ds){
		//过滤授予称号，保留先进党组织
		ds.filterBy(function(record,id){
			if("0".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	});
	grantedTitleComboBox.un("expand",onSelectGrantedTitleCode);
}

/**
*是否建立党组织
*/
function showParty(obj){
	var index=obj.value;
	var build=$("buildDiv");
	var unfounded=$("unfoundedDiv");
	if(index==0){
	    build.style.display="none";
		unfounded.style.display="block";
	}else if(index==1){
		build.style.display="block";
		unfounded.style.display="none";	
	}
}

/**
*返回主表
*/
function returnList(){
	var data=new L5.Map();
	var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(searchSorgName)));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(searchSorgCode)));
	data.put("searchSorgType",encodeURIComponent(encodeURIComponent(searchSorgType)));
	data.put("partyId",partyId);
	L5.forward(url,'',data);
}
/**
*党建信息注册
*/
function saveParty(){
		var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
		var somParty=somPartyDS.getCurrent();
		var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
		var somPartyPraiseRecords=somPartyPraiseInsertDataSet.getAllChangedRecords();
		var somPartyChangeDataSet=L5.DatasetMgr.lookup("somPartyChangeDataSet");
		var somPartyChangeRecords=somPartyChangeDataSet.getAllChangedRecords();
		//校验
		var validate=somPartyDS.isValidate(true);
		if(validate!=true){
			L5.Msg.alert("提示","校验未通过："+validate);
			return;
		}
		if(somParty.get('ifBuildParty')=='1'){
			if(somParty.get('buildType')==''){
				L5.Msg.alert("提示","请选择党组织类别！");
				return false;
			}
			if(somParty.get('buildType')=='5'&&somParty.get('combined')==''){
				L5.Msg.alert("提示","请输入联合支部名称！");
				return false;
			}
			
			if(somParty.get('belongRel')==''){
				L5.Msg.alert("提示","请选择党组织隶属关系！");
				return false;
			}
			if(somParty.get('belongRel')=='3'&&somParty.get('belongRelDesc')==''){
				L5.Msg.alert("提示","请输入隶属关系说明！");
				return false;
			}
			
			if(somParty.get('groupType')=='3'&&somParty.get('groupDesc')==''){
				L5.Msg.alert("提示","请输入已建群团组织说明！");
				return false;
			}
		}else if(somParty.get('ifBuildParty')=='0'){
			if(somParty.get('groupType')=='3'&&somParty.get('groupDesc')==''){
				L5.Msg.alert("提示","请输入已建群团组织说明！");
				return false;
			}
			
			if(somParty.get('nobuildReason')==''){
				L5.Msg.alert("提示","请选择未建党组织原因！");
				return false;
			}
		}			
		if(_$("inType") == "1" && (_$("inTime") == ""||_$("inFromOrgan") == "")){
			L5.Msg.alert("提示","整建制转入时请填写转入时间和从何单位转入！");
			$("inFromOrgan").focus();
			return false;
		}
		var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
		command.setParameter("somParty",somParty);
		command.setParameter("somPartyPraiseRecords",somPartyPraiseRecords);
		command.setParameter("somPartyChangeRecords",somPartyChangeRecords);
		command.execute("updateParty");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
			L5.forward(url);
			});
		}else{
			L5.Msg.alert("提示","Error: " + command.error);
			return;
		}	
	}
//联合支部
    function showCombined(obj){
    		index=obj.value;
			var combine=$("combinedTr");
			if(index==5){
				combine.style.display="block";
			}else{
				combine.style.display="none";
			}
    }
//隶属关系说明
    function showBelongRel(obj){
    		index=obj.value;
			var belong=$("belongRelTr");
			if(index==3){
				belong.style.display="block";
			}else{
				belong.style.display="none";
			}
    }    
//已建群团组织说明
    function showGroupDesc(obj){
    		index=obj.value;
			var desc=$("groupDescTr");
			if(index==3){
				desc.style.display="block";
			}else{
				desc.style.display="none";
			}
    }
    //已建群团组织说明
    function showGroupDesc2(obj){
    		index=obj.value;
			var desc=$("groupDescTr2");
			if(index==3){
				desc.style.display="block";
			}else{
				desc.style.display="none";
			}
    }    
// 党建指导员
    function showInstructor(obj){
    		index=obj.value;
			var instructor1=$("instructorTr");
			var instructor2=$("instructorTr2");
			if(index==3){
				instructor1.style.display="block";
				instructor2.style.display="block";
			}else{
				instructor1.style.display="none";
				instructor2.style.display="none";
			}
    } 
// 增加
function addPraise(){
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.newRecord({"memberId":partyId,'praiseType':'P'});
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
function addChange(){
	var somPartyChangeDataSet=L5.DatasetMgr.lookup("somPartyChangeDataSet");
	somPartyChangeDataSet.newRecord({"partyId":partyId});
}
function delChange(){
	var somPartyChangeDataSet=L5.DatasetMgr.lookup("somPartyChangeDataSet");
	var record=somPartyChangeDataSet.getCurrent();
	if(record!=null){
		somPartyChangeDataSet.remove(record);
	}
}
function getPartyChief(){		
	if(_$("idCard_partyChief")!=''){
		//身份证号
		if(checkIDCard($("idCard_partyChief")) != true){
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}else{
			var somPartyMemberDataSet=L5.DatasetMgr.lookup("somPartyMemberDataSet");
			somPartyMemberDataSet.setParameter('SORG_ID',sorgId);
			somPartyMemberDataSet.setParameter('ID_CARD',_$('idCard_partyChief'));
			somPartyMemberDataSet.load();
			somPartyMemberDataSet.on('load',function(ds){
				ds.filterBy(function(record, id){
					if(record.get('outType')==''){
						return record;
					}
				});
				if(ds.getCount()>0){					
					var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
					somPartyDS.set('partyChief',ds.get('name'));
					somPartyDS.set('sex',ds.get('sex'));
					somPartyDS.set('birthday',ds.get('birthday'));
					somPartyDS.set('phone',ds.get('phone'));
					somPartyDS.set('education',ds.get('education'));
					somPartyDS.set('folk',ds.get('folk'));
					somPartyDS.set('sorgDuties',ds.get('sorgDuties'));
					somPartyDS.set('workName',ds.get('workName'));
					somPartyDS.set('workDuties',ds.get('workDuties'));
				}
			});
		}
	}
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}		

function showInInfo(){
	if(_$("inType") == "1"){
		$("fullSystemInDiv").style.display="block";
	}else{
		$("fullSystemInDiv").style.display="none";
		var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
		somPartyDS.set('inTime',"");
		somPartyDS.set('inFromOrgan',"");
	}
}
