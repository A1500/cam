function init(){
      var DomicileDataset = L5.DatasetMgr.lookup("domicileDataset");
      DomicileDataset.setParameter("filterSql", " (LEVE='1' OR  LEVE='2') and substr(id,1,4)= '3701'");
      DomicileDataset.load();
	assistanceTypeDS.filterBy(function(record, id){
		if("01".indexOf(record.get('value'))>-1 || "02".indexOf(record.get('value'))>-1 || "03".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
function query(){
	samSureyWfDataset.setParameter("NAME",_$("name"));
	samSureyWfDataset.setParameter("ID_CARD",_$("idCard"));
	samSureyWfDataset.setParameter("OPINION_CODE",_$("opinionCode"));
	samSureyWfDataset.setParameter("ASSISTANCE_TYPE",_$("assistanceType"));
	samSureyWfDataset.setParameter("ORGAN_AREA",organArea);
	samSureyWfDataset.setParameter("ORGAN_TYPE","A1");
	samSureyWfDataset.load();
}