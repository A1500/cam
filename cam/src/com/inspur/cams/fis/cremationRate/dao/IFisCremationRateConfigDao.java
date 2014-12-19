package com.inspur.cams.fis.cremationRate.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.cremationRate.data.FisCremationRateConfig;

/**
 * @title:IFisCremationRateConfigDao
 * @description:
 * @author:
 * @since:2012-11-16
 * @version:1.0
*/
 public interface IFisCremationRateConfigDao extends BaseCURD<FisCremationRateConfig>{
	public void save(List<FisCremationRateConfig> list);
}

