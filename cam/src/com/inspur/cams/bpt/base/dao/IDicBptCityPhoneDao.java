package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.base.data.DicBptCityPhone;

/**
 * @title:IDicBptCityPhoneDao
 * @description:
 * @author:
 * @since:2011-09-20
 * @version:1.0
*/
 public interface IDicBptCityPhoneDao extends BaseCURD<DicBptCityPhone>{
	public void save(List<DicBptCityPhone> list);
}

