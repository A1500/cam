function init() {
	var prssoldierstrainDataset=L5.DatasetMgr.lookup("prssoldierstrainDataset");
	prssoldierstrainDataset.baseParams["SOLDIERS_ID"]=idField;
	prssoldierstrainDataset.load();
}
 function back()
 {	
 	history.go(-1);
 }
  function print(){
	var url='../print/reguIdenti_apptable.jsp?soldierId='+idField+'&type=03';
	window.showModalDialog(url,window);
}