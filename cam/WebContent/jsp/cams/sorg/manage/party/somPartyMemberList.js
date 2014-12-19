function init(){
	$("qsorgName").value=searchSorgName;
	$("qsorgCode").value=searchSorgCode;
	$("qsorgType").value=searchSorgType;
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	if(sorgId!=''){
  		somPartyMemberDS.setParameter("SORG_ID@=",sorgId);
		somPartyMemberDS.load();
	}else{	
    	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	  	organDataSet.setParameter("CN_NAME@=",_$("qsorgName"));
	  	organDataSet.setParameter("SORG_CODE@=",_$("qsorgCode"));
	  	organDataSet.setParameter("SORG_TYPE@=",_$("qsorgType"));
	  	organDataSet.load();
	  	//query方法中也要用到该onload方法
	  	organDataSet.on('load',function(ds){	  		
			ds.filterBy(function(record, id){
				if(record.get('morgArea') == morgArea){
					return record;
				}
			});
	  		if(ds.getCount()>0){				
		  		somPartyMemberDS.setParameter("SORG_ID@=",ds.get("sorgId"));
		  		if(!_$("qinType") == ""){
		  			somPartyMemberDS.setParameter("IN_TYPE@=",_$("qinType"));
		  		}
		  		if(!_$("qoutType") == ""){
		  			somPartyMemberDS.setParameter("OUT_TYPE@=",_$("qoutType"));
		  		}
				somPartyMemberDS.load();
			}else{
				somPartyMemberDS.setParameter("SOM_PARTY_MEMBER.SORG_ID@=","不存在");
				somPartyMemberDS.load();
			}
	  	});
	}
	
	//党员状态过滤，不显示转往其他党组织，转入组织关系
	statusChangeTypePartSelect.filterBy(function(record, id){
		if(record.get('value') == "0"){
			return record;
		}
		if(record.get('value') == "1"){
			return record;
		}
		if(record.get('value') == "2"){
			return record;
		}
		if(record.get('value') == "5"){
			return record;
		}
	});
}
	function addPartyMember(){
		var data=new L5.Map();
		data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
		data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
		data.put("searchSorgType",_$('qsorgType'));
		var url="jsp/cams/sorg/manage/party/somPartyMemberInsert.jsp";
		L5.forward(url,'',data);
	}
	
	/**
	*查询
	*/
function query(){
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
    var qsorgName=_$("qsorgName"); 
    var qsorgCode=_$("qsorgCode");
    var qsorgType=_$("qsorgType");
    var qinType=_$("qinType");
    var qoutType=_$("qoutType");
    if(qsorgName==''&&qsorgCode==''){
    	if(qoutType == "" && qinType == ""){
    		L5.Msg.alert("提示",'请至少输入社会组织名称或登记证号！');
    		return;
    	}else{
    		somPartyMemberDS.setParameter("IN_TYPE@=",qinType)
		  	somPartyMemberDS.setParameter("OUT_TYPE@=",qoutType)
			somPartyMemberDS.load();
			return;
    	}
    }
	if(sorgId!=''){
  		somPartyMemberDS.setParameter("SORG_ID@=",sorgId);
  		somPartyMemberDS.setParameter("IN_TYPE@=",qinType)
	  	somPartyMemberDS.setParameter("OUT_TYPE@=",qoutType)
		somPartyMemberDS.load();
	}else{
    	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	  	organDataSet.setParameter("CN_NAME@=",qsorgName);
	  	organDataSet.setParameter("SORG_CODE@=",qsorgCode);
	  	organDataSet.setParameter("SORG_TYPE@=",qsorgType);
	  	organDataSet.load();
  	}
}
	/**
	*查看党员详情
	*/
	function lookPartyMember(){
		var somPartyMember=L5.getCmp("somPartyMemberEdit");
		var record=somPartyMember.getSelectionModel().getSelections();
		if(record.length!=1){
			L5.Msg.alert("提示","请选择一条党员信息！");
			return;
		}
		var data=new L5.Map();
		data.put("memberId",record[0].get("memberId"));
		data.put("sorgId",record[0].get("sorgId"));
		data.put("peopleType",record[0].get("peopleType"));
		data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
		data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
		data.put("searchSorgType",_$('qsorgType'));
		var url="jsp/cams/sorg/manage/party/somPartyMember.jsp";
		var text="党员基本情况";
		L5.forward(url,text,data);
	}
	/**
	*修改党员详情
	*/
	function editPartyMember(){
		var somPartyMember=L5.getCmp("somPartyMemberEdit");
		var record=somPartyMember.getSelectionModel().getSelections();
		if(record.length!=1){
			L5.Msg.alert("提示","请选择一条党员信息！");
			return;
		}
		if(record[0].get("outType") == "1"){
			L5.Msg.alert("提示","该党员已经整建制转出！");
			return;
		}
		if(record[0].get("outType") == "0"){
			L5.Msg.alert("提示","该党员已经转出！");
			return;
		}
		var somPartyQueryDataSet=L5.DatasetMgr.lookup("somPartyQueryDataSet_edit");
		somPartyQueryDataSet.setParameter("SORG_ID@=",record[0].get("sorgId"));
		somPartyQueryDataSet.load();
		somPartyQueryDataSet.on('load',function(){
			if(somPartyQueryDataSet.getCount()>0){
				if(somPartyQueryDataSet.get('partyStatus')=='1'){
					L5.Msg.alert("提示",'所属党组织已撤销，不能进行修改操作！');
					return;
				}
			}
			if(record[0].get('inOrOut')=='0'){
				L5.Msg.alert('提示',"已进行转出操作，不能进行修改!");
				return false;
			}
			var data=new L5.Map();
			data.put("memberId",record[0].get("memberId"));
			data.put("sorgId",record[0].get("sorgId"));
			data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
			data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
			data.put("searchSorgType",_$('qsorgType'));
			var url="jsp/cams/sorg/manage/party/somPartyMemberUpdate.jsp";
			var text="党员基本情况";
			L5.forward(url,text,data);
		});
	}
	function delPartyMember(){
		var somPartyMember=L5.getCmp("somPartyMemberEdit");
		var record=somPartyMember.getSelectionModel().getSelections();
		if(record.length!=1){
			L5.Msg.alert("提示","请选择一条党员信息！");
			return;
		}
		var somPartyQueryDataSet=L5.DatasetMgr.lookup("somPartyQueryDataSet_del");
		somPartyQueryDataSet.setParameter("SORG_ID@=",record[0].get("sorgId"));
		somPartyQueryDataSet.load();
		somPartyQueryDataSet.on('load',function(){
			if(somPartyQueryDataSet.getCount()>0){
				if(somPartyQueryDataSet.get('partyStatus')=='1'){
					L5.Msg.alert("提示",'所属党组织已撤销，不能进行删除操作！');
					return;
				}
			}
			if(record[0].get("outType") == "1" || record[0].get("outType") == "0"){
				L5.Msg.alert('提示',"已进行转出操作，不能进行删除!");
				return false;
			}
			
			L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
				if(sta=="yes"){
					var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyMemberCmd");
					command.setParameter("memberId",record[0].get("memberId"));
					command.execute("delPartyMember");
					if (!command.error) {
						L5.Msg.alert("提示","删除成功！");
						query();
					}else{
						L5.Msg.alert('提示',"删除时出现错误！"+command.error);
					}
				}
			});
		});
	}
	function returnPartyList(){
		var somPartyMember=L5.getCmp("somPartyMemberEdit");
		var record=somPartyMember.getSelectionModel().getSelections();
		var data=new L5.Map();
		var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
		if(record.length==1){
			var sorgId=record[0].get('sorgId');
			data.put("searchSorgName",encodeURIComponent(encodeURIComponent(getDicText(cnNameDS,sorgId))));
		}
		L5.forward(url,'党建信息管理',data);
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
function closeIn(){
	var win=L5.getCmp("inWin");
	win.hide();
}
function outPartyMember(){
	var somPartyMember=L5.getCmp("somPartyMemberEdit");
	var record=somPartyMember.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请选择一条党员信息！");
		return;
	}
	if(record[0].get("outType") == "1"){
		L5.Msg.alert("提示","该党员已经整建制转出！");
		return;
	}
	if(record[0].get("outType") == "0"){
		L5.Msg.alert("提示","该党员已经转出！");
		return;
	}
	var win=L5.getCmp("outWin");
	win.show();
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
	var somPartyMember=L5.getCmp("somPartyMemberEdit");
	var record=somPartyMember.getSelectionModel().getSelections();			
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyMemberCmd");
	command.setParameter("somPartyMember",record[0]);
	command.setParameter('outTime',_$("outTime"));	
	command.setParameter('outToOrgan',_$("outToOrgan"));	
	command.execute("saveOutInfo");
	if (!command.error) {
		L5.Msg.alert("提示","转出操作成功！",function(){	
			var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
			closeOut();
			somPartyMemberDS.reload();
		});
	}else{
		L5.Msg.alert("提示","Error: " + command.error);
		return;
	}	
}
function closeOut(){
	var win=L5.getCmp("outWin");
	win.hide();
}

function getInOrOut(value,cellmeta,record,rowindex,colindex,dataset){
	var inOrOut=record.get('inOrOut');
	if(inOrOut=="1"){
		return '<label style="color:blue">'+'转入'+'</label>';
	}else if(inOrOut=="0"){
		return '<label style="color:red">'+'转出'+'</label>';
	}else{
		return "";
	} 
}

function inPartyMemberFull(){
	var data=new L5.Map();
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
	data.put("searchSorgType",_$('qsorgType'));
	data.put("ifFullSystemIn","1");
	var url="jsp/cams/sorg/manage/party/somPartyMemberInsert.jsp";
	L5.forward(url,'',data);
}

function inPartyMember(){
	var data=new L5.Map();
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(_$("qsorgName"))));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(_$("qsorgCode"))));
	data.put("searchSorgType",_$('qsorgType'));
	//参数，转入操作
	data.put("ifIn","1");
	var url="jsp/cams/sorg/manage/party/somPartyMemberInsert.jsp";
	L5.forward(url,'',data);
}

function changeStatus(){
	var somPartyMember=L5.getCmp("somPartyMemberEdit");
	var record=somPartyMember.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请选择一条党员信息！");
		return;
	}
	if(record[0].get("peopleType") != "1"){
		L5.Msg.alert("提示","该人还不是党员，不能进行状态变更！");
		return;
	}
	if(record[0].get("outType") == "1"){
		L5.Msg.alert("提示","该党员已经整建制转出！");
		return;
	}
	if(record[0].get("outType") == "0"){
		L5.Msg.alert("提示","该党员已经转出！");
		return;
	}
	var win=L5.getCmp("changeStatusWin");
	win.show();
}

function confirmChange(){
	if(_$("memberStatus")=="" || _$("memberStatus")==null){
		L5.Msg.alert('提示',"请填写党员状态!");
		return false;
	}
	if(_$("statusChangeDate")=="" || _$("statusChangeDate")==null){
		L5.Msg.alert('提示',"请填写党员状态变更时间!");
		return false;
	}
	var somPartyMember=L5.getCmp("somPartyMemberEdit");
	var record=somPartyMember.getSelectionModel().getSelections();			
	var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyMemberCmd");
	command.setParameter("somPartyMember",record[0]);
	command.setParameter('memberStatus',_$("memberStatus"));	
	command.setParameter('statusChangeDate',_$("statusChangeDate"));	
	command.execute("saveStatusChangeInfo");
	if (!command.error) {
		L5.Msg.alert("提示","党员状态变更操作成功！",function(){	
			var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
			closeChange();
			somPartyMemberDS.reload();
		});
	}else{
		L5.Msg.alert("提示","Error: " + command.error);
		return;
	}	
}
function closeChange(){
	var win=L5.getCmp("changeStatusWin");
	win.hide();
}

function showChangeListWin(){
	var somPartyMember=L5.getCmp("somPartyMemberEdit");
	var record=somPartyMember.getSelectionModel().getSelections();
	var memberId = record[0].get("memberId");
	var somPartyMemberStatusChangeDataSet = L5.DatasetMgr.lookup("somPartyMemberStatusChangeDataSet");
	somPartyMemberStatusChangeDataSet.setParameter("MEMBER_ID@=",memberId);
	somPartyMemberStatusChangeDataSet.load();
	var win=L5.getCmp("ChangeListWin");
	win.show();
}

function closeChangeListWin(){
	var win=L5.getCmp("ChangeListWin");
	win.hide();
}
