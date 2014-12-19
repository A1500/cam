package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;

/**
 * @title:IFisCemeCheckScoreDao
 * @description:
 * @author:
 * @since:2011-12-14
 * @version:1.0
*/
 public interface IFisCemeCheckScoreDao extends BaseCURD<FisCemeCheckScore>{
	public void save(List<FisCemeCheckScore> list);
}

