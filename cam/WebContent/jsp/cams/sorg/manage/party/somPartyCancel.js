function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.setParameter("SOM_PARTY.PARTY_ID@=",partyId);
	somPartyDS.load();
	somPartyDS.on('load',function(ds){
		sorgId=ds.get('sorgId');		
		somElectronicDataSet_load();	
	});
}

function saveParty(){
		var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
		var validate=somPartyDS.isValidate(true);
		if(validate!=true){
			L5.Msg.alert("提示","校验未通过："+validate);
			return;
		}

		var somParty=somPartyDS.getCurrent();	
		somParty.set("partyStatus","1");					
		var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
		command.setParameter("somParty",somParty);
		command.execute("cancelParty");
		if (!command.error) {
			L5.Msg.alert("提示","撤销成功！",function(){
			var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
			L5.forward(url);
			});
		}else{
			L5.Msg.alert("提示","Error: " + command.error);
			return;
		}	
}

function returnList(){
	var data=new L5.Map();
	var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(searchSorgName)));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(searchSorgCode)));
	data.put("searchSorgType",encodeURIComponent(encodeURIComponent(searchSorgType)));
	data.put("partyId",partyId);
	L5.forward(url,'',data);
}
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}