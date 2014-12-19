package com.inspur.cams.bpt.dichealth.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IDicHealthDao
 * @description:
 * @author:
 * @since:2011-12-26
 * @version:1.0
*/
 public interface IDicHealthDao extends BaseCURD<DicHealth>{
	public void save(List<DicHealth> list);
}

