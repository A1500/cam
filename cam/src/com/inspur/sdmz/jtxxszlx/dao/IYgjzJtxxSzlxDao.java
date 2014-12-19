package com.inspur.sdmz.jtxxszlx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IYgjzJtxxSzlxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxSzlxDao extends BaseCURD<YgjzJtxxSzlx>{
	public void save(List<YgjzJtxxSzlx> list);
	
	public void batchDeleteByYgjzJtxx(String[] jtid);
	
}

