package com.inspur.cams.drel.esurey.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.esurey.data.SamLowStandards;

/**
 * @title:ISamLowStandardsDao
 * @description:
 * @author:
 * @since:2011-07-06
 * @version:1.0
*/
 public interface ISamLowStandardsDao extends BaseCURD<SamLowStandards>{
	public void save(List<SamLowStandards> list);
}

