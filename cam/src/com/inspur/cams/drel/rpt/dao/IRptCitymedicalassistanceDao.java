package com.inspur.cams.drel.rpt.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.rpt.data.RptCitymedicalassistance;

/**
 * @title:IRptCitymedicalassistanceDao
 * @description:城市医疗救助工作情况Dao接口类
 * @author:fujw
 * @since:2011-06-14
 * @version:1.0
*/
 public interface IRptCitymedicalassistanceDao extends BaseCURD<RptCitymedicalassistance>{
	public void save(List<RptCitymedicalassistance> list);
}

