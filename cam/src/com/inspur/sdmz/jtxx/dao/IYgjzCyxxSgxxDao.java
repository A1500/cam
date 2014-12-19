package com.inspur.sdmz.jtxx.dao;


import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamPeopleAccident;

/**
 * @title:IYgjzCyxxSgxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface IYgjzCyxxSgxxDao extends BaseCURD<SamPeopleAccident>{
	public void save(List<SamPeopleAccident> list);

	public void batchDeleteByYgjzJtxxCyxx(String[] peopleId);

}

