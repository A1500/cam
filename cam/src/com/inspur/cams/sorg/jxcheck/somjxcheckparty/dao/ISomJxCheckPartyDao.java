package com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckPartyDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckPartyDao extends BaseCURD<SomJxCheckParty>{
	public void save(List<SomJxCheckParty> list);
}

