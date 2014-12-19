function init(){
  var ds=L5.DatasetMgr.lookup("ds");
  ds.load();
}

function queryit(){
	var organName = document.getElementById('organNameText').value;
	if(organName){
		ds.setParameter("ORGAN_NAME",organName);
	}
	ds.load();
}

function confirmValue(){
    var grid=L5.getCmp("editGridPanel");
	var ds=L5.DatasetMgr.lookup("ds");
	var revalue=[];
    var sm=grid.getSelectionModel();
	var cell=sm.getSelections();
	if(cell.length==1){
		var organId=cell[0].get("organId");
		var organName=cell[0].get("organName");
	    if(organId !="" && organName !=""){
	     if(returnValueType=="string"){
	       window.returnValue=organId+";"+organName;
	     }else{
	         revalue[0]=organId;
             revalue[1]=organName;
	       window.returnValue=revalue;
	     }
		   window.close();
		 }
	   }else{
	    L5.MessageBox.alert("提示","请选择一条记录！");
	      return false;
	   }
 }


function closew(){
  window.returnValue="";
  window.close();
}