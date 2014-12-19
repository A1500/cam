package com.inspur.sdmz.ygjzcyxxhbxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzCyxxHbxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface IYgjzCyxxHbxxDao extends BaseCURD<YgjzCyxxHbxx>{
	public void save(List<YgjzCyxxHbxx> list);
	
	public void batchDeleteByYgjzJtxxCyxx(String[] cyid);
	
}

