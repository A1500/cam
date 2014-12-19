function init() {	
	ds.load();
	ds.on("load",function(ds){
			fillBackSorgName();
		});
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/sorg/penalty/correct/sompenaltycorrect_list.jsp';
		var text = 'SOM_PENALTY_CORRECT';
		L5.forward(url,text);	 
 }
 
 function fillBackSorgName(){
	if(_$("sorgType")==''||_$("sorgCode")==''){
	 	return;
	}
	somOrganDataSet.baseParams["SORG_TYPE@="]=_$("sorgType");
	somOrganDataSet.baseParams["SORG_CODE@="]=_$("sorgCode");
	somOrganDataSet.baseParams["SORG_STATUS@="]='22';
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
			if(ds.getCount() == 0){
				$("sorgName").innerHTML = "";
				return;
			}else{
				$("sorgName").innerHTML = ds.get("cnName");
			}
		});
}

function print(){
	var record = ds.getCurrent();
	var id = record.get("id");
	var sorgName =$("sorgName").innerHTML;
	sorgName = encodeURIComponent(encodeURIComponent(sorgName));
	var printurl=url+"/jsp/cams/sorg/comm/print/penaltyCorrectForPrint.jsp?id="+id+"&sorgName="+sorgName;
	window.open(printurl);
}