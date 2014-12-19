package com.inspur.cams.drel.surey.assistance.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.surey.comm.data.SamSureyWf;

public interface ISamAssistanceDomain {
	@Trans
	public void insertSurey(SamSureyWf sureyWfBean);
	
	@Trans
	public void sendSurey(List<String> lists,String userId,String userName);
	
	@Trans
	public void deleteSurey(Record[] records);
	
	@Trans
	public void updateSurey(SamSureyWf sureyWfBean,Map<String, String> map);
}
