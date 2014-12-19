function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.setParameter("SOM_PARTY.PARTY_ID@=",partyId);
	somPartyDS.load();
    //做权限限制 
	somPartyDS.on('load',function(){
		somPartyDS.filterBy(function(record, id){
			if(record.get('morgArea') == morgArea){
				return record;
			}
		});
		var organDataSet=L5.DatasetMgr.lookup("organDataSet");
		organDataSet.setParameter("SORG_ID",somPartyDS.get('sorgId'));
		organDataSet.load();
		organDataSet.on('load',function(){
			$('sorgAdds').innerHTML=organDataSet.get('sorgAdds');
			$('sorgPhone').innerHTML=organDataSet.get('sorgPhone');
			$('borgName').value=organDataSet.get('borgName');
			somPartyDS.set('borgIfBuildParty',getDicText(ifSorgPartySelect,_$('borgName')));
		});		
	});
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
function saveParty(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
		var somParty=somPartyDS.getCurrent();
		var command=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
		command.setParameter("somParty",somParty);
		command.execute("updateParty");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
			});
		}else{
			L5.Msg.alert("提示","Error: " + command.error);
			return;
		}	
}
function returnList(){
	history.go(-1);
}
//检测身份证号并回填性别和年龄
function checkIdCradNo(){
 	var idCard=document.getElementById('idCard_partyChief').value;
 	if(checkIDCard($("idCard_partyChief")) != true && !(idCard.length==18 && idCard.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		document.getElementById('idCard_partyChief').value='';
		return;
	}else{
		//回填性别
		var somPartyDS = L5.DatasetMgr.lookup("somPartyDS");
		document.getElementById('sex').value=getSexByCode(idCard);
		somPartyDS.set("sex",getSexByCode(idCard));
		//回填出生年月	
		document.getElementById('birthday').value=getBirthByCode(idCard);
		somPartyDS.set("birthday",getBirthByCode(idCard));
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