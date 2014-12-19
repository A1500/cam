package com.inspur.cams.welfare.config.economic.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IWealDicEconomicnatureDao
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
 public interface IWealDicEconomicnatureDao extends BaseCURD<WealDicEconomicnature>{
	public void save(List<WealDicEconomicnature> list);
}

