package com.inspur.sdmz.ygjzcyxxjyxx.dao;


import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzCyxxJyxxDao
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
 public interface IYgjzCyxxJyxxDao extends BaseCURD<YgjzCyxxJyxx>{
	public void save(List<YgjzCyxxJyxx> list);
	
	public void batchDeleteByYgjzJtxxCyxx(String[] cyid);
	
}

