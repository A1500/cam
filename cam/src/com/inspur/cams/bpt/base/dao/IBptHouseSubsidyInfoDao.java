package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo;

/**
 * @title:IBptHouseSubsidyInfoDao
 * @description:建购房补助信息
 * @author:
 * @since:2011-07-04
 * @version:1.0
*/
 public interface IBptHouseSubsidyInfoDao extends BaseCURD<BptHouseSubsidyInfo>{
	public void save(List<BptHouseSubsidyInfo> list);
}

