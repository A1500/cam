package com.inspur.cams.prs.prssoldierstrain.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPrsSoldiersTrainDao
 * @description:
 * @author:
 * @since:2011-08-19
 * @version:1.0
*/
 public interface IPrsSoldiersTrainDao extends BaseCURD<PrsSoldiersTrain>{
	public void save(List<PrsSoldiersTrain> list);
}

