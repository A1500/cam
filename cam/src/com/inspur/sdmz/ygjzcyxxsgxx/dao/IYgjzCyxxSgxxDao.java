package com.inspur.sdmz.ygjzcyxxsgxx.dao;


import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzCyxxSgxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface IYgjzCyxxSgxxDao extends BaseCURD<YgjzCyxxSgxx>{
	public void save(List<YgjzCyxxSgxx> list);
	
	public void batchDeleteByYgjzJtxxCyxx(String[] cyid);
	
}

