package com.inspur.sdmz.jtxx.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.SamFamilyHouse;


/**
 * @title:ISamFamilyHouseDao
 * @description:房屋基本信息DAO
 * @author:
 * @since:2011-11-07
 * @version:1.0
*/
 public interface ISamFamilyHouseDao extends BaseCURD<SamFamilyHouse>{
		public void save(List<SamFamilyHouse> list);
}

