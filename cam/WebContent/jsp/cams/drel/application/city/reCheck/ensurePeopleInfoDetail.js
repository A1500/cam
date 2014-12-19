function init() {
	peopleInfoDs.setParameter("submitOrgan", submitOrgan);
	peopleInfoDs.setParameter("commissionState", commissionState);
	peopleInfoDs.setParameter("projectId", projectId);
	peopleInfoDs.setParameter("submitTime", submitTime);
	peopleInfoDs.setParameter("submitOrganId", submitOrganId);
	peopleInfoDs.setParameter("commissionType", commissionType);
	peopleInfoDs.setParameter("organId", organId);
	peopleInfoDs.setParameter("batchId", batchId);
	peopleInfoDs.load();
	if(ifCheck==null||ifCheck=="null"){
		L5.getCmp("detail").hide();
	}
}
function query(){
	peopleInfoDs.setParameter("submitOrgan", submitOrgan);
	peopleInfoDs.setParameter("commissionState", commissionState);
	peopleInfoDs.setParameter("projectId", projectId);
	peopleInfoDs.setParameter("submitTime", submitTime);
	peopleInfoDs.setParameter("submitOrganId", submitOrganId);
	peopleInfoDs.setParameter("commissionType", commissionType);
	peopleInfoDs.setParameter("organId", organId);
	peopleInfoDs.setParameter("batchId", batchId);
	peopleInfoDs.load();


}
function detail(){
	var grid = L5.getCmp('ensureCommissionGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var _url="peopleInfoDetail.jsp?idCard="+records[0].get("D204A010005");
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
 function back()
 {
 }
 
 function state(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("COMMISSION_STATE")=="97"){
		return 	"<font color='red'>已驳回</font>";
	}else if(record.get("COMMISSION_STATE")=="2"){
		return 	"<font color='blue'>待审核</font>";
	}else{
		return 	"<font color='green'>审核通过</font>";
	}
}
 
//人员状态
 function peoState(value,cellmeta,record,rowindex,colindex,dataset){
 	if(record.get("COMMISSION_STATE")=="97"){
 		return 	"<font color='red'>"+value+"</font>";
 	}else{
 		return 	value;
 	}
 }