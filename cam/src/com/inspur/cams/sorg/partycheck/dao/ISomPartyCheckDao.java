package com.inspur.cams.sorg.partycheck.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.sorg.partycheck.data.*;

/**
 * @title:ISomPartyCheckDao
 * @description:
 * @author:
 * @since:2013-04-26
 * @version:1.0
*/
 public interface ISomPartyCheckDao extends BaseCURD<SomPartyCheck>{
	public void save(List<SomPartyCheck> list);
}

