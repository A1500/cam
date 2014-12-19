package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomSignet;

public interface ISomSignetDao extends BaseCURD<SomSignet> {
	public void del(String taskCode);

}
