package com.inspur.sdmz.jtxxcyxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzJtxxCyxxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxCyxxDao extends BaseCURD<YgjzJtxxCyxx>{
	public void save(List<YgjzJtxxCyxx> list);
	
	public void batchDeleteByYgjzJtxx(String[] jtid);
	
}

