package com.inspur.cams.comm.menuconfig.domain;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

public interface IPubMenuConfigDomain {
	
	@Trans
	public void applyMenuAll(Record[] dsRecords,String menuTypeId,String menuTypeName);
}
