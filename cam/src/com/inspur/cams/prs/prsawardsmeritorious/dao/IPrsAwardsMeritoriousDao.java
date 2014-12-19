package com.inspur.cams.prs.prsawardsmeritorious.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPrsAwardsMeritoriousDao
 * @description:
 * @author:
 * @since:2011-08-23
 * @version:1.0
*/
 public interface IPrsAwardsMeritoriousDao extends BaseCURD<PrsAwardsMeritorious>{
	public void save(List<PrsAwardsMeritorious> list);
}

