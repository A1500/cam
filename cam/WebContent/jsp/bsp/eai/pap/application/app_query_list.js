function init(){
  var ds=L5.DatasetMgr.lookup("ds");
  ds.load();
}

function confirmValue(){
    var grid=L5.getCmp("editGridPanel");
	var ds=L5.DatasetMgr.lookup("ds");
	var revalue=[];
    var sm=grid.getSelectionModel();
	var cell=sm.getSelections();
	if(cell.length==1){
		var appCode=cell[0].get("appCode");
		var appName=cell[0].get("appName");
	    if(appCode !=="" && appName !==""){
	       window.returnValue=appCode+";"+appName;
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
function clears(){
	window.returnValue=";;;;;;;"
	window.close();
}
