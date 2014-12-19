var buildType;
var belongRel;
var groupType;

function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.setParameter("SOM_PARTY.PARTY_ID@=",partyId);	
	somPartyDS.load();
	somPartyDS.on("load",queryMess);
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.setParameter('MEMBER_ID',partyId);
	somPartyPraiseInsertDataSet.setParameter('PRAISE_TYPE',"P");//党建：P，党员：M
	somPartyPraiseInsertDataSet.load();
	var somPartyChangeDataSet=L5.DatasetMgr.lookup("somPartyChangeDataSet");
	somPartyChangeDataSet.setParameter('PARTY_ID',partyId);
	somPartyChangeDataSet.load();
}

function queryMess(ds){
	var record=ds.getCurrent();
	buildType=record.get("buildType");
	if(buildType==5){
		$("combinedTr").style.display="block";
	}
	belongRel=record.get("belongRel");
	if(belongRel==3){
		$("belongRelTr").style.display="block";
	}	
	groupType=record.get("groupType");
	if(groupType==3){
		$("groupDescTr").style.display="block";
	}
	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	sorgId=ds.get('sorgId');
	organDataSet.setParameter("SORG_ID",ds.get('sorgId'));
	organDataSet.load();
	organDataSet.on('load',function(){
		$('sorgAdds').innerHTML=organDataSet.get('sorgAdds');
		$('sorgPhone').innerHTML=organDataSet.get('sorgPhone');
		$('borgName').value=organDataSet.get('borgName');
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
	//判断是否显示转入信息
	if(ds.get("inType") == "1"){
		$("fullSystemInDiv").style.display="block";
	}
	//判断是否显示转出信息
	if(ds.get("outType") == "1"){
		$("fullSystemOutDiv").style.display="block";
	}
}
/**
*返回党员列表
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
