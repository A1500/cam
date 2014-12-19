package com.inspur.cams.prs.prssoldiersarmy.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPrsSoldiersArmyDao
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
 public interface IPrsSoldiersArmyDao extends BaseCURD<PrsSoldiersArmy>{
	public void save(List<PrsSoldiersArmy> list);
}

