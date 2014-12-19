function init() {
	var grid=L5.getCmp('ensureCommissionGridPanel');
	grid.getView().getRowClass = function(record, index, p, ds) {
		var flag=record.get("CURRENT_STATUS");
		if(flag=="1"){
			var cls = 'x-grid-record-red';
			return cls;
		}
	}
	peopleInfoDs.setParameter("areaName", areaName);
	peopleInfoDs.setParameter("feedbackTime", feedbackTime);
	peopleInfoDs.load(true);
//	alert(peopleInfoDs.getAt(0).get("CURRENT_STATUS"));
	
	
//	L5.QuickTips.init();
}
function query(){
	peopleInfoDs.setParameter("areaName", areaName);
	peopleInfoDs.setParameter("feedbackTime", feedbackTime);
	peopleInfoDs.load();


}
function detail(){
	var grid = L5.getCmp('ensureCommissionGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length<1){
		L5.Msg.alert("提醒","请选择一条记录！");
		return;
	}
	var url='feedBackInfoDetail.jsp?peopleId='+records[0].get("PEOPLE_ID");
	var width = screen.availWidth;
    var height = screen.availHeight;
//	var width = 1000;
//    var height = 400;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
}
