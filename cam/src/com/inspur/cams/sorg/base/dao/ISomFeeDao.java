package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.sorg.base.data.SomFee;

public interface ISomFeeDao  extends BaseCURD<SomFee> {
	public void save(List<SomFee> list);
	
	public void del(String taskCode);
}
