	/*
	*
	*/
	function init(){
		$("qsorgName").value=searchSorgName;
		$("qsorgCode").value=searchSorgCode;
		$("qsorgType").value=searchSorgType;
		var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
		if(partyId!=''){
			somPartyDS.setParameter("SOM_PARTY.PARTY_Id@=",partyId);
			somPartyDS.load();
		}else{			
			somPartyDS.setParameter("SOM_PARTY.SORG_NAME@=",searchSorgName);	
			if(searchSorgCode!=''){
				somPartyDS.setParameter("SOM_PARTY.SORG_ID@=",getDicText(sorgIdSelect,searchSorgCode));
			}
			somPartyDS.setParameter("SOM_PARTY.SORG_TYPE@=",searchSorgType);
			somPartyDS.load();
			//做权限限制 
			somPartyDS.on('load',function(){
				somPartyDS.filterBy(function(record, id){
					if(record.get('morgArea') == morgArea){
						return record;
					}
				});
			});
		}
		//转入类型过滤，只有整建制转入
		inTypeSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
		//转出类型过滤，只有整建制转出
		outTypeSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}

	/*
	*查询
	*/
function query(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
    var qsorgName=_$("qsorgName"); 
    var qsorgCode=_$("qsorgCode"); 
    var qpartyStatus=_$("qpartyStatus");
    var qpartyType=_$("qpartyType");
    var qsorgType=_$("qsorgType");
    var qbuildType=_$("qbuildType");
    var qifBuildParty=_$("qifBuildParty");
    var qinType=_$("qinType");
    var qoutType=_$("qoutType");
	somPartyDS.setParameter("SOM_PARTY.SORG_NAME@=",qsorgName);
	if(qsorgCode!=''){
		somPartyDS.setParameter("SOM_PARTY.SORG_ID@=",getDicText(sorgIdSelect,qsorgCode));
	}
	somPartyDS.setParameter("SOM_PARTY.PARTY_STATUS@=",qpartyStatus);	

	somPartyDS.setParameter("SOM_PARTY.PARTY_TYPE@=",qpartyType);
	
    somPartyDS.setParameter("SOM_PARTY.SORG_TYPE@=",qsorgType);

    somPartyDS.setParameter("SOM_PARTY.BUILD_TYPE@=",qbuildType);
 
    somPartyDS.setParameter("SOM_PARTY.IF_BUILD_PARTY@=",qifBuildParty);  
    
    somPartyDS.setParameter("SOM_PARTY.IN_TYPE@=",qinType);  
    
    somPartyDS.setParameter("SOM_PARTY.OUT_TYPE@=",qoutType);  
	somPartyDS.load();
	//做权限限制 
	somPartyDS.on('load',function(){
		somPartyDS.filterBy(function(record, id){
			if(record.get('morgArea') == morgArea){
				return record;
			}
		});
	});
}
	/*
	*党建情况登记
	*/
	function addParty(){
		var data=new L5.Map();
		data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
		data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
		data.put("searchSorgType",encodeURIComponent(encodeURIComponent(_$("qsorgType"))));
		var url="jsp/cams/sorg/manage/party/somPartyInsert.jsp";
		L5.forward(url,'',data);
	}
	/*
	*党建情况登记详情
	*/
	function detailSomParty(){
		var somParty=L5.getCmp("somPartyGrid");
		var records=somParty.getSelectionModel().getSelections();
		if(records.length==0){
			L5.Msg.alert("提示","请选择一条记录进行查看！");
			return;
		}
		var data=new L5.Map();
		data.put("partyId",records[0].get("partyId"));
		data.put("ifBuildParty",records[0].get("ifBuildParty"));
		data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
		data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
		data.put("searchSorgType",encodeURIComponent(encodeURIComponent(_$("qsorgType"))));
		var text="党建情况登记详情";
		if("1"==records[0].get("partyStatus")){
			var url="jsp/cams/sorg/manage/party/somPartyCancelX.jsp";
			L5.forward(url,text,data);
			return;
		}
		if("1"==records[0].get("ifBuildParty")){
			var url="jsp/cams/sorg/manage/party/somPartyBuild.jsp";
			L5.forward(url,text,data);
		}else if("0"==records[0].get("ifBuildParty")){
			var url="jsp/cams/sorg/manage/party/somPartyUnfounded.jsp";
			L5.forward(url,text,data);
		}
		
	}
	/*
	*党建修改
	*/
	function editSomParty(){
		var somParty=L5.getCmp("somPartyGrid");
		var records=somParty.getSelectionModel().getSelections();
		if(records.length!=1){
			L5.Msg.alert("提示","请选择一条记录进行修改！");
			return;
		}
		if("1"==records[0].get("partyStatus")){
			L5.Msg.alert("提示","此社会组织的党建已经撤销了！");
			return;
		}		
		if('1'==records[0].get("outType")){
			L5.Msg.alert("提示","此社会组织的党组织已转出！");
			return;		
		}
		var data=new L5.Map();
		data.put("partyId",records[0].get("partyId"));
		data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
		data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
		data.put("searchSorgType",encodeURIComponent(encodeURIComponent(_$("qsorgType"))));
		var text="党建情况登记详情";
		var url="jsp/cams/sorg/manage/party/somPartyUpdate.jsp";
		L5.forward(url,text,data);		
	}
	/*
	*党员情况管理
	*/
	function somPartyMemberList(){
		var somParty=L5.getCmp("somPartyGrid");
		var records=somParty.getSelectionModel().getSelections();
		var data=new L5.Map();
		var url="jsp/cams/sorg/manage/party/somPartyMemberList.jsp";
		if(records.length==1){
			data.put("searchSorgName",encodeURIComponent(encodeURIComponent(records[0].get('sorgName'))));
		}
		L5.forward(url,'党员信息管理',data);
	}
	/*
	*党建撤销备案
	*/
	function cancleParty(){
		var somParty=L5.getCmp("somPartyGrid");
		var records=somParty.getSelectionModel().getSelections();
		if(records.length!=1){
			L5.Msg.alert("提示","请选择一条记录进行修改！");
			return;
		}
		if('1'==records[0].get("partyStatus")){
			L5.Msg.alert("提示","此社会组织的党组织已撤销！");
			return;		
		}
		if('1'==records[0].get("outType")){
			L5.Msg.alert("提示","此社会组织的党组织已转出！");
			return;		
		}
		var data=new L5.Map();
		data.put("partyId",records[0].get("partyId"));
		data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
		data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
		data.put("searchSorgType",encodeURIComponent(encodeURIComponent(_$("qsorgType"))));
		var text="党建撤销备案";
		var url="jsp/cams/sorg/manage/party/somPartyCancel.jsp";
		L5.forward(url,text,data);		
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
	

function fullPartyOut(){
	var somParty=L5.getCmp("somPartyGrid");
	var records=somParty.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行修改！");
		return;
	}
	if('1'==records[0].get("partyStatus")){
		L5.Msg.alert("提示","此社会组织的党组织已撤销！");
		return;		
	}
	if('1'==records[0].get("outType")){
		L5.Msg.alert("提示","此社会组织的党组织已转出！");
		return;		
	}
	var win=L5.getCmp("outWin");
	win.show();
	
}

function closeOut(){
	var win=L5.getCmp("outWin");
	win.hide();
}

function confirmOut(){
	if(_$("outTime")=="" || _$("outTime")==null){
		L5.Msg.alert('提示',"请填写转出时间!");
		return false;
	}
	if(_$("outToOrgan")=="" || _$("outToOrgan")==null){
		L5.Msg.alert('提示',"请填写转出到何单位!");
		return false;
	}
	L5.Msg.confirm( '是否做党组织信息的整建制转出？' ,'点确认按钮后党组织信息及所属该党组织的党员信息都会做整建制转出' ,
         function(isOk){
             if(isOk == 'yes' ){
                    var somParty=L5.getCmp("somPartyGrid");
					var records=somParty.getSelectionModel().getSelections();		
					var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
					command.setParameter("somParty",records[0]);
					command.setParameter('outTime',_$("outTime"));	
					command.setParameter('outToOrgan',_$("outToOrgan"));	
					command.execute("saveFullPartyOut");
					if (!command.error) {
						L5.Msg.alert("提示","转出操作成功！",function(){	
							closeOut();
							var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
							somPartyDS.reload();
						});
					}else{
						L5.Msg.alert("提示","Error: " + command.error);
						return;
					}	
             }
    });
}