function init(){
		var dsPro = L5.DatasetMgr.lookup("dsPro");
		dsPro.setParameter("PEOPLE_ID",peopleId);
//		dsPro.setParameter("ORGAN_ID",organCode);
		
		var objectType = serviceType;
		var index_type = objectType.substring(0,1);
		if(index_type == "1" || index_type =="2") {
			objectType = index_type+"1";
		}
		dsPro.setParameter("serviceType",objectType);
		
		dsPro.load();
		ds.setParameter("PEOPLE_ID",peopleId);
//		ds.setParameter("SERVICE_TYPE",serviceType);
		ds.setParameter("ORGAN_ID", organCode);
		ds.load();
		L5.QuickTips.init();
		L5.getCmp("editGridPanelPro").on("rowclick", forRowApplyId);
}

function forRowApplyId(grid, rowIndex ,e) {
	var peopleid = grid.getDataset().getAt(rowIndex).get("PEOPLE_ID");
	var applyid = grid.getDataset().getAt(rowIndex).get("APPLY_ID");
	var ywname = grid.getDataset().getAt(rowIndex).get("YW_NAME");
	var service = grid.getDataset().getAt(rowIndex).get("SERVICE_TYPE");
	if(ywname == "数据采集"||ywname == "其他") {
		ywname ="1";
	}
	var url='electronicListDetailDoc.jsp?peopleId='+peopleId+'&applyId='+applyid+'&ywName='+ywname+'&serviceType='+serviceType + "&service="+service;
	var width = screen.width-200;
	var height = 520;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");

}

