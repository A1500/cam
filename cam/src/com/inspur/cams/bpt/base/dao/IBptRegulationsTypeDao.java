package com.inspur.cams.bpt.base.dao;

import java.util.List;


import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptRegulationsType;

/**
 * @title:IBptRegulationsTypeDao
 * @description:
 * @author:
 * @since:2011-12-13
 * @version:1.0
*/
 public interface IBptRegulationsTypeDao extends BaseCURD<BptRegulationsType>{
	public void save(List<BptRegulationsType> list);
}

