package com.inspur.sdmz.jtxxzrzh.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzJtxxZrzhDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxZrzhDao extends BaseCURD<YgjzJtxxZrzh>{
	public void save(List<YgjzJtxxZrzh> list);
	
	public void batchDeleteByYgjzJtxx(String[] jtid);
	
}

