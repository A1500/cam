/**
*
*/
var sorgId;
var sorgName;
var sorgType;
var legalPeople;
var politics;
var meetingNum;
var ifBuildParty;
function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.newRecord({'partyId':partyId,'ifBuildParty':'1'});
	showParty();
	
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
function showParty(){
	ifBuildParty=_$('ifBuildParty');
	var build=$("buildDiv");
	var unfounded=$("unfoundedDiv");
	if(ifBuildParty==0){
	    build.style.display="none";
		unfounded.style.display="block";
	}else if(ifBuildParty==1){
		build.style.display="block";
		unfounded.style.display="none";	
	}

}
/**
*查询社会组织信息
*/
function querySorgOrganMess(){
	$("sorgId").value="";
	$("sorgName").innerHTML="";
	$("legalPeople").innerHTML="";
	$("meetingNum").innerHTML="";
	var sorgCode=_$("sorgCode").trim();
	var sorgType=_$("sorgType");
	if(sorgCode!=""&&sorgType!=""){
		var organDataSet=L5.DatasetMgr.lookup("organDataSet");
		organDataSet.setParameter("SOM_ORGAN.SORG_CODE@=",sorgCode);
		organDataSet.setParameter("SOM_ORGAN.SORG_TYPE@=",sorgType);
		organDataSet.load();
		organDataSet.on('load',queryOrgan);
	}
}


function queryOrgan(organDataSet){
	if(organDataSet.getCount()<1){
		L5.Msg.alert("提示","此登记证号不存在,请重新填写！");
		$("sorgCode").value="";
		return;
	}
	var partyNum = 0;
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.setParameter("SORG_ID",organDataSet.getCurrent().get("sorgId"));
	somDutyDataSet.setParameter("SORG_DUTIES","00012");
	somDutyDataSet.setParameter("IF_SERVE","1");
	somDutyDataSet.load();
	somDutyDataSet.on('load',function(){
	if(somDutyDataSet.getCount()<1){
		L5.Msg.alert("提示","法定代表人不存在,请重新填写！");
		$("sorgCode").value="";
		return;
	}
	var somPartyCheckDS=L5.DatasetMgr.lookup("somPartyCheckDS");
	somPartyCheckDS.setParameter("SORG_ID@=",organDataSet.getCurrent().get("sorgId"));
	somPartyCheckDS.load();
	somPartyCheckDS.on('load',function(ds){
			partyNum = somPartyCheckDS.getCount();
			var somDutyRecord=somDutyDataSet.getCurrent();
			if(organDataSet.getCount()==0){
				L5.Msg.alert("提示","此登记证号不存在,请重新填写！");
				$("sorgCode").value="";
				return;
			}else if("32"==organDataSet.getCurrent().get("sorgStatus") || "62"==organDataSet.getCurrent().get("sorgStatus")){
				L5.Msg.alert("提示","此社会组织已注销！");
				$("sorgCode").value="";
				return;
			}else if("52"==organDataSet.getCurrent().get("sorgStatus")){
				L5.Msg.alert("提示","此社会组织已撤销！");
				$("sorgCode").value="";
				return;
			}else if("22"==organDataSet.getCurrent().get("sorgStatus")&&partyNum>0&&ds.get("outType")== ""){
				L5.Msg.alert("提示","此社会组织已登记党建信息！");
				$("sorgCode").value="";
				return;
			}else if(("22"==organDataSet.getCurrent().get("sorgStatus")&&partyNum==0)||("22"==organDataSet.getCurrent().get("sorgStatus")&&ds.get("outType")!= "")){
				record=organDataSet.getCurrent();
				$("sorgCode").value=record.get("sorgCode");
				sorgId=record.get("sorgId");
				$("sorgId").value=sorgId;
				sorgName=record.get("cnName");
				$("sorgName").innerHTML=sorgName;
				legalPeople=somDutyRecord.get("name");
				$("legalPeople").innerHTML=legalPeople;
				meetingNum=record.get("engagedNum");
				$("meetingNum").innerHTML=meetingNum;
				$("politics").value=somDutyRecord.get("politics");
				politics=somDutyRecord.get("politics");
				if($("createTime")){
					$("createTime").value=createTime;
				}
				if($("createTime_build")){
					$("createTime_build").value=createTime;
				}				
				$('sorgAdds').innerHTML=record.get('sorgAdds');
				$('sorgPhone').innerHTML=record.get('sorgPhone');
				$('borgName').value=record.get('borgName');
				var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");	
				somPartyDS.set('borgIfBuildParty',getDicText(ifSorgPartySelect,_$('borgName')));
				
				
				var somPartyMemberDataSet1=L5.DatasetMgr.lookup("somPartyMemberDataSet1");
				somPartyMemberDataSet1.setParameter('SORG_ID',sorgId);
				somPartyMemberDataSet1.setParameter('PEOPLE_TYPE','1');
				somPartyMemberDataSet1.load();
				somPartyMemberDataSet1.on('load',function(){
					somPartyMemberDataSet1.filterBy(function(record, id){
						//领导班子、工作人员兼职并且排除掉转出的
						if((record.get('ifFulltime')=='00' || record.get('ifFulltime')=='01') && record.get('outType')==''){
							return record;
						}
					});
					somPartyDS.set('fulltimeNum',somPartyMemberDataSet1.getCount());
					
					var somPartyMemberDataSet_1=L5.DatasetMgr.lookup("somPartyMemberDataSet_1");
					somPartyMemberDataSet_1.setParameter('SORG_ID',sorgId);
					somPartyMemberDataSet_1.setParameter('PEOPLE_TYPE','1');
					somPartyMemberDataSet_1.load();
					somPartyMemberDataSet_1.on('load',function(){
						somPartyMemberDataSet_1.filterBy(function(record, id){
							//领导班子、工作人员专职并且排除掉转出的
							if((record.get('ifFulltime')=='10' || record.get('ifFulltime')=='11') && record.get('outType')==''){
								return record;
							}
						});
						somPartyDS.set('parttimeNum',somPartyMemberDataSet_1.getCount());
						
						//if(ds.get('ifBuildParty')=='1'){
							var fulltimeNum=somPartyDS.get('fulltimeNum');	
							var parttimeNum=somPartyDS.get('parttimeNum');	
							if(fulltimeNum>0&&parttimeNum==0){
								somPartyDS.set('partyType','0');//专0，兼1，专兼2
								somPartyDS.set('ifComParty','0');
							}else if(fulltimeNum==0&&parttimeNum>0){
								somPartyDS.set('partyType','1');
								somPartyDS.set('ifComParty','1');
							}else if(fulltimeNum>0&&parttimeNum>0){
								somPartyDS.set('partyType','2');
								somPartyDS.set('ifComParty','1');
							}
							somPartyDS.set('engagedMemberNum',parseInt(fulltimeNum)+parseInt(parttimeNum));
						//}
					});
				});
				var somPartyMemberDataSet2=L5.DatasetMgr.lookup("somPartyMemberDataSet2");
				somPartyMemberDataSet2.setParameter('SORG_ID',sorgId);
				somPartyMemberDataSet2.setParameter('PEOPLE_TYPE','2');
				somPartyMemberDataSet2.load();
				somPartyMemberDataSet2.on('load',function(){
					somPartyMemberDataSet2.filterBy(function(record, id){
						if(record.get('outType')==''){
							return record;
						}
					});
					somPartyDS.set('prepareNum',somPartyMemberDataSet2.getCount());
				});		
				var somPartyMemberDataSet3=L5.DatasetMgr.lookup("somPartyMemberDataSet3");
				somPartyMemberDataSet3.setParameter('SORG_ID',sorgId);
				somPartyMemberDataSet3.setParameter('PEOPLE_TYPE','3');
				somPartyMemberDataSet3.load();
				somPartyMemberDataSet3.on('load',function(){
					somPartyMemberDataSet3.filterBy(function(record, id){
						if(record.get('outType')==''){
							return record;
						}
					});
					somPartyDS.set('developNum',somPartyMemberDataSet3.getCount());
				});			
				var somPartyMemberDataSet4=L5.DatasetMgr.lookup("somPartyMemberDataSet4");
				somPartyMemberDataSet4.setParameter('SORG_ID',sorgId);
				somPartyMemberDataSet4.setParameter('PEOPLE_TYPE','4');
				somPartyMemberDataSet4.load();
				somPartyMemberDataSet4.on('load',function(){
					somPartyMemberDataSet4.filterBy(function(record, id){
						if(record.get('outType')==''){
							return record;
						}
					});
					somPartyDS.set('energeticNum',somPartyMemberDataSet4.getCount());
				});		
				var somPartyMemberDataSet5=L5.DatasetMgr.lookup("somPartyMemberDataSet5");
				somPartyMemberDataSet5.setParameter('SORG_ID',sorgId);
				somPartyMemberDataSet5.setParameter('PEOPLE_TYPE','5');
				somPartyMemberDataSet5.load();
				somPartyMemberDataSet5.on('load',function(){
					somPartyMemberDataSet5.filterBy(function(record, id){
						if(record.get('outType')==''){
							return record;
						}
					});
					somPartyDS.set('appPartyNum',somPartyMemberDataSet5.getCount());
				});
				
				somElectronicDataSet_load();
			}else{
				L5.Msg.alert("提示","此社会组织未正式成立！");
				$("sorgCode").value="";
				return;
			}
		});
	});
	
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
		somParty.set("sorgId",sorgId);
		somParty.set("ifBuildParty",_$("ifBuildParty"));
		somParty.set("sorgType",sorgType);	
		somParty.set("sorgName",sorgName);	
		somParty.set("legalPeople",legalPeople);
		somParty.set("politics",politics);
		somParty.set("meetingNum",meetingNum);		
		//校验
		if(_$("sorgCode")==""){
			L5.Msg.alert("提示","社会组织登记证号，必须填写！");
			return;
		}
		
		if(_$("sorgType")==""){
			L5.Msg.alert("提示","社会组织类型，必须填写！");
			return;
		}
		
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
		command.execute("insertParty");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
				returnList();
			//var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
			//L5.forward(url);
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
	somPartyPraiseInsertDataSet.newRecord({"memberId":partyId,'praiseType':'P','praiseOrPunnish':'0'});
}
// 删除
function delPraise(){
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var record=somPartyPraiseInsertDataSet.getCurrent();
	if(record!=null){
		somPartyPraiseInsertDataSet.remove(record);
	}
}
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
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

function showInInfo(inType){
	if(inType == "1"){
		$("fullSystemInDiv").style.display="block";
	}else{
		$("fullSystemInDiv").style.display="none";
		var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
		somPartyDS.set('inTime',"");
		somPartyDS.set('inFromOrgan',"");
	}
}
