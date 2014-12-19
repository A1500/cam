function init() {	
	RetiredSoldierDataSet.setParameter("peopleId",peopleId);
    RetiredSoldierDataSet.load();
    
    RetiredSoldierDataSet.on("load",func_rd);
}
function func_rd(){
    var rd =RetiredSoldierDataSet.getCurrent();
    if(rd.get("isOtherBptobject")=='1'){
       document.getElementById("objectType").style.display='';
       if(rd.get("disabilityCivil")=="true"){
          document.getElementById("disabilityCivil").checked=true;
       }
       if(rd.get("disabilitySoldier")=="true"){
          document.getElementById("disabilitySoldier").checked=true;
       }
       if(rd.get("disabilityPolice")=="true"){
          document.getElementById("disabilityPolice").checked=true;
       }
       if(rd.get("disabilityMigrant")=="true"){
          document.getElementById("disabilityMigrant").checked=true;
       }
       if(rd.get("dependMartyrs")=="true"){
          document.getElementById("dependMartyrs").checked=true;
       }
    
       if(rd.get("dependDied")=="true"){
          document.getElementById("dependDied").checked=true;
       }
   
       if(rd.get("dependPublic")=="true"){
          document.getElementById("dependPublic").checked=true;
       }
       if(rd.get("demobilizedSoldier")=="true"){
          document.getElementById("demobilizedSoldier").checked=true;
       }
       if(rd.get("demobilizedIllnessPeople")=="true"){
          document.getElementById("demobilizedIllnessPeople").checked=true;
       }
       if(rd.get("warPeople")=="true"){
          document.getElementById("warPeople").checked=true;
       }
       if(rd.get("testedPeople")=="true"){
          document.getElementById("testedPeople").checked=true;
       }
    }
    if(rd.get("isOtherBptobject")!='1'){
       document.getElementById("objectType").style.display='none';
    }
   
    
}
 function back()
 {	 	var url='jsp/bptcountretiredsoldier/bptcountretiredsoldier_list.jsp';
		var text = 'BPT_COUNT_RETIRED_SOLDIER';
		L5.forward(url,text);	 
 }