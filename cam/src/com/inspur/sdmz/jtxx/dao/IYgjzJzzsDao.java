package com.inspur.sdmz.jtxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamIndex;

/**
 * @title:IYgjzJzzsDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJzzsDao extends BaseCURD<SamIndex>{
	public void save(List<SamIndex> list);

	public void batchDeleteByYgjzJtxx(String[] familyId);

}

