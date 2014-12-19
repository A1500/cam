package com.inspur.sdmz.jtxx.dao;


import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamPeopleEdu;

/**
 * @title:IYgjzCyxxJyxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface IYgjzCyxxJyxxDao extends BaseCURD<SamPeopleEdu>{
	public void save(List<SamPeopleEdu> list);

	public void batchDeleteByYgjzJtxxCyxx(String[] peopleId);

}

