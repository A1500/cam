package com.inspur.sdmz.jtxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamPeopleDisease;

/**
 * @title:IYgjzCyxxHbxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface IYgjzCyxxHbxxDao extends BaseCURD<SamPeopleDisease>{
	public void save(List<SamPeopleDisease> list);

	public void batchDeleteByYgjzJtxxCyxx(String[] peopleId);

}

