package com.inspur.sdmz.jtxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;

/**
 * @title:IYgjzJtxxSzlxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxSzlxDao extends BaseCURD<SamFamilyAssistance>{
	public void save(List<SamFamilyAssistance> list);

	public void batchDeleteByYgjzJtxx(String[] familyId);

}

