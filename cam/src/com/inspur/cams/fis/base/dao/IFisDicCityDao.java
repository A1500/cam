package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisDicCity;

/**
 * @title:IFisDicCityDao
 * @description:
 * @author:
 * @since:2012-02-10
 * @version:1.0
*/
 public interface IFisDicCityDao extends BaseCURD<FisDicCity>{
	public void save(List<FisDicCity> list);
}

