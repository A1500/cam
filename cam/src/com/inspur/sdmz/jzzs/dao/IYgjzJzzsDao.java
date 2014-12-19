package com.inspur.sdmz.jzzs.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzJzzsDao
 * @description:
 * @author licunbing
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJzzsDao extends BaseCURD<YgjzJzzs>{
	public void save(List<YgjzJzzs> list);
	
	public void batchDeleteByYgjzJtxx(String[] jtid);
	
}

