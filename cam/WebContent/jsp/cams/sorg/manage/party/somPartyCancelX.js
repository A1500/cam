function init(){
	L5.getCmp("tab").setActiveTab("0");
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
			$('practiceNum').innerHTML=organDataSet.get('practiceNum');
			$('borgName').value=organDataSet.get('borgName');
			$('sorgAdds1').innerHTML=organDataSet.get('sorgAdds');
			$('sorgPhone1').innerHTML=organDataSet.get('sorgPhone');
			$('practiceNum1').innerHTML=organDataSet.get('practiceNum');
			$('borgName1').value=organDataSet.get('borgName');
		});
		
		var somPartyMemberDataSet1=L5.DatasetMgr.lookup("somPartyMemberDataSet1");
		somPartyMemberDataSet1.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet1.setParameter('PEOPLE_TYPE','1');
		somPartyMemberDataSet1.setParameter('IF_FULLTIME','0');//专职0，兼职1
		somPartyMemberDataSet1.load();
		somPartyMemberDataSet1.on('load',function(){
			somPartyMemberDataSet1.filterBy(function(record, id){
				if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
					return record;
				}
			});
			ds.set('fulltimeNum',somPartyMemberDataSet1.getCount());
			
			var somPartyMemberDataSet_1=L5.DatasetMgr.lookup("somPartyMemberDataSet_1");
			somPartyMemberDataSet_1.setParameter('SORG_ID',ds.get('sorgId'));
			somPartyMemberDataSet_1.setParameter('PEOPLE_TYPE','1');
			somPartyMemberDataSet_1.setParameter('IF_FULLTIME','1');//专职0，兼职1
			somPartyMemberDataSet_1.load();
			somPartyMemberDataSet_1.on('load',function(){			
				somPartyMemberDataSet_1.filterBy(function(record, id){
					if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
						return record;
					}
				});
				ds.set('parttimeNum',somPartyMemberDataSet_1.getCount());
				var fulltimeNum=ds.get('fulltimeNum');	
				var parttimeNum=ds.get('parttimeNum');	
				ds.set('engagedMemberNum',parseInt(fulltimeNum)+parseInt(parttimeNum));
			});
		});	
		var somPartyMemberDataSet2=L5.DatasetMgr.lookup("somPartyMemberDataSet2");
		somPartyMemberDataSet2.setParameter('SORG_ID',ds.get('sorgId'));
		somPartyMemberDataSet2.setParameter('PEOPLE_TYPE','2');
		somPartyMemberDataSet2.load();
		somPartyMemberDataSet2.on('load',function(){
			somPartyMemberDataSet2.filterBy(function(record, id){
				if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
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
				if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
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
				if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
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
				if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
					return record;
				}
			});
			ds.set('appPartyNum',somPartyMemberDataSet5.getCount());
		});
		somElectronicDataSet_load();	
	});
	if(ifBuildParty == 1){
		$("somPartyBuildForm").style.display="block";
	}
	if(ifBuildParty == 0){
		$("somPartyUnfoundedForm").style.display="block";
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