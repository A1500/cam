package com.inspur.cams.sorg.check.somcheckparty.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckPartyDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckPartyDao extends BaseCURD<SomCheckParty>{
	public void save(List<SomCheckParty> list);
}

