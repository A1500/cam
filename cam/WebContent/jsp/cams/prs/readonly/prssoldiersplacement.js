function init() {
	prsPlacementDataset.baseParams["SOLDIERS_ID"]=idField;
	prsPlacementDataset.load();

}
 function back()
 {	
 	history.go(-1);
 }
 function print(){
	var url='../print/reguIdenti_apptable.jsp?soldierId='+idField+'&type=02';
	window.showModalDialog(url,window);
}