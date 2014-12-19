package com.inspur.sdmz.jtxx.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamFamilyCalamity;

/**
 * @title:IYgjzJtxxZrzhDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxZrzhDao extends BaseCURD<SamFamilyCalamity>{
	public void save(List<SamFamilyCalamity> list);

	public void batchDeleteByYgjzJtxx(String[] familyId);

}

