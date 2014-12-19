package com.inspur.cams.comm.menuconfig.domain;

import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

public interface ICustomMenuDomain {
	@Trans
	public void updatePk(Map<String, String> map);
}
